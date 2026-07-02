library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity rodada_mod is
port(R: in std_logic; E: in std_logic; clock: in std_logic; end_round: out std_logic; X: out std_logic_vector(3 downto 0));
end rodada_mod;

architecture bhv of rodada_mod is
    signal count: std_logic_vector(4 downto 0) := "01111";
    signal done: std_logic := '0';
begin
    process(clock, R)
    begin
        if R = '1' then
            count <= "01111";
            done <= '0';
        elsif rising_edge(clock) then
            if E = '1' then
                if count = "00000" then
                    done <= '1';
                else
                    count <= count - 1;
                end if;
            end if;
        end if;
    end process;
    X <= count(3 downto 0);
    end_round <= done;
end bhv;
