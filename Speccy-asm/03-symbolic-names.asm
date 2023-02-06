attribute_adr equ $5800
entry_point   equ $8000


	org entry_point

start:
	ld a,%11010110
	ld (attribute_adr),a
	ret
