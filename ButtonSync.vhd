library ieee;
use ieee.std_logic_1164.all;

entity ButtonSync is
port(
    KEY0, KEY1, CLK: in  std_logic;
    Enter, Reset   : out std_logic
);
end ButtonSync;

architecture ButtonSyncImpl of ButtonSync is
    type STATES is (EsperaApertar, SaidaAtiva, EsperaSoltar);
    signal Enter_state, Reset_state: STATES := EsperaApertar;
    signal Enter_next, Reset_next: STATES := EsperaApertar;
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            Enter_state <= Enter_next;
            Reset_state <= Reset_next;
        end if;
    end process;

    process(KEY0, Reset_state)
    begin
        case Reset_state is
            when EsperaApertar =>
                if KEY0 = '0' then Reset_next <= SaidaAtiva; else Reset_next <= EsperaApertar; end if;
                Reset <= '0';
            when SaidaAtiva =>
                if KEY0 = '0' then Reset_next <= EsperaSoltar; else Reset_next <= EsperaApertar; end if;
                Reset <= '1';
            when EsperaSoltar =>
                if KEY0 = '0' then Reset_next <= EsperaSoltar; else Reset_next <= EsperaApertar; end if;
                Reset <= '0';
        end case;
    end process;

    process(KEY1, Enter_state)
    begin
        case Enter_state is
            when EsperaApertar =>
                if KEY1 = '0' then Enter_next <= SaidaAtiva; else Enter_next <= EsperaApertar; end if;
                Enter <= '0';
            when SaidaAtiva =>
                if KEY1 = '0' then Enter_next <= EsperaSoltar; else Enter_next <= EsperaApertar; end if;
                Enter <= '1';
            when EsperaSoltar =>
                if KEY1 = '0' then Enter_next <= EsperaSoltar; else Enter_next <= EsperaApertar; end if;
                Enter <= '0';
        end case;
    end process;
end ButtonSyncImpl;
