; Example that is used in following article:
;    Programujeme zvuky a hudbu na ZX Spectru
;    https://www.root.cz/clanky/programujeme-zvuky-a-hudbu-na-zx-spectru/
;
; This article is part of series:
;    "Vývoj pro slavné ZX Spectrum"
;    https://www.root.cz/serialy/vyvoj-pro-slavne-zx-spectrum/
;
; Repository:
;    https://github.com/tisnik/8bit-fame
;
; Example #104:
;    Play music scale via beeper.

ENTRY_POINT   equ $8000
BEEPER        equ $03B5
DURATION      equ 200



        org ENTRY_POINT


start:
        ld   BC, notes                 ; adresa 16bitových konstant
next_note:
        ld   A, (BC)                   ; načíst spodní bajt 16bitové konstanty
        ld   L, A                      ; uložit do L
        inc  BC                        ; a zvýšit adresu v poli

        ld   A, (BC)                   ; načíst horní bajt 16bitové konstanty
        ld   H, A                      ; uložit do H
        inc  BC                        ; a zvýšit adresu v poli

        add  A, L                      ; test na 16bitovou nulu
        ret  z                         ; návrat do BASICu pokud je načtená hodnota nulová

        ld   DE, DURATION              ; parametry pro BEEP jsou v HL a DE
        push BC
        call BEEPER                    ; zavolat subrutinu z ROM
        call delay                     ; doba bez tónu
        pop  BC
        jr   next_note                 ; zahrát další notu


notes:
        ; nota  frekvence   437500 / frekvence – 30.125
        ; C     261.63      1642
        ; D     293.66      1459
        ; E     329.63      1297
        ; F     349.23      1222
        ; G     392.00      1086
        ; A     440.00      964
        ; H     493.88      855
        ; C     523.26      806
        dw 1642, 1459, 1297, 1222, 1086, 964, 855, 806, 0

delay:
        ; zpožďovací rutina
        ; mění BC (což nám nevadí)
        ld   b, 200                    ; počitadlo vnější zpožďovací smyčky
outer_loop:
        ld   c, 0                      ; počitadlo vnitřní zpožďovací smyčky
inner_loop:
        dec  c                         ; snížení hodnoty počitadla (v první iteraci 256->255)
        jr   NZ, inner_loop            ; opakovat, dokud není dosaženo nuly
        djnz outer_loop                ; opakovat vnější smyčku, nyní s počitadlem v B
        ret                            ; návrat z podprogramu

end ENTRY_POINT
