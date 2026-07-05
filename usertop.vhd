library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity usertop is
port(
    CLK_500Hz: in std_logic;
    CLK_1Hz: in std_logic;
    KEY: in std_logic_vector(3 downto 0);
    SW: in std_logic_vector(17 downto 0);
    LEDR: out std_logic_vector(17 downto 0);
    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7: out std_logic_vector(6 downto 0)
);
end usertop;

architecture completo of usertop is
    type states is (INIT, SETUP, PLAY, COUNT_ROUND, CHECK, WAITT, RESULT);
    signal EA, PE: states := INIT;
    signal enter_pulse, reset_pulse: std_logic := '0';
    signal key0_ant, key1_ant: std_logic := '1';
    signal sel: std_logic_vector(5 downto 0) := (others => '0');
    signal code, user: std_logic_vector(15 downto 0) := (others => '0');
    signal p, e, p_reg, e_reg: std_logic_vector(2 downto 0) := (others => '0');
    signal rodada: std_logic_vector(3 downto 0) := "1111";
    signal tempo: std_logic_vector(3 downto 0) := "0000";
    signal end_time, end_game, end_round: std_logic := '0';
    signal score: std_logic_vector(7 downto 0);

    function seg7(g: std_logic_vector(3 downto 0)) return std_logic_vector is
    begin
        case g is
            when "0000" => return "1000000";
            when "0001" => return "1111001";
            when "0010" => return "0100100";
            when "0011" => return "0110000";
            when "0100" => return "0011001";
            when "0101" => return "0010010";
            when "0110" => return "0000010";
            when "0111" => return "1111000";
            when "1000" => return "0000000";
            when "1001" => return "0010000";
            when "1010" => return "0001000";
            when "1011" => return "0000011";
            when "1100" => return "1000110";
            when "1101" => return "0100001";
            when "1110" => return "0000110";
            when others => return "0001110";
        end case;
    end;

    function segredo(s: std_logic_vector(5 downto 0)) return std_logic_vector is
    begin
        case s(1 downto 0) is
            when "00" =>
                case s(5 downto 4) is
                    when "00" => return x"0123";
                    when "01" => return x"0123";
                    when "10" => return x"0246";
                    when others => return x"1234";
                end case;
            when "01" =>
                case s(5 downto 4) is
                    when "00" => return x"0213";
                    when "01" => return x"1350";
                    when "10" => return x"1357";
                    when others => return x"5790";
                end case;
            when "10" =>
                case s(5 downto 4) is
                    when "00" => return x"1032";
                    when "01" => return x"2405";
                    when "10" => return x"7654";
                    when others => return x"2468";
                end case;
            when others =>
                case s(5 downto 4) is
                    when "00" => return x"2301";
                    when "01" => return x"5432";
                    when "10" => return x"6273";
                    when others => return x"7081";
                end case;
        end case;
    end;

    function existe_pos_errada(cod, usu: std_logic_vector(15 downto 0)) return std_logic_vector is
        variable c3, c2, c1, c0, u3, u2, u1, u0: std_logic_vector(3 downto 0);
        variable r: std_logic_vector(2 downto 0) := "000";
    begin
        c3 := cod(15 downto 12); c2 := cod(11 downto 8); c1 := cod(7 downto 4); c0 := cod(3 downto 0);
        u3 := usu(15 downto 12); u2 := usu(11 downto 8); u1 := usu(7 downto 4); u0 := usu(3 downto 0);
        if c3 = u2 or c3 = u1 or c3 = u0 then r := r + 1; end if;
        if c2 = u3 or c2 = u1 or c2 = u0 then r := r + 1; end if;
        if c1 = u3 or c1 = u2 or c1 = u0 then r := r + 1; end if;
        if c0 = u3 or c0 = u2 or c0 = u1 then r := r + 1; end if;
        return r;
    end;

    function pos_certa(cod, usu: std_logic_vector(15 downto 0)) return std_logic_vector is
        variable r: std_logic_vector(2 downto 0) := "000";
    begin
        if cod(15 downto 12) = usu(15 downto 12) then r := r + 1; end if;
        if cod(11 downto 8) = usu(11 downto 8) then r := r + 1; end if;
        if cod(7 downto 4) = usu(7 downto 4) then r := r + 1; end if;
        if cod(3 downto 0) = usu(3 downto 0) then r := r + 1; end if;
        return r;
    end;

    function termo(x: std_logic_vector(3 downto 0)) return std_logic_vector is
        variable r: std_logic_vector(15 downto 0) := (others => '0');
        variable n: integer;
    begin
        n := conv_integer(x);
        for i in 0 to 15 loop
            if i <= n then r(i) := '1'; end if;
        end loop;
        return r;
    end;
