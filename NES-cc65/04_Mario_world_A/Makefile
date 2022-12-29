CC65 = cc65
CA65 = ca65
LD65 = ld65
NAME = mario_world
CFG = nrom_32k_vert.cfg


.PHONY: default clean

default: $(NAME).nes


$(NAME).nes: $(NAME).o crt0.o $(CFG)
	$(LD65) -C $(CFG) -o $(NAME).nes crt0.o $(NAME).o nes.lib

crt0.o: crt0.s mario.chr
	$(CA65) crt0.s

$(NAME).o: $(NAME).s
	$(CA65) $(NAME).s -g

$(NAME).s: $(NAME).c
	$(CC65) -Oirs $(NAME).c --add-source

clean:
	rm -f $(NAME).nes
	rm -f *.o
	rm -f $(NAME).s
