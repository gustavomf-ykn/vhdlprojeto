library ieee;
use ieee.std_logic_1164.all;

entity comp_n is 
port(
    c, u: in std_logic_vector(3 downto 0);
    P0: out std_logic_vector(2 downto 0)
);
end entity;

architecture circ_comp_n of comp_n is
begin
    P0 <= "001" when c = u else "000";
end circ_comp_n;
