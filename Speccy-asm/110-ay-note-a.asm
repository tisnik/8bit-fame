; Example that is used in following article:
;    Zvuky a hudba na ZX Spectru: zvukové čipy řady AY-3–8910
;    https://www.root.cz/clanky/zvuky-a-hudba-na-zx-spectru-zvukove-cipy-rady-ay-3-8910/
;
; This article is part of series:
;    "Vývoj pro slavné ZX Spectrum"
;    https://www.root.cz/serialy/vyvoj-pro-slavne-zx-spectrum/
;
; Repository:
;    https://github.com/tisnik/8bit-fame
;
; Example #110:
;    Play a note via AY-3-8912 chip.
;    Version based on subroutine to set up AY control registers.

ENTRY_POINT        equ $8000
AY_SELECT_REGISTER equ $fffd
AY_DATA_REGISTER   equ $bffd



org ENTRY_POINT

start:
        ld      d, 0                   ; výška tónu (spodní bajt)
        ld      e, 251
        call    ay_write               ; zápis hodnoty do AY

        ld      d, 1                   ; výška tónu (horní bajt)
        ld      e, 0
        call    ay_write               ; zápis hodnoty do AY

        ld      d, 8                   ; hlasitost kanálu A
        ld      e, 15                  ; maximální hlasitost
        call    ay_write               ; zápis hodnoty do AY

        ld      d, 7                   ; povolení výstupu z kanálu A
        ld      e, %11111110           ; bitová maska
        call    ay_write               ; zápis hodnoty do AY

loop:
        jr      loop                   ; nechceme návrat do BASICu


ay_write:
        ld      bc, AY_SELECT_REGISTER ; zápis do výběrového registru AY
        out     (c), d                 ; index vybraného registru
        ld      bc,AY_DATA_REGISTER    ; zápis do datového registru AY
        out     (c), e                 ; zapisovaná hodnota
        ret                            ; návrat ze subrutiny


end ENTRY_POINT
