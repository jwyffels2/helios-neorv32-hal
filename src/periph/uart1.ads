-- This is the uart1 file, used for communicating with the camera
with Interfaces; use Interfaces;
with Interfaces; use Interfaces;
package Uart1 is

    subtype Byte is Unsigned_8;

    -- Startup uart1, settings
    procedure Init (Baud_Rate : Natural);
    -- Read a byte from the data reg
    function Read_RX_Byte return Byte;
    procedure Write_TX_Byte (Value : Byte);

    function TX_Ready return Boolean;
    function RX_Ready return Boolean;

    procedure Flush_RX;




    procedure Flush_RX;




end Uart1;
