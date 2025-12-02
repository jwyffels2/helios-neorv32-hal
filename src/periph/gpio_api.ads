with Ada.Assertions;
with neorv32; use neorv32;
with neorv32.GPIO; use neorv32.GPIO;

package GPIO_API is

   type GPIO_Pin_T is tagged private;
   type Mode_T is (Off, Input, Output, InOut);

   function Create_Pin
     (Pin_Index : Natural;
      Mode : Mode_T := Off;
      Enabled : Boolean := False)
      return GPIO_Pin_T;
   procedure Set_Mode (Pin : in out GPIO_Pin_T; Mode : Mode_T);
   procedure Enable (Pin : in out GPIO_Pin_T);
   procedure Disable (Pin : in out GPIO_Pin_T);

private

   type GPIO_Pin_T is tagged record
      Pin_Index : Natural range 0 .. 31;
      Pin_Mode  : Mode_T  := Off;
      Enabled   : Boolean := False;
   end record;

end GPIO_API;
