; Prehrani zakladniho tonu na kartach s cipem OPL2.
;
;
; preklad pomoci:
;     nasm -f bin -o sound_opl2_table.com sound_opl2_table.asm
;
; nebo pouze:
;     nasm -o sound_opl2_table.com sound_opl2_table.asm

 
;-----------------------------------------------------------------------------

; registry karet s cipem OPL2
OPL_ADDRESS equ 0x388
OPL_DATA    equ 0x389

;-----------------------------------------------------------------------------

; ukonceni procesu a navrat do DOSu
%macro exit 0
        ret
%endmacro

; vyprazdneni bufferu klavesnice a cekani na klavesu
%macro wait_key 0
        xor     ax, ax
        int     0x16
%endmacro

; makro pro zapis do registru OPL2
%macro write_opl_register 2
        mov     al, %1
        mov     ah, %2
        call    perform_write_to_opl_register
%endmacro

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        push cs
        pop  ds                          ; DS==CS

        mov  si, tone1                   ; zacatek tabulky
        call write_table_to_opl2         ; zapis obsahu tabulky do OPL2

        wait_key
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


tone1:  ; tabulka s tonem pro prvni kanal
        db 0x20, 0x01    ; nastaveni modulatoru: nasobeni frekvence jednickou
        db 0x40, 0x10    ; uroven vystupu 40 dB
        db 0x60, 0xF0    ; modulator: rychly nastup zvuku + pomale doznivani
        db 0x80, 0x77    ; urovne sustain a release pro modulator
        db 0xA0, 0x41    ; frekvence zvuku (komorni A = 440 Hz)
        db 0x23, 0x01    ; nastaveni nosne: nasobeni frekvence jednickou
        db 0x43, 0x00    ; nastaveni urovne vystupu nosne na 47 dB
        db 0x63, 0xF0    ; nosna: rychly nastup + pomale doznivani
        db 0x83, 0x77    ; urovne sustain a release pro nosnou
        db 0xB0, 0x32    ; zapnuti/povoleni zvuku + nastaveni oktavy a vyssich bitu frekvence
        db 0, 0          ; zarazka

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
