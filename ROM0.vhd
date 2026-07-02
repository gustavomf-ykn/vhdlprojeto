library ieee;
use ieee.std_logic_1164.all;

entity ROM0 is
port(
    address: in std_logic_vector(3 downto 0);
    data: out std_logic_vector(15 downto 0)
);
end ROM0;

architecture Rom_Arch of ROM0 is
    type memory is array (0 to 15) of std_logic_vector(15 downto 0);
    constant my_Rom: memory := (
        0 => x"0123", 1 => x"0132", 2 => x"0213", 3 => x"0231",
        4 => x"0312", 5 => x"0321", 6 => x"1023", 7 => x"1032",
        8 => x"1203", 9 => x"1230", 10 => x"1302", 11 => x"1320",
        12 => x"2013", 13 => x"2031", 14 => x"2103", 15 => x"2130"
    );
begin
    with address select
        data <= my_Rom(0) when "0000",
                my_Rom(1) when "0001",
                my_Rom(2) when "0010",
                my_Rom(3) when "0011",
                my_Rom(4) when "0100",
                my_Rom(5) when "0101",
                my_Rom(6) when "0110",
                my_Rom(7) when "0111",
                my_Rom(8) when "1000",
                my_Rom(9) when "1001",
                my_Rom(10) when "1010",
                my_Rom(11) when "1011",
                my_Rom(12) when "1100",
                my_Rom(13) when "1101",
                my_Rom(14) when "1110",
                my_Rom(15) when others;
end architecture Rom_Arch;
