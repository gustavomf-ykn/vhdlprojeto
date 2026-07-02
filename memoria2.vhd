library ieee;
use ieee.std_logic_1164.all;

entity memoria2 is
port(address: in std_logic_vector(3 downto 0); data: out std_logic_vector(15 downto 0));
end memoria2;

architecture tabela of memoria2 is
begin
    data <= x"0246" when address(1 downto 0) = "00" else
            x"1357" when address(1 downto 0) = "01" else
            x"7654" when address(1 downto 0) = "10" else
            x"6273";
end tabela;
