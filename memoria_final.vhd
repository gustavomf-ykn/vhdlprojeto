library ieee;
use ieee.std_logic_1164.all;

entity memd is
port(address: in std_logic_vector(3 downto 0); data: out std_logic_vector(15 downto 0));
end memd;

architecture tabela of memd is
begin
    data <= x"1234";
end tabela;
