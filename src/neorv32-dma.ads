pragma Style_Checks (Off);

--  This spec has been automatically generated from neorv32.svd

pragma Restrictions (No_Elaboration_Code);

with System;

--  Direct memory access controller
package neorv32.DMA is
   pragma Preelaborate;

   ---------------
   -- Registers --
   ---------------

   subtype CTRL_DMA_CTRL_EN_Field is neorv32.Bit;
   subtype CTRL_DMA_CTRL_START_Field is neorv32.Bit;
   subtype CTRL_DMA_CTRL_FIFO_Field is neorv32.UInt4;
   subtype CTRL_DMA_CTRL_DEMPTY_Field is neorv32.Bit;
   subtype CTRL_DMA_CTRL_DFULL_Field is neorv32.Bit;
   subtype CTRL_DMA_CTRL_ERROR_Field is neorv32.Bit;
   subtype CTRL_DMA_CTRL_DONE_Field is neorv32.Bit;
   subtype CTRL_DMA_CTRL_BUSY_Field is neorv32.Bit;

   --  Control and status register
   type CTRL_Register is record
      --  DMA enable flag
      DMA_CTRL_EN     : CTRL_DMA_CTRL_EN_Field := 16#0#;
      --  Write-only. Start programmed DMA transfer(s)
      DMA_CTRL_START  : CTRL_DMA_CTRL_START_Field := 16#0#;
      --  unspecified
      Reserved_2_15   : neorv32.UInt14 := 16#0#;
      --  Read-only. log2(descriptor FIFO depth)
      DMA_CTRL_FIFO   : CTRL_DMA_CTRL_FIFO_Field := 16#0#;
      --  unspecified
      Reserved_20_26  : neorv32.UInt7 := 16#0#;
      --  Read-only. Descriptor FIFO is empty
      DMA_CTRL_DEMPTY : CTRL_DMA_CTRL_DEMPTY_Field := 16#0#;
      --  Read-only. Descriptor FIFO is full
      DMA_CTRL_DFULL  : CTRL_DMA_CTRL_DFULL_Field := 16#0#;
      --  Error during last transfer; clear by writing one
      DMA_CTRL_ERROR  : CTRL_DMA_CTRL_ERROR_Field := 16#0#;
      --  Transfer(s) done; clear by writing one
      DMA_CTRL_DONE   : CTRL_DMA_CTRL_DONE_Field := 16#0#;
      --  Read-only. Transfer(s) in progress
      DMA_CTRL_BUSY   : CTRL_DMA_CTRL_BUSY_Field := 16#0#;
   end record
     with Volatile_Full_Access, Object_Size => 32,
          Bit_Order => System.Low_Order_First;

   for CTRL_Register use record
      DMA_CTRL_EN     at 0 range 0 .. 0;
      DMA_CTRL_START  at 0 range 1 .. 1;
      Reserved_2_15   at 0 range 2 .. 15;
      DMA_CTRL_FIFO   at 0 range 16 .. 19;
      Reserved_20_26  at 0 range 20 .. 26;
      DMA_CTRL_DEMPTY at 0 range 27 .. 27;
      DMA_CTRL_DFULL  at 0 range 28 .. 28;
      DMA_CTRL_ERROR  at 0 range 29 .. 29;
      DMA_CTRL_DONE   at 0 range 30 .. 30;
      DMA_CTRL_BUSY   at 0 range 31 .. 31;
   end record;

   -----------------
   -- Peripherals --
   -----------------

   --  Direct memory access controller
   type DMA_Peripheral is record
      --  Control and status register
      CTRL : aliased CTRL_Register;
      --  Descriptor FIFO
      DESC : aliased neorv32.UInt32;
   end record
     with Volatile;

   for DMA_Peripheral use record
      CTRL at 16#0# range 0 .. 31;
      DESC at 16#4# range 0 .. 31;
   end record;

   --  Direct memory access controller
   DMA_Periph : aliased DMA_Peripheral
     with Import, Address => DMA_Base;

end neorv32.DMA;
