COMPILER=actionc

execs := \
	color1.xex \
	color2.xex \
	drawto_1.xex \
	drawto_2.xex \
	drawto_3.xex \
	hello.xex \
	inc.xex \
	lsh.xex \
	multiply.xex \
	rsh.xex \
	rtc.xex \
	snowcrash1.xex \
	snowcrash2.xex \
	sprite1.xex \
	sprite2.xex \
	sprite3.xex \
	fill_screen_1.xex \
	fill_screen_2.xex \
	fill_screen_3.xex \
	fill_screen_4.xex

asms := color1.asm \
	color2.asm \
	drawto_1.asm \
	drawto_2.asm \
	drawto_3.asm \
	hello.asm \
	inc.asm \
	lsh.asm \
	multiply.asm \
	rsh.asm \
	rtc.asm \
	snowcrash1.asm \
	snowcrash2.asm \
	sprite1.asm \
	sprite2.asm \
	sprite3.asm \
	fill_screen_1.asm \
	fill_screen_2.asm \
	fill_screen_3.asm \
	fill_screen_4.asm

all: $(execs) $(asms)

clean:
	rm -f *.xex
	rm -f *.asm

.PHONY: all clean

%.xex:	%.act
	${COMPILER} --runtime standalone $<

%.obj:	%.xex
	tail -c +7 $< | head -c -6 > $@

%.asm:	%.obj
	da65 $< > $@ 
