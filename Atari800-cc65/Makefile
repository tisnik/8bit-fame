INCLUDE_PATH=/usr/share/cc65/include

execs := background_color.xex \
	 poke.xex \
	 sprite1.xex \
	 sprite2.xex

all: $(execs)

clean:
	rm -f *.o
	rm -f *.xex

.PHONY: all clean

%.o: %.c

%.xex:	%.o
	cl65 -t atari -Oirs $< -o $@ -m $(basename $<).map

%.o:	%.asm
	ca65 $< -o $@

%.asm:	%.c
	cc65 -I ${INCLUDE_PATH} -Oirs -t atari $< -o $@
