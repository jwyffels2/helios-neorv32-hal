-- This is the uart1 file, used for communicating with the camera
package Uart1 is
    -- Checks status bit until something arrives
    procedure Echo_Uart_RX;
    -- Startup uart1, settings
    procedure Init (Baud_Rate : Natural);
    -- Read a char from the data reg
    function Read_RX return Character;
    -- Transmit a string over uart1
    procedure Put (S : String);
    procedure Write_TX (Value : Character);

    function TX_Ready return Boolean;
    function RX_Ready return Boolean;

end Uart1;
