library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cmpt_TB is
end entity;

architecture tb of cmpt_TB is
--	signal i_clk_ref            : std_logic;
	signal i_clock_test           : std_logic;
	signal i_rstb               : std_logic;
	signal o_clock_freq         : std_logic_vector(15 downto 0);
	
	signal clk_test1				 : std_logic;
	signal clk_test2				 : std_logic;
	signal clk_test3				 : std_logic;


	signal CLK_50            : std_logic := '0';
	signal Test            : std_logic := '0';


constant CLK_PERIOD : time := 20 ns;

constant T : time := 10 us;
constant T1 : time := 17 us;


	component cmpt is
	port (
	  i_clk_ref            : in  std_logic;
	  i_clk_test           : in  std_logic;
	  i_rstb               : in  std_logic;
	  o_clock_freq         : out std_logic_vector(15 downto 0));
	end component;

begin
	UUT : entity work.cmpt port map (
		i_clk_ref => CLK_50,
		i_clk_test => Test, 
		i_rstb => i_rstb,
		o_clock_freq => o_clock_freq 
	);
 
	P_RST: process
	begin 
		i_rstb <= '0';
		wait for CLK_PERIOD*2;
		i_rstb <= '1';
		wait;
	end process;


	 
	P_CLK50: process
	begin 
		CLK_50 <= '1';
		wait for CLK_PERIOD/2;
		CLK_50 <= '0';
		wait for CLK_PERIOD/2;
	end process;
--
--	process
--	begin 
--
--		i_clk_ref <= '1';
--		wait for T1/2;
--		i_clk_ref <= '0';
--		wait for T1/2;
--
--	end process;



	-- clock of the process
--
--	process
--	begin
--		i_clk_test <= '0';
--		wait for T/2;
--		i_clk_test<= '1';
--		wait for T/2;
--	end process;

	-- other examples of clock ref
	-- 5000Hz
	process
	begin 

		clk_test1 <= '1';
		wait for 100 us;
		clk_test1 <= '0';
		wait for 100 us;

	end process;


	-- 6000Hz
	process
	begin 

		clk_test2 <= '1';
		wait for 83 us;
		clk_test2 <= '0';
		wait for 83 us;

	end process;

	-- 7000Hz
	process
	begin 

		clk_test3 <= '1';
		wait for 66 us;
		clk_test3 <= '0';
		wait for 66 us;

	end process;

--
--
--	process
--	begin
--		i_clock_test <= clk_test1;
--		wait for 20 ms;
--		
--		i_clock_test <= clk_test2;
--		wait for 20 ms;
--		
--		i_clock_test <= clk_test3; 
--		wait;
--		
--	end process;
--

process
	variable T : time := 66 us;
begin 

	Test <= '1';
	wait for T/2;
	Test <= '0';
	wait for T/2;
	
	Test <= '1';
	wait for T/2;
	Test <= '0';
	wait for T/2;

	Test <= '1';
	wait for T/2;
	Test <= '0';
	wait for T/2;

	Test <= '1';
	wait for T/2;
	Test <= '0';
	wait for T/2;

	Test <= '1';
	wait for T/2;
	Test <= '0';
	wait for T/2;
	
	if (T > 100 us ) then
		wait;
	end if;
	T := T + 2 us;

end process;






end tb;
