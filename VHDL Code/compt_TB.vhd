library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
USE ieee.math_real.ALL;

entity compt_TB is
end entity;


architecture RTL of compt_TB is

constant clk_period : time := 10e3 ns; -- clock at frequency 10^6 Hz

	-- Build an enumerated type for the state machine
	type state_type is (s0, s1, s2, s3, s4, s5,s6,s7,s8);

	-- Register to hold the current state
	signal STATE : state_type;
	
	signal i_clk_ref : std_logic := '0';
	signal i_clk_test : std_logic := '0';
	signal i_rstb : std_logic;
	signal REG_out: std_logic_vector(7 downto 0);
	signal REG_out_2: std_logic_vector(7 downto 0);
	signal GPIO_0_0 : std_logic;
	signal GPIO_0_1: std_logic;

















end RTL;