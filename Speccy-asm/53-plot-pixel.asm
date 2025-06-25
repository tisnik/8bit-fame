; Example that is used in following article:
;    Vývoj her a dem pro ZX Spectrum: vlastní vykreslovací subrutiny potřetí
;    https://www.root.cz/clanky/vyvoj-pro-zx-spectrum-vlastni-vykreslovaci-subrutiny-potreti/
;
; This article is part of series:
;    "Vývoj pro slavné ZX Spectrum"
;    https://www.root.cz/serialy/vyvoj-pro-slavne-zx-spectrum/
;
; Repository:
;    https://github.com/tisnik/8bit-fame
;
; Example #53:
;    Drawing real pixel, but erasing whole 8x1 pixel block background (optimized variant).
;
; This source code is available at:
;    https://github.com/tisnik/8bit-fame/blob/master/Speccy-asm/53-plot-pixel.asm



SCREEN_ADR      equ $4000
CHAR_ADR        equ $3c00
ENTRY_POINT     equ $8000

        org ENTRY_POINT

        ; Vstupní bod celého programu
start:
        ld b, 0                  ; x-ová souřadnice vykreslovaného pixelu
        ld c, 0                  ; y-ová souřadnice vykreslovaného pixelu
loop:
        call plot                ; vykreslení pixelu
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


plot:
        ; druhá varianta podprogramu pro vykreslení pixelu
        ;
        ; parametry:
        ; B - x-ová souřadnice (v pixelech)
        ; C - y-ová souřadnice (v pixelech)
        call calc_pixel_address  ; výpočet adresy pixelu
        call calc_pixel_value    ; výpočet ukládané hodnoty
        ld (hl), a               ; zápis hodnoty pixelu
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


end ENTRY_POINT
