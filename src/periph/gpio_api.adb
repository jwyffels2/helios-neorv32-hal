package body GPIO_API is

   procedure Enable_Pin (Pin : GPIO_Pin) is
   begin
      Port_State := Port_State or Shift_Left (1, Pin);
      Set_Port_Out;
   end Enable_Pin;

   procedure Disable_Pin (Pin : GPIO_Pin) is
   begin
      Port_State := Port_State and not Shift_Left (1, Pin);
      Set_Port_Out;
   end Disable_Pin;

   procedure Set_Pins (Mask : UInt32) is
   begin
      Port_State := Mask;
      Set_Port_Out;
   end Set_Pins;

   procedure Set_Port_Out is
   begin
      neorv32.GPIO.GPIO_Periph.PORT_OUT := Port_State;
   end Set_Port_Out;

end GPIO_API;
