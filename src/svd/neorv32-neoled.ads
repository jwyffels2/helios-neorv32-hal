pragma Style_Checks (Off);

--  This spec has been automatically generated from neorv32.svd

pragma Restrictions (No_Elaboration_Code);

with System;

--  Smart LED hardware interface
package neorv32.NEOLED is
   pragma Preelaborate;

   ---------------
   -- Registers --
   ---------------

   subtype CTRL_NEOLED_CTRL_EN_Field is neorv32.Bit;
   subtype CTRL_NEOLED_CTRL_PRSC_Field is neorv32.UInt3;
   subtype CTRL_NEOLED_CTRL_T_TOT_Field is neorv32.UInt5;
   subtype CTRL_NEOLED_CTRL_T_0H_Field is neorv32.UInt5;
   subtype CTRL_NEOLED_CTRL_T_1H_Field is neorv32.UInt5;
   subtype CTRL_NEOLED_CTRL_FIFO_Field is neorv32.UInt4;
   subtype CTRL_NEOLED_CTRL_TX_EMPTY_Field is neorv32.Bit;
   subtype CTRL_NEOLED_CTRL_TX_FULL_Field is neorv32.Bit;
   subtype CTRL_NEOLED_CTRL_TX_BUSY_Field is neorv32.Bit;

   --  Control register
   type CTRL_Register is record
      --  NEOLED enable flag
      NEOLED_CTRL_EN       : CTRL_NEOLED_CTRL_EN_Field := 16#0#;
      --  Clock prescaler select
      NEOLED_CTRL_PRSC     : CTRL_NEOLED_CTRL_PRSC_Field := 16#0#;
      --  pulse-clock ticks per total period bit
      NEOLED_CTRL_T_TOT    : CTRL_NEOLED_CTRL_T_TOT_Field := 16#0#;
      --  pulse-clock ticks per ZERO high-time
      NEOLED_CTRL_T_0H     : CTRL_NEOLED_CTRL_T_0H_Field := 16#0#;
      --  pulse-clock ticks per ONE high-time
      NEOLED_CTRL_T_1H     : CTRL_NEOLED_CTRL_T_1H_Field := 16#0#;
      --  unspecified
      Reserved_19_24       : neorv32.UInt6 := 16#0#;
      --  Read-only. log2(TX FIFO size)
      NEOLED_CTRL_FIFO     : CTRL_NEOLED_CTRL_FIFO_Field := 16#0#;
      --  Read-only. TX FIFO is empty
      NEOLED_CTRL_TX_EMPTY : CTRL_NEOLED_CTRL_TX_EMPTY_Field := 16#0#;
      --  Read-only. TX FIFO is full
      NEOLED_CTRL_TX_FULL  : CTRL_NEOLED_CTRL_TX_FULL_Field := 16#0#;
      --  Read-only. busy flag
      NEOLED_CTRL_TX_BUSY  : CTRL_NEOLED_CTRL_TX_BUSY_Field := 16#0#;
   end record
     with Volatile_Full_Access, Object_Size => 32,
          Bit_Order => System.Low_Order_First;

   for CTRL_Register use record
      NEOLED_CTRL_EN       at 0 range 0 .. 0;
      NEOLED_CTRL_PRSC     at 0 range 1 .. 3;
      NEOLED_CTRL_T_TOT    at 0 range 4 .. 8;
      NEOLED_CTRL_T_0H     at 0 range 9 .. 13;
      NEOLED_CTRL_T_1H     at 0 range 14 .. 18;
      Reserved_19_24       at 0 range 19 .. 24;
      NEOLED_CTRL_FIFO     at 0 range 25 .. 28;
      NEOLED_CTRL_TX_EMPTY at 0 range 29 .. 29;
      NEOLED_CTRL_TX_FULL  at 0 range 30 .. 30;
      NEOLED_CTRL_TX_BUSY  at 0 range 31 .. 31;
   end record;

   -----------------
   -- Peripherals --
   -----------------

   --  Smart LED hardware interface
   type NEOLED_Peripheral is record
      --  Control register
      CTRL   : aliased CTRL_Register;
      --  Send 24-bit data
      DATA24 : aliased neorv32.UInt32;
      --  Send 32-bit data
      DATA32 : aliased neorv32.UInt32;
      --  Write any value to send STROBE command
      STROBE : aliased neorv32.UInt32;
   end record
     with Volatile;

   for NEOLED_Peripheral use record
      CTRL   at 16#0# range 0 .. 31;
      DATA24 at 16#4# range 0 .. 31;
      DATA32 at 16#8# range 0 .. 31;
      STROBE at 16#C# range 0 .. 31;
   end record;

   --  Smart LED hardware interface
   NEOLED_Periph : aliased NEOLED_Peripheral
     with Import, Address => NEOLED_Base;

end neorv32.NEOLED;