begin
    code <= segredo(sel);
    p <= pos_certa(code, user);
    e <= existe_pos_errada(code, user);
    end_game <= '1' when p = "100" else '0';
    score <= "000" & end_game & (rodada and not(end_time & end_time & end_time & end_time));

    process(CLK_500Hz)
    begin
        if rising_edge(CLK_500Hz) then
            enter_pulse <= '0';
            reset_pulse <= '0';
            if key1_ant = '1' and KEY(1) = '0' then enter_pulse <= '1'; end if;
            if key0_ant = '1' and KEY(0) = '0' then reset_pulse <= '1'; end if;
            key1_ant <= KEY(1);
            key0_ant <= KEY(0);
        end if;
    end process;

    process(CLK_500Hz, reset_pulse)
    begin
        if reset_pulse = '1' then
            EA <= INIT;
        elsif rising_edge(CLK_500Hz) then
            EA <= PE;
        end if;
    end process;

    process(EA, enter_pulse, end_time, end_game, end_round)
    begin
        PE <= EA;
        case EA is
            when INIT => PE <= SETUP;
            when SETUP => if enter_pulse = '1' then PE <= PLAY; else PE <= SETUP; end if;
            when PLAY =>
                if end_time = '1' then PE <= RESULT;
                elsif enter_pulse = '1' then PE <= COUNT_ROUND;
                else PE <= PLAY; end if;
            when COUNT_ROUND => PE <= CHECK;
            when CHECK => if end_game = '1' or end_round = '1' then PE <= RESULT; else PE <= WAITT; end if;
            when WAITT => if enter_pulse = '1' then PE <= PLAY; else PE <= WAITT; end if;
            when RESULT => if enter_pulse = '1' then PE <= INIT; else PE <= RESULT; end if;
        end case;
    end process;

    process(CLK_500Hz, reset_pulse)
    begin
        if reset_pulse = '1' then
            sel <= (others => '0');
            user <= (others => '0');
            p_reg <= (others => '0');
            e_reg <= (others => '0');
            rodada <= "1111";
            end_round <= '0';
        elsif rising_edge(CLK_500Hz) then
            if EA = INIT then
                sel <= (others => '0');
                user <= (others => '0');
                p_reg <= (others => '0');
                e_reg <= (others => '0');
                rodada <= "1111";
                end_round <= '0';
            elsif EA = SETUP then
                sel <= SW(5 downto 0);
            elsif EA = PLAY then
                user <= SW(15 downto 0);
            elsif EA = COUNT_ROUND then
                if rodada = "0000" then
                    end_round <= '1';
                else
                    rodada <= rodada - 1;
                end if;
            elsif EA = WAITT then
                p_reg <= p;
                e_reg <= e;
            end if;
        end if;
    end process;

    process(CLK_1Hz, reset_pulse, EA)
    begin
        if reset_pulse = '1' or EA = INIT or EA = COUNT_ROUND or EA = CHECK or EA = WAITT then
            tempo <= "0000";
            end_time <= '0';
        elsif rising_edge(CLK_1Hz) then
            if EA = PLAY then
                if tempo = "1001" then
                    end_time <= '1';
                else
                    tempo <= tempo + 1;
                end if;
            end if;
        end if;
    end process;

    process(EA, sel, user, code, p_reg, e_reg, tempo, score, rodada)
    begin
        HEX0 <= "1111111"; HEX1 <= "1111111"; HEX2 <= "1111111"; HEX3 <= "1111111";
        HEX4 <= "1111111"; HEX5 <= "1111111"; HEX6 <= "1111111"; HEX7 <= "1111111";
        case EA is
            when SETUP =>
                HEX3 <= "1000110";
                HEX2 <= seg7(sel(5 downto 2));
                HEX1 <= "1000111";
                HEX0 <= seg7("00" & sel(1 downto 0));
            when PLAY =>
                HEX5 <= "0000111";
                HEX4 <= seg7(tempo);
                HEX3 <= seg7(user(15 downto 12));
                HEX2 <= seg7(user(11 downto 8));
                HEX1 <= seg7(user(7 downto 4));
                HEX0 <= seg7(user(3 downto 0));
            when WAITT =>
                HEX3 <= "0001100";
                HEX2 <= seg7('0' & p_reg);
                HEX1 <= "0000110";
                HEX0 <= seg7('0' & e_reg);
            when RESULT =>
                HEX7 <= seg7(score(7 downto 4));
                HEX6 <= seg7(score(3 downto 0));
                HEX3 <= seg7(code(15 downto 12));
                HEX2 <= seg7(code(11 downto 8));
                HEX1 <= seg7(code(7 downto 4));
                HEX0 <= seg7(code(3 downto 0));
            when others => null;
        end case;
    end process;

    LEDR(15 downto 0) <= termo(rodada) when EA /= SETUP else (others => '0');
    LEDR(17 downto 16) <= "00";
end completo;
