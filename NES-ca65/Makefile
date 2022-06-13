objs := example01.o example02.o example03.o example04.o example05.o
roms := example01.nes example02.nes example03.nes example04.nes example05.nes

all: $(roms)

clean:
	rm -f $(objs) $(roms)

.PHONY: all clean

%.o: %.asm
	ca65 $< -o $@ -l test.list

main.o: main.asm

example01.nes: link.cfg example01.o
	ld65 -C link.cfg example01.o -o $@

example02.nes: example02.o
	ld65 -C nes.cfg example02.o -o $@

example03.nes: link.cfg example03.o
	ld65 -C link.cfg example03.o -o $@

example04.nes: link.cfg example04.o
	ld65 -C link.cfg example04.o -o $@

example05.nes: link.cfg example05.o
	ld65 -C link.cfg example05.o -o $@

