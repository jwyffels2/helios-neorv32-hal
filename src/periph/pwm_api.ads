with neorv32; use neorv32;
with neorv32.PWM; use neorv32.PWM;
with neorv32.SYSINFO; use neorv32.SYSINFO;

package PWM_API is

   type PWM_T is tagged private;

   -- 32-bit PWM channel index
   subtype PWM_Channel_T is Natural range 0 .. 31;

   -- PWM output frequency in Hertz
   subtype Hz_T is Float range 1.0 .. Float'Last;

   -- PWM duty cycle represented as a decimal between 0 and 1
   -- (0.0 = 0%, 1.0 = 100%)
   subtype Duty_Cycle_T is Float range 0.0 .. 1.0;

   ----------------------------------------------------------------------------
   -- Create
   --
   -- Constructs a PWM object bound to a specific PWM channel index.
   ----------------------------------------------------------------------------
   function Create (Channel : PWM_Channel_T) return PWM_T;

   ----------------------------------------------------------------------------
   -- Set_Frequency
   --
   -- Computes and stores the prescaler and TOP values required to achieve the
   -- requested PWM frequency. CMP is also recomputed to preserve the current
   -- duty cycle.
   ----------------------------------------------------------------------------
   procedure Set_Frequency (PWM : in out PWM_T; Target_Hz : Hz_T);

   ----------------------------------------------------------------------------
   -- Set_Duty_Cycle
   --
   -- Updates the stored duty cycle and recomputes CMP accordingly.
   ----------------------------------------------------------------------------
   procedure Set_Duty_Cycle (PWM : in out PWM_T; Duty : Duty_Cycle_T);

   ----------------------------------------------------------------------------
   -- Enable
   --
   -- Programs the PWM hardware registers for this channel and enables it.
   ----------------------------------------------------------------------------
   procedure Enable  (PWM : in out PWM_T);

   ----------------------------------------------------------------------------
   -- Disable
   --
   -- Disables the PWM channel.
   ----------------------------------------------------------------------------
   procedure Disable (PWM : in out PWM_T);

private

   -- Internal representation of a PWM channel configuration.
   -- All fields correspond to hardware-visible parameters or
   -- derived values required to program the PWM peripheral.
   type PWM_T is tagged record
      Channel   : PWM_Channel_T := 0;
      TOP       : UInt16        := 0;
      CMP       : UInt16        := 0;
      CLKPRSC   : UInt32        := 0;
      Duty      : Duty_Cycle_T  := 0.5;
      Frequency : Float         := 5.0;
      Enabled   : Boolean       := False;
   end record;

end PWM_API;
