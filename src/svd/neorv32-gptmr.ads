pragma Style_Checks (Off);

--  This spec has been automatically generated from neorv32.svd

pragma Restrictions (No_Elaboration_Code);

with System;

--  General purpose timer
package neorv32.GPTMR is
   pragma Preelaborate;

   ---------------
   -- Registers --
   ---------------

   subtype CSR0_ENABLE_Field is neorv32.UInt16;
   subtype CSR0_MODE_Field is neorv32.UInt16;

   --  Control and status register 0
   type CSR0_Register is record
      --  Per-slice enable bit
      ENABLE : CSR0_ENABLE_Field := 16#0#;
      --  Per-slice mode bit (0 = single-shot mode, 1 = continuous mode)
      MODE   : CSR0_MODE_Field := 16#0#;
   end record
     with Volatile_Full_Access, Object_Size => 32,
          Bit_Order => System.Low_Order_First;

   for CSR0_Register use record
      ENABLE at 0 range 0 .. 15;
      MODE   at 0 range 16 .. 31;
   end record;

   subtype CSR1_IRQ_Field is neorv32.UInt16;
   subtype CSR1_PRSC_Field is neorv32.UInt3;

   --  Control and status register 1
   type CSR1_Register is record
      --  Per-slice interrupt-pending bit; write 0 to clear
      IRQ            : CSR1_IRQ_Field := 16#0#;
      --  Global clock prescaler select
      PRSC           : CSR1_PRSC_Field := 16#0#;
      --  unspecified
      Reserved_19_31 : neorv32.UInt13 := 16#0#;
   end record
     with Volatile_Full_Access, Object_Size => 32,
          Bit_Order => System.Low_Order_First;

   for CSR1_Register use record
      IRQ            at 0 range 0 .. 15;
      PRSC           at 0 range 16 .. 18;
      Reserved_19_31 at 0 range 19 .. 31;
   end record;

   -------------------------------
   -- SLICE cluster's Registers --
   -------------------------------

   --  Timer slice
   type SLICE_Cluster is record
      --  Counter register
      CNT : aliased neorv32.UInt32;
      --  Threshold register
      THR : aliased neorv32.UInt32;
   end record
     with Size => 64;

   for SLICE_Cluster use record
      CNT at 16#0# range 0 .. 31;
      THR at 16#4# range 0 .. 31;
   end record;

   --  Timer slice
   type SLICE_Clusters is array (0 .. 15) of SLICE_Cluster;

   -----------------
   -- Peripherals --
   -----------------

   --  General purpose timer
   type GPTMR_Peripheral is record
      --  Control and status register 0
      CSR0  : aliased CSR0_Register;
      --  Control and status register 1
      CSR1  : aliased CSR1_Register;
      --  Timer slice
      SLICE : aliased SLICE_Clusters;
   end record
     with Volatile;

   for GPTMR_Peripheral use record
      CSR0  at 16#0# range 0 .. 31;
      CSR1  at 16#4# range 0 .. 31;
      SLICE at 16#80# range 0 .. 1023;
   end record;

   --  General purpose timer
   GPTMR_Periph : aliased GPTMR_Peripheral
     with Import, Address => GPTMR_Base;

end neorv32.GPTMR;
