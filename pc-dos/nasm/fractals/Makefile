ASM=nasm
RM=rm

all:	mandel_1.com mandel_2.com mandel_3.com xtisno00.com fract_j2.com

clean:
	$(RM) *.com

mandel_1.com:	mandel_1.asm
	$(ASM) $< -o $@

mandel_2.com:	mandel_2.asm
	$(ASM) $< -o $@

mandel_3.com:	mandel_3.asm
	$(ASM) $< -o $@

xtisno00.com:	xtisno00.asm
	$(ASM) $< -o $@

fract_j2.com:	fract_j2.asm
	$(ASM) $< -o $@

