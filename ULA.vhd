library ieee;
use ieee.std_logic_1164.all;

entity ula is
	port(
		entrada1, entrada2: in std_logic_vector(3 downto 0);
		operador: in std_logic_vector(2 downto 0);
		result: out std_logic_vector(3 downto 0);
		flagCarry, flagNeg, flagZero, flagOverflow: out std_logic
	);
end ula;

architecture behavioral of ula is
	signal resultFinal, resultadoSoma, resultadoSubtracao, resultadoInverteSinal, resultadoIncremento, resultadoComparador, resultadoDobro: std_logic_vector(3 downto 0);
	signal resultadoAnd, resultadoOr: std_logic_vector(3 downto 0);
	signal carrySum, carrySubtracao, carryIncrement,carryDobro: std_logic;
	signal somaNegativa, negativeSubtract: std_logic;
	signal somaZero, zeroSubtract: std_logic;
	signal somaOverflow, overflowSubtract, flagOverflowDobro: std_logic;

	component increment
		port(
			entrada: in std_logic_vector(3 downto 0);
			resultado: out std_logic_vector(3 downto 0);
			carryOut: out std_logic
		);
	end component;

	component dobro
		port(
			entrada: in std_logic_vector(3 downto 0);
			resultado: out std_logic_vector(3 downto 0);
			carryOut: out std_logic;
			flagOverflow: out std_logic
		);
	end component;

	component comparador is
  	 	 Port ( 
      	        a: in std_logic_vector(3 downto 0); -- input 4-bit 
         		b: in std_logic_vector(3 downto 0); -- input 4-bit
			resultado: out std_logic_vector(3 downto 0) -- output 4-bit
    		 );
	end component;

	component fullAdder4bits
		port(
			entrada1, entrada2: in std_logic_vector(3 downto 0);
			carryIn: in std_logic;
			soma: out std_logic_vector(3 downto 0);
			carryOut, flagNegativo, flagZero, flagOverflow: out std_logic
		);
	end component;

	component subtrator
		port(
			entrada1, entrada2: in std_logic_vector(3 downto 0);
			carryIn: in std_logic;
			difference: out std_logic_vector(3 downto 0);
			carryOut, flagNegativo, flagZero, flagOverflow: out std_logic
		);
	end component;

	component invertSign is
		port(
			input: in std_logic_vector(3 downto 0);
			output: out std_logic_vector(3 downto 0)
		);
	end component;

begin
	resultadoAnd <= entrada1 and entrada2;
	resultadoOr  <= entrada1 or  entrada2;
	compara: comparador port map(entrada1,entrada2,resultadoComparador);
	fazDobro: dobro port map(entrada1,resultadoDobro,carryDobro, flagOverflowDobro);
	soma: fullAdder4bits port map(entrada1, entrada2, '0', resultadoSoma, carrySum, somaNegativa, somaZero, somaOverflow);
	subtrai: subtrator port map(entrada1, entrada2, '0', resultadoSubtracao, carrySubtracao, negativeSubtract, zeroSubtract, overflowSubtract);
	invert: invertSign port map(entrada1, resultadoInverteSinal);
	addOne: increment port map(entrada1, resultadoIncremento, carryIncrement);

	with operador select
		resultFinal <= resultadoSoma       when "000",
    			       resultadoSubtracao    when "001",
    			       resultadoIncremento   when "010",
    			       resultadoInverteSinal when "011",
    			       resultadoAnd          when "100",
    			       resultadoOr           when "101",
    			       resultadoComparador   when "110",
    			       resultadoDobro        when "111",
    			       "0000"                when others;

	result <= resultFinal;

	with operador select
		flagCarry <= carrySum when "000",
			     carrySubtracao when "001",
			     carryIncrement when "010",
			     carryDobro when "111",
		             '0' when others;

	with operador select
		flagNeg <= somaNegativa when "000",
		           negativeSubtract when "001",
		           resultFinal(3) when others;

	with operador select
		flagZero <= somaZero when "000",
		            zeroSubtract when "001",
					not(resultFinal(3) or resultFinal(2) or resultFinal(1) or resultFinal(0)) when others;

	with operador select
		flagOverflow <= somaOverflow when "000",
		                overflowSubtract when "001",
							 flagOverflowDobro when "111",
					    '0' when others;
end behavioral;
