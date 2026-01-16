package body PWM_API is

   -- PWM prescaler configuration record
   type Prescaler_Entry is record
      CLKPRSC : UInt32;
      Clock_Prescaler : UInt32;
   end record;

   -- PWM prescalers array containing the clock prescaler value used by the PWM counter
   Prescalers : constant array (Natural range <>) of Prescaler_Entry :=
     [ (0,    2),
       (1,    4),
       (2,    8),
       (3,   64),
       (4,  128),
       (5, 1024),
       (6, 2048),
       (7, 4096) ];

   ----------------------------------------------------------------------------
   -- Compute_CLKPRSC_And_TOP
   --
   -- Selects the prescaler and TOP value that produce a PWM frequency closest
   -- to the requested Target_Hz.
   ----------------------------------------------------------------------------
   procedure Compute_CLKPRSC_And_TOP (Target_Hz : Hz_T; CLKPRSC : out UInt32; TOP : out UInt16) is
      F_Main : constant Float := Float (SYSINFO_Periph.CLK);
      Best_Error_Hz : Float := Float'Last; -- Track smallest frequenct error
   begin
      for P of Prescalers loop
         declare
            -- Get the ideal TOP and round it to minimize frequency error
            Ideal_TOP : Float := (F_Main / (Float (P.Clock_Prescaler) * Target_Hz)) - 1.0;
            Rounded_TOP : Integer := Integer (Ideal_TOP + 0.5);
         begin
            if Rounded_TOP >= 0 and Rounded_TOP <= Integer (UInt16'Last) then
               declare
                  -- Compute actual frequency with this prescaler and store error
                  Actual_Frequency : Float := F_Main / (Float (P.Clock_Prescaler) * Float (Rounded_TOP + 1));
                  Error : Float := abs (Actual_Frequency - Target_Hz);
               begin
                  -- Use the prescaler with the smallest error
                  if Error < Best_Error_Hz then
                     Best_Error_Hz := Error;
                     CLKPRSC := P.CLKPRSC;
                     TOP := UInt16 (Rounded_TOP);
                  end if;
               end;
            end if;
         end;
      end loop;
   end Compute_CLKPRSC_And_TOP;

   function Create (Channel : PWM_Channel_T) return PWM_T is
      PWM : PWM_T;
   begin
      PWM.Channel := Channel;
      return PWM;
   end Create;

   procedure Set_Frequency (PWM : in out PWM_T; Target_Hz : Hz_T) is
   begin
      PWM.Frequency := Target_Hz;
      Compute_CLKPRSC_And_TOP (Target_Hz, PWM.CLKPRSC, PWM.TOP);

      PWM.CMP := UInt16 (Integer (Float (PWM.TOP + 1) * PWM.Duty));
   end Set_Frequency;

   procedure Set_Duty_Cycle (PWM : in out PWM_T; Duty : Duty_Cycle_T) is
   begin
      PWM.Duty := Duty;
      PWM.CMP := UInt16 (Integer (Float (PWM.TOP + 1) * Duty));
   end Set_Duty_Cycle;

   procedure Enable (PWM : in out PWM_T) is
   begin
      -- Disable channel before reconfiguration
      PWM_Periph.ENABLE := PWM_Periph.ENABLE and not Shift_Left (1, PWM.Channel);

      -- Configure global prescaler
      PWM_Periph.CLKPRSC := PWM.CLKPRSC;

      -- Program TOP and CMP
      PWM_Periph.CHANNEL (PWM.Channel).TOPCMP.TOP := PWM.TOP;
      PWM_Periph.CHANNEL (PWM.Channel).TOPCMP.CMP := PWM.CMP;

      -- Normal polarity
      PWM_Periph.POLARITY := PWM_Periph.POLARITY and not Shift_Left (1, PWM.Channel);

      -- Enable channel
      PWM_Periph.ENABLE := PWM_Periph.ENABLE or Shift_Left (1, PWM.Channel);

      PWM.Enabled := True;
   end Enable;

   procedure Disable (PWM : in out PWM_T) is
   begin
      PWM_Periph.ENABLE := PWM_Periph.ENABLE and not Shift_Left (1, PWM.Channel);

      PWM.Enabled := False;
   end Disable;

end PWM_API;
