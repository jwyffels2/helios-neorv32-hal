with neorv32; use neorv32;
with neorv32.GPIO; use neorv32.GPIO;

package GPIO_API is

   subtype GPIO_Pin is Natural range 0 .. 31;

   procedure Enable_Pin (Pin : GPIO_Pin);
   procedure Disable_Pin (Pin : GPIO_Pin);
   procedure Set_Pins (Mask : UInt32);

private

   Port_State : UInt32 := 0;

   procedure Set_Port_Out;

end GPIO_API;
