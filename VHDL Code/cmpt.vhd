library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cmpt is
port (
  i_clk_ref            : in  std_logic;
  i_clk_test           : in  std_logic;
  i_rstb               : in  std_logic;
  humidity         : out std_logic_vector(15 downto 0));
end cmpt;

architecture rtl of cmpt is

-- r1_  register con clock reference domain
-- r2_  register con clock test domain

--  CLOCK REFERENCE signal declaration
signal r1_counter_ref              : unsigned(12 downto 0);  -- 12+1 bit: extra bit used for test counter control
signal r1_counter_test_ena         : std_logic;
signal r1_counter_test_strobe      : std_logic;
signal r1_counter_test_rstb        : std_logic;
--  CLOCK TEST signal declaration
signal r2_counter_test             : unsigned(15 downto 0); -- clock test can be up-to 16 times clock ref
signal r2_counter_test_ena         : std_logic;
signal r2_counter_test_strobe      : std_logic;
signal r2_counter_test_rstb        : std_logic;

-- operations to calculate humidity rate

signal r2_unsigned : unsigned(15 downto 0);
signal r2_integer : integer;
signal freq : integer;
signal intermediate : integer;
signal humidity_int : integer;

signal humidity_unsigned : unsigned(15 downto 0);

signal humidity_vector : std_logic_vector(15 downto 0);

begin
--  CLOCK REFERENCE domain
p_counter_ref : process (i_rstb,i_clk_ref)
begin
  if(i_rstb='0') then
    r1_counter_ref                 <= (others=>'0');
    r1_counter_test_ena            <= '0';
    r1_counter_test_strobe         <= '0';
    r1_counter_test_rstb           <= '0';
  elsif(rising_edge(i_clk_ref)) then
    r1_counter_ref            <= r1_counter_ref + 1;  -- free running

    -- use MSB to control test counter
    r1_counter_test_ena       <= not r1_counter_ref(r1_counter_ref'high);

    -- enable storing for 1024 clock cycle after 256 clock cycle => on doit augmenter cette p�riode de stockage (1024*1/(50*10^6) = 2*10^(-8)*1024 = 2.048*10^(-5) s = 20.48 us = 20480 ns ) parce qu'on veut compter sur une p�riode de 100 us maximum
    if(r1_counter_ref>16#1100#) and (r1_counter_ref<16#2500#) then
      r1_counter_test_strobe     <= '1';
    else
      r1_counter_test_strobe     <= '0';
    end if;

    -- enable reset for 1024 clock cycle; after 1024 clock cycle from storing
    if(r1_counter_ref>16#2900#) and (r1_counter_ref<16#3D00#) then
      r1_counter_test_rstb    <= '0';
    else
      r1_counter_test_rstb    <= '1';
    end if;
  end if;
end process p_counter_ref;

------------------------------------------------------------------------------------------------------------------------

p_clk_test_resync : process (i_clk_test)
begin
  if(rising_edge(i_clk_test)) then
    r2_counter_test_ena        <= r1_counter_test_ena     ;
    r2_counter_test_strobe     <= r1_counter_test_strobe  ;
    r2_counter_test_rstb       <= r1_counter_test_rstb    ;
  end if;
end process p_clk_test_resync;

p_counter_test : process (r2_counter_test_rstb,i_clk_test)
begin
  if(r2_counter_test_rstb='0') then
    r2_counter_test         <= (others=>'0');
  elsif(rising_edge(i_clk_test)) then
    if(r2_counter_test_ena='1') then
      r2_counter_test    <= r2_counter_test + 1;
    end if;
  end if;
end process p_counter_test;

p_counter_test_out : process (i_rstb,i_clk_test)
begin
  if(i_rstb='0') then
    humidity         <= (others=>'1');  -- set all bit to '1' at reset and if test clock is not present
  elsif(rising_edge(i_clk_test)) then
    if(r2_counter_test_strobe='1') then

-- r2_counter_test => unsigned
-- sensitivity of 379 and offset of 7720 : https://forum.arduino.cc/t/humidity-sensor-hh10d/152103/7
-- humidity => std_logic , output
-- divise clk_ref by r2_counter_ref to have a frequency like the datasheet and do the formula : humidity(%) = (offset - freq)*sens/4096
-- clk_ref => 50 millions (integer)


--convert counter r2 into integer to deal with operations
		r2_unsigned <= r2_counter_test;
		r2_integer <= to_integer(r2_unsigned);

-- operations
		r2_integer <= r2_integer*2; -- to have on n entire period
		r2_integer <= r2_integer*1000; -- to avoid bad rounding
		freq <= r2_integer/5000000; -- divide by clk_ref
		freq <= freq/1000;
		intermediate <= 7720 - freq; -- (offset - freq)
		intermediate <= intermediate*379; -- (offset - freq)*sens
		humidity_int <= intermediate/4096; -- (offset - freq)*sens/4096

		-- return to vector

		humidity_unsigned <= to_unsigned(humidity_int, humidity_unsigned'length);
		humidity_vector <= std_logic_vector(humidity_unsigned);

		-- send humidity out

		humidity <= humidity_vector;
    end if;
  end if;
end process p_counter_test_out;

end rtl;
--end bhv;
