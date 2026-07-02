library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Div_Freq_DE2 is
port(
    clk: in std_logic;
    reset: in std_logic;
    CLK_1Hz: out std_logic
);
end Div_Freq_DE2;

architecture divisor of Div_Freq_DE2 is
    signal cont: std_logic_vector(27 downto 0);
begin
    P1: process(clk, reset)
    begin
        if reset = '1' then
            cont <= x"0000000";
            CLK_1Hz <= '0';
        elsif rising_edge(clk) then
            if cont < x"2FAF07F" then
                CLK_1Hz <= '0';
                cont <= cont + 1;
            else
                cont <= x"0000000";
                CLK_1Hz <= '1';
            end if;
        end if;
    end process;
end architecture;
