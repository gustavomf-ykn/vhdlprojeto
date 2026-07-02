library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Para uso com o clock de 500Hz do FPGAEmu, caso queira gerar 1Hz internamente.
-- No usertop do emulador deste projeto, o CLK_1Hz entra direto, conforme o PDF.
entity Div_Freq is
port(
    clk: in std_logic;
    reset: in std_logic;
    CLK_1Hz, sim_2hz: out std_logic
);
end Div_Freq;

architecture divisor of Div_Freq is
    signal cont: std_logic_vector(11 downto 0);
begin
    P1: process(clk, reset)
    begin
        if reset = '1' then
            cont <= x"000";
            CLK_1Hz <= '0';
            sim_2hz <= '0';
        elsif rising_edge(clk) then
            if cont < x"0F9" then
                sim_2hz <= '0';
                CLK_1Hz <= '0';
                cont <= cont + 1;
            elsif cont < x"1F3" then
                CLK_1Hz <= '0';
                sim_2hz <= '1';
                cont <= cont + 1;
            else
                cont <= x"000";
                CLK_1Hz <= '1';
                sim_2hz <= '1';
            end if;
        end if;
    end process;
end architecture;
