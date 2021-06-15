library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cmpt_TB is
end cmpt_TB;

architecture tb of cmpt_TB is
signal i_clk_ref            : std_logic;
signal i_clk_test           : std_logic;
signal i_rstb               : std_logic;
signal o_clock_freq         : std_logic;

constant T : time := 10e3 ns

begin

UUT : entity work.cmpt port map (i_clk_ref => i_clk_ref, i_clk_test => i_clk_test, o_clock_freq => o_clock_freq);

i_clk_ref <= '1', '0' after 0.835e5 ns, '1' after 1.67e5 ns, '0' after 0.835e5 ns;

-- clock of the process

process
begin
i_clock_test <= '0';
wait for T/2;
i_clock_test <= '1';
wait for T/2;
end process;



end tb;
