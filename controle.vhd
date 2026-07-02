library ieee;
use ieee.std_logic_1164.all;

entity controle is
port(
    clock, K1, K0, endtime, endgame, endround: in std_logic;
    R1, R2, E1, E2, E3, E4, E5: out std_logic
);
end controle;

architecture bhv of controle is
    -- WAIT eh palavra reservada em VHDL; por isso foi usado WAITT.
    type STATES is (INIT, SETUP, PLAY, COUNT_ROUND, CHECK, WAITT, RESULT);
    signal EA, PE: STATES := INIT;
begin
    -- K0 vem do ButtonSync e fica ativo em '1' por um ciclo.
    p1: process(clock, K0)
    begin
        if K0 = '1' then
            EA <= INIT;
        elsif rising_edge(clock) then
            EA <= PE;
        end if;
    end process;

    p2: process(EA, K1, endtime, endgame, endround)
    begin
        R1 <= '0';
        R2 <= '0';
        E1 <= '0';
        E2 <= '0';
        E3 <= '0';
        E4 <= '0';
        E5 <= '0';
        PE <= EA;

        case EA is
            when INIT =>
                R1 <= '1';
                R2 <= '1';
                PE <= SETUP;

            when SETUP =>
                E1 <= '1';
                if K1 = '1' then
                    PE <= PLAY;
                else
                    PE <= SETUP;
                end if;

            when PLAY =>
                E2 <= '1';
                if endtime = '1' then
                    PE <= RESULT;
                elsif K1 = '1' then
                    PE <= COUNT_ROUND;
                else
                    PE <= PLAY;
                end if;

            when COUNT_ROUND =>
                R1 <= '1';
                E3 <= '1';
                PE <= CHECK;

            when CHECK =>
                R1 <= '1';
                if (endround = '1') or (endgame = '1') then
                    PE <= RESULT;
                else
                    PE <= WAITT;
                end if;

            when WAITT =>
                R1 <= '1';
                E4 <= '1';
                if K1 = '1' then
                    PE <= PLAY;
                else
                    PE <= WAITT;
                end if;

            when RESULT =>
                E5 <= '1';
                if K1 = '1' then
                    PE <= INIT;
                else
                    PE <= RESULT;
                end if;
        end case;
    end process;
end bhv;
