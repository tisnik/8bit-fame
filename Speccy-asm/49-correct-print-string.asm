SCREEN_ADR      equ $4000
CHAR_ADR        equ $3c00
ENTRY_POINT     equ $8000

	org ENTRY_POINT

start:
	ld b, 15                 ; x-ová souřadnice
	ld c, 12                 ; y-ová souřadnice
	call calc_char_address   ; výpočet adresy
	ld   hl, TEXT            ; adresa prvního znaku v řetězci
	call print_string        ; tisk celého řetězce

finish:
	jr finish                ; žádný návrat do systému


calc_char_address:
        ; parametry:
	; B - x-ová souřadnice (ve znacích, ne pixelech)
	; C - y-ová souřadnice (ve znacích, ne pixelech)
	;
	; návratové hodnoty:
	; DE - adresa pro zápis bloku
	;
	; vzor adresy:
	; 0 1 0 Y4 Y3 0 0 0 | Y2 Y1 Y0 X4 X3 X2 X1 X0
	ld  a, c
	and %00000111            ; pouze spodní tři bity y-ové souřadnice (řádky 0..7)
	rrca
	rrca
	rrca                     ; nyní jsou čísla řádků v horních třech bitech
	or  b                    ; připočítat x-ovou souřadnici
	ld  e, a                 ; máme spodní bajt adresy
	                         ; Y2 Y1 Y0 X4 X3 X2 X1 X0

	ld  a, c                 ; y-ová souřadnice
	and %00011000            ; dva bity s indexem "bloku" 0..3 (dolní tři bity už máme zpracovány)
	or  %01000000            ; "posun" do obrazové paměti (na 0x4000)
	ld  d, a                 ; máme horní bajt adresy
	                         ; 0 1 0 Y5 Y4 0 0 0
	ret                      ; návrat z podprogramu


print_string:
	ld   a, (hl)             ; načíst kód znaku z řetězce
	and  a                   ; test na kód znak s kódem 0
	ret  Z                   ; ukončit podprogram na konci řetězce
	push hl                  ; uschovat HL na zásobník
	call draw_char           ; tisk jednoho znaku
	pop  hl                  ; obnovit obsah HL ze zásobníku
	inc  hl                  ; přechod na další znak
	jr   print_string        ; na další znak

draw_char:
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
        ld    a,(hl)             ; načtení jednoho bajtu z masky
        ld  (de),a               ; zápis hodnoty na adresu (DE)
        inc  l                   ; posun na další bajt masky (nemusíme řešit přetečení do vyššího bajtu)
        inc  d                   ; posun na definici dalšího obrazového řádku
        djnz loop                ; vnitřní smyčka: blok s osmi zápisy
        inc   e
        ret   z                  ; D+=8,E=E+1=0
        ld    d, c
        ret                      ; D=D,E=E+1

; nulou ukončený řetězec
TEXT:	db "Hello, Speccy!", 0

end ENTRY_POINT
