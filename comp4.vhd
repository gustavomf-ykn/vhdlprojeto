library ieee;
use ieee.std_logic_1164.all;

entity comp4 is
port(
    P: in std_logic_vector(2 downto 0);
    Peq4: out std_logic
);
end comp4;

architecture circ_comp4 of comp4 is
begin
    Peq4 <= '1' when P = "100" else '0';
end circ_comp4;
