
with Interfaces; use Interfaces;
with Interfaces.C; use Interfaces.C;

-- This is the uart0 "spec file" and defines what procedures/functions are available to use in helios.adb
package Uart0 is

    subtype Byte is Unsigned_8;

    -- Checks status bit until something arrives
    procedure Echo_Uart_RX;

    -- Startup uart0, settings
    procedure Init (Baud_Rate : Natural);

    -- Read a char from the data reg
    function Read_RX return Character;
    function Read_RX_Byte return Byte;

    -- Write a byte to the tx data register
    procedure Write_TX (Value : Character);

    -- Returns True when UART0 RX has a byte waiting
    function RX_Ready return Boolean;

    -- Removes any unread bytes currently in RX FIFO
    procedure Flush_RX;

    -- C-exported TX helper
    procedure Put_Char (C : Interfaces.C.char) with Export, Convention => C, External_Name => "putchar";

    -- Transmit a string over UART0
    procedure Put (S : String);

end Uart0;
