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

   ---------------------------------
   -- CHANNEL cluster's Registers --
   ---------------------------------

   subtype TOPCMP_CHANNEL_CMP_Field is neorv32.UInt16;
   subtype TOPCMP_CHANNEL_TOP_Field is neorv32.UInt16;

   type TOPCMP_CHANNEL_Register is record
      --  Channel counter compare value
      CMP : TOPCMP_CHANNEL_CMP_Field := 16#0#;
      --  Channel counter top/wrap value
      TOP : TOPCMP_CHANNEL_TOP_Field := 16#0#;
   end record
     with Volatile_Full_Access, Object_Size => 32,
          Bit_Order => System.Low_Order_First;

   for TOPCMP_CHANNEL_Register use record
      CMP at 0 range 0 .. 15;
      TOP at 0 range 16 .. 31;
   end record;

   --  Channel configuration register
   type CHANNEL_Cluster is record
      TOPCMP : aliased TOPCMP_CHANNEL_Register;
   end record
     with Size => 32;

   for CHANNEL_Cluster use record
      TOPCMP at 0 range 0 .. 31;
   end record;

   --  Channel configuration register
   type CHANNEL_Clusters is array (0 .. 31) of CHANNEL_Cluster;

   -----------------
   -- Peripherals --
   -----------------

   --  Pulse-width modulation controller
   type PWM_Peripheral is record
      --  Channel enable
      ENABLE   : aliased neorv32.UInt32;
      --  Channel polarity
      POLARITY : aliased neorv32.UInt32;
      --  Clock prescaler select
      CLKPRSC  : aliased neorv32.UInt32;
      --  Channel configuration register
      CHANNEL  : aliased CHANNEL_Clusters;
   end record
     with Volatile;

   for PWM_Peripheral use record
      ENABLE   at 16#0# range 0 .. 31;
      POLARITY at 16#4# range 0 .. 31;
      CLKPRSC  at 16#8# range 0 .. 31;
      CHANNEL  at 16#80# range 0 .. 1023;
   end record;

   --  Pulse-width modulation controller
   PWM_Periph : aliased PWM_Peripheral
     with Import, Address => PWM_Base;

end neorv32.PWM;
