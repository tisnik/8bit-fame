	org $8000

start:
	ld a,%00010000
	ld ($5800),a
	ret
