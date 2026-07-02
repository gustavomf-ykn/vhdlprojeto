library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity comp_e is
port(
    inc, inu: in std_logic_vector(15 downto 0);
    E: out std_logic_vector(2 downto 0)
);
end comp_e;

architecture arc_comp of comp_e is
    signal c3, c2, c1, c0: std_logic_vector(3 downto 0);
    signal u3, u2, u1, u0: std_logic_vector(3 downto 0);
    signal e3, e2, e1, e0: std_logic_vector(2 downto 0);
begin
    c3 <= inc(15 downto 12); c2 <= inc(11 downto 8); c1 <= inc(7 downto 4); c0 <= inc(3 downto 0);
    u3 <= inu(15 downto 12); u2 <= inu(11 downto 8); u1 <= inu(7 downto 4); u0 <= inu(3 downto 0);

    e3 <= "001" when (c3 = u2 or c3 = u1 or c3 = u0) else "000";
    e2 <= "001" when (c2 = u3 or c2 = u1 or c2 = u0) else "000";
    e1 <= "001" when (c1 = u3 or c1 = u2 or c1 = u0) else "000";
    e0 <= "001" when (c0 = u3 or c0 = u2 or c0 = u1) else "000";

    E <= e3 + e2 + e1 + e0;
end arc_comp;
