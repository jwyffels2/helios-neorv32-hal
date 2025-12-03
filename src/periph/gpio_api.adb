package body GPIO_API is

   function Create_Pin (Pin_Index : GPIO_Index) return GPIO_Pin_T is
   begin
      return (Pin_Index => Pin_Index);
   end Create_Pin;

   function Read (Pin : in out GPIO_Pin_T) return Boolean is
      Mask : constant UInt32 := Shift_Left (1, Pin.Pin_Index);
   begin
      return (GPIO_Periph.PORT_IN and Mask) /= 0;
   end Read;

   procedure Set (Pin : in out GPIO_Pin_T) is
      Mask : constant UInt32 := Shift_Left (1, Pin.Pin_Index);
   begin
      GPIO_Periph.PORT_OUT := GPIO_Periph.PORT_OUT or Mask;
   end Set;

   procedure Clear (Pin : in out GPIO_Pin_T) is
      Mask : constant UInt32 := Shift_Left (1, Pin.Pin_Index);
   begin
      GPIO_Periph.PORT_OUT := GPIO_Periph.PORT_OUT and not Mask;
   end Clear;

   procedure Toggle (Pin : in out GPIO_Pin_T) is
      Mask : constant UInt32 := Shift_Left (1, Pin.Pin_Index);
   begin
      GPIO_Periph.PORT_OUT := GPIO_Periph.PORT_OUT xor Mask;
   end Toggle;

end GPIO_API;
