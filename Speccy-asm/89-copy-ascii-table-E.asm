; Example #89:
;    Print ASCII table on screen + copy it to second part of screen using unrolled loop.

SCREEN_ADR          equ $4000
SCREEN_BLOCK_SIZE   equ 32*64
SECOND_SCREEN_BLOCK equ SCREEN_ADR+SCREEN_BLOCK_SIZE

CHAR_ADR            equ $3c00
ENTRY_POINT         equ $8000

	org ENTRY_POINT

	; Vstupní bod celého programu
start:
	call fill_in_screen           ; vyplnění obrazovky ASCII tabulkami
	ld   hl, SCREEN_ADR           ; adresa zdrojového bloku
	ld   de, SECOND_SCREEN_BLOCK  ; adresa cílového bloku
	ld   bc, SCREEN_BLOCK_SIZE    ; velikost přenášených dat
	call mem_copy
finito:
	jr finito                     ; ukončit program nekonečnou smyčkou

mem_copy:
	ld   a, b                ; kontrola BC na nulu
	or   c
	ret  z                   ; při prázdném bloku podprogram ukončíme

	ld   a, 16               ; na základě hodnoty v C vypočteme, kolik
	sub  c                   ; instrukcí LDI se má na začátku přenosu přeskočit
	and  15                  ; maximálně se přeskočí 15 instrukcí ze 16

	add  a, a                ; vynásobit dvěma protože LDI je dvoubajtová instrukce
	ld   (jump_address), a   ; uložíme offset do tohoto paměťového místa
	jr   $                   ; relativní skok přečte offset z ^
jump_address equ $-1             ; trik jak zasáhnout do operandu instrukce JR

repeat:
	ldi                      ; provést přenos jednoho bajtu
	ldi                      ; provést přenos jednoho bajtu
	ldi                      ; provést přenos jednoho bajtu
	ldi                      ; provést přenos jednoho bajtu
	ldi                      ; provést přenos jednoho bajtu
	ldi                      ; provést přenos jednoho bajtu
	ldi                      ; provést přenos jednoho bajtu
	ldi                      ; provést přenos jednoho bajtu
	ldi                      ; provést přenos jednoho bajtu
	ldi                      ; provést přenos jednoho bajtu
	ldi                      ; provést přenos jednoho bajtu
	ldi                      ; provést přenos jednoho bajtu
	ldi                      ; provést přenos jednoho bajtu
	ldi                      ; provést přenos jednoho bajtu
	ldi                      ; provést přenos jednoho bajtu
	ldi                      ; provést přenos jednoho bajtu
	jp   pe, repeat          ; ukončit blokový přenos při BC==0
	ret                      ; návrat z podprogramu


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
