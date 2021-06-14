# Humidity-Sensor-HH10D---VHDL-Implementation-via-Quartus-and-MicroSim
 Implementation via Quartus and MicroSim Private  Updated 3 minutes ago In this project, we will familiar with the I2C bus, Quartus and MicroSim. In this case, we will implement a VHDL code to control a Humidity sensor HH10D
This project is composed in 4 sections : 
- C Code, which regroups all ".C" codes that you will need 
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




![image](https://user-images.githubusercontent.com/82948794/121933034-d4b4fa80-cd45-11eb-90df-b36d201fbf00.png)
