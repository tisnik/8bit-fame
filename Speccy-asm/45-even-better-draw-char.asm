; Example that is used in following article:
;    Vývoj her a dem pro ZX Spectrum: vlastní vykreslovací subrutiny podruhé
;    https://www.root.cz/clanky/vyvoj-her-a-dem-pro-zx-spectrum-vlastni-vykreslovaci-subrutiny-podruhe/
;
; This article is part of series:
;    "Vývoj pro slavné ZX Spectrum"
;    https://www.root.cz/serialy/vyvoj-pro-slavne-zx-spectrum/
;
; Repository:
;    https://github.com/tisnik/8bit-fame
;
; Example #45:
;    Draw any character anywhere on screen using own drawing routine (even better solution).
;
; This source code is available at:
;    https://github.com/tisnik/8bit-fame/blob/master/Speccy-asm/45-even-better-draw-char.asm



SCREEN_ADR      equ $4000
CHAR_ADR        equ $3c00
ENTRY_POINT     equ $8000

        org ENTRY_POINT

start:
        ld de, SCREEN_ADR        ; adresa pro zápis
        ld a, 'A'                ; kód vykreslovaného znaku
        call draw_char           ; zavolat subrutinu pro vykreslení znaku

        ld a, 'B'                ; kód vykreslovaného znaku
        call draw_char           ; zavolat subrutinu pro vykreslení znaku

        ld a, '?'                ; kód vykreslovaného znaku
        call draw_char           ; zavolat subrutinu pro vykreslení znaku

finish:
        ret                      ; ukončit program

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

end ENTRY_POINT
