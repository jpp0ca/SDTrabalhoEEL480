library ieee;
use ieee.std_logic_1164.all;

entity fullAdder is
	port(
		entrada1, entrada2: in std_logic_vector(3 downto 0);
		carryIn: in std_logic;
		soma: out std_logic_vector(3 downto 0);
		carryOut, flagNegativo, flagZero, flagOverflow: out std_logic
	);
end fullAdder;

architecture behavioral of fullAdder is
	signal carry0, carry1, carry2, carry3, carry4: std_logic;
	signal a0, a1, a2, a3: std_logic;
	signal b0, b1, b2, b3: std_logic;
	signal s0, s1, s2, s3: std_logic;

	component fullAdder
		port(
			entrada1, entrada2, carryIn: in std_logic;
			soma, carryOut: out std_logic
		);
	end component;
begin
	
	a0 <= entrada1(0);
	a1 <= entrada1(1);
	a2 <= entrada1(2);
	a3 <= entrada1(3);

	b0 <= entrada2(0);
	b1 <= entrada2(1);
	b2 <= entrada2(2);
	b3 <= entrada2(3);

	carry0 <= carryIn;

	bit0: fullAdder port map(a0, b0, carry0, s0, carry1);
	bit1: fullAdder port map(a1, b1, carry1, s1, carry2);
	bit2: fullAdder port map(a2, b2, carry2, s2, carry3);
	bit3: fullAdder port map(a3, b3, carry3, s3, carry4);

	carryOut <= carry4;

	soma(0) <= s0;
	soma(1) <= s1;
	soma(2) <= s2;
	soma(3) <= s3;

	flagNegativo <= s3;

	flagZero <= not(s0 or s1 or s2 or s3);

	flagOverflow <= carry3 xor carry4;

end behavioral;

