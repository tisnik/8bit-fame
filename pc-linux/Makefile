ASM=nasm
LINKER=ld

execs := mmx_support mmx_init \
	 mmx_paddb_1 mmx_paddb_2 mmx_paddw mmx_paddd mmx_paddq mmx_paddusb mmx_paddx mmx_paddx_saturation \
	 mmx_psubx mmx_pmullw_1 mmx_pmullw_2 mmx_pmulhw mmx_pmaddwd mmx_logical

all:	$(execs)

clean:
	rm -f *.o $(execs)

.PHONY: all clean

%.o: %.asm linux_macros.asm hex2string.asm
	${ASM} -f elf $< -o $@

mmx_support:	mmx_support.o
	ld -melf_i386 $< -o $@

mmx_init:	mmx_init.o
	ld -melf_i386 $< -o $@

mmx_paddb_1:	mmx_paddb_1.o
	ld -melf_i386 $< -o $@

mmx_paddb_2:	mmx_paddb_2.o
	ld -melf_i386 $< -o $@

mmx_paddw:	mmx_paddw.o
	ld -melf_i386 $< -o $@

mmx_paddd:	mmx_paddd.o
	ld -melf_i386 $< -o $@

mmx_paddq:	mmx_paddq.o
	ld -melf_i386 $< -o $@

mmx_paddx:	mmx_paddx.o
	ld -melf_i386 $< -o $@

mmx_paddx_saturation:	mmx_paddx_saturation.o
	ld -melf_i386 $< -o $@

mmx_paddusb:	mmx_paddusb.o
	ld -melf_i386 $< -o $@

mmx_psubx:	mmx_psubx.o
	ld -melf_i386 $< -o $@

mmx_pmullw_1:	mmx_pmullw_1.o
	ld -melf_i386 $< -o $@

mmx_pmullw_2:	mmx_pmullw_2.o
	ld -melf_i386 $< -o $@

mmx_pmulhw:	mmx_pmulhw.o
	ld -melf_i386 $< -o $@

mmx_pmaddwd:	mmx_pmaddwd.o
	ld -melf_i386 $< -o $@

mmx_logical:	mmx_logical.o
	ld -melf_i386 $< -o $@
