package PWM_API is

   type PWM_T is tagged private;

   -- 32-bit PWM channel index
   subtype PWM_Channel_T is Natural range 0 .. 31;

   -- PWM output frequency in Hertz
   subtype Hz_T is Float range 1.0 .. Float'Last;

   -- PWM duty cycle represented as a decimal between 0 and 1
   -- (0.0 = 0%, 1.0 = 100%)
   subtype Duty_Cycle_T is Float range 0.0 .. 1.0;

   -- Creates a PWM handle bound to a specific hardware channel. This does not
   -- touch hardware; it only associates a channel with this API.
   function Create (Channel : PWM_Channel_T) return PWM_T;

   -- Configures the PWM channel to generate a waveform with the requested
   -- frequency and duty cycle.
   --
   -- This procedure programs hardware registers (CLKPRSC, TOP, CMP) and may
   -- fail to update the CLKPRSC prescaler if:
   --  * Other channels are active, or
   --  * The calculated prescaler does not match the existing prescaler
   -- This is to prevent improperly overwriting the prescaler which can break
   -- active PWM channels.
   --
   -- Note: This does not automatically enable the channel.
   procedure Configure (PWM : PWM_T; Target_Hz : Hz_T; Duty : Duty_Cycle_T);

   -- Sets output polarity for this channel. When Inverted = True, the PWM
   -- output is active-low.
   procedure Set_Polarity (PWM : PWM_T; Inverted : Boolean);

   -- Enables PWM output for this channel. If already enabled, this is a
   -- no-op.
   procedure Enable (PWM : PWM_T);

   -- Disables PWM output for this channel. If already disabled, this is a
   -- no-op.
   procedure Disable (PWM : PWM_T);

private

   type PWM_T is tagged record
      Channel : PWM_Channel_T;
   end record;

end PWM_API;
