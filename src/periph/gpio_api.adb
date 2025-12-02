package body GPIO_API is

   procedure Update_GPIO (Pin : GPIO_Pin_T) is
      Mask : UInt32 := Shift_Left (1, Pin.Pin_Index);
   begin
      -- Clear the pin in both registers
      GPIO_Periph.PORT_IN  := GPIO_Periph.PORT_IN  and not Mask;
      GPIO_Periph.PORT_OUT := GPIO_Periph.PORT_OUT and not Mask;

      if Pin.Enabled then
         case Pin.Pin_Mode is
            when Input =>
               GPIO_Periph.PORT_IN := GPIO_Periph.PORT_IN or Mask;

            when Output =>
               GPIO_Periph.PORT_OUT := GPIO_Periph.PORT_OUT or Mask;

            when InOut =>
               GPIO_Periph.PORT_IN  := GPIO_Periph.PORT_IN  or Mask;
               GPIO_Periph.PORT_OUT := GPIO_Periph.PORT_OUT or Mask;

            when Off =>
               null;
         end case;
      end if;
   end Update_GPIO;

   function Create_Pin
     (Pin_Index : Natural;
      Mode      : Mode_T := Off;
      Enabled   : Boolean := False)
     return GPIO_Pin_T
   is
      Pin : GPIO_Pin_T := (
         Pin_Index => Pin_Index,
         Pin_Mode  => Mode,
         Enabled   => Enabled
      );
   begin
      Update_GPIO(Pin);
      return Pin;
   end Create_Pin;

   procedure Set_Mode (Pin : in out GPIO_Pin_T; Mode : Mode_T) is
   begin
      Pin.Pin_Mode := Mode;

      if Mode = Off then
         Pin.Enabled := False;
      end if;

      Update_GPIO (Pin);
   end Set_Mode;

   procedure Enable (Pin : in out GPIO_Pin_T) is
   begin
      Ada.Assertions.Assert (Pin.Pin_Mode /= Off, "Cannot enable pin in Off Mode");

      Pin.Enabled := True;
      Update_GPIO (Pin);
   end Enable;

   procedure Disable (Pin : in out GPIO_Pin_T) is
   begin
      Pin.Enabled := False;
      Update_GPIO (Pin);
   end Disable;

end GPIO_API;
