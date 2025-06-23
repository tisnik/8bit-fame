; This article is part of series:
;    "Vývoj pro slavné ZX Spectrum"
;    https://www.root.cz/serialy/vyvoj-pro-slavne-zx-spectrum/
;
; Repository:
;    https://github.com/tisnik/8bit-fame
;
; Example #124:
;    Load 8 shifted sprites from binary files.
;    Draw 24x24 sprites on screen.

SCREEN_ADR      equ $4000
ENTRY_POINT     equ $8000

        org ENTRY_POINT


draw_shifted_sprite MACRO index
        ld hl, SPRITE_ADR+(index*24*4) ; adresa, od níž začíná maska spritu
        call draw_sprite
endm


start:
        ld b, 0                  ; x-ová souřadnice
        ld c, 2                  ; y-ová souřadnice
        call calc_sprite_address ; výpočet adresy spritu
        draw_shifted_sprite 0

        ld b, 0                  ; x-ová souřadnice
        ld c, 5                  ; y-ová souřadnice
        call calc_sprite_address ; výpočet adresy spritu
        draw_shifted_sprite 1

        ld b, 0                  ; x-ová souřadnice
        ld c, 9                  ; y-ová souřadnice
        call calc_sprite_address ; výpočet adresy
        draw_shifted_sprite 2

        ld b, 0                  ; x-ová souřadnice
        ld c, 12                 ; y-ová souřadnice
        call calc_sprite_address ; výpočet adresy
        draw_shifted_sprite 3

        ld b, 0                  ; x-ová souřadnice
        ld c, 16                 ; y-ová souřadnice
        call calc_sprite_address ; výpočet adresy
        draw_shifted_sprite 4

        ld b, 0                  ; x-ová souřadnice
        ld c, 19                 ; y-ová souřadnice
        call calc_sprite_address ; výpočet adresy
        draw_shifted_sprite 5

finish:
        jr finish                ; žádný návrat do systému


calc_sprite_address:
        ; parametry:
        ; B - x-ová souřadnice (ve znacích, ne pixelech)
        ; C - y-ová souřadnice (ve znacích, ne pixelech)
        ;
        ; návratové hodnoty:
        ; DE - adresa pro zápis bloku
        ;
        ; vzor adresy:
        ; 0 1 0 Y4 Y3 0 0 0 | Y2 Y1 Y0 X4 X3 X2 X1 X0
        ;
        ; popis struktury obrazové paměti:
        ; https://www.root.cz/clanky/vyvoj-her-a-dem-pro-zx-spectrum-vlastni-vykreslovaci-subrutiny/#k03
        ;
        ; postup výpočtu adresy:
        ; https://www.root.cz/clanky/vyvoj-her-a-dem-pro-zx-spectrum-vlastni-vykreslovaci-subrutiny/#k15
        ;
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


add_e MACRO n                    ; zvýšení hodnoty regitru E
        ld   a, e
        add  a, n
        ld   e, a
endm


draw_sprite:
        push de
        call draw_8_lines        ; vykreslit prvních 8 řádků spritu

        pop  de
        add_e 32                 ; zvýšit E o hodnotu 32
        push de
        call draw_8_lines        ; vykreslit druhých 8 řádků spritu

        pop  de
        add_e 32                 ; zvýšit E o hodnotu 32
        call draw_8_lines        ; vykreslit třetích 8 řádků spritu

        ret                      ; návrat z podprogramu


draw_8_lines:
        ld b, 8                  ; počitadlo zapsaných řádků

loop:
        ld  a,(hl)               ; načtení jednoho bajtu z masky
        ld  (de),a               ; zápis hodnoty na adresu (DE)
        inc hl                   ; posun na další bajt masky
        inc e

        ld  a,(hl)               ; načtení jednoho bajtu z masky
        ld  (de),a               ; zápis hodnoty na adresu (DE)
        inc hl                   ; posun na další bajt masky
        inc e

        ld  a,(hl)               ; načtení jednoho bajtu z masky
        ld  (de),a               ; zápis hodnoty na adresu (DE)
        inc hl                   ; posun na další bajt masky
        inc e

        ld  a,(hl)               ; načtení jednoho bajtu z masky
        ld  (de),a               ; zápis hodnoty na adresu (DE)
        inc hl                   ; posun na další bajt masky

        inc d                    ; posun na definici dalšího obrazového řádku
        dec e                    ; korekce - posun zpět pod první osmici pixelů
        dec e                    ; dtto
        dec e                    ; dtto
        djnz loop                ; vnitřní smyčka: blok s 4x osmi zápisy
        ret                      ; návrat z podprogramu


SPRITE_ADR
        incbin "sprites_0.bin"
        incbin "sprites_1.bin"
        incbin "sprites_2.bin"
        incbin "sprites_3.bin"
        incbin "sprites_4.bin"
        incbin "sprites_5.bin"
        incbin "sprites_6.bin"
        incbin "sprites_7.bin"


end ENTRY_POINT
