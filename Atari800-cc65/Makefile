INCLUDE_PATH=/usr/share/cc65/include

execs := background_color.xex \
	 poke.xex \
	 sprite1.xex \
	 sprite2.xex \
	 sprite3.xex \
	 sprite4.xex \
	 sprite5.xex \
	 sprite5_1.xex \
	 sprite5_2.xex \
	 sprite5_3.xex \
	 sprite5_4.xex \
	 sprite6.xex \
	 sprite7.xex \
	 print_1.xex \
	 print_2.xex \
	 print_3.xex \
	 print_4.xex

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

sprite5_1.asm:	sprite5.c
	cc65 -t atari $< -o $@

sprite5_2.asm:	sprite5.c
	cc65 -t atari -T $< -o $@

sprite5_3.asm:	sprite5.c
	cc65 -Oirs -t atari -T $< -o $@

sprite5_4.asm:	sprite5.c
	cc65 -Oirs -t atari -T -Cl $< -o $@

sprite6.asm:	sprite6.c
	cc65 -Oirs -t atari -T -Cl $< -o $@

sprite7.asm:	sprite7.c
	cc65 -Oirs -t atari -T $< -o $@

print_1.asm:	print_1.c
	cc65 -Oirs -t atari -Cl -T $< -o $@
