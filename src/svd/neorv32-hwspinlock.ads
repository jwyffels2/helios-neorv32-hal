pragma Style_Checks (Off);

--  This spec has been automatically generated from neorv32.svd

pragma Restrictions (No_Elaboration_Code);

with System;

--  Hardware spinlocks
package neorv32.HWSPINLOCK is
   pragma Preelaborate;

   ---------------
   -- Registers --
   ---------------

   -----------------
   -- Peripherals --
   -----------------

   --  Hardware spinlocks
   type HWSPINLOCK_Peripheral is record
      --  32 locks, one binary spinlock per word
      LOCK   : aliased neorv32.UInt32;
      --  Status of all 32 spinlocks
      STATUS : aliased neorv32.UInt32;
   end record
     with Volatile;

   for HWSPINLOCK_Peripheral use record
      LOCK   at 16#0# range 0 .. 31;
      STATUS at 16#80# range 0 .. 31;
   end record;

   --  Hardware spinlocks
   HWSPINLOCK_Periph : aliased HWSPINLOCK_Peripheral
     with Import, Address => HWSPINLOCK_Base;

end neorv32.HWSPINLOCK;
