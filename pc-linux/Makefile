ASM=nasm
LINKER=ld

execs := mmx_support mmx_init \
	 mmx_paddb_1 mmx_paddb_2 mmx_paddw mmx_paddd mmx_paddq mmx_paddusb mmx_paddx mmx_paddx_saturation \
	 mmx_psubx mmx_pmullw_1 mmx_pmullw_2 mmx_pmulhw mmx_pmaddwd mmx_logical \
	 mmx_shift_left mmx_shift_right mmx_arithmetic_right \
	 mmx_cmpeq mmx_cmpgt \
	 mmx_unpack_bytes mmx_unpack_words mmx_unpack_dwords \
	 mmx_pack_into_bytes_1 mmx_pack_into_bytes_2 \
	 sse_support sse_value_unaligned_1 sse_value_unaligned_2 sse_value_aligned sse_addps sse_addss

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

mmx_shift_left:	mmx_shift_left.o
	ld -melf_i386 $< -o $@

mmx_shift_right:	mmx_shift_right.o
	ld -melf_i386 $< -o $@

mmx_arithmetic_right:	mmx_arithmetic_right.o
	ld -melf_i386 $< -o $@

mmx_cmpeq:	mmx_cmpeq.o
	ld -melf_i386 $< -o $@

mmx_cmpgt:	mmx_cmpgt.o
	ld -melf_i386 $< -o $@

mmx_unpack_bytes:	mmx_unpack_bytes.o
	ld -melf_i386 $< -o $@

mmx_unpack_words:	mmx_unpack_words.o
	ld -melf_i386 $< -o $@

mmx_unpack_dwords:	mmx_unpack_dwords.o
	ld -melf_i386 $< -o $@

mmx_pack_into_bytes_1:	mmx_pack_into_bytes_1.o
	ld -melf_i386 $< -o $@

mmx_pack_into_bytes_2:	mmx_pack_into_bytes_2.o
	ld -melf_i386 $< -o $@

sse_support:	sse_support.o
	ld -melf_i386 $< -o $@

sse_value_unaligned_1:	sse_value_unaligned_1.o
	ld -melf_i386 $< -o $@

sse_value_unaligned_2:	sse_value_unaligned_2.o
	ld -melf_i386 $< -o $@

sse_value_aligned:	sse_value_aligned.o
	ld -melf_i386 $< -o $@

sse_addps:	sse_addps.o
	ld -melf_i386 $< -o $@

sse_addss:	sse_addss.o
	ld -melf_i386 $< -o $@
