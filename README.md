# Humidity-Sensor-HH10D---VHDL-Implementation-via-Quartus-and-MicroSim
Within the framework of the Hardware/Software course, given in Master 1 by Mr. Valaderrama at Faculty Polytechnic of Mons, we have to use a HH10D humidity sensor in order to make it work with a FGPA board following the I2C protocol. 
In this project, we will familiar with the I2C bus, Quartus and MicroSim. In this case, we will implement a VHDL code to control a Humidity sensor HH10D
This project is composed in 4 sections : 
- C Code, which regroups all ".C" codes that you will need to understand the sensor 
- VHDL Code, which takes in account all ".VHD" code used in the project 
- Simulation, regroups Psim and Quartus code to implement
- Documentation, with all our sources and documents about I2C or Humidity Sensor HH10D
- And in the end, a "TUTO" presentation that explains the code process and regroup all our explanations.


```

//-------------Lecture  I2C------------------
signed byte lec_i2c(byte device, byte address, byte del) {
   signed BYTE data;

   i2c_start();
   i2c_write(device);
   i2c_write(address);
   if (del!=0) delay_ms(del);
   i2c_start();
   i2c_write(device | 1);
   data=i2c_read(0);
   i2c_stop();
   return(data);
}

//-------------Lecture  I2C  2 bytes -----------------
signed int16 lecdb_i2c(byte device, byte address, byte del) {
   BYTE dataM,dataL;
   int16 data;

   i2c_start();
   i2c_write(device);
   i2c_write(address);
   if (del!=0) delay_ms(del);
   i2c_start();
   i2c_write(device | 1);
   dataM = i2c_read(1);				// Read MSB
   dataL = i2c_read(0);				// Read LSB
   i2c_stop();
   data=((dataM*256)+dataL);		// True value
   return(data);
}



