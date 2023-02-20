ENTRY_POINT      equ $8000
ROM_OPEN_CHANNEL equ $1601

INK              equ $10
PAPER            equ $11
FLASH            equ $12
BRIGHT           equ $13
INVERSE          equ $14

BLACK_COLOR      equ %000
BLUE_COLOR       equ %001
RED_COLOR        equ %010
MAGENTA_COLOR    equ %011
GREEN_COLOR      equ %100
CYAN_COLOR       equ %101
YELLOW_COLOR     equ %110
WHITE_COLOR      equ %111

	org ENTRY_POINT

start:
	ld   A,2              ; číslo kanálu
	call ROM_OPEN_CHANNEL ; otevření kanálu číslo 2 (screen)

	ld   A, INK           ; řídicí kód pro specifikaci barvy inkoustu
	rst  0x10             ; zavolání rutiny v ROM

	ld   A, YELLOW_COLOR  ; barva inkoustu
	rst  0x10             ; zavolání rutiny v ROM

	ld   A, PAPER         ; řídicí kód pro specifikaci barvy papíru
	rst  0x10             ; zavolání rutiny v ROM

	ld   A, BLUE_COLOR    ; barva papíru
	rst  0x10             ; zavolání rutiny v ROM

	ld   A, 42            ; kód znaku '*' pro tisk
	rst  0x10             ; zavolání rutiny v ROM

	ret                   ; návrat z programu do BASICu

end ENTRY_POINT
