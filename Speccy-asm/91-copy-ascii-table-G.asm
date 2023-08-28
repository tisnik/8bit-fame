; Example that is used in following article:
;    Kopie datových bloků na ZX Spectru s využitím zásobníku
;    https://www.root.cz/clanky/kopie-datovych-bloku-na-zx-spectru-s-vyuzitim-zasobniku/
;
; This article is part of series:
;    "Vývoj pro slavné ZX Spectrum"
;    https://www.root.cz/serialy/vyvoj-pro-slavne-zx-spectrum/
;
; Repository:
;    https://github.com/tisnik/8bit-fame
;
; Example #91:
;    Usage of macros supported by Pasmo.
;
; This source code is available at:
;    https://github.com/tisnik/8bit-fame/blob/master/Speccy-asm/91-copy-ascii-table-G.asm



SCREEN_ADR          equ $4000
SCREEN_BLOCK_SIZE   equ 32*64
SECOND_SCREEN_BLOCK equ SCREEN_ADR+SCREEN_BLOCK_SIZE

CHAR_ADR            equ $3c00
ENTRY_POINT         equ $8000

copy16bytes MACRO source_address, destination_address
	ld   sp, source_address
	pop  af
	pop  bc
	pop  de
	pop  hl
	exx
	ex   af, af'
	pop  af
	pop  bc
	pop  de
	pop  hl
	ld   sp, destination_address+16
	push hl
	push de
	push bc
	push af
	exx
	ex   af, af'
	push hl
	push de
	push bc
	push af
ENDM

	org ENTRY_POINT

	; Vstupní bod celého programu
start:
	call fill_in_screen           ; vyplnění obrazovky ASCII tabulkami
	di

	copy16bytes SCREEN_ADR+32*(0*8+9), SECOND_SCREEN_BLOCK+(32*8*0)
	copy16bytes SCREEN_ADR+32*(1*8+9), SECOND_SCREEN_BLOCK+(32*8*1)
	copy16bytes SCREEN_ADR+32*(2*8+9), SECOND_SCREEN_BLOCK+(32*8*2)
	copy16bytes SCREEN_ADR+32*(3*8+9), SECOND_SCREEN_BLOCK+(32*8*3)
	copy16bytes SCREEN_ADR+32*(4*8+9), SECOND_SCREEN_BLOCK+(32*8*4)
	copy16bytes SCREEN_ADR+32*(5*8+9), SECOND_SCREEN_BLOCK+(32*8*5)
	copy16bytes SCREEN_ADR+32*(6*8+9), SECOND_SCREEN_BLOCK+(32*8*6)
	copy16bytes SCREEN_ADR+32*(7*8+9), SECOND_SCREEN_BLOCK+(32*8*7)

	ld sp, SCREEN_ADR+SECOND_SCREEN_BLOCK+2048
	ei
finito:
	jr finito                     ; ukončit program nekonečnou smyčkou


fill_in_screen:
	; Vyplnění obrazovky snadno rozpoznatelným vzorkem - ASCII tabulkami
	;
	; vstupy:
	; žádné
	ld de, SCREEN_ADR        ; adresa pro vykreslení prvního bloku znaků
	call draw_ascii_table    ; vykreslení 96 znaků
	ret                      ; návrat z podprogramu


draw_ascii_table:
	; Vytištění ASCII tabulky
	;	
	; vstupy:
	; DE - adresa v obrazové paměti pro vykreslení znaku
	ld a, ' '                ; kód vykreslovaného znaku
next_char:
	push af                  ; uschovat akumulátor na zásobník
	call draw_char           ; zavolat subrutinu pro vykreslení znaku
	ld a, ' '                ; vykreslit za znakem mezeru
	call draw_char           ; zavolat subrutinu pro vykreslení znaku
	pop af                   ; obnovit akumulátor ze zásobníku
	inc a                    ; ASCII kód dalšího znaku
	cp  ' ' + 96             ; jsme již na konci ASCII tabulky?
	jr nz, next_char         ; ne? potom pokračujeme
	ret                      ; návrat z podprogramu


draw_char:
	; Vytištění jednoho znaku na obrazovku
	;
	; vstupy:
	; A - kód znaku pro vykreslení
	; DE - adresa v obrazové paměti pro vykreslení znaku
	;
	; výstupy:
	; DE - adresa v obrazové paměti pro vykreslení dalšího znaku
	;
	; změněné registry:
	; všechny
	ld bc, CHAR_ADR          ; adresa, od níž začínají masky znaků
	ld h, c                  ; C je nulové, protože CHAR_ADR=0x3c00
	ld l, a                  ; kód znaku je nyní ve dvojici HL

	add  hl, hl              ; 2x
	add  hl, hl              ; 4x
	add  hl, hl              ; 8x
	add  hl, bc              ; přičíst bázovou adresu masek znaků

	ld b, 8                  ; počitadlo zapsaných bajtů
	ld c, d

loop:
	ld   a,(hl)              ; načtení jednoho bajtu z masky
	ld   (de),a              ; zápis hodnoty na adresu (DE)
	inc  l                   ; posun na další bajt masky (nemusíme řešit přetečení do vyššího bajtu)
	inc  d                   ; posun na definici dalšího obrazového řádku
	djnz loop                ; vnitřní smyčka: blok s osmi zápisy
	inc  e
	ret  z                   ; D+=8,E=E+1=0
	ld   d, c
	ret                      ; D=D,E=E+1

end ENTRY_POINT
