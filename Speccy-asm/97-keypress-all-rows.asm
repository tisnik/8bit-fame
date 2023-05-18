; Example that is used in following article:
;    Práce s klávesnicí na ZX Spectru
;    https://www.root.cz/clanky/prace-s-klavesnici-na-zx-spectru/
;
; This article is part of series:
;    "Vývoj pro slavné ZX Spectrum"
;    https://www.root.cz/serialy/vyvoj-pro-slavne-zx-spectrum/
;
; Repository:
;    https://github.com/tisnik/8bit-fame

ATTRIBUTE_ADR equ $5800
ENTRY_POINT   equ $8000
ROM_CLS       equ $0DAF

	org ENTRY_POINT

BLINK_BIT     equ %10000000
INTENSITY_BIT equ %01000000
BLACK_COLOR   equ %000
BLUE_COLOR    equ %001
RED_COLOR     equ %010
MAGENTA_COLOR equ %011
GREEN_COLOR   equ %100
CYAN_COLOR    equ %101
YELLOW_COLOR  equ %110
WHITE_COLOR   equ %111

KB_ROW_0_PORT equ $fe
KB_ROW_1_PORT equ $fd
KB_ROW_2_PORT equ $fb
KB_ROW_3_PORT equ $f7
KB_ROW_4_PORT equ $ef
KB_ROW_5_PORT equ $df
KB_ROW_6_PORT equ $bf
KB_ROW_7_PORT equ $7f


changeAttribute MACRO attribute
	ld  (hl), attribute
	inc hl
ENDM

keypress MACRO port, attribute_address
	ld  b, port                    ; adresa portu, ze kterého budeme číst údaje
	ld  c, $fe
	ld  hl, attribute_address      ; adresa, od které budeme měnit barvové atributy
	call keypress_detection        ; zavolání subrutiny pro detekci sticku kláves
ENDM


start:
	call ROM_CLS                   ; smazání obrazovky a otevření kanálu číslo 2 (screen)

	ld   HL, keys                  ; adresa prvního znaku v řetězci
	call print_string              ; subrutina pro tisk řetězce
repeat:
	keypress KB_ROW_0_PORT, ATTRIBUTE_ADR+32*0
	keypress KB_ROW_1_PORT, ATTRIBUTE_ADR+32*1
	keypress KB_ROW_2_PORT, ATTRIBUTE_ADR+32*2
	keypress KB_ROW_3_PORT, ATTRIBUTE_ADR+32*3
	keypress KB_ROW_4_PORT, ATTRIBUTE_ADR+32*4
	keypress KB_ROW_5_PORT, ATTRIBUTE_ADR+32*5
	keypress KB_ROW_6_PORT, ATTRIBUTE_ADR+32*6
	keypress KB_ROW_7_PORT, ATTRIBUTE_ADR+32*7

	jp   repeat
	ret                            ; návrat do BASICu (nikdy k němu nedojde)

keypress_detection:
	in  a, (c)                     ; vlastní čtení z portu (5 bitů)
	ld  b, 5                       ; počet atributů + počet testovaných kláves
next_key:
	srl a                          ; přesunout kód stisku klávesy do příznaku carry
	jr  nc, key_pressed            ; test stisku klávesy
	changeAttribute WHITE_COLOR << 3
	jr  next                       ; test další klávesy
key_pressed:
	changeAttribute INTENSITY_BIT | (RED_COLOR << 3)
next:
	djnz next_key                  ; opakovat celou smyčku 5x
	ret                            ; návrat z podprogramu



print_string:
	ld   A, (HL)                   ; načíst kód znaku z řetězce
	and  a                         ; test na kód znak s kódem 0
	ret  Z                         ; ukončit program na konci řetězce

	rst  0x10                      ; zavolání rutiny v ROM
	inc  HL                        ; přechod na další znak
	jr   print_string
	ret                            ; návrat ze subrutiny



keys:                                  ; layout klávesnice z pohledu čipů ZX Spectra
	NEW_LINE      equ 13
	END_OF_STRING equ  0
	DB "^", "Z", "X", "C", "V", NEW_LINE
	DB "A", "S", "D", "F", "G", NEW_LINE
	DB "Q", "W", "E", "R", "T", NEW_LINE
	DB "1", "2", "3", "4", "5", NEW_LINE
	DB "0", "9", "8", "7", "6", NEW_LINE
	DB "P", "O", "I", "U", "Y", NEW_LINE
	DB 127, "L", "K", "J", "H", NEW_LINE
	DB "_", $60, "M", "N", "B", END_OF_STRING



end ENTRY_POINT
