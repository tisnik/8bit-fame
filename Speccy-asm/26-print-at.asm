ENTRY_POINT      equ $8000
ROM_OPEN_CHANNEL equ $1601

AT               equ 0x16

	org ENTRY_POINT

start:
	ld   A,2              ; číslo kanálu
	call ROM_OPEN_CHANNEL ; otevření kanálu číslo 2 (screen)

	ld   A, AT            ; řídicí kód pro specifikaci pozice psaní
	rst  0x10             ; zavolání rutiny v ROM

	ld   A, 16            ; y-ová souřadnice
	rst  0x10             ; zavolání rutiny v ROM

	ld   A, 31            ; x-ová souřadnice
	rst  0x10             ; zavolání rutiny v ROM

	ld   A, 42            ; kód znaku '*' pro tisk
	rst  0x10             ; zavolání rutiny v ROM

	ret                   ; návrat z programu do BASICu

end ENTRY_POINT