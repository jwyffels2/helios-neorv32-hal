with neorv32; use neorv32;
with neorv32.GPIO; use neorv32.GPIO;

package GPIO_API is

   subtype GPIO_Index is Natural range 0 .. 31;
   type GPIO_Pin_T is tagged private;

   function Create_Pin (Pin_Index : GPIO_Index) return GPIO_Pin_T;
   function Read (Pin : in out GPIO_Pin_T) return Boolean;
   procedure Set (Pin : in out GPIO_Pin_T);
   procedure Clear (Pin : in out GPIO_Pin_T);
   procedure Toggle (Pin : in out GPIO_Pin_T);

private

   type GPIO_Pin_T is tagged record
      Pin_Index : GPIO_Index;
   end record;

end GPIO_API;
