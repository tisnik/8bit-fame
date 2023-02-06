	org $8000

start:
	ld a,%11010110
	ld ($5800),a
	ret
