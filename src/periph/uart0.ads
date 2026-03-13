-- This is the uart0 "spec file" and defines what procedures/functions are available to use in helios.adb
package Uart0 is
    -- Checks status bit until something arrives
    procedure Echo_Uart_RX;
    -- Startup uart0, settings
    procedure Init (Baud_Rate : Natural);
    -- Read a char from the data reg
    function Read_RX return Character;
    -- Transmit a string over UART0
    procedure Put (S : String);

end Uart0;
