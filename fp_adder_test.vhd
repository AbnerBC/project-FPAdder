-- Listing 3.20
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity fp_adder_test is
   port(
      clk: in std_logic;
      sw: in std_logic_vector(9 downto 0);
      btn: in std_logic_vector(3 downto 0);
      an: out std_logic_vector(3 downto 0);
		KEY: in std_logic_vector(1 downto 0);
      sseg: out std_logic_vector(7 downto 0);
		HEX5, HEX4,HEX3 ,HEX2, HEX1,HEX0: out std_logic_vector(7 downto 0)
   );
end fp_adder_test;

architecture arch of fp_adder_test is
   signal sign1, singS, singF, singT, sign2: std_logic;
   signal exp1, exp2: std_logic_vector(3 downto 0);
   signal frac1, frac2: std_logic_vector(7 downto 0);
   signal sign_out: std_logic;
   signal exp_out: std_logic_vector(3 downto 0);
   signal frac_out: std_logic_vector(7 downto 0);
   signal led3, led2, led1, led0:
             std_logic_vector(7 downto 0);
begin
   -- set up the fp adder input signals
	
		HEX1 <= "10000110";
		HEX4 <= "01000000";

	recebimento: process (KEY)
	
	begin
		if (KEY(1) = '0') then
	
			sign1 <= '0';
			exp1 <= "0000";
			frac1<= "00000000";
	
			sign2 <= '0';
			exp2 <= "0000";
			frac2 <= "00000000";
			
			singS<= '0'; -- para o sinal
			singF<= '0'; -- para a fração
			singT<= '0'; -- para a troca de frac1 para frac2
			
			
			
	elsif (singS = '0'and singF = '0' and singT = '0' and rising_edge(KEY(0))) then
			--sinal1
			sign1 <= sw(0);
			singS <= '1';
	elsif(singS = '1'and singF = '0' and singT = '0' and rising_edge(KEY(0))) then
			--fração1
			frac1 <= sw(7 downto 0);
			singF <= '1';
	elsif(singS= '1'and singF = '1' and singT = '0' and rising_edge(KEY(0))) then
			--expoente1
			exp1 <= sw(3 downto 0);
			singT <= '1';
			singS<= '0'; -- resetando verificação de sinal e fração
			singF<= '0';
			
	elsif (singS = '0'and singF = '0' and singT = '1' and rising_edge(KEY(0))) then
			--sinal2
			sign2 <= sw(0);
			singS <= '1';
	elsif(singS = '1'and singF = '0' and singT = '1' and rising_edge(KEY(0))) then
			--fração2
			frac2 <= sw(7 downto 0);
			singF <= '1';
	elsif(singS = '1'and singF = '1' and singT = '1' and rising_edge(KEY(0))) then
			--expoente2
			exp2 <= sw(3 downto 0);
			
	end if;
	end process;		

	
   -- instantiate fp adder
   fp_add_unit: entity work.fp_adder
      port map(
         sign1=>sign1, sign2=>sign2, exp1=>exp1, exp2=>exp2,
         frac1=>frac1, frac2=>frac2,
         sign_out=>sign_out, exp_out=>exp_out,
         frac_out=>frac_out
      );

   -- instantiate three instances of hex decoders
   -- exponent
   sseg_unit_0: entity work.hex_to_sseg
      port map(hex=>exp_out, dp=>'0', sseg=>HEX0);
   -- 4 LSBs of fraction
   sseg_unit_1: entity work.hex_to_sseg
      port map(hex=>frac_out(3 downto 0),
               dp=>'1', sseg=>HEX2);
	
   -- 4 MSBs of fraction
   sseg_unit_2: entity work.hex_to_sseg
      port map(hex=>frac_out(7 downto 4),
               dp=>'0', sseg=>HEX3);
   -- sign
   HEX5 <= "11111111" when sign_out='0' else -- middle bar
           "10111111";                       -- blank

   -- instantiate 7-seg LED display time-multiplexing module
   disp_unit: entity work.disp_mux
      port map(
         clk=>clk, reset=>'0',
         in0=>led0, in1=>led1, in2=>led2, in3=>led3,
         an=>an, sseg=>sseg
      );
end arch;


