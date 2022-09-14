CC65=cc65

STD_FLAGS = 
INCLUDE_SOURCE =-T
STATIC_LOCAL_VARS = -Cl
STD_OPTIMIZATION = -O
REGISTER_VARS = -Or
INLINE_FUNC = -Oi
ALL_OPTIMIZATIONS = -Osir

all:	local_add_1.asm local_add_2.asm local_add_3.asm local_add_4.asm local_add_5.asm local_add_6.asm local_add_7.asm \
    	memset1.asm memset2.asm memset3.asm memset4.asm memset5.asm

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
