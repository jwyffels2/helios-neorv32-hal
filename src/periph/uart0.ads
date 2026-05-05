
with Interfaces; use Interfaces;
with Interfaces.C; use Interfaces.C;

-- This is the uart0 "spec file" and defines what procedures/functions are available to use in helios.adb
package Uart0 is

    subtype Byte is Unsigned_8;

    -- Startup uart0, settings
    procedure Init (Baud_Rate : Natural);

    -- Read a char from the data reg
    function Read_RX return Character;

    -- Write a byte to the tx data register
    procedure Write_TX (Value : Character);

    -- C-exported TX helper
    procedure Put_Char (C : Interfaces.C.char) with Export, Convention => C, External_Name => "putchar";

    -- Transmit a string over UART0
    procedure Put (S : String);

end Uart0;
