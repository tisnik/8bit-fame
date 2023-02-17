ENTRY_POINT   equ $8000
ROM_CLS       equ $0DAF

	org ENTRY_POINT

start:
	call ROM_CLS    ; smazání obrazovky a otevření kanálu číslo 2 (screen)
	ld   A, 42      ; kód znaku '*' pro tisk
	rst  0x10       ; zavolání rutiny v ROM
	ret             ; návrat z programu do BASICu

end ENTRY_POINT
