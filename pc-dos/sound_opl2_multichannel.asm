; Klavesami 1-8 lze prehrat noty z jedne oktavy (i soucasne).
; Delsi varianta s rozvetvenim kodu dle stlacene klavesy.
; Pojmenovani registru OPL2.
;
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
;
; preklad pomoci:
;     nasm -f bin -o sound_opl2_table.com sound_opl2_multichannel.asm
;
; nebo pouze:
;     nasm -o sound_opl2_table.com sound_opl2_multichannel.asm

;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU 8086        ; specifikace pouziteho instrukcniho souboru

 
;-----------------------------------------------------------------------------

; registry karet s cipem OPL2
OPL_ADDRESS equ 0x388
OPL_DATA    equ 0x389

; ridici registry OPL2
OPL_TEST_LSI          equ 0x01
OPL_TIMER_1           equ 0x02
OPL_TIMER_2           equ 0x03
OPL_TIMER_CTRL        equ 0x04
OPL_KBSPLIT           equ 0x08
OPL_AMP_VIBRATO_EG    equ 0x20
OPL_LEVEL             equ 0x40
OPL_ATTACK_DECAY      equ 0x60
OPL_SUSTAIN_RELEASE   equ 0x80
OPL_FREQUENCY_LOW     equ 0xa0
OPL_KEY_ON            equ 0xb0
OPL_AM_VIBRATO_RHYTHM equ 0xbd
OPL_FEEDBACK          equ 0xc0
OPL_WAVE_SELECT       equ 0xe0

; indexy kanalu
CHANNEL_1 equ 0
CHANNEL_2 equ 1
CHANNEL_3 equ 2
CHANNEL_4 equ 3
CHANNEL_5 equ 4
CHANNEL_6 equ 5
CHANNEL_7 equ 6
CHANNEL_8 equ 7
CHANNEL_9 equ 8

; offsety pro jednotlive operatory
; --------------------------------------------------
;  Channel        1   2   3   4   5   6   7   8   9
;  Operator 1    00  01  02  08  09  0A  10  11  12
;  Operator 2    03  04  05  0B  0C  0D  13  14  15
; --------------------------------------------------
;  Channel        1   2   3   4   5   6   7   8   9
CHANNEL_1_OPERATOR_1 equ 0x00
CHANNEL_1_OPERATOR_2 equ 0x03
CHANNEL_2_OPERATOR_1 equ 0x01
CHANNEL_2_OPERATOR_2 equ 0x04
CHANNEL_3_OPERATOR_1 equ 0x02
CHANNEL_3_OPERATOR_2 equ 0x05
CHANNEL_4_OPERATOR_1 equ 0x08
CHANNEL_4_OPERATOR_2 equ 0x0b
CHANNEL_5_OPERATOR_1 equ 0x09
CHANNEL_5_OPERATOR_2 equ 0x0c
CHANNEL_6_OPERATOR_1 equ 0x0a
CHANNEL_6_OPERATOR_2 equ 0x0d
CHANNEL_7_OPERATOR_1 equ 0x10
CHANNEL_7_OPERATOR_2 equ 0x13
CHANNEL_8_OPERATOR_1 equ 0x11
CHANNEL_8_OPERATOR_2 equ 0x14
CHANNEL_9_OPERATOR_1 equ 0x12
CHANNEL_9_OPERATOR_2 equ 0x15

; registry PPI
PPI_PORT_A equ 0x60
PPI_PORT_B equ 0x61

; kody klaves
KEY_ESC     equ 0x01
KEY_SPACE   equ 0x39
KEY_RELEASE equ 0x80
KEY_1       equ 0x02
KEY_2       equ 0x03
KEY_3       equ 0x04
KEY_4       equ 0x05
KEY_5       equ 0x06
KEY_6       equ 0x07
KEY_7       equ 0x08
KEY_8       equ 0x09

;-----------------------------------------------------------------------------

; ukonceni procesu a navrat do DOSu
%macro exit 0
        ret
%endmacro

; makro pro zapis do registru OPL2
%macro write_opl_register 2
        mov     al, %1
        mov     ah, %2
        call    perform_write_to_opl_register
%endmacro

%macro on_key_press 3
        cmp al, %1                   ; test na stisk klavesy
        jne %%not_pressed            ; neni stisknuta -> preskok
        write_opl_register %2, %3    ; povoleni KEY ON bitu
        jmp .opak
    %%not_pressed:
%endmacro

%macro on_key_release 3
        cmp al, 0x80 + %1            ; test na uvolneni klavesy
        jne %%not_released           ; neni uvolnena -> preskok
        write_opl_register %2, %3    ; zakaz KEY ON bitu
        jmp .opak
    %%not_released:
