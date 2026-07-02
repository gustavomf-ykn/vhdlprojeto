# Projeto Final VHDL - Mastermind corrigido

Este pacote foi ajustado para seguir o enunciado do jogo Mastermind e o diagrama datapath-control fornecido na disciplina.

## Top-levels

- `usertop.vhd`: versão para o FPGAEmu/emulador online.
  - Entradas de clock: `CLK_500Hz` e `CLK_1Hz`.
  - Não instancia divisor de frequência, seguindo a observação do PDF do datapath.
- `usertop_de2.vhd`: versão alternativa para placa DE2.
  - Entrada `CLOCK_50`.
  - Instancia `Div_Freq_DE2` para gerar `CLK_1Hz`.

## Principais correções

1. Reset padronizado como ativo em nível alto (`RST = '1'`) nos registradores e contadores.
2. `controle.vhd` refeito mantendo a FSM datapath-control: `INIT`, `SETUP`, `PLAY`, `COUNT_ROUND`, `CHECK`, `WAITT`, `RESULT`.
3. `datapath.vhd` agora recebe `clk_1hz` como entrada e não usa divisor interno no modo emulador.
4. Corrigido o HEX4 para mostrar `TIME`, não `USER(11..8)`.
5. `counter_time.vhd` conta de 0 a 9 e ativa `end_time` após os 10 segundos.
6. `counter_round.vhd` suporta 16 tentativas: R15, R14, ..., R0 e só depois ativa `end_round`.
7. `comp_e.vhd` simplificado e corrigido para não deixar bits de sinais auxiliares sem atribuição.
8. Mantidas as ROMs e a estrutura geral do projeto original.

## Ordem recomendada dos arquivos no emulador/Quartus

Adicione todos os `.vhd` do pacote. Use `usertop` como top-level no emulador online. Para DE2, use `usertop_de2` como top-level.
