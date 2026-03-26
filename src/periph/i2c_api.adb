with TWI_API; use TWI_API;

package body I2C_API is

   procedure I2C_Write
     (Device_Address : I2C_Addr7;
      Register       : UInt16;
      Value          : Integer)
   is
      Write_Address : Integer := Integer (Shift_Left (Device_Address, 1));
      RegHi : Integer := Integer (Shift_Right (Register, 8) and 16#FF#);
      RegLo : Integer := Integer (Register and 16#FF#);
      Data  : Integer := Value;
      Ack   : Integer;
   begin
      TWI_Generate_Start;

      Ack := TWI_Transfer (Write_Address, False);
      if Ack /= 0 then
         TWI_Generate_Stop;
         return;
      end if;

      Ack := TWI_Transfer (RegHi, False);
      if Ack /= 0 then
         TWI_Generate_Stop;
         return;
      end if;

      Ack := TWI_Transfer (RegLo, False);
      if Ack /= 0 then
         TWI_Generate_Stop;
         return;
      end if;

      Ack := TWI_Transfer (Data, False);

      TWI_Generate_Stop;

   end I2C_Write;

   function I2C_Read
     (Device_Address : I2C_Addr7;
      Register       : UInt16) return Integer
   is
      Write_Address : Integer := Integer (Shift_Left (Device_Address, 1));
      Read_Address : Integer := Integer (Shift_Left (Device_Address, 1) + 1);
      RegHi : Integer := Integer (Shift_Right (Register, 8) and 16#FF#);
      RegLo : Integer := Integer (Register and 16#FF#);
      Data  : Integer := 16#FF#;
      Ack   : Integer;
   begin
      TWI_Generate_Start;

      Ack := TWI_Transfer (Write_Address, False);
      if Ack /= 0 then
         TWI_Generate_Stop;
         return -1;
      end if;

      Ack := TWI_Transfer (RegHi, False);
      if Ack /= 0 then
         TWI_Generate_Stop;
         return -1;
      end if;

      Ack := TWI_Transfer (RegLo, False);
      if Ack /= 0 then
         TWI_Generate_Stop;
         return -1;
      end if;

      TWI_Generate_Start;

      if Ack /= 0 then
         TWI_Generate_Stop;
         return -1;
      end if;

      Ack := TWI_Transfer (Read_Address, False);
      if Ack /= 0 then
         TWI_Generate_Stop;
         return -1;
      end if;

      Ack := TWI_Transfer (Data, True);
      if Ack /= 0 then
         TWI_Generate_Stop;
         return -1;
      end if;

      TWI_Generate_Stop;

      TWI_Generate_Start;

      return Data;
   end I2C_Read;

   function I2C_Ping (Device_Address : I2C_Addr7) return Boolean
   is
      Write_Address : Integer := Integer (Shift_Left (Device_Address, 1));
      Ack : Integer;
   begin
      TWI_Generate_Start;
      Ack := TWI_Transfer (Write_Address, False);
      TWI_Generate_Stop;
      return Ack = 0;
   end I2C_Ping;

end I2C_API;
