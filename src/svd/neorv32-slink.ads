pragma Style_Checks (Off);

--  This spec has been automatically generated from neorv32.svd

pragma Restrictions (No_Elaboration_Code);

with System;

--  Stream Link Interface
package neorv32.SLINK is
   pragma Preelaborate;

   ---------------
   -- Registers --
   ---------------

   subtype CTRL_SLINK_CTRL_EN_Field is neorv32.Bit;
   subtype CTRL_SLINK_CTRL_RX_EMPTY_Field is neorv32.Bit;
   subtype CTRL_SLINK_CTRL_RX_FULL_Field is neorv32.Bit;
   subtype CTRL_SLINK_CTRL_TX_EMPTY_Field is neorv32.Bit;
   subtype CTRL_SLINK_CTRL_TX_FULL_Field is neorv32.Bit;
   subtype CTRL_SLINK_CTRL_RX_LAST_Field is neorv32.Bit;
   subtype CTRL_SLINK_CTRL_IRQ_RX_NEMPTY_Field is neorv32.Bit;
   subtype CTRL_SLINK_CTRL_IRQ_RX_FULL_Field is neorv32.Bit;
   subtype CTRL_SLINK_CTRL_IRQ_TX_EMPTY_Field is neorv32.Bit;
   subtype CTRL_SLINK_CTRL_IRQ_TX_NFULL_Field is neorv32.Bit;
   subtype CTRL_SLINK_CTRL_RX_FIFO_Field is neorv32.UInt4;
   subtype CTRL_SLINK_CTRL_TX_FIFO_Field is neorv32.UInt4;

   --  Control register
   type CTRL_Register is record
      --  SLINK enable flag
      SLINK_CTRL_EN            : CTRL_SLINK_CTRL_EN_Field := 16#0#;
      --  unspecified
      Reserved_1_7             : neorv32.UInt7 := 16#0#;
      --  Read-only. RX FIFO empty
      SLINK_CTRL_RX_EMPTY      : CTRL_SLINK_CTRL_RX_EMPTY_Field := 16#0#;
      --  Read-only. RX FIFO full
      SLINK_CTRL_RX_FULL       : CTRL_SLINK_CTRL_RX_FULL_Field := 16#0#;
      --  Read-only. TX FIFO empty
      SLINK_CTRL_TX_EMPTY      : CTRL_SLINK_CTRL_TX_EMPTY_Field := 16#0#;
      --  Read-only. TX FIFO full
      SLINK_CTRL_TX_FULL       : CTRL_SLINK_CTRL_TX_FULL_Field := 16#0#;
      --  RX link end-of-stream delimiter
      SLINK_CTRL_RX_LAST       : CTRL_SLINK_CTRL_RX_LAST_Field := 16#0#;
      --  unspecified
      Reserved_13_15           : neorv32.UInt3 := 16#0#;
      --  Interrupt if RX FIFO not empty
      SLINK_CTRL_IRQ_RX_NEMPTY : CTRL_SLINK_CTRL_IRQ_RX_NEMPTY_Field := 16#0#;
      --  Interrupt if RX FIFO full
      SLINK_CTRL_IRQ_RX_FULL   : CTRL_SLINK_CTRL_IRQ_RX_FULL_Field := 16#0#;
      --  Interrupt if TX FIFO empty
      SLINK_CTRL_IRQ_TX_EMPTY  : CTRL_SLINK_CTRL_IRQ_TX_EMPTY_Field := 16#0#;
      --  Interrupt if TX FIFO not full
      SLINK_CTRL_IRQ_TX_NFULL  : CTRL_SLINK_CTRL_IRQ_TX_NFULL_Field := 16#0#;
      --  unspecified
      Reserved_20_23           : neorv32.UInt4 := 16#0#;
      --  Read-only. log2(RX FIFO size)
      SLINK_CTRL_RX_FIFO       : CTRL_SLINK_CTRL_RX_FIFO_Field := 16#0#;
      --  Read-only. log2(TX FIFO size)
      SLINK_CTRL_TX_FIFO       : CTRL_SLINK_CTRL_TX_FIFO_Field := 16#0#;
   end record
     with Volatile_Full_Access, Object_Size => 32,
          Bit_Order => System.Low_Order_First;

   for CTRL_Register use record
      SLINK_CTRL_EN            at 0 range 0 .. 0;
      Reserved_1_7             at 0 range 1 .. 7;
      SLINK_CTRL_RX_EMPTY      at 0 range 8 .. 8;
      SLINK_CTRL_RX_FULL       at 0 range 9 .. 9;
      SLINK_CTRL_TX_EMPTY      at 0 range 10 .. 10;
      SLINK_CTRL_TX_FULL       at 0 range 11 .. 11;
      SLINK_CTRL_RX_LAST       at 0 range 12 .. 12;
      Reserved_13_15           at 0 range 13 .. 15;
      SLINK_CTRL_IRQ_RX_NEMPTY at 0 range 16 .. 16;
      SLINK_CTRL_IRQ_RX_FULL   at 0 range 17 .. 17;
      SLINK_CTRL_IRQ_TX_EMPTY  at 0 range 18 .. 18;
      SLINK_CTRL_IRQ_TX_NFULL  at 0 range 19 .. 19;
      Reserved_20_23           at 0 range 20 .. 23;
      SLINK_CTRL_RX_FIFO       at 0 range 24 .. 27;
      SLINK_CTRL_TX_FIFO       at 0 range 28 .. 31;
   end record;

   subtype ROUTE_SLINK_ROUTE_Field is neorv32.UInt4;

   --  Routing information
   type ROUTE_Register is record
      --  RX/TX stream source/destination address/ID
      SLINK_ROUTE   : ROUTE_SLINK_ROUTE_Field := 16#0#;
      --  unspecified
      Reserved_4_31 : neorv32.UInt28 := 16#0#;
   end record
     with Volatile_Full_Access, Object_Size => 32,
          Bit_Order => System.Low_Order_First;

   for ROUTE_Register use record
      SLINK_ROUTE   at 0 range 0 .. 3;
      Reserved_4_31 at 0 range 4 .. 31;
   end record;

   -----------------
   -- Peripherals --
   -----------------

   --  Stream Link Interface
   type SLINK_Peripheral is record
      --  Control register
      CTRL      : aliased CTRL_Register;
      --  Routing information
      ROUTE     : aliased ROUTE_Register;
      --  RX/TX data register
      DATA      : aliased neorv32.UInt32;
      --  TX data register (plus TX end-of-stream delimiter)
      DATA_LAST : aliased neorv32.UInt32;
   end record
     with Volatile;

   for SLINK_Peripheral use record
      CTRL      at 16#0# range 0 .. 31;
      ROUTE     at 16#4# range 0 .. 31;
      DATA      at 16#8# range 0 .. 31;
      DATA_LAST at 16#C# range 0 .. 31;
   end record;

   --  Stream Link Interface
   SLINK_Periph : aliased SLINK_Peripheral
     with Import, Address => SLINK_Base;

end neorv32.SLINK;
