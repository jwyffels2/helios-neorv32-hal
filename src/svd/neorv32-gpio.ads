pragma Style_Checks (Off);

--  This spec was originally automatically generated from neorv32.svd
--  It has since been modified to be more understandable and in-line with the documentation.
--  Modified By Justin Wyffels @jwyffels2 on github
pragma Restrictions (No_Elaboration_Code);

--  General purpose input/output port (GPIO)
--  Base address: 0xFFFC0000
--  Provides:
--    * 32-bit parallel input port  (gpio_i)
--    * 32-bit parallel output port (gpio_o)
--    * Per-pin interrupt configuration and status
package neorv32.GPIO is
   pragma Preelaborate;

   type GPIO_Peripheral is record
      --  PORT_IN
      --  Parallel input port; PORT_IN(i) corresponds to gpio_i(i).
      --  Read-only: reflects the current state of the external GPIO input pins.
      PORT_IN      : aliased neorv32.UInt32;

      --  PORT_OUT
      --  Parallel output port; PORT_OUT(i) corresponds to gpio_o(i).
      --  Read/write: writing to a bit drives the corresponding external GPIO output pin.
      PORT_OUT     : aliased neorv32.UInt32;

      --  RESERVED0
      --  Reserved address space (0xFFFC0008); reads return zero, writes are ignored.
      RESERVED0    : aliased neorv32.UInt32;

      --  RESERVED1
      --  Reserved address space (0xFFFC000C); reads return zero, writes are ignored.
      RESERVED1    : aliased neorv32.UInt32;

      --  IRQ_TYPE
      --  Interrupt trigger type for each input pin.
      --    0 = level-triggered
      --    1 = edge-triggered
      --  IRQ_TYPE(i) configures the trigger type for gpio_i(i).
      IRQ_TYPE     : aliased neorv32.UInt32;

      --  IRQ_POLARITY
      --  Interrupt trigger polarity for each input pin.
      --    0 = low-level / falling-edge
      --    1 = high-level / rising-edge
      --  IRQ_POLARITY(i) configures the polarity for gpio_i(i).
      IRQ_POLARITY : aliased neorv32.UInt32;

      --  IRQ_ENABLE
      --  Per-pin interrupt enable for each input pin.
      --    0 = interrupt disabled for that pin
      --    1 = interrupt enabled for that pin
      --  IRQ_ENABLE(i) enables/disables the interrupt for gpio_i(i).
      IRQ_ENABLE   : aliased neorv32.UInt32;

      --  IRQ_PENDING
      --  Per-pin interrupt pending flags for each input pin.
      --  Each set bit indicates that the configured trigger fired on gpio_i(i).
      --  Pending bits are cleared by writing zero to the corresponding bit(s).
      IRQ_PENDING  : aliased neorv32.UInt32;
   end record
     with Volatile;

   for GPIO_Peripheral use record
      PORT_IN      at 16#00# range 0 .. 31;
      PORT_OUT     at 16#04# range 0 .. 31;
      RESERVED0    at 16#08# range 0 .. 31;
      RESERVED1    at 16#0C# range 0 .. 31;
      IRQ_TYPE     at 16#10# range 0 .. 31;
      IRQ_POLARITY at 16#14# range 0 .. 31;
      IRQ_ENABLE   at 16#18# range 0 .. 31;
      IRQ_PENDING  at 16#1C# range 0 .. 31;
   end record;

   --  General purpose input/output port
   GPIO_Periph : aliased GPIO_Peripheral
     with Import, Address => GPIO_Base;

end neorv32.GPIO;
