ASSEMBLER := pasmo

all: 01.tap 02.tap 03.tap 04.tap 05.tap 06.tap 07.tap 08.tap 09.tap 10.tap \
    11.tap 12.tap 13.tap 14.tap 15.tap 16.tap 17.tap 18.tap 19.tap 20.tap \
    21.tap 22.tap 23.tap 24.tap 25.tap 26.tap 27.tap 28.tap 29.tap 30.tap \
    31.tap 32.tap 33.tap 34.tap 35.tap 36.tap 37.tap 38.tap 39.tap 40.tap \
    41.tap

clean:
	rm -f *.tap

.PHONY: all clean


01.tap:	01-color-attribute.asm
	$(ASSEMBLER) -v -d --tap $< $@ > 01-color-attribute.lst

02.tap:	02-blinking-attribute.asm
	$(ASSEMBLER) -v -d --tap $< $@ > 02-blinking-attribute.lst

03.tap:	03-symbolic-names.asm
	$(ASSEMBLER) -v -d --tap $< $@ > 03-symbolic-names.lst

04.tap:	04-operators.asm
	$(ASSEMBLER) -v -d --tap $< $@ > 04-operators.lst

05.tap:	05-better-symbols.asm
	$(ASSEMBLER) -v -d --tap $< $@ > 05-better-symbols.lst

06.tap:	06-tapbas-v1.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 06-tapbas-v1.lst

07.tap:	07-tapbas-v2.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 07-tapbas-v2.lst

08.tap:	08-loop.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 08-loop.lst

09.tap:	09-loop.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 09-loop.lst

10.tap:	10-loop.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 10-loop.lst

11.tap:	11-loop.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 11-loop.lst

12.tap:	12-loop.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 12-loop.lst

13.tap:	13-loop.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 13-loop.lst

14.tap:	14-loop.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 14-loop.lst

15.tap:	15-loop.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 15-loop.lst

16.tap:	16-loop.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 16-loop.lst

17.tap:	17-loop.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 17-loop.lst

18.tap:	18-cls.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 18-cls.lst

19.tap:	19-print-char-call.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 19-print-char-call.lst

20.tap:	20-print-char-rst.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 20-print-char-rst.lst

21.tap:	21-print-char.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 21-print-char.lst

22.tap:	22-print-all-chars.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 22-print-all-chars.lst

23.tap:	23-print-all-chars.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 23-print-all-chars.lst

24.tap:	24-change-color.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 24-change-color.lst

25.tap:	25-change-flash.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 25-change-flash.lst

26.tap:	26-print-at.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 26-print-at.lst

27.tap:	27-print-string.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 27-print-string.lst

28.tap:	28-print-string.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 28-print-string.lst

29.tap:	29-print-colorized-string.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 29-print-colorized-string.lst

30.tap:	30-print-string-ROM.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 30-print-string-ROM.lst

31.tap:	31-attributes.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 31-attributes.lst

32.tap:	32-fill-in-vram.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 32-fill-in-vram.lst

33.tap:	33-fill-in-vram-no-ret.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 33-fill-in-vram-no-ret.lst

34.tap:	34-fill-in-vram-pattern.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 34-fill-in-vram-pattern.lst

35.tap:	35-slow-fill-in-vram.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 35-slow-fill-in-vram.lst

36.tap:	36-slow-fill-in-vram-no-ret.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 36-slow-fill-in-vram-no-ret.lst

37.tap:	37-fill-block.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 37-fill-block.lst

38.tap:	38-fill-block-with-pattern.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 38-fill-block-with-pattern.lst

39.tap:	39-fill-block-optimized.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 39-fill-block-optimized.lst

40.tap:	40-draw-char.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 40-draw-char.lst

41.tap:	41-draw-any-char.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 41-draw-any-char.lst

42.tap:	42-block-anywhere.asm
	$(ASSEMBLER) -v -d --tapbas $< $@ > 42-block-anywhere.lst
