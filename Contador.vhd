library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
entity contador is
    Port ( clk: in std_logic; -- clock input
           reset: in std_logic; -- reset input 
           ce: in std_logic; -- enable input
           counter: out std_logic_vector(7 downto 0) -- output 4-bit counter
     );
end contador;
architecture Behavioral of contador is
    signal counter_up: std_logic_vector(7 downto 0);
    signal tick: integer:=0;
begin
-- up counter
process(clk)
begin
    if rising_edge(clk) then
            if reset = '1' then
                counter_up <= (others=>'0');
            elsif ce = '1' and tick = 500000000 then
                M1: for i in 0 to 20
                    loop
                      counter_up <= counter_up + i;
                    end loop;
                tick <= 0;
            elsif tick <= 500000000 then
                tick <= tick + 1;
            end if;
    end if;
 end process;
    counter <= counter_up;            
end Behavioral;
