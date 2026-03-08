with Ada.Text_IO; use Ada.Text_IO;
with neorv32; use neorv32;
with neorv32.PWM; use neorv32.PWM;
with neorv32.SYSINFO; use neorv32.SYSINFO;

package body PWM_API is

   ----------------------------------------------------------------------------
   -- Helper function declarations
   ----------------------------------------------------------------------------

   -- Returns True if and only if the currently enabled PWM channels consist
   -- solely of the channel represented by PWM.
   function Only_This_Channel_Enabled (PWM : PWM_T) return Boolean;

   -- Determines whether the PWM prescaler may be updated.
   --
   -- The prescaler can be changed if:
   --  * No PWM channels are currently enabled, or
   --  * The only enabled channel is the one being configured, or
   --  * The requested prescaler matches the currently active prescaler
   function Can_Prescaler_Update (PWM : PWM_T; Requested : Natural) return Boolean;

   -- Supported prescalers defined by the NEORV32 PWM documentation. The array
   -- index corresponds to the value written into CLKPRSC.
   Prescaler_Values : constant array (0 .. 7) of Natural :=
     (2, 4, 8, 64, 128, 1024, 2048, 4096);

   ----------------------------------------------------------------------------
   -- Public API implementation
   ----------------------------------------------------------------------------

   function Create (Channel : PWM_Channel_T) return PWM_T is
      PWM : PWM_T;
   begin
      PWM.Channel := Channel;
      return PWM;
   end Create;

   procedure Configure (PWM : PWM_T; Target_Hz : Hz_T; Duty : Duty_Cycle_T) is
      F_Main : constant Float := Float (SYSINFO_Periph.CLK);
      Ideal_TOP : Float;
      TOP : UInt16;
      CMP : UInt16;
   begin
      for I in Prescaler_Values'Range loop
         Ideal_TOP := (F_Main / (Float (Prescaler_Values (I)) * Target_Hz)) - 1.0;

         if Ideal_TOP >= 0.0 and Ideal_TOP <= Float (UInt16'Last) then
            if Can_Prescaler_Update (PWM, I) then
               PWM_Periph.CLKPRSC := UInt32 (I);

               TOP := UInt16 (Ideal_TOP);
               PWM_Periph.CHANNEL (PWM.Channel).TOPCMP.TOP := TOP;

               CMP := UInt16 (Float (TOP + 1) * Duty);
               PWM_Periph.CHANNEL (PWM.Channel).TOPCMP.CMP := CMP;
            else
               Put_Line ("CLKPRSC conflict: enabled channel requires a different prescaler");
            end if;

            return;
         end if;
      end loop;
   end Configure;

   procedure Set_Polarity (PWM : PWM_T; Inverted : Boolean) is
   begin
      if Inverted then
         PWM_Periph.POLARITY := PWM_Periph.POLARITY or Shift_Left (1, PWM.Channel);
      else
         PWM_Periph.POLARITY := PWM_Periph.POLARITY and not Shift_Left (1, PWM.Channel);
      end if;
   end Set_Polarity;

   procedure Enable (PWM : PWM_T) is
   begin
      if (PWM_Periph.ENABLE and Shift_Left (1, PWM.Channel)) = 0 then
         PWM_Periph.ENABLE := PWM_Periph.ENABLE or Shift_Left (1, PWM.Channel);
      end if;
   end Enable;

   procedure Disable (PWM : PWM_T) is
   begin
      if (PWM_Periph.ENABLE and Shift_Left (1, PWM.Channel)) /= 0 then
         PWM_Periph.ENABLE := PWM_Periph.ENABLE and not Shift_Left (1, PWM.Channel);
      end if;
   end Disable;

   ----------------------------------------------------------------------------
   -- Helper function implementations
   ----------------------------------------------------------------------------

   function Only_This_Channel_Enabled (PWM : PWM_T) return Boolean is
      This_Channel : constant UInt32 := Shift_Left (1, PWM.Channel);
   begin
      return PWM_Periph.ENABLE = This_Channel;
   end Only_This_Channel_Enabled;

   function Can_Prescaler_Update (PWM : PWM_T; Requested : Natural) return Boolean is
   begin
      if PWM_Periph.ENABLE = 0 or else Only_This_Channel_Enabled (PWM) then
         return true;
      end if;

      return Requested = Natural (PWM_Periph.CLKPRSC);
   end Can_Prescaler_Update;

end PWM_API;
