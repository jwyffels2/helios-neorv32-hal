package body GPIO_API is

   procedure Enable (Pin : GPIO_Pin_T) is
   begin
      Port_State := Port_State or Shift_Left (1, Pin);
      Set_Port_Out;
   end Enable;

   procedure Disable (Pin : GPIO_Pin_T) is
   begin
      Port_State := Port_State and not Shift_Left (1, Pin);
      Set_Port_Out;
   end Disable;

   procedure Set (Pins : GPIO_Pin_List_T) is
      Mask : UInt32 := 0;
   begin
      for Pin of Pins loop
         Mask := Mask or Shift_Left (1, Pin);
      end loop;

      Port_State := Mask;
      Set_Port_Out;
   end Set;

   procedure Set_Port_Out is
   begin
      neorv32.GPIO.GPIO_Periph.PORT_OUT := Port_State;
   end Set_Port_Out;

end GPIO_API;
