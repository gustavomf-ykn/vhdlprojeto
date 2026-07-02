library ieee;
use ieee.std_logic_1164.all;

entity ROM1 is
port(address: in std_logic_vector(3 downto 0); data: out std_logic_vector(15 downto 0));
end ROM1;

architecture Rom_Arch of ROM1 is
    constant D0: std_logic_vector(3 downto 0) := "0000";
    constant D1: std_logic_vector(3 downto 0) := "0001";
    constant D2: std_logic_vector(3 downto 0) := "0010";
    constant D3: std_logic_vector(3 downto 0) := "0011";
    constant D4: std_logic_vector(3 downto 0) := "0100";
    constant D5: std_logic_vector(3 downto 0) := "0101";
begin
    process(address)
    begin
        case address(1 downto 0) is
            when "00" => data <= D0 & D1 & D2 & D3;
            when "01" => data <= D1 & D3 & D5 & D0;
            when "10" => data <= D2 & D4 & D0 & D5;
            when others => data <= D5 & D4 & D3 & D2;
        end case;
    end process;
end architecture Rom_Arch;
