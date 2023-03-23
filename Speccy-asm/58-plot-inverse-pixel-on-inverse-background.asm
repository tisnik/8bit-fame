SCREEN_ADR      equ $4000
CHAR_ADR        equ $3c00
ENTRY_POINT     equ $8000

	org ENTRY_POINT

	; Vstupní bod celého programu
start:
	call fill_in_screen      ; vyplnění obrazovky ASCII tabulkami

	ld b, 0                  ; x-ová souřadnice vykreslovaného pixelu
	ld c, 0                  ; y-ová souřadnice vykreslovaného pixelu
loop:
	call plot_inverse        ; vykreslení pixelu barvou papíru
	call delay
	inc b                    ; posun na další souřadnici
	inc c
	ld  a, b
	cp  192                  ; test na ukončení smyčky
	jr nz, loop              ; opakovat, dokud není vykreslena celá šikmá "úsečka"
finito:
	jr finito                ; ukončit program nekonečnou smyčkou


delay:
	; zpožďovací rutina
	; nemění žádné registry
	push bc                  ; uschovat hodnoty registrů, které se používají ve smyčkách
	ld   b, 20               ; počitadlo vnější zpožďovací smyčky
outer_loop:
        ld   c, 0                ; počitadlo vnitřní zpožďovací smyčky
inner_loop:
        dec  c                   ; snížení hodnoty počitadla (v první iteraci 256->255)
        jr   NZ, inner_loop      ; opakovat, dokud není dosaženo nuly
	djnz outer_loop          ; opakovat vnější smyčku, nyní s počitadlem v B
	pop  bc                  ; obnovit hodnoty registrů změněných smyčkami
	ret                      ; návrat z podprogramu


plot_inverse:
        ; varianta podprogramu pro vykreslení pixelu barvou papíru
	;
	; parametry:
	; B - x-ová souřadnice (v pixelech)
	; C - y-ová souřadnice (v pixelech)
	call calc_pixel_address  ; výpočet adresy pixelu
	call calc_pixel_value    ; výpočet ukládané hodnoty
	ld d, (hl)               ; přečíst původní hodnotu osmice pixelů
	cpl                      ; inverze masky
	and d                    ; použít vypočtenou masku pro vynulování jediného bitu
	ld (hl), a               ; zápis hodnoty pixelu (ostatních sedm pixelů se nezmění)
	ret                      ; návrat z podprogramu


calc_pixel_value:
	; parametry:
	; B - x-ová souřadnice (v pixelech)
	;
	; návratové hodnoty:
	; A - hodnota pixelu
	push bc                  ; zapamatovat si hodnotu v registru B
	ld   a, b                ; A: X7 X6 X5 X4 X3 X2 X1 X0 
	and  %00000111           ; A: 0  0  0  0  0  X2 X1 X0
	ld b, a                  ; počitadlo smyčky (neměníme příznaky)
	ld a, %10000000          ; výchozí maska (neměníme příznaky)
	jr z, end_calc           ; pokud je nyní souřadnice nulová, zapíšeme výchozí masku + konec

next_shift:
	srl a                    ; posunout masku doprava
	djnz next_shift          ; 1x až 7x
end_calc:
	pop bc                   ; obnovit hodnotu v registru B
	ret                      ; návrat z podprogramu


calc_pixel_address:
	; parametry:
	; B - x-ová souřadnice (v pixelech)
	; C - y-ová souřadnice (v pixelech)
	;
	; návratové hodnoty:
	; HL - adresa pro zápis pixelu
	;
	; pozměněné registry:
	; A
	;
	; vzor adresy:
	; 0 1 0 Y7 Y6 Y2 Y1 Y0 | Y5 Y4 Y3 X4 X3 X2 X1 X0
	ld  a, c              ; všech osm bitů Y-ové souřadnice
	and %00000111         ; pouze spodní tři bity y-ové souřadnice (Y2 Y1 Y0)
	                      ; A: 0 0 0 0 0 Y2 Y1 Y0
	or  %01000000         ; "posun" do obrazové paměti (na 0x4000)
	ld  h, a              ; část horního bajtu adresy je vypočtena
	                      ; H: 0 1 0 0 0 Y2 Y1 Y0

	ld  a, c              ; všech osm bitů Y-ové souřadnice
	rra
	rra
	rra                   ; rotace doprava -> Y1 Y0 xx Y7 Y6 Y5 Y4 Y3
	and %00011000         ; zamaskovat
	                      ; A: 0  0  0 Y7 Y6  0  0  0
	or  h                 ; a přidat k vypočtenému mezivýsledku
	ld  h, a              ; H: 0  1  0 Y7 Y6 Y2 Y1 Y0

	ld  a, c              ; všech osm bitů Y-ové souřadnice
	rla
	rla                   ; A:  Y5 Y4 Y3 Y2 Y1 Y0 xx xx
	and %11100000         ; A:  Y5 Y4 Y3 0  0  0  0  0
	ld  l, a              ; část spodního bajtu adresy je vypočtena

	ld  a, b              ; všech osm bitů X-ové souřadnice
	rra
	rra
	rra                   ; rotace doprava -> 0  0  0  X7 X6 X5 X4
	and %00011111         ; A: 0  0  0  X7 X6 X5 X4 X3
	or  l                 ; A: Y5 Y3 Y3 X7 X6 X5 X4 X3
	ld  l, a              ; spodní bajt adresy je vypočten

	ret                   ; návrat z podprogramu


fill_in_screen:
	; Vyplnění obrazovky snadno rozpoznatelným vzorkem - ASCII tabulkami
	;
	; vstupy:
	; žádné
	ld de, SCREEN_ADR         ; adresa pro vykreslení prvního bloku znaků
	call draw_ascii_table_inv ; vykreslení 96 znaků
	call draw_ascii_table_inv ; vykreslení 96 znaků
	call draw_ascii_table_inv ; vykreslení 96 znaků
	call draw_ascii_table_inv ; vykreslení 96 znaků
	ret                       ; návrat z podprogramu


draw_ascii_table_inv:
	; Vytištění ASCII tabulky inverzně (barva inkoustu je barvou pozadí a naopak)
	;	
	; vstupy:
	; DE - adresa v obrazové paměti pro vykreslení znaku
	ld a, ' '                ; kód vykreslovaného znaku
next_char:
	push af                  ; uschovat akumulátor na zásobník
	call draw_char_inv       ; zavolat subrutinu pro vykreslení znaku
	ld a, ' '                ; vykreslit za znakem mezeru
	call draw_char_inv       ; zavolat subrutinu pro vykreslení znaku
	pop af                   ; obnovit akumulátor ze zásobníku
	inc a                    ; ASCII kód dalšího znaku
	cp  ' ' + 96             ; jsme již na konci ASCII tabulky?
	jr nz, next_char         ; ne? potom pokračujeme
	ret                      ; návrat z podprogramu


draw_char_inv:
	; Vytištění jednoho inverzního znaku na obrazovku
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

loop2:
	ld   a,(hl)              ; načtení jednoho bajtu z masky
	cpl                      ; negace hodnoty v akumulátoru
	ld   (de),a              ; zápis hodnoty na adresu (DE)
	inc  l                   ; posun na další bajt masky (nemusíme řešit přetečení do vyššího bajtu)
	inc  d                   ; posun na definici dalšího obrazového řádku
	djnz loop2               ; vnitřní smyčka: blok s osmi zápisy
	inc  e
	ret  z                   ; D+=8,E=E+1=0
	ld   d, c
	ret                      ; D=D,E=E+1

end ENTRY_POINT
