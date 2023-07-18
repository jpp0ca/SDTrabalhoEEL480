library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity count_display is
    port (CLOCK_50: in std_logic;
    G_HEX0: out std_logic_vector(6 downto 0)
    );
end count_display;

architecture structural of count_display is
    signal counter: unsigned(3 downto 0) := "0000";

    component counter_seconds is
        port(CLOCK_50: in std_logic;
        counter_out: out unsigned(3 downto 0) := "0000"
        );
    end component;

    component decoder7seg is
        port (
            bcd_in: in unsigned(3 downto 0) := "0000";
            seven_seg_out: out std_logic_vector(6 downto 0)
        );
    end component;

begin
    counter0: counter_seconds port map(CLOCK_50, counter);
    decoder0: decoder7seg port map(counter, G_HEX0);
end structural;