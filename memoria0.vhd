library ieee;
use ieee.std_logic_1164.all;

entity memoria0 is
port(address: in std_logic_vector(3 downto 0); data: out std_logic_vector(15 downto 0));
end memoria0;

architecture tabela of memoria0 is
begin
    data <= x"0123" when address(1 downto 0) = "00" else
            x"0213" when address(1 downto 0) = "01" else
            x"1032" when address(1 downto 0) = "10" else
            x"2301";
end tabela;
