objs := example01.o
out := ctnes.nes

all: $(out)

clean:
	rm -f $(objs) $(out)

.PHONY: all clean

%.o: %.asm
	ca65 $< -o $@ -l test.list

main.o: main.asm

ctnes.nes: link.cfg $(objs)
	ld65 -C link.cfg $(objs) -o $@