%endmacro

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        push cs
        pop  ds                          ; DS==CS

        mov  si, tones                   ; zacatek tabulky
        call write_table_to_opl2         ; zapis obsahu tabulky do OPL2

        in  al, PPI_PORT_B               ; port B s rizenim zarizeni
        or  al, 0b1000000                ; nastaveni bitu cislo 7 na jednicku
        out PPI_PORT_B, al               ; zapis zpet na port B

.opak:
        in  al, PPI_PORT_A               ; cteni stisknute klavesy

        on_key_press   KEY_1, CHANNEL_1 + OPL_KEY_ON, 0b00101110
        on_key_release KEY_1, CHANNEL_1 + OPL_KEY_ON, 0b00001110
        on_key_press   KEY_2, CHANNEL_2 + OPL_KEY_ON, 0b00110001
        on_key_release KEY_2, CHANNEL_2 + OPL_KEY_ON, 0b00010001
        on_key_press   KEY_3, CHANNEL_3 + OPL_KEY_ON, 0b00110001
        on_key_release KEY_3, CHANNEL_3 + OPL_KEY_ON, 0b00010001
        on_key_press   KEY_4, CHANNEL_4 + OPL_KEY_ON, 0b00110001
        on_key_release KEY_4, CHANNEL_4 + OPL_KEY_ON, 0b00010001
        on_key_press   KEY_5, CHANNEL_5 + OPL_KEY_ON, 0b00110010
        on_key_release KEY_5, CHANNEL_5 + OPL_KEY_ON, 0b00010010
        on_key_press   KEY_6, CHANNEL_6 + OPL_KEY_ON, 0b00110010
        on_key_release KEY_6, CHANNEL_6 + OPL_KEY_ON, 0b00010010
        on_key_press   KEY_7, CHANNEL_7 + OPL_KEY_ON, 0b00110010
        on_key_release KEY_7, CHANNEL_7 + OPL_KEY_ON, 0b00010010
        on_key_press   KEY_8, CHANNEL_8 + OPL_KEY_ON, 0b00110010
        on_key_release KEY_8, CHANNEL_8 + OPL_KEY_ON, 0b00010010

        cmp al, KEY_ESC                  ; test stisknute klavesy ESC
        jne .opak                        ; neni stisknuta? -> zkusme znovu
        exit


write_table_to_opl2:
        lodsb                            ; nacist bajt z tabulky (cislo registru)
        or  al, al                       ; test na nulu
        jnz .write_register
        ret                              ; dosahli jsme konce tabulky
.write_register:
        mov ah, al
        lodsb                            ; nacist dalsi bajt z tabulky (hodnota registru)
        xchg al, ah                      ; podprogram vyzaduje opacne poradi AL, AH
        call perform_write_to_opl_register
        jmp  write_table_to_opl2         ; muzeme prejit na dalsi registr


