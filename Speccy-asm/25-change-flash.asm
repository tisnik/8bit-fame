; Example that is used in following article:
;    Vývoj pro ZX Spectrum: výpis informací na obrazovku
;    https://www.root.cz/clanky/vyvoj-pro-zx-spectrum-vypis-informaci-na-obrazovku/
;
; This article is part of series:
;    "Vývoj pro slavné ZX Spectrum"
;    https://www.root.cz/serialy/vyvoj-pro-slavne-zx-spectrum/
;
; Repository:
;    https://github.com/tisnik/8bit-fame
;
; Example #25:
;    Change character blinking attribute via control characters

ENTRY_POINT      equ $8000
ROM_OPEN_CHANNEL equ $1601

INK              equ $10
PAPER            equ $11
FLASH            equ $12
BRIGHT           equ $13
INVERSE          equ $14

ENABLE           equ 1
DISABLE          equ 0

	org ENTRY_POINT

start:
	ld   A,2              ; číslo kanálu
	call ROM_OPEN_CHANNEL ; otevření kanálu číslo 2 (screen)

	ld   A, FLASH         ; řídicí kód pro specifikaci blikání
	rst  0x10             ; zavolání rutiny v ROM

	ld   A, ENABLE        ; povolení blikání
	rst  0x10             ; zavolání rutiny v ROM

	ld   A, 42            ; kód znaku '*' pro tisk
	rst  0x10             ; zavolání rutiny v ROM

	ret                   ; návrat z programu do BASICu

end ENTRY_POINT
