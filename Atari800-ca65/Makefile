execs := dummy.xex print_a.xex \
	 background_color_1.xex  background_color_2.xex \
	 color_computation_1.xex color_computation_2.xex \
	 subroutine_1.xex        subroutine_2.xex \
	 hex_number_1.xex        hex_number_2.xex \
	 hex_number_3.xex        hex_number_4.xex \
	 hex_number_5.xex        hex_number_6.xex \
	 hex_number_7.xex        hex_number_8.xex \
	 hex_number_9.xex \
	 fill_block_1.xex        fill_block_2.xex \
	 fill_block_3.xex        fill_block_4.xex \
	 fill_block_5.xex \
	 pmg_01.xex              pmg_02.xex \
	 pmg_03.xex              pmg_04.xex \
	 pmg_05.xex              pmg_06.xex \
	 pmg_07.xex              pmg_08.xex \
	 pmg_09.xex              pmg_10.xex \
	 pmg_11.xex              pmg_12.xex \
	 pmg_13.xex              pmg_14.xex \
	 pmg_15.xex \
	 pmg_stick_1.xex         pmg_stick_2.xex \
	 pmg_stick_3.xex         pmg_stick_4.xex \
	 pmg_stick_5.xex         pmg_stick_6.xex \
	 pmg_collisions_1.xex    pmg_collisions_2.xex \
	 pmg_collisions_3.xex    pmg_collisions_4.xex \
	 antic_1.xex             antic_2.xex

all: $(execs)

clean:
	rm -f *.o
	rm -f *.xex

.PHONY: all clean

%.o: %.asm
	ca65 $< -t atari -o $@ -l $(basename $<)_list.asm --list-bytes 100

%.xex: %.o
	ld65 -C linker.cfg $< -o $@ -m $(basename $<).map