tones:  ; tabulka s tony pro osm kanalu
        db CHANNEL_1_OPERATOR_1 + OPL_AMP_VIBRATO_EG,  0x01  ; nastaveni modulatoru: nasobeni frekvence jednickou
        db CHANNEL_1_OPERATOR_1 + OPL_LEVEL,           0x10  ; uroven vystupu 40 dB
        db CHANNEL_1_OPERATOR_1 + OPL_ATTACK_DECAY,    0x55  ; modulator: rychly nastup zvuku + pomale doznivani
        db CHANNEL_1_OPERATOR_1 + OPL_SUSTAIN_RELEASE, 0x77  ; urovne sustain a release pro modulator
        db CHANNEL_1_OPERATOR_2 + OPL_AMP_VIBRATO_EG,  0x01  ; nastaveni nosne: nasobeni frekvence jednickou
        db CHANNEL_1_OPERATOR_2 + OPL_LEVEL,           0x00  ; nastaveni urovne vystupu nosne na 47 dB
        db CHANNEL_1_OPERATOR_2 + OPL_ATTACK_DECAY,    0xF0  ; nosna: rychly nastup + pomale doznivani
        db CHANNEL_1_OPERATOR_2 + OPL_SUSTAIN_RELEASE, 0x77  ; urovne sustain a release pro nosnou
        db CHANNEL_1 + OPL_FREQUENCY_LOW,              0xae  ; frekvence zvuku (C)

        db CHANNEL_2_OPERATOR_1 + OPL_AMP_VIBRATO_EG,  0x01  ; nastaveni modulatoru: nasobeni frekvence jednickou
        db CHANNEL_2_OPERATOR_1 + OPL_LEVEL,           0x10  ; uroven vystupu 40 dB
        db CHANNEL_2_OPERATOR_1 + OPL_ATTACK_DECAY,    0x55  ; modulator: rychly nastup zvuku + pomale doznivani
        db CHANNEL_2_OPERATOR_1 + OPL_SUSTAIN_RELEASE, 0x77  ; urovne sustain a release pro modulator
        db CHANNEL_2_OPERATOR_2 + OPL_AMP_VIBRATO_EG,  0x01  ; nastaveni nosne: nasobeni frekvence jednickou
        db CHANNEL_2_OPERATOR_2 + OPL_LEVEL,           0x00  ; nastaveni urovne vystupu nosne na 47 dB
        db CHANNEL_2_OPERATOR_2 + OPL_ATTACK_DECAY,    0xF0  ; nosna: rychly nastup + pomale doznivani
        db CHANNEL_2_OPERATOR_2 + OPL_SUSTAIN_RELEASE, 0x77  ; urovne sustain a release pro nosnou
        db CHANNEL_2 + OPL_FREQUENCY_LOW,              0x81  ; frekvence zvuku (D)

        db CHANNEL_3_OPERATOR_1 + OPL_AMP_VIBRATO_EG,  0x01  ; nastaveni modulatoru: nasobeni frekvence jednickou
        db CHANNEL_3_OPERATOR_1 + OPL_LEVEL,           0x10  ; uroven vystupu 40 dB
        db CHANNEL_3_OPERATOR_1 + OPL_ATTACK_DECAY,    0x55  ; modulator: rychly nastup zvuku + pomale doznivani
        db CHANNEL_3_OPERATOR_1 + OPL_SUSTAIN_RELEASE, 0x77  ; urovne sustain a release pro modulator
        db CHANNEL_3_OPERATOR_2 + OPL_AMP_VIBRATO_EG,  0x01  ; nastaveni nosne: nasobeni frekvence jednickou
        db CHANNEL_3_OPERATOR_2 + OPL_LEVEL,           0x00  ; nastaveni urovne vystupu nosne na 47 dB
        db CHANNEL_3_OPERATOR_2 + OPL_ATTACK_DECAY,    0xF0  ; nosna: rychly nastup + pomale doznivani
        db CHANNEL_3_OPERATOR_2 + OPL_SUSTAIN_RELEASE, 0x77  ; urovne sustain a release pro nosnou
        db CHANNEL_3 + OPL_FREQUENCY_LOW,              0xb0  ; frekvence zvuku (E)

        db CHANNEL_4_OPERATOR_1 + OPL_AMP_VIBRATO_EG,  0x01  ; nastaveni modulatoru: nasobeni frekvence jednickou
        db CHANNEL_4_OPERATOR_1 + OPL_LEVEL,           0x10  ; uroven vystupu 40 dB
        db CHANNEL_4_OPERATOR_1 + OPL_ATTACK_DECAY,    0x55  ; modulator: rychly nastup zvuku + pomale doznivani
        db CHANNEL_4_OPERATOR_1 + OPL_SUSTAIN_RELEASE, 0x77  ; urovne sustain a release pro modulator
        db CHANNEL_4_OPERATOR_2 + OPL_AMP_VIBRATO_EG,  0x01  ; nastaveni nosne: nasobeni frekvence jednickou
        db CHANNEL_4_OPERATOR_2 + OPL_LEVEL,           0x00  ; nastaveni urovne vystupu nosne na 47 dB
        db CHANNEL_4_OPERATOR_2 + OPL_ATTACK_DECAY,    0xF0  ; nosna: rychly nastup + pomale doznivani
        db CHANNEL_4_OPERATOR_2 + OPL_SUSTAIN_RELEASE, 0x77  ; urovne sustain a release pro nosnou
        db CHANNEL_4 + OPL_FREQUENCY_LOW,              0xca  ; frekvence zvuku (F)

        db CHANNEL_5_OPERATOR_1 + OPL_AMP_VIBRATO_EG,  0x01  ; nastaveni modulatoru: nasobeni frekvence jednickou
        db CHANNEL_5_OPERATOR_1 + OPL_LEVEL,           0x10  ; uroven vystupu 40 dB
        db CHANNEL_5_OPERATOR_1 + OPL_ATTACK_DECAY,    0x55  ; modulator: rychly nastup zvuku + pomale doznivani
        db CHANNEL_5_OPERATOR_1 + OPL_SUSTAIN_RELEASE, 0x77  ; urovne sustain a release pro modulator
        db CHANNEL_5_OPERATOR_2 + OPL_AMP_VIBRATO_EG,  0x01  ; nastaveni nosne: nasobeni frekvence jednickou
        db CHANNEL_5_OPERATOR_2 + OPL_LEVEL,           0x00  ; nastaveni urovne vystupu nosne na 47 dB
        db CHANNEL_5_OPERATOR_2 + OPL_ATTACK_DECAY,    0xF0  ; nosna: rychly nastup + pomale doznivani
        db CHANNEL_5_OPERATOR_2 + OPL_SUSTAIN_RELEASE, 0x77  ; urovne sustain a release pro nosnou
        db CHANNEL_5 + OPL_FREQUENCY_LOW,              0x02  ; frekvence zvuku (G)

        db CHANNEL_6_OPERATOR_1 + OPL_AMP_VIBRATO_EG,  0x01  ; nastaveni modulatoru: nasobeni frekvence jednickou
        db CHANNEL_6_OPERATOR_1 + OPL_LEVEL,           0x10  ; uroven vystupu 40 dB
        db CHANNEL_6_OPERATOR_1 + OPL_ATTACK_DECAY,    0x55  ; modulator: rychly nastup zvuku + pomale doznivani
        db CHANNEL_6_OPERATOR_1 + OPL_SUSTAIN_RELEASE, 0x77  ; urovne sustain a release pro modulator
        db CHANNEL_6_OPERATOR_2 + OPL_AMP_VIBRATO_EG,  0x01  ; nastaveni nosne: nasobeni frekvence jednickou
        db CHANNEL_6_OPERATOR_2 + OPL_LEVEL,           0x00  ; nastaveni urovne vystupu nosne na 47 dB
        db CHANNEL_6_OPERATOR_2 + OPL_ATTACK_DECAY,    0xF0  ; nosna: rychly nastup + pomale doznivani
        db CHANNEL_6_OPERATOR_2 + OPL_SUSTAIN_RELEASE, 0x77  ; urovne sustain a release pro nosnou
        db CHANNEL_6 + OPL_FREQUENCY_LOW,              0x41  ; frekvence zvuku (A)

        db CHANNEL_7_OPERATOR_1 + OPL_AMP_VIBRATO_EG,  0x01  ; nastaveni modulatoru: nasobeni frekvence jednickou
        db CHANNEL_7_OPERATOR_1 + OPL_LEVEL,           0x10  ; uroven vystupu 40 dB
        db CHANNEL_7_OPERATOR_1 + OPL_ATTACK_DECAY,    0x55  ; modulator: rychly nastup zvuku + pomale doznivani
        db CHANNEL_7_OPERATOR_1 + OPL_SUSTAIN_RELEASE, 0x77  ; urovne sustain a release pro modulator
        db CHANNEL_7_OPERATOR_2 + OPL_AMP_VIBRATO_EG,  0x01  ; nastaveni nosne: nasobeni frekvence jednickou
        db CHANNEL_7_OPERATOR_2 + OPL_LEVEL,           0x00  ; nastaveni urovne vystupu nosne na 47 dB
        db CHANNEL_7_OPERATOR_2 + OPL_ATTACK_DECAY,    0xF0  ; nosna: rychly nastup + pomale doznivani
        db CHANNEL_7_OPERATOR_2 + OPL_SUSTAIN_RELEASE, 0x77  ; urovne sustain a release pro nosnou
        db CHANNEL_7 + OPL_FREQUENCY_LOW,              0x87  ; frekvence zvuku (B)

        db CHANNEL_8_OPERATOR_1 + OPL_AMP_VIBRATO_EG,  0x01  ; nastaveni modulatoru: nasobeni frekvence jednickou
        db CHANNEL_8_OPERATOR_1 + OPL_LEVEL,           0x10  ; uroven vystupu 40 dB
        db CHANNEL_8_OPERATOR_1 + OPL_ATTACK_DECAY,    0x55  ; modulator: rychly nastup zvuku + pomale doznivani
        db CHANNEL_8_OPERATOR_1 + OPL_SUSTAIN_RELEASE, 0x77  ; urovne sustain a release pro modulator
        db CHANNEL_8_OPERATOR_2 + OPL_AMP_VIBRATO_EG,  0x01  ; nastaveni nosne: nasobeni frekvence jednickou
        db CHANNEL_8_OPERATOR_2 + OPL_LEVEL,           0x00  ; nastaveni urovne vystupu nosne na 47 dB
        db CHANNEL_8_OPERATOR_2 + OPL_ATTACK_DECAY,    0xF0  ; nosna: rychly nastup + pomale doznivani
        db CHANNEL_8_OPERATOR_2 + OPL_SUSTAIN_RELEASE, 0x77  ; urovne sustain a release pro nosnou
        db CHANNEL_8 + OPL_FREQUENCY_LOW,              0xae  ; frekvence zvuku (C)

        db 0, 0                                              ; zarazka


perform_write_to_opl_register:
        ; zapis do vybraneho registru OPL2
        ; AL - registr
        ; AH - hodnota
        mov dx, OPL_ADDRESS   ; vyber registru pro modifikaci
        out dx, al

        ; cekani priblizne 3.3 mikrosekundy
        mov cl, 6
.delay1:
        in  al, dx
        loop .delay1

        mov al, ah            ; zapis hodnoty do vybraneho registru
        mov dx, OPL_DATA
        out dx, al

        ; cekani priblizne 23 mikrosekund
        mov cl, 35
.delay2:
        in  al, dx
        loop .delay2

        ret
