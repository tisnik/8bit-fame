SCREEN_ADR      equ $4000
CHAR_ADR        equ $3c00
ENTRY_POINT     equ $8000

	org ENTRY_POINT

start:
	ld de, SCREEN_ADR        ; adresa pro zápis
	ld a, 'A'                ; kód vykreslovaného znaku
	call draw_char           ; zavolat subrutinu pro vykreslení znaku

	ld de, SCREEN_ADR+1      ; adresa pro zápis
	ld a, 'B'                ; kód vykreslovaného znaku
	call draw_char           ; zavolat subrutinu pro vykreslení znaku

	ld de, SCREEN_ADR+128+31 ; adresa pro zápis
	ld a, '?'                ; kód vykreslovaného znaku
	call draw_char           ; zavolat subrutinu pro vykreslení znaku

finish:
	ret                      ; ukončit program

draw_char:
	ld hl, CHAR_ADR          ; adresa, od níž začínají masky znaků
	ld b, 0
	ld c, a                  ; kód znaku je nyní ve dvojici BC
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b                     ; vynásobení BC osmi
	add hl, bc               ; přičíst adresu k offsetu masky znaku

	ld b, 8                  ; počitadlo zapsaných bajtů
loop:
	ld a, (hl)               ; načtení jednoho bajtu z masky
	ld (de), a               ; zápis hodnoty na adresu (DE)
	inc hl                   ; posun na další bajt masky
	inc d                    ; posun na definici dalšího obrazového řádku
	djnz loop                ; vnitřní smyčka: blok s osmi zápisy
	ret

end ENTRY_POINT
