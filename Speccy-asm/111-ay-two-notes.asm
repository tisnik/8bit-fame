; Example that is used in following article:
;    Podrobnější popis možností zvukového čipu řady AY-3–8910 na ZX Spectru 128k
;    https://www.root.cz/clanky/podrobnejsi-popis-moznosti-zvukoveho-cipu-rady-ay-3-8910-na-zx-spectru-128k/
;
; This article is part of series:
;    "Vývoj pro slavné ZX Spectrum"
;    https://www.root.cz/serialy/vyvoj-pro-slavne-zx-spectrum/
;
; Repository:
;    https://github.com/tisnik/8bit-fame
;
; Example #111:
;    Play two notes on AY-3-8912 chip.

ENTRY_POINT        equ $8000
AY_SELECT_REGISTER equ $fffd
AY_DATA_REGISTER   equ $bffd



org ENTRY_POINT

start:
        ; nota A4 = 440.00 Hz
        ld      a, 0                   ; výška tónu (spodní bajt) pro kanál A
        ld      bc, AY_SELECT_REGISTER
        out     (c), a
        ld      a, 251
        ld      bc, AY_DATA_REGISTER
        out     (c), a                 ; zápis hodnoty do AY

        ld      a, 1                   ; výška tónu (horní bajt) pro kanál A
        ld      bc, AY_SELECT_REGISTER
        out     (c), a
        ld      a, 0
        ld      bc, AY_DATA_REGISTER
        out     (c), a                 ; zápis hodnoty do AY

        ; nota C4 = 261.63 Hz
        ld      a, 2                   ; výška tónu (spodní bajt) pro kanál B
        ld      bc, AY_SELECT_REGISTER
        out     (c), a
        ld      a, 167
        ld      bc, AY_DATA_REGISTER
        out     (c), a                 ; zápis hodnoty do AY

        ld      a, 3                   ; výška tónu (horní bajt) pro kanál B
        ld      bc, AY_SELECT_REGISTER
        out     (c), a
        ld      a, 1
        ld      bc, AY_DATA_REGISTER
        out     (c), a                 ; zápis hodnoty do AY

        ld      a, 8                   ; hlasitost kanálu A
        ld      bc, AY_SELECT_REGISTER
        out     (c), a
        ld      a, 15                  ; maximální hlasitost
        ld      bc, AY_DATA_REGISTER
        out     (c), a                 ; zápis hodnoty do AY

        ld      a, 9                   ; hlasitost kanálu B
        ld      bc, AY_SELECT_REGISTER
        out     (c), a
        ld      a, 10
        ld      bc, AY_DATA_REGISTER
        out     (c), a                 ; zápis hodnoty do AY

        ld      a, 7                   ; povolení výstupu z kanálu A i kanálu B
        ld      bc, AY_SELECT_REGISTER
        out     (c), a
        ld      a, %11111100           ; bitová maska
        ld      bc, AY_DATA_REGISTER
        out     (c), a                 ; zápis hodnoty do AY

loop:
        jr loop                        ; nechceme návrat do BASICu


end ENTRY_POINT
