-- This is the uart0 "implementation file" and implements procedures/functions defined in uart0.ads
with Interfaces.C; use Interfaces.C;
with Ada.Text_IO; use Ada.Text_IO;

with neorv32; use neorv32;
with neorv32.UART0; use neorv32.UART0;

--with Sysinfo; use Sysinfo;
with Neorv32_Hal_Config; use Neorv32_Hal_Config;

with RISCV.CSR; use RISCV.CSR;

package body Uart0 is

    -- Startup procedure
    procedure Init (Baud_Rate : Natural) is
        -- Creates a 32 bit view of the UART0 CTRL register
        Reset : UInt32 with Volatile, Address => UART0_Periph.CTRL'Address;
        -- Compute baud rate divider value
        Baud_Div : Natural := Clk / (2 * Baud_Rate);
        -- Prescaler starts at 0
        Prsc_Sel : Natural := 0;
    begin
        -- Set entire UART0 CTRL reg to all 0's (clears control bits and puts in 'starting state')
        Reset := 0;
        -- While Baud_Div > 1023 keep scaling it down by increasing Prsc_Sel
        while Baud_Div >= 2#11_1111_1111# loop
            if Prsc_Sel = 2 or else Prsc_Sel = 4 then
                Baud_Div := Baud_Div / 8;
            else
                Baud_Div := Baud_Div / 2;
            end if;
            -- Increment prescaler by 1
            Prsc_Sel := @ + 1;
        end loop;
        -- Write prescaler to uart0 ctrl reg. 3 bit.
        UART0_Periph.CTRL.UART_CTRL_PRSC := UInt3 (Prsc_Sel);
        -- Write baud rate divider to uart0 ctrl reg. 10 bit.
        UART0_Periph.CTRL.UART_CTRL_BAUD := UInt10 (Baud_Div - 1);
        -- UART0_Periph.CTRL.UART_CTRL_IRQ_RX_NEMPTY := 1;
        -- Disables the uart0 rx “not empty” interrupt
        UART0_Periph.CTRL.UART_CTRL_IRQ_RX_NEMPTY := 0;
        -- Enable uart0 peripheral
        UART0_Periph.CTRL.UART_CTRL_EN := 1;
        -- Mie.Write (2#100_00000000_00000000#);
    end Init;

    -- Return the next byte in the fifo
    function Read_RX return Character is
        -- Create a uart_rx object with character type. Map it onto the uart0 data reg address
        UART_RX : Character with Volatile, Address => UART0_Periph.DATA'Address;
    begin
        -- Return the next character at that address
        return UART_RX;
    end Read_RX;
    -- Convert function to be inline
    pragma Inline (Read_RX);

    -- Write a byte to the tx data register
    procedure Write_TX (Value : Character) is
        -- Create a uart_tx object with character type. Map it onto the uart0 data reg address
        UART_TX : Character with Volatile, Address => UART0_Periph.DATA'Address;
    begin
        -- Pass the character to the address
        UART_TX := Value;
    end Write_TX;
    -- Convert function to be inline
    pragma Inline (Write_TX);

    -- Wait until hardware is ready before writing the byte using write_tx
    procedure Put_Char (C : Interfaces.C.char) with
        -- Make put_char available to C as putchar
        Export, Convention => C, External_Name => "putchar";
    procedure Put_Char (C : Interfaces.C.char) is
    begin
        -- Wait while TX FIFO is full: this is when TX_NFULL = 0
        while UART0_Periph.CTRL.UART_CTRL_TX_NFULL = 0 loop
            null;
        end loop;
        -- Write a byte to the tx data register
        Write_TX (Interfaces.C.To_Ada (C));
    end Put_Char;

    -- Polls status bit until something arrives. When it does, print it.
    procedure Echo_Uart_RX is
        -- Declare C to hold a char
        C : Character;
    begin
        loop
            -- Check the uart status bit. 1 means not empty
            if UART0_Periph.CTRL.UART_CTRL_RX_NEMPTY = 1 then
                -- Read byte from the data reg into C
                C := Read_RX;
                -- Print the string representation of C
                Put_Line (C'Image);
                exit;
            end if;
        end loop;
    end Echo_Uart_RX;

    -- Similar to put_char but puts an entire string and not available to C
    procedure Put (S : String) is
    begin
        -- For each char in string
        for C of S loop
            -- Wait while TX FIFO is full (TX_NFULL = 0 means "full")
            while UART0_Periph.CTRL.UART_CTRL_TX_NFULL = 0 loop
                null;
            end loop;
            -- Write a byte to the tx data register
            Write_TX (C);
        end loop;
    end Put;
end Uart0;
