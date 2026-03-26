with neorv32; use neorv32;

package I2C_API is

   subtype I2C_Addr7 is neorv32.UInt16 range 0 .. 127;

    --  Use subtype and restrict Device_Address to be 7 bits
   procedure I2C_Write
     (Device_Address : I2C_Addr7;
      Register       : UInt16;
      Value          : Integer);

   function I2C_Read
     (Device_Address : I2C_Addr7;
      Register       : UInt16) return Integer;

   function I2C_Ping (Device_Address : I2C_Addr7) return Boolean;

end I2C_API;
