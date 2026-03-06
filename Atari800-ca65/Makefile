execs := dummy.xex print_a.xex \
	 background_color_1.xex  background_color_2.xex \
	 color_computation_1.xex color_computation_2.xex \
	 subroutine_1.xex        subroutine_2 \
	 hex_number_1.xex        hex_number_2.xex

all: $(execs)

clean:
	rm -f *.o
	rm -f *.xex

.PHONY: all clean

%.o: %.asm
	ca65 $< -t atari -o $@ -l $(basename $<)_list.asm --list-bytes 100

%.xex: %.o
	ld65 -C linker.cfg $< -o $@ -m $(basename $<).map

