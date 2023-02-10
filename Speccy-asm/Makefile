ASSEMBLER := pasmo

all: 01.tap 02.tap 03.tap 04.tap 05.tap 06.tap 07.tap 08.tap 09.tap 10.tap 11.tap 12.tap 13.tap 14.tap. 15.tap

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
