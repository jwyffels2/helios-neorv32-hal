-- This is the uart1 "implementation file" and implements procedures/functions defined in uart1.ads
with Ada.Text_IO; use Ada.Text_IO;

with Interfaces; use Interfaces;

with neorv32; use neorv32;
with neorv32.UART1; use neorv32.UART1;

--with Sysinfo; use Sysinfo;
with Neorv32_Hal_Config; use Neorv32_Hal_Config;

with RISCV.CSR; use RISCV.CSR;

package body Uart1 is

    -- Startup procedure
    procedure Init (Baud_Rate : Natural) is
        -- Creates a 32 bit view of the UART1 CTRL register
        Reset : UInt32 with Volatile, Address => UART1_Periph.CTRL'Address;
        -- Compute baud rate divider value
        Baud_Div : Natural := Clk / (2 * Baud_Rate);
        -- Prescaler starts at 0
        Prsc_Sel : Natural := 0;
    begin
        -- Set entire UART1 CTRL reg to all 0's (clears control bits and puts in 'starting state')
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
        -- Write prescaler to uart1 ctrl reg. 3 bit.
        UART1_Periph.CTRL.UART_CTRL_PRSC := UInt3 (Prsc_Sel);
        -- Write baud rate divider to uart1 ctrl reg. 10 bit.
        UART1_Periph.CTRL.UART_CTRL_BAUD := UInt10 (Baud_Div - 1);
        -- UART1_Periph.CTRL.UART_CTRL_IRQ_RX_NEMPTY := 1;
        -- Disables the uart1 rx “not empty” interrupt
        UART1_Periph.CTRL.UART_CTRL_IRQ_RX_NEMPTY := 0;
        -- Enable uart1 peripheral
        UART1_Periph.CTRL.UART_CTRL_EN := 1;
        -- Mie.Write (2#100_00000000_00000000#);
    end Init;

    -- Return the next byte in the fifo
    function Read_RX return Character is
        -- Create a uart_rx object with character type. Map it onto the uart1 data reg address
        UART_RX : Character with Volatile, Address => UART1_Periph.DATA'Address;
    begin
        -- Return the next character at that address
        return UART_RX;
    end Read_RX;
    -- Convert function to be inline
    pragma Inline (Read_RX);

    -- Write a byte to the tx data register
    procedure Write_TX (Value : Character) is
        -- Create a uart_tx object with character type. Map it onto the uart1 data reg address
        UART_TX : Character with Volatile, Address => UART1_Periph.DATA'Address;
    begin
        -- Pass the character to the address
        UART_TX := Value;
    end Write_TX;
    -- Convert function to be inline
    pragma Inline (Write_TX);

    -- Polls status bit until something arrives. When it does, print it.
    procedure Echo_Uart_RX is
        -- Declare C to hold a char
        C : Character;
    begin
        loop
            -- Check the uart status bit. 1 means not empty
            if UART1_Periph.CTRL.UART_CTRL_RX_NEMPTY = 1 then
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
            while UART1_Periph.CTRL.UART_CTRL_TX_NFULL = 0 loop
                null;
            end loop;
            -- Write a byte to the tx data register
            Write_TX (C);
        end loop;
    end Put;

    function TX_Ready return Boolean is
    begin
        return UART1_Periph.CTRL.UART_CTRL_TX_NFULL = 1;
    end TX_Ready;
    pragma Inline (TX_Ready);

    function RX_Ready return Boolean is
    begin
        return UART1_Periph.CTRL.UART_CTRL_RX_NEMPTY = 1;
    end RX_Ready;
    pragma Inline (RX_Ready);

    procedure Flush_RX is
        Dummy : Character;
    begin
        while RX_Ready loop
            Dummy := Read_RX;
        end loop;
    end Flush_RX;

    function Read_RX_Byte return Byte is
        UART_RX : Byte with Volatile, Address => UART1_Periph.DATA'Address;
    begin
        return UART_RX;
    end Read_RX_Byte;
    pragma Inline (Read_RX_Byte);

    procedure Write_TX_Byte (Value : Byte) is
        UART_TX : Byte with Volatile, Address => UART1_Periph.DATA'Address;
    begin
        UART_TX := Value;
    end Write_TX_Byte;
    pragma Inline (Write_TX_Byte);

end Uart1;
