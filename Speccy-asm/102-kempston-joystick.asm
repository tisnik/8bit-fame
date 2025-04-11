; Example that is used in following article:
;    Ovládání hráčů ve hře klávesnicí nebo joystickem na ZX Spectru
;    https://www.root.cz/clanky/ovladani-hracu-ve-hre-klavesnici-nebo-joystickem-na-zx-spectru/
;
; This article is part of series:
;    "Vývoj pro slavné ZX Spectrum"
;    https://www.root.cz/serialy/vyvoj-pro-slavne-zx-spectrum/
;
; Repository:
;    https://github.com/tisnik/8bit-fame
;
; Example #102:
;    Move game character by Kempston joystick.

ATTRIBUTE_ADR equ $5800
ENTRY_POINT   equ $8000
ROM_CLS       equ $0DAF

        org ENTRY_POINT

BLINK_BIT     equ %10000000
INTENSITY_BIT equ %01000000
BLACK_COLOR   equ %000
BLUE_COLOR    equ %001
RED_COLOR     equ %010
MAGENTA_COLOR equ %011
GREEN_COLOR   equ %100
CYAN_COLOR    equ %101
YELLOW_COLOR  equ %110
WHITE_COLOR   equ %111

RED_BLOCK     equ INTENSITY_BIT | (RED_COLOR << 3)
ORIG_BLOCK    equ WHITE_COLOR << 3

INIT_X        equ 15
INIT_Y        equ 12
INIT_POSITION equ ATTRIBUTE_ADR + INIT_X + 32*INIT_Y

KEMPSTON_PORT equ 31


changeAttribute MACRO attribute
        ld  (hl), attribute
ENDM

add_to_hl MACRO value
        ld  b, 0
        ld  c, value
        add hl, bc
ENDM

sub_from_hl MACRO value
        ld  b, 0
        ld  c, value
        or  a
        sbc hl, bc
ENDM

start:
        call ROM_CLS                   ; smazání obrazovky
        ld   hl, INIT_POSITION
        changeAttribute RED_BLOCK      ; vykreslit hráče na startovní pozici zhruba uprostřed obrazovky
repeat:
        ld  bc, KEMPSTON_PORT          ; adresa portu
        in  a, (c)                     ; čtení z portu
        rra                            ; otestovat nejnižší bit
        jr nc, right_not_pressed       ; přeskok dalších instrukcí, pokud klávesa není stisknuta
        changeAttribute ORIG_BLOCK     ; smazat hráče na původní pozici
        inc hl                         ; posun doprava o jeden bajt
        changeAttribute RED_BLOCK      ; vykreslit hráče na nové pozici

right_not_pressed:
        rra                            ; otestovat druhý bit
        jr nc, left_not_pressed        ; přeskok dalších instrukcí, pokud klávesa není stisknuta
        changeAttribute ORIG_BLOCK     ; smazat hráče na původní pozici
        dec hl                         ; posun doleva o jeden bajt
        changeAttribute RED_BLOCK      ; vykreslit hráče na nové pozici

left_not_pressed:
        rra                            ; třetí bit do příznaku carry
        jr nc, up_not_pressed         ; přeskok dalších instrukcí, pokud klávesa není stisknuta
        changeAttribute ORIG_BLOCK     ; smazat hráče na původní pozici
        add_to_hl 32                   ; posun dolů (o 32 bajtů)
        changeAttribute RED_BLOCK      ; vykreslit hráče na nové pozici

up_not_pressed:
        rra                            ; čtvrtý bit do příznaku carry
        jr nc, down_not_pressed        ; přeskok dalších instrukcí, pokud klávesa není stisknuta
        changeAttribute ORIG_BLOCK     ; smazat hráče na původní pozici
        sub_from_hl 32                 ; posun nahoru (o 32 bajtů)
        changeAttribute RED_BLOCK      ; vykreslit hráče na nové pozici

down_not_pressed:
        call delay                     ; Z80 je pro nás moc rychlý :-)
        jr   repeat                    ; opakovat

delay:
        ; zpožďovací rutina
        ; mění BC (což nám nevadí)
        ld   b, 30                     ; počitadlo vnější zpožďovací smyčky
outer_loop:
        ld   c, 0                      ; počitadlo vnitřní zpožďovací smyčky
inner_loop:
        dec  c                         ; snížení hodnoty počitadla (v první iteraci 256->255)
        jr   NZ, inner_loop            ; opakovat, dokud není dosaženo nuly
        djnz outer_loop                ; opakovat vnější smyčku, nyní s počitadlem v B
        ret                            ; návrat z podprogramu


end ENTRY_POINT
