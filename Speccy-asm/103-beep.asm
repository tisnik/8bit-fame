ENTRY_POINT   equ $8000
BEEPER        equ $03B5



	org ENTRY_POINT

beep MACRO pitch, duration
	ld   hl, pitch
	ld   de, duration
	call BEEPER
ENDM

start:
	beep 964, 1000                 ; přehrání noty
	ret                            ; návrat do BASICu


end ENTRY_POINT
