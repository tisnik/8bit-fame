ASM=nasm
RM=rm

all:	blob3.com blob4.com

clean:
	$(RM) *.com

blob3.com:	blob3.asm blobdata.asm
	$(ASM) $< -o $@

blob4.com:	blob4.asm blobdata.asm
	$(ASM) $< -o $@

