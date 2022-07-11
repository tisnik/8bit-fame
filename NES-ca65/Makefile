objs := example01.o example02.o example03.o example04.o example05.o example06.o example07.o example08.o example09.o example10.o example11.o example12.o
roms := example01.nes example02.nes example03.nes example04.nes example05.nes example06.nes example07.nes example08.nes example09.nes example10.nes example11.nes example12.nes

all: $(roms)

clean:
	rm -f $(objs) $(roms)

.PHONY: all clean

%.o: %.asm
	ca65 $< -o $@ -l test.list --list-bytes 100

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

example06.nes: link.cfg example06.o
	ld65 -C link.cfg example06.o -o $@

example07.nes: link.cfg example07.o
	ld65 -C link.cfg example07.o -o $@

example08.nes: link.cfg example08.o
	ld65 -C link.cfg example08.o -o $@

example09.nes: link.cfg example09.o
	ld65 -C link.cfg example09.o -o $@

example10.nes: link.cfg example10.o
	ld65 -C link.cfg example10.o -o $@

example11.nes: link.cfg example11.o
	ld65 -C link.cfg example11.o -o $@

example12.nes: link.cfg example12.o
	ld65 -C link.cfg example12.o -o $@
