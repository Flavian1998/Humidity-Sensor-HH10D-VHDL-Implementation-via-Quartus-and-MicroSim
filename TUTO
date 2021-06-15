First, the main goal of the project is to implement a VHDL code driving in procol I2C that will return the value of humidity in the room. We use for that a HH10D humidity sensor (you can find its datasheet in the documentation section).
To begin, we had on our disposal the C code of the project that we have to translate in VHDL. That code explains us how to use the datas presented in the datasheet and all inputs and outputs of the sensor and how they are used. 
As a first step, let's unpack the first lines of our code and see how many parts it is divided into.

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

```

This first lines represent the lecture of outputs of the sensor and inputs in the driver that we will explain later.
The next part is composed by the C code responding at the demand of convert a pulse width given by the sensor in a humidity rate :

![image](https://user-images.githubusercontent.com/82948794/121937598-2318c800-cd4b-11eb-8655-020e14024a56.png)

That traduces the the elements given in the data sheet :

![image](https://user-images.githubusercontent.com/82948794/121937446-fb296480-cd4a-11eb-9604-89a54184cefd.png)

At this point, we have the keys to implement this C code into a VHDL one using I2C driver.
To set up the comprehension and see what we will do next. As a drawing is better than a long speech, let us now represent the situation that will define the guideline of our project.

![image](https://user-images.githubusercontent.com/82948794/121969918-a818d700-cd75-11eb-8113-0c71c27b04e5.png)

In this case, we can see the FGPA board which is composed by 2 blocks systems :
- Bloc
- I2C Driver

We will start by discovering the sensor and its different outputs

![image](https://user-images.githubusercontent.com/82948794/121933034-d4b4fa80-cd45-11eb-90df-b36d201fbf00.png)

The HH10D humidity sensor is constitued by 3 real outputs : 
- Fout
- SDA
- SCL

Indeed, the 2 others are linked with alimentation (VDD) and ground. They doenst communicate with the FGPA.

The sensor has to return a value wich represent the pulse lengh as we saw above. 

So, we have constructed a code around this pulse width.

METTRE CODE COUNTER

After, we have to test this code with a "Test Bench". The Test Bench simulates the behaviour of the sensor in a case we choose and have to confirms our expectations.

METTRE TEST BENCH COUNTER

Then, we can go to the I2C driver. How work a I2C driver ? First, we consider a driver by its state machine. This means that we implement lines that explain the behaviour of the FPGA and how it has to go step by step. The following picture is quite interesting to understand the work of the driver.

![image](https://user-images.githubusercontent.com/82948794/121968052-d1cfff00-cd71-11eb-9160-18e511fa4ce0.png)

The I2C_M master code (driver I2C) say how we can change state and when it is possible. We thus know when we have to reset, when the bus is ready to write information on sda, when the machine is able to receive or send datas etc. We can see a part of the I2C driver given in Code VHDL Folder and called "I2C_M" just below.

![image](https://user-images.githubusercontent.com/82948794/121969260-30967800-cd74-11eb-952c-9be7ef9bdd36.png)

To end, with have an other block that we will explain in the projet wich is Bloc. It contains all the registers that will be needed ton save the datas coming from the sensor by sda and Fout. All the datas that it has to save are :
- Pulse Width
- Offset
- Sensibility

All these variables are used to calculate the humidity rate (RH%) we search. We can see their implementation in the "Counter" block.

After all these settings, we have to simulate the true behaviour of the all the installation.
First, we have to join all the Inputs/Outputs of the system like the picture just below.

![image](https://user-images.githubusercontent.com/82948794/121970491-f11d5b00-cd76-11eb-87ff-1a47bd5ff636.png)
