library ieee;
use ieee.std_logic_1164.all;

entity fullSubtractor4bits is
	port(
		entrada1, entrada2: in std_logic_vector(3 downto 0);
		carryIn: in std_logic;
		difference: out std_logic_vector(3 downto 0);
		carryOut, flagNegativo, flagZero, flagOverflow: out std_logic
	);
end fullSubtractor4bits;

architecture behavioral of fullSubtractor4bits is
	signal inverted: std_logic_vector(3 downto 0);
	signal carrySum: std_logic;

	component invertSign is
		port(
			input: in std_logic_vector(3 downto 0);
			output: out std_logic_vector(3 downto 0)
		);
	end component;

	component fullAdder4bits is
		port(
			entrada1, entrada2: in std_logic_vector(3 downto 0);
			carryIn: in std_logic;
			soma: out std_logic_vector(3 downto 0);
			carryOut, flagNegativo, flagZero, flagOverflow: out std_logic
		);
	end component;
begin

   invert: invertSign port map(entrada2, inverted);

	add: fullAdder4bits port map(
		entrada1, inverted,
		carryIn,
		difference,
		carrySum, flagNegativo, flagZero, flagOverflow
	);

	carryOut <= not carrySum;

end behavioral;
