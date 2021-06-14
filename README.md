# Humidity-Sensor-HH10D---VHDL-Implementation-via-Quartus-and-MicroSim
Within the framework of the Hardware/Software course, given in Master 1 by Mr. Valaderrama at Faculty Polytechnic of Mons, we have to use a HH10D humidity sensor in order to make it work with a FGPA board following the I2C protocol. 
In this project, we will familiar with the I2C bus, Quartus and MicroSim. In this case, we will implement a VHDL code to control a Humidity sensor HH10D
This project is composed in 4 sections : 
- C Code, which regroups all ".C" codes that you will need to understand the sensor 
- VHDL Code, which takes in account all ".VHD" code used in the project 
- Simulation, regroups Psim and Quartus code to implement
- Documentation, with all our sources and documents about I2C or Humidity Sensor HH10D
- And in the end, a "read me" presentation that explains the code process and all our explanation.

First, the main goal of the project is to implement a VHDL code driving in procol I2C that will return the value of humidity in the room. We use for that a HH10D humidity sensor (you can find its datasheet in the documentation section).
To begin, we had on our disposal the C code of the project that we have to translate in VHDL. That code explains us how to use the datas presented in the datasheet and all inputs and outputs of the sensor and how they are used. 
As a first step, let's unpack the first lines of our code and see how many parts it is divided into.

![image](https://user-images.githubusercontent.com/82948794/121937138-a71e8000-cd4a-11eb-86ee-1143e2f71473.png)

This first lines represent the lecture of outputs of the sensor and inputs in the driver that we will explain later.
The next part is composed by the C code responding at the demand of convert a pulse width given by the sensor in a humidity rate :

![image](https://user-images.githubusercontent.com/82948794/121937598-2318c800-cd4b-11eb-8655-020e14024a56.png)

That traduces the the elements given in the data sheet :

![image](https://user-images.githubusercontent.com/82948794/121937446-fb296480-cd4a-11eb-9604-89a54184cefd.png)

At this point, we have the keys to implement this C code into a VHDL one using I2C driver.
To set up the comprehension and see what we will do next. As a drawing is better than a long speech, let us now represent the situation that will define the guideline of our project.

![image](https://user-images.githubusercontent.com/82948794/121956579-96c5cf80-cd61-11eb-84b3-05ad37917e53.png)

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

The I2C_M master code (driver I2C) say how we can change state and when it is possible. We thus know when we have to reset, when the bus is ready to write information on sda, when the machine is able to receive or send datas etc.

![image](https://user-images.githubusercontent.com/82948794/121969260-30967800-cd74-11eb-952c-9be7ef9bdd36.png)



