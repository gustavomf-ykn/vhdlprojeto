# Projeto Final VHDL - Mastermind corrigido

Arquivo principal: `usertop.vhd`.

Use `usertop` como top-level no FPGAEmu. Esta versão está autocontida: inclui FSM, datapath, seleção de nível, comparação P/E, temporização, rodadas, displays HEX e LEDs dentro da própria arquitetura.

## Entradas esperadas no emulador

- `CLK_500Hz`: clock principal da FSM e leitura dos botões.
- `CLK_1Hz`: clock do contador de tempo.
- `KEY(1)`: enter, ativo em nível baixo.
- `KEY(0)`: reset, ativo em nível baixo.
- `SW(1 downto 0)`: nível do jogo.
- `SW(5 downto 2)`: seleção do código dentro do nível.
- `SW(15 downto 0)`: tentativa do usuário no estado PLAY.

## Como compilar

Defina a entidade top-level como:

```text
usertop
```

O antigo `usertop2.vhd` foi removido para evitar conflito de top-level duplicado.
