ASM=nasm
LINKER=ld

execs := mmx_support mmx_init \
	 mmx_paddb_1 mmx_paddb_2 mmx_paddw mmx_paddd mmx_paddq mmx_paddusb mmx_paddx mmx_paddx_saturation \
	 mmx_psubx mmx_pmullw_1 mmx_pmullw_2 mmx_pmulhw mmx_pmaddwd mmx_logical \
	 mmx_shift_left mmx_shift_right mmx_arithmetic_right \
	 mmx_cmpeq mmx_cmpgt \
	 mmx_unpack_bytes mmx_unpack_words mmx_unpack_dwords \
	 mmx_pack_into_bytes_1 mmx_pack_into_bytes_2 \
	 sse_support sse_value_unaligned_1 sse_value_unaligned_2 sse_value_aligned \
	 sse_addps sse_addss sse_subss sse_subps sse_mulps sse_divps sse_maxmin sse_reciprocal sse_sqrt \
	 sse_cmpeqps sse_cmpltps sse_ordered sse_inf_nan \
	 sse_shufps sse_unpckhps sse_unpcklps sse_cvtsi2ss sse_cvtss2si sse_cvtss2si_fract sse_cvtss2si_special \
	 sse_ldmxcsr sse_stmxcsr \
	 sse2_support sse2_paddb sse2_paddw sse2_paddusb \
	 sse_sum sse_dot_product sse2_add_delta \
	 sse2_sqrtpd sse2_sqrtpd_negative sse2_sqrtpd_special \
	 sse2_shift_right_words, sse2_shift_right_dwords, sse2_shift_right_qwords, sse2_shift_right_dqwords \
	 sse2_and sse2_and_not sse2_cvtps2dq sse2_cvtps2dq_neg sse2_cvtps2dq_special \
	 sse2_cvtps2pd sse2_cvtpd2ps sse2_cvtps2dq_special sse2_unpckhpd sse2_unpcklpd sse2_punpckhbw sse2_punpcklbw \
	 sse2_pmovmskb sse2_pshufd

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

sse_subps:	sse_subps.o
	ld -melf_i386 $< -o $@

sse_subss:	sse_subss.o
	ld -melf_i386 $< -o $@

sse_mulps:	sse_mulps.o
	ld -melf_i386 $< -o $@

sse_divps:	sse_divps.o
	ld -melf_i386 $< -o $@

sse_maxmin:	sse_maxmin.o
	ld -melf_i386 $< -o $@

sse_reciprocal:	sse_reciprocal.o
	ld -melf_i386 $< -o $@

sse_sqrt:	sse_sqrt.o
	ld -melf_i386 $< -o $@

sse_cmpeqps:	sse_cmpeqps.o
	ld -melf_i386 $< -o $@

sse_cmpltps:	sse_cmpltps.o
	ld -melf_i386 $< -o $@

sse_ordered:	sse_ordered.o
	ld -melf_i386 $< -o $@

sse_inf_nan:	sse_inf_nan.o
	ld -melf_i386 $< -o $@

sse_shufps:	sse_shufps.o
	ld -melf_i386 $< -o $@

sse_unpckhps:	sse_unpckhps.o
	ld -melf_i386 $< -o $@

sse_unpcklps:	sse_unpcklps.o
	ld -melf_i386 $< -o $@

sse_cvtsi2ss:	sse_cvtsi2ss.o
	ld -melf_i386 $< -o $@

sse_cvtss2si:	sse_cvtss2si.o
	ld -melf_i386 $< -o $@

sse_cvtss2si_fract:	sse_cvtss2si_fract.o
	ld -melf_i386 $< -o $@

sse_cvtss2si_special:	sse_cvtss2si_special.o
	ld -melf_i386 $< -o $@

sse_ldmxcsr:	sse_ldmxcsr.o
	ld -melf_i386 $< -o $@

sse_stmxcsr:	sse_stmxcsr.o
	ld -melf_i386 $< -o $@

sse2_support:	sse2_support.o
	ld -melf_i386 $< -o $@

sse2_paddb:	sse2_paddb.o
	ld -melf_i386 $< -o $@

sse2_paddw:	sse2_paddw.o
	ld -melf_i386 $< -o $@

sse2_paddusb:	sse2_paddusb.o
	ld -melf_i386 $< -o $@

sse2_paddsb:	sse2_paddsb.o
	ld -melf_i386 $< -o $@

sse_sum:	sse_sum.o
	ld -melf_i386 $< -o $@

sse_dot_product:	sse_dot_product.o
	ld -melf_i386 $< -o $@

sse2_add_delta:	sse2_add_delta.o
	ld -melf_i386 $< -o $@

sse2_sqrtpd:	sse2_sqrtpd.o
	ld -melf_i386 $< -o $@

sse2_sqrtpd_negative:	sse2_sqrtpd_negative.o
	ld -melf_i386 $< -o $@

sse2_sqrtpd_special:	sse2_sqrtpd_special.o
	ld -melf_i386 $< -o $@

sse2_shift_right_words:	sse2_shift_right_words.o
	ld -melf_i386 $< -o $@

sse2_shift_right_dwords:	sse2_shift_right_dwords.o
	ld -melf_i386 $< -o $@

sse2_shift_right_qwords:	sse2_shift_right_qwords.o
	ld -melf_i386 $< -o $@

sse2_shift_right_dqwords:	sse2_shift_right_dqwords.o
	ld -melf_i386 $< -o $@

sse2_and:	sse2_and.o
	ld -melf_i386 $< -o $@

sse2_and_not:	sse2_and_not.o
	ld -melf_i386 $< -o $@

sse2_cvtps2dq:	sse2_cvtps2dq.o
	ld -melf_i386 $< -o $@

sse2_cvtps2dq_neg:	sse2_cvtps2dq_neg.o
	ld -melf_i386 $< -o $@

sse2_cvtps2dq_special:	sse2_cvtps2dq_special.o
	ld -melf_i386 $< -o $@

sse2_cvtps2pd:	sse2_cvtps2pd.o
	ld -melf_i386 $< -o $@

sse2_cvtpd2ps:	sse2_cvtpd2ps.o
	ld -melf_i386 $< -o $@

sse2_cvtpd2ps_special:	sse2_cvtpd2ps_special.o
	ld -melf_i386 $< -o $@

sse2_unpckhpd:	sse2_unpckhpd.o
	ld -melf_i386 $< -o $@

sse2_unpcklpd:	sse2_unpcklpd.o
	ld -melf_i386 $< -o $@

sse2_punpckhbw:	sse2_punpckhbw.o
	ld -melf_i386 $< -o $@

sse2_punpcklbw:	sse2_punpcklbw.o
	ld -melf_i386 $< -o $@

sse2_pmovmskb:	sse2_pmovmskb.o
	ld -melf_i386 $< -o $@

sse2_pshufd:	sse2_pshufd.o
	ld -melf_i386 $< -o $@

