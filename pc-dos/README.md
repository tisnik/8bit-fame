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

#### Putpixel implementation

1. [Naive variant based on 16bit multiplication](gfx_6_putpixel_1.asm)
1. [A bit better variant based on 8bit multiplication](gfx_6_putpixel_2.asm)
1. [Using shifts instead of multiplications](gfx_6_putpixel_3.asm)
1. [Drawing pixels over image (incorrect variant)](gfx_6_putpixel_4.asm)
1. [Drawing pixels over image (correct variant)](gfx_6_putpixel_5.asm)

#### Image transfers (blitting)

1. [Base variant using program loop](gfx_4_image_1.asm)
1. [Faster variant using REP MOVSB](gfx_4_image_2.asm)
1. [Faster variant using REP MOVSW](gfx_4_image_3.asm)
1. [Correct even scanlines (empty odd scanlines)](gfx_4_image_4.asm)
1. [Correct even and odd scanlines](gfx_4_image_5.asm)
1. [Color palette selection](gfx_4_image_6.asm)
1. [Color palette selection + low intensity mode](gfx_4_image_7.asm)
1. [Color palette selection + low intensity mode after keypress](gfx_4_image_8.asm)

#### Text modes and pseuographics modes

1. [Standard BIOS text mode #1 (40x25)](cga_text_mode_1.asm)
1. [Standard BIOS text mode #3 (80x25)](cga_text_mode_3.asm)
1. [Changing meaning of intensity bit in color attributes](cga_text_mode_intensity.asm)
1. [Changing text cursor shape](cga_text_mode_cursor.asm)
1. [Changing characters height](cga_text_mode_char_height.asm)
1. [Pseudographics mode 160x25 'pixels'](cga_text_gfx_1.asm)
1. [Pseudographics mode 160x100 'pixels'](cga_text_160x100.asm)



## Text and graphics on Hercules graphics card (HGC)

### Text mode on HGC

1. [Text mode 80x25 characters](hercules_text_mode_1.asm)
1. [Text mode with high intensity flag enabled](hercules_text_mode_2.asm)
1. [Turning off video signal](hercules_turn_off.asm)

### Graphics mode on HGC

1. [Setting graphics mode 720x348 pixels, basic variant](hercules_gfx_mode_1.asm)
1. [Setting graphics mode 720x348 pixels, better variant](hercules_gfx_mode_2.asm)
1. [Putpixel operation in graphics mode](hercules_putpixel.asm)

