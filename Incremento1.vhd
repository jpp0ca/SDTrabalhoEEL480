library ieee;
use ieee.std_logic_1164.all;

entity increment is
	port(
		entrada: in std_logic_vector(3 downto 0);
		resultado: out std_logic_vector(3 downto 0);
		carryOut: out std_logic
	);
end increment;

architecture behavioral of increment is
	component fullAdder4bits is
		port(
			entrada1, entrada2: in std_logic_vector(3 downto 0);
			carryIn: in std_logic;
			soma: out std_logic_vector(3 downto 0);
			carryOut, flagNegativo, flagZero, flagOverflow: out std_logic
		);
	end component;
begin
	-- O fullAdder foi reutilizado
	add1: fullAdder4bits port map(entrada, "0001", '0', resultado, carryOut, open, open, open);

end behavioral;

