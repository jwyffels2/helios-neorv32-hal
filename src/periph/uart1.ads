-- This is the uart1 file, used for communicating with the camera
with Interfaces; use Interfaces;
package Uart1 is

    subtype Byte is Unsigned_8;

    -- Checks status bit until something arrives
    procedure Echo_Uart_RX;
    -- Startup uart1, settings
    procedure Init (Baud_Rate : Natural);
    -- Read a char from the data reg
    function Read_RX return Character;
    function Read_RX_Byte return Byte;
    -- Transmit a string over uart1
    procedure Put (S : String);
    procedure Write_TX (Value : Character);
    procedure Write_TX_Byte (Value : Byte);

    function TX_Ready return Boolean;
    function RX_Ready return Boolean;

    procedure Flush_RX;




end Uart1;
