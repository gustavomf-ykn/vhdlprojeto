library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tempo_mod is
port(R: in std_logic; clock: in std_logic; E: in std_logic; tempo: out std_logic_vector(3 downto 0); fim_tempo: out std_logic);
end tempo_mod;

architecture bhv of tempo_mod is
    signal count: std_logic_vector(3 downto 0) := "0000";
    signal done: std_logic := '0';
begin
    process(clock, R)
    begin
        if R = '1' then
            count <= "0000";
            done <= '0';
        elsif rising_edge(clock) then
            if E = '1' then
                if done = '0' then
                    if count = "1001" then
                        done <= '1';
                    else
                        count <= count + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;
    tempo <= count;
    fim_tempo <= done;
end bhv;
