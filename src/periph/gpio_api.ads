with neorv32; use neorv32;
with neorv32.GPIO; use neorv32.GPIO;

package GPIO_API is

   subtype GPIO_Pin_T is Natural range 0 .. 31;
   type GPIO_Pin_List_T is array (Positive range <>) of GPIO_Pin_T;

   procedure Enable (Pin : GPIO_Pin_T);
   procedure Enable (Pins : GPIO_Pin_List_T);
   procedure Disable (Pin : GPIO_Pin_T);
   procedure Disable (Pins : GPIO_Pin_List_T);

private

   Port_State : UInt32 := 0;

   procedure Set_Port_Out;

end GPIO_API;
