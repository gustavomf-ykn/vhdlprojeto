library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity somador is
port(
    A: in std_logic_vector(2 downto 0);
    B: in std_logic_vector(2 downto 0);
    C: in std_logic_vector(2 downto 0);
    D: in std_logic_vector(2 downto 0);
    F: out std_logic_vector(2 downto 0)
);
end somador;

architecture circuito of somador is
    signal soma: std_logic_vector(4 downto 0);
begin
    soma <= ("00" & A) + ("00" & B) + ("00" & C) + ("00" & D);
    F <= soma(2 downto 0);
end circuito;
