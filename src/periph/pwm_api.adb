package body PWM_API is

   type Prescaler_Entry is record
      CLKPRSC : UInt32;
      Result  : UInt32;
   end record;

   Prescalers : constant array (Natural range <>) of Prescaler_Entry :=
     [ (CLKPRSC => 0, Result => 2),
       (CLKPRSC => 1, Result => 4),
       (CLKPRSC => 2, Result => 8),
       (CLKPRSC => 3, Result => 64),
       (CLKPRSC => 4, Result => 128),
       (CLKPRSC => 5, Result => 1024),
       (CLKPRSC => 6, Result => 2048),
       (CLKPRSC => 7, Result => 4096) ];

   procedure Compute_Prescaler_And_Top
     (Target_Hz : Float;
      PSC       : out UInt32;
      TOP       : out UInt16)
   is
      Clk_Hz : constant Float := Float (SYSINFO_Periph.CLK);
      Best_Top : Float := Float (UInt16'Last);
   begin
      for P of Prescalers loop
         declare
            T : constant Float :=
              Clk_Hz / (Float (P.Result) * Target_Hz) - 1.0;
         begin
            if T >= 0.0 and T <= Best_Top then
               Best_Top := T;
               PSC      := P.CLKPRSC;
               TOP      := UInt16 (Integer (T));
            end if;
         end;
      end loop;
   end Compute_Prescaler_And_Top;

   function Create (Channel : PWM_Channel_T) return PWM_T is
      PWM : PWM_T;
   begin
      PWM.Channel := Channel;
      return PWM;
   end Create;

   procedure Set_Hz (PWM : in out PWM_T; Target_Hz : Hz_T) is
   begin
      PWM.Target_Hz := Target_Hz;
      Compute_Prescaler_And_Top (Target_Hz, PWM.PSC_Code, PWM.TOP);
   end Set_Hz;

   procedure Set_Duty_Cycle (PWM : in out PWM_T; Duty : Percentage_T) is
   begin
      PWM.Duty := Duty;
      PWM.CMP  := UInt16 (Integer (Float (PWM.TOP) * PWM.Duty));
   end Set_Duty_Cycle;

   procedure Enable (PWM : in out PWM_T) is
   begin
      -- Disable channel before updating
      PWM_Periph.ENABLE := PWM_Periph.ENABLE and not Shift_Left(1, PWM.Channel);

      -- Update prescaler, TOP, CMP
      PWM_Periph.CLKPRSC := PWM.PSC_Code;
      PWM_Periph.CHANNEL (PWM.Channel).TOPCMP.TOP := PWM.TOP;
      PWM_Periph.CHANNEL (PWM.Channel).TOPCMP.CMP := PWM.CMP;

      -- Normal polarity
      PWM_Periph.POLARITY := PWM_Periph.POLARITY and not Shift_Left(1, PWM.Channel);

      -- Enable channel
      PWM_Periph.ENABLE := PWM_Periph.ENABLE or Shift_Left(1, PWM.Channel);

      PWM.Enabled := True;
   end Enable;

   procedure Disable (PWM : in out PWM_T) is
   begin
      PWM_Periph.ENABLE := PWM_Periph.ENABLE and not Shift_Left(1, PWM.Channel);

      PWM.Enabled := False;
   end Disable;

end PWM_API;
