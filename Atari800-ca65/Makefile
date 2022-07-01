objs := print_a.o
exec := print_a.xex

all: $(exec)

clean:
	rm -f $(objs) $(exec)

.PHONY: all clean

%.o: %.asm
	ca65 $< -t atari -o $@ -l test.list --list-bytes 100

print_a.o: print_a.asm

print_a.xex: linker.cfg print_a.o
	ld65 -C linker.cfg print_a.o -o $@
