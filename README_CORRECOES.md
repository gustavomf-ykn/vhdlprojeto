# Projeto Final VHDL - Mastermind corrigido

Arquivo principal recomendado: `usertop2.vhd`.

Use `usertop2` como top-level no FPGAEmu. Ele é uma versão autocontida do projeto: inclui FSM, datapath, seleção de nível, comparação P/E, temporização, rodadas, displays HEX e LEDs dentro da própria arquitetura.

## Entradas esperadas no emulador

- `CLK_500Hz`: clock principal da FSM e leitura dos botões.
- `CLK_1Hz`: clock do contador de tempo.
- `KEY(1)`: enter, ativo em nível baixo.
- `KEY(0)`: reset, ativo em nível baixo.
- `SW(1 downto 0)`: nível do jogo.
- `SW(5 downto 2)`: seleção do código dentro do nível.
- `SW(15 downto 0)`: tentativa do usuário no estado PLAY.

## Observação

O repositório também contém arquivos auxiliares e versões parciais usadas durante a correção. Para evitar conflito no emulador, carregue prioritariamente o arquivo `usertop2.vhd` e defina a entidade `usertop2` como top-level.
