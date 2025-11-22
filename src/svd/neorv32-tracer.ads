pragma Style_Checks (Off);

--  This spec has been automatically generated from neorv32.svd

pragma Restrictions (No_Elaboration_Code);

with System;

--  Execution Trace Buffer
package neorv32.TRACER is
   pragma Preelaborate;

   ---------------
   -- Registers --
   ---------------

   subtype CTRL_TRACER_CTRL_EN_Field is neorv32.Bit;
   subtype CTRL_TRACER_CTRL_HSEL_Field is neorv32.Bit;
   subtype CTRL_TRACER_CTRL_START_Field is neorv32.Bit;
   subtype CTRL_TRACER_CTRL_STOP_Field is neorv32.Bit;
   subtype CTRL_TRACER_CTRL_RUN_Field is neorv32.Bit;
   subtype CTRL_TRACER_CTRL_AVAIL_Field is neorv32.Bit;
   subtype CTRL_TRACER_CTRL_IRQ_CLR_Field is neorv32.Bit;
   subtype CTRL_TRACER_CTRL_TBM_Field is neorv32.UInt4;

   --  Control and status register
   type CTRL_Register is record
      --  TRACER enable, reset module when 0
      TRACER_CTRL_EN      : CTRL_TRACER_CTRL_EN_Field := 16#0#;
      --  Hart select for tracing
      TRACER_CTRL_HSEL    : CTRL_TRACER_CTRL_HSEL_Field := 16#0#;
      --  Write-only. Start tracing, flag always reads as zero
      TRACER_CTRL_START   : CTRL_TRACER_CTRL_START_Field := 16#0#;
      --  Write-only. Manually stop tracing, flag always reads as zero
      TRACER_CTRL_STOP    : CTRL_TRACER_CTRL_STOP_Field := 16#0#;
      --  Read-only. Tracing in progress when set
      TRACER_CTRL_RUN     : CTRL_TRACER_CTRL_RUN_Field := 16#0#;
      --  Read-only. Trace data available when set
      TRACER_CTRL_AVAIL   : CTRL_TRACER_CTRL_AVAIL_Field := 16#0#;
      --  Write-only. Clear pending interrupt when writing 1
      TRACER_CTRL_IRQ_CLR : CTRL_TRACER_CTRL_IRQ_CLR_Field := 16#0#;
      --  Read-only. log2 of trace buffer depth
      TRACER_CTRL_TBM     : CTRL_TRACER_CTRL_TBM_Field := 16#0#;
      --  unspecified
      Reserved_11_31      : neorv32.UInt21 := 16#0#;
   end record
     with Volatile_Full_Access, Object_Size => 32,
          Bit_Order => System.Low_Order_First;

   for CTRL_Register use record
      TRACER_CTRL_EN      at 0 range 0 .. 0;
      TRACER_CTRL_HSEL    at 0 range 1 .. 1;
      TRACER_CTRL_START   at 0 range 2 .. 2;
      TRACER_CTRL_STOP    at 0 range 3 .. 3;
      TRACER_CTRL_RUN     at 0 range 4 .. 4;
      TRACER_CTRL_AVAIL   at 0 range 5 .. 5;
      TRACER_CTRL_IRQ_CLR at 0 range 6 .. 6;
      TRACER_CTRL_TBM     at 0 range 7 .. 10;
      Reserved_11_31      at 0 range 11 .. 31;
   end record;

   -----------------
   -- Peripherals --
   -----------------

   --  Execution Trace Buffer
   type TRACER_Peripheral is record
      --  Control and status register
      CTRL      : aliased CTRL_Register;
      --  Stop tracing when reaching this address, set to all-zero to disable
      --  auto-stopping
      STOP_ADDR : aliased neorv32.UInt32;
      --  Trace data: delta source address + first-packet bit
      DELTA_SRC : aliased neorv32.UInt32;
      --  Trace data: delta destination address + trap-entry bit
      DELTA_DST : aliased neorv32.UInt32;
   end record
     with Volatile;

   for TRACER_Peripheral use record
      CTRL      at 16#0# range 0 .. 31;
      STOP_ADDR at 16#4# range 0 .. 31;
      DELTA_SRC at 16#8# range 0 .. 31;
      DELTA_DST at 16#C# range 0 .. 31;
   end record;

   --  Execution Trace Buffer
   TRACER_Periph : aliased TRACER_Peripheral
     with Import, Address => TRACER_Base;

end neorv32.TRACER;
