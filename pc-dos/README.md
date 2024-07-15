# Demos written in assembly language for PC and 16bit DOS

## Primer for assembly language on PC/DOS

1. [The classic 'Hello world' written in assembly](hello.asm)
1. [Shorter way how to exit from DOS application](hello_shorter.asm)
1. [Waiting for key press before program exits](hello_wait.asm)
1. [Macros usage](hello_macros.asm)

## Text and graphics on CGA graphics card

### BIOS graphics subroutines

1. [Draw pixel via BIOS in graphics mode #4](gfx_4_putpixel.asm)
1. [Draw pixel via BIOS in graphics mode #6](gfx_6_putpixel.asm)
1. [Draw line using separate pixel draw via BIOS in graphics mode #4](gfx_4_line.asm)
1. [Draw line using separate pixel draw via BIOS in graphics mode #6](gfx_6_line.asm)

### Accessing CGA video RAM directly

#### Screen fill

1. [Explicit loop with counter](gfx_6_fill_1.asm)
1. [LOOP instruction usage](gfx_6_fill_2.asm)
1. [REP STOSB instruction usage](gfx_6_fill_3.asm)
1. [VSync-based synchronization](gfx_6_fill_4.asm)
