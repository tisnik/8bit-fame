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
; Example #99:
;    Move game character (represented as color attribute) by keyboard; updated macros usage.
;
; This source code is available at:
;    https://github.com/tisnik/8bit-fame/blob/master/Speccy-asm/99-game-character-2.asm



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

KB_ROW_0_PORT equ $fe
KB_ROW_1_PORT equ $fd
KB_ROW_2_PORT equ $fb
KB_ROW_3_PORT equ $f7
KB_ROW_4_PORT equ $ef
KB_ROW_5_PORT equ $df
KB_ROW_6_PORT equ $bf
KB_ROW_7_PORT equ $7f


changeAttribute MACRO attribute
        ld  (hl), attribute
ENDM

keypress MACRO port
        ld  b, port                    ; adresa portu, ze kterého budeme číst údaje
        in  a, (c)                     ; vlastní čtení z portu (5 bitů)
ENDM

add_to_hl MACRO value
        ld  b, 0
        ld  c, value
        add hl, bc
ENDM

sub_from_hl MACRO value
        ld  b, 0
        ld  c, value
        or  a                          ; vynulovat carry
        sbc hl, bc
ENDM

start:
        call ROM_CLS                   ; smazání obrazovky
        ld   hl, INIT_POSITION
        changeAttribute RED_BLOCK      ; vykreslit hráče na startovní pozici zhruba uprostřed obrazovky
repeat:
        ld  c, $fe                     ; port, ze kterého se bude číst

        keypress KB_ROW_5_PORT         ; test stisku klávesy O a P
        rra                            ; nultý bit do příznaku carry
        jr c, p_not_pressed            ; přeskok dalších instrukcí, pokud klávesa není stisknuta
        changeAttribute ORIG_BLOCK     ; smazat hráče na původní pozici
        inc hl                         ; posun doprava o jeden bajt
        changeAttribute RED_BLOCK      ; vykreslit hráče na nové pozici

p_not_pressed:
        rra                            ; první bit do příznaku carry
        jr c, o_not_pressed            ; přeskok dalších instrukcí, pokud klávesa není stisknuta
        changeAttribute ORIG_BLOCK     ; smazat hráče na původní pozici
        dec hl                         ; posun doleva o jeden bajt
        changeAttribute RED_BLOCK      ; vykreslit hráče na nové pozici

o_not_pressed:
        keypress KB_ROW_1_PORT         ; test stisku klávesy A
        rra                            ; nultý bit do příznaku carry
        jr c, a_not_pressed            ; přeskok dalších instrukcí, pokud klávesa není stisknuta
        changeAttribute ORIG_BLOCK     ; smazat hráče na původní pozici
        add_to_hl 32                   ; posun dolů (o 32 bajtů)
        changeAttribute RED_BLOCK      ; vykreslit hráče na nové pozici

a_not_pressed:
        keypress KB_ROW_2_PORT         ; test stisku klávesy Q
        rra                            ; nultý bit do příznaku carry
        jr c, q_not_pressed            ; přeskok dalších instrukcí, pokud klávesa není stisknuta
        changeAttribute ORIG_BLOCK     ; smazat hráče na původní pozici
        sub_from_hl 32                 ; posun nahoru (o 32 bajtů)
        changeAttribute RED_BLOCK      ; vykreslit hráče na nové pozici

q_not_pressed:
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
