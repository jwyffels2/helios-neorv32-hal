pragma Style_Checks (Off);

--  This spec has been automatically generated from neorv32.svd

pragma Restrictions (No_Elaboration_Code);

with System;

--  Watchdog timer
package neorv32.WDT is
   pragma Preelaborate;

   ---------------
   -- Registers --
   ---------------

   subtype CTRL_WDT_CTRL_EN_Field is neorv32.Bit;
   subtype CTRL_WDT_CTRL_LOCK_Field is neorv32.Bit;
   subtype CTRL_WDT_CTRL_RCAUSE_Field is neorv32.UInt2;
   subtype CTRL_WDT_CTRL_TIMEOUT_Field is neorv32.UInt24;

   --  Control register
   type CTRL_Register is record
      --  WDT enable flag
      WDT_CTRL_EN      : CTRL_WDT_CTRL_EN_Field := 16#0#;
      --  Lock write access to control register, clears on reset only
      WDT_CTRL_LOCK    : CTRL_WDT_CTRL_LOCK_Field := 16#0#;
      --  Read-only. Cause of last system reset: 0=external reset, 1=OCD reset,
      --  2=WDT reset, 3=WDT access violation
      WDT_CTRL_RCAUSE  : CTRL_WDT_CTRL_RCAUSE_Field := 16#0#;
      --  unspecified
      Reserved_4_7     : neorv32.UInt4 := 16#0#;
      --  Timeout value
      WDT_CTRL_TIMEOUT : CTRL_WDT_CTRL_TIMEOUT_Field := 16#0#;
   end record
     with Volatile_Full_Access, Object_Size => 32,
          Bit_Order => System.Low_Order_First;

   for CTRL_Register use record
      WDT_CTRL_EN      at 0 range 0 .. 0;
      WDT_CTRL_LOCK    at 0 range 1 .. 1;
      WDT_CTRL_RCAUSE  at 0 range 2 .. 3;
      Reserved_4_7     at 0 range 4 .. 7;
      WDT_CTRL_TIMEOUT at 0 range 8 .. 31;
   end record;

   -----------------
   -- Peripherals --
   -----------------

   --  Watchdog timer
   type WDT_Peripheral is record
      --  Control register
      CTRL  : aliased CTRL_Register;
      --  Watchdog reset register
      RESET : aliased neorv32.UInt32;
   end record
     with Volatile;

   for WDT_Peripheral use record
      CTRL  at 16#0# range 0 .. 31;
      RESET at 16#4# range 0 .. 31;
   end record;

   --  Watchdog timer
   WDT_Periph : aliased WDT_Peripheral
     with Import, Address => WDT_Base;

end neorv32.WDT;
