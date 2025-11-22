pragma Style_Checks (Off);

--  This spec has been automatically generated from neorv32.svd

pragma Restrictions (No_Elaboration_Code);

with System;

--  Pulse-width modulation controller
package neorv32.PWM is
   pragma Preelaborate;

   ---------------
   -- Registers --
   ---------------

   subtype CHANNEL_CFG_PWM_CFG_DUTY_Field is neorv32.Byte;
   subtype CHANNEL_CFG_PWM_CFG_CDIV_Field is neorv32.UInt10;
   subtype CHANNEL_CFG_PWM_CFG_POL_Field is neorv32.Bit;
   subtype CHANNEL_CFG_PWM_CFG_PRSC_Field is neorv32.UInt3;
   subtype CHANNEL_CFG_PWM_CFG_EN_Field is neorv32.Bit;

   --  Channel 0 configuration register
   type CHANNEL_CFG_Register is record
      --  Duty cycle
      PWM_CFG_DUTY   : CHANNEL_CFG_PWM_CFG_DUTY_Field := 16#0#;
      --  Clock divider
      PWM_CFG_CDIV   : CHANNEL_CFG_PWM_CFG_CDIV_Field := 16#0#;
      --  unspecified
      Reserved_18_26 : neorv32.UInt9 := 16#0#;
      --  Channel polarity, inverted when set
      PWM_CFG_POL    : CHANNEL_CFG_PWM_CFG_POL_Field := 16#0#;
      --  Clock prescaler select
      PWM_CFG_PRSC   : CHANNEL_CFG_PWM_CFG_PRSC_Field := 16#0#;
      --  Channel enable
      PWM_CFG_EN     : CHANNEL_CFG_PWM_CFG_EN_Field := 16#0#;
   end record
     with Volatile_Full_Access, Object_Size => 32,
          Bit_Order => System.Low_Order_First;

   for CHANNEL_CFG_Register use record
      PWM_CFG_DUTY   at 0 range 0 .. 7;
      PWM_CFG_CDIV   at 0 range 8 .. 17;
      Reserved_18_26 at 0 range 18 .. 26;
      PWM_CFG_POL    at 0 range 27 .. 27;
      PWM_CFG_PRSC   at 0 range 28 .. 30;
      PWM_CFG_EN     at 0 range 31 .. 31;
   end record;

   -----------------
   -- Peripherals --
   -----------------

   --  Pulse-width modulation controller
   type PWM_Peripheral is record
      --  Channel 0 configuration register
      CHANNEL_CFG0  : aliased CHANNEL_CFG_Register;
      --  Channel 1 configuration register
      CHANNEL_CFG1  : aliased CHANNEL_CFG_Register;
      --  Channel 2 configuration register
      CHANNEL_CFG2  : aliased CHANNEL_CFG_Register;
      --  Channel 3 configuration register
      CHANNEL_CFG3  : aliased CHANNEL_CFG_Register;
      --  Channel 4 configuration register
      CHANNEL_CFG4  : aliased CHANNEL_CFG_Register;
      --  Channel 5 configuration register
      CHANNEL_CFG5  : aliased CHANNEL_CFG_Register;
      --  Channel 6 configuration register
      CHANNEL_CFG6  : aliased CHANNEL_CFG_Register;
      --  Channel 7 configuration register
      CHANNEL_CFG7  : aliased CHANNEL_CFG_Register;
      --  Channel 8 configuration register
      CHANNEL_CFG8  : aliased CHANNEL_CFG_Register;
      --  Channel 9 configuration register
      CHANNEL_CFG9  : aliased CHANNEL_CFG_Register;
      --  Channel 10 configuration register
      CHANNEL_CFG10 : aliased CHANNEL_CFG_Register;
      --  Channel 11 configuration register
      CHANNEL_CFG11 : aliased CHANNEL_CFG_Register;
      --  Channel 12 configuration register
      CHANNEL_CFG12 : aliased CHANNEL_CFG_Register;
      --  Channel 13 configuration register
      CHANNEL_CFG13 : aliased CHANNEL_CFG_Register;
      --  Channel 14 configuration register
      CHANNEL_CFG14 : aliased CHANNEL_CFG_Register;
      --  Channel 15 configuration register
      CHANNEL_CFG15 : aliased CHANNEL_CFG_Register;
   end record
     with Volatile;

   for PWM_Peripheral use record
      CHANNEL_CFG0  at 16#0# range 0 .. 31;
      CHANNEL_CFG1  at 16#4# range 0 .. 31;
      CHANNEL_CFG2  at 16#8# range 0 .. 31;
      CHANNEL_CFG3  at 16#C# range 0 .. 31;
      CHANNEL_CFG4  at 16#10# range 0 .. 31;
      CHANNEL_CFG5  at 16#14# range 0 .. 31;
      CHANNEL_CFG6  at 16#18# range 0 .. 31;
      CHANNEL_CFG7  at 16#1C# range 0 .. 31;
      CHANNEL_CFG8  at 16#20# range 0 .. 31;
      CHANNEL_CFG9  at 16#24# range 0 .. 31;
      CHANNEL_CFG10 at 16#28# range 0 .. 31;
      CHANNEL_CFG11 at 16#2C# range 0 .. 31;
      CHANNEL_CFG12 at 16#30# range 0 .. 31;
      CHANNEL_CFG13 at 16#34# range 0 .. 31;
      CHANNEL_CFG14 at 16#38# range 0 .. 31;
      CHANNEL_CFG15 at 16#3C# range 0 .. 31;
   end record;

   --  Pulse-width modulation controller
   PWM_Periph : aliased PWM_Peripheral
     with Import, Address => PWM_Base;

end neorv32.PWM;
