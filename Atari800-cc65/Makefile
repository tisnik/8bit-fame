INCLUDE_PATH=/usr/share/cc65/include

%.o: %.c

%.xex:	%.o
	cl65 -t atari -Oirs $< -o $@ -m $(basename $<).map

%.o:	%.asm
	ca65 $< -o $@

%.asm:	%.c
	cc65 -I ${INCLUDE_PATH} -Oirs -t atari $< -o $@
