CC65=cc65

STD_FLAGS = 
INCLUDE_SOURCE =-T
STATIC_LOCAL_VARS = -Cl
STD_OPTIMIZATION = -O
REGISTER_VARS = -Or
INLINE_FUNC = -Oi
ALL_OPTIMIZATIONS = -Osir

all:	local_add_1.asm local_add_2.asm local_add_3.asm local_add_4.asm local_add_5.asm local_add_6.asm local_add_7.asm \
    	memset1.asm memset2.asm memset3.asm memset4.asm memset5.asm memset6.asm \
	empty_main.asm local_var_1.asm local_var_2.asm register_var_1.asm register_var_2.asm \
	a_register.asm ax_register_1.asm ax_register_2.asm eax_register_1.asm eax_register_2.asm \
	post_increment_1.asm post_increment_2.asm pre_increment_1.asm pre_increment_2.asm \
	assembly1.asm assembly2.asm assembly3.asm assembly4.asm \
	a_register_add.asm a_register_shift.asm a_register_rshift.asm a_register_double_shift.asm \
	a_register_double.asm a_register_triple.asm a_register_quadruple.asm \
	a_register_half.asm a_register_times5.asm a_register_times42.asm

clean:
	rm *.asm

local_add_1.asm:	local_add.c
	${CC65} ${STD_FLAGS} -o $@ $<

local_add_2.asm:	local_add.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} -o $@ $<

local_add_3.asm:	local_add.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STATIC_LOCAL_VARS} -o $@ $<

local_add_4.asm:	local_add.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STATIC_LOCAL_VARS} ${STD_OPTIMIZATION} -o $@ $<

local_add_5.asm:	local_add.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STATIC_LOCAL_VARS} ${REGISTER_VARS} -o $@ $<

local_add_6.asm:	local_add.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STATIC_LOCAL_VARS} ${INLINE_FUNC} -o $@ $<

local_add_7.asm:	local_add.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STATIC_LOCAL_VARS} ${ALL_OPTIMIZATIONS} -o $@ $<

local_add_B.asm:	local_add_B.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STATIC_LOCAL_VARS} ${INLINE_FUNC} -o $@ $<

local_mul.asm:	local_mul.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STATIC_LOCAL_VARS} ${ALL_OPTIMIZATIONS} -o $@ $<

memset1.asm:	memset1.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STATIC_LOCAL_VARS} ${STD_OPTIMIZATION} -o $@ $<

memset2.asm:	memset2.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STATIC_LOCAL_VARS} ${STD_OPTIMIZATION} -o $@ $<

memset3.asm:	memset3.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STATIC_LOCAL_VARS} ${STD_OPTIMIZATION} -o $@ $<

memset4.asm:	memset4.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STATIC_LOCAL_VARS} ${STD_OPTIMIZATION} -o $@ $<

memset5.asm:	memset5.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STATIC_LOCAL_VARS} ${STD_OPTIMIZATION} -o $@ $<

memset6.asm:	memset6 .c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STATIC_LOCAL_VARS} ${STD_OPTIMIZATION} -o $@ $<

empty_main.asm:	empty_main.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STATIC_LOCAL_VARS} ${STD_OPTIMIZATION} -o $@ $<

local_var_1.asm:	local_var.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STATIC_LOCAL_VARS} ${STD_OPTIMIZATION} -o $@ $<

local_var_2.asm:	local_var.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${REGISTER_VARS} ${STD_OPTIMIZATION} -o $@ $<

register_var_1.asm:	register_var.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STATIC_LOCAL_VARS} ${STD_OPTIMIZATION} -o $@ $<

register_var_2.asm:	register_var.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${REGISTER_VARS} ${STD_OPTIMIZATION} -o $@ $<

a_register.asm:	a_register.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STD_OPTIMIZATION} -o $@ $<

ax_register_1.asm:	ax_register.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} -o $@ $<

ax_register_2.asm:	ax_register.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STD_OPTIMIZATION} -o $@ $<

eax_register_1.asm:	eax_register.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} -o $@ $<

eax_register_2.asm:	eax_register.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STD_OPTIMIZATION} -o $@ $<

post_increment_1.asm:	post_increment.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STATIC_LOCAL_VARS} ${STD_OPTIMIZATION} ${INLINE_FUNC} -o $@ $<

post_increment_2.asm:	post_increment.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${post_incrementS} ${STD_OPTIMIZATION} ${INLINE_FUNC} -o $@ $<

pre_increment_1.asm:	pre_increment.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STATIC_LOCAL_VARS} ${STD_OPTIMIZATION} ${INLINE_FUNC} -o $@ $<

pre_increment_2.asm:	pre_increment.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${pre_incrementS} ${STD_OPTIMIZATION} ${INLINE_FUNC} -o $@ $<

assembly1.asm:	assembly1.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${pre_incrementS} ${STD_OPTIMIZATION} ${REGISTER_VARS} -o $@ $<

assembly2.asm:	assembly2.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${pre_incrementS} ${STD_OPTIMIZATION} ${REGISTER_VARS} -o $@ $<

assembly3.asm:	assembly3.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${pre_incrementS} ${STD_OPTIMIZATION} ${REGISTER_VARS} -o $@ $<

assembly4.asm:	assembly4.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${pre_incrementS} ${STD_OPTIMIZATION} ${REGISTER_VARS} -o $@ $<

a_register_add.asm:	a_register_add.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STD_OPTIMIZATION} -o $@ $<

a_register_shift.asm:	a_register_shift.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STD_OPTIMIZATION} -o $@ $<

a_register_rshift.asm:	a_register_rshift.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STD_OPTIMIZATION} -o $@ $<

a_register_double_shift.asm:	a_register_double_shift.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STD_OPTIMIZATION} -o $@ $<

a_register_double.asm:	a_register_double.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STD_OPTIMIZATION} -o $@ $<

a_register_triple.asm:	a_register_triple.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STD_OPTIMIZATION} -o $@ $<

a_register_quadruple.asm:	a_register_quadruple.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STD_OPTIMIZATION} -o $@ $<

a_register_times5.asm:	a_register_times5.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STD_OPTIMIZATION} -o $@ $<

a_register_times42.asm:	a_register_times42.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STD_OPTIMIZATION} -o $@ $<

a_register_half.asm:	a_register_half.c
	${CC65} ${STD_FLAGS} ${INCLUDE_SOURCE} ${STD_OPTIMIZATION} -o $@ $<

