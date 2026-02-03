CC=clang

outputs := noop.ll noop_no_opt.ll noop_wasm.ll noop_aarch64.ll \
	   add_unsigned.ll add_unsigned_no_opt.ll \
	   add_signed.ll numeric_types.ll \
	   arith_operators.ll comparison_operators.ll \
	   branching_1.ll branching_2.ll pointers_1.ll pointers_2.ll \
	   add_arrays_1.ll add_arrays_2.ll \
	   fibonacci.ll \
	   numeric_conversions_1.ll numeric_conversions_2.ll numeric_conversions_3.ll \
	   switch_1.ll switch_2.ll switch_3.ll switch_4.ll switch_5.ll switch_6.ll

all:	$(outputs)

clean:
	rm -f *.ll

.PHONY: all clean


%.ll:	%.c
	$(CC) -Os -S -emit-llvm $< -o $@

add_unsigned_no_opt.ll:	add_unsigned.c
	$(CC) -S -emit-llvm $< -o $@

noop_no_opt.ll:	noop.c
	$(CC) -S -emit-llvm $< -o $@

noop_wasm.ll:	noop.c
	$(CC) -Os -S -emit-llvm --target=wasm32 $< -o $@

noop_aarch64.ll:	noop.c
	$(CC) -Os -S -emit-llvm --target=aarch64 $< -o $@
