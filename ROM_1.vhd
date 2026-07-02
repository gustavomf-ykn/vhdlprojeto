library ieee;
use ieee.std_logic_1164.all;

entity ROM1 is
port(address: in std_logic_vector(3 downto 0); data: out std_logic_vector(15 downto 0));
end ROM1;

architecture Rom_Arch of ROM1 is
begin
    data <= x"1234";
end architecture Rom_Arch;
