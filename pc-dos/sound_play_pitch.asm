; Zakladni vystup zvuku na PC Speaker s vyuzitim casovace 8253
;
;
; preklad pomoci:
;     nasm -f bin -o sound_play_pitch.com sound_play_pitch.asm
;
; nebo pouze:
;     nasm -o sound_play_pitch.com sound_play_pitch.asm

;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU 8086        ; specifikace pouziteho instrukcniho souboru

 
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

; povoleni zvuku
%macro sound_enable 0
        in  al, 0x61          ; obsah řídicího bajtu portu B
        or  al, 0b00000011    ; povolení GATE + povolení výstupu na PC Speaker
        out 0x61, al          ; zápis modifikovaného řídicího bajtu portu B
%endmacro

; zakaz zvuku
%macro sound_disable 0
        in  al, 0x61          ; obsah řídicího bajtu portu B
        and al, 0b11111100    ; zákaz GATE + zákaz výstupu na PC Speaker
        out 0x61, al          ; zápis modifikovaného řídicího bajtu portu B
%endmacro

; vyber tonu
%macro play_pitch 1
        mov  al, 0b10110110   ; 10xxxxxx: kanál číslo 2
                              ; xx11xxxx: zápis obou bajtů dělitele
                              ; xxxx011x: režim generátoru obdélníku
                              ; xxxxxxx0: binární režim čítače
        out  0x43, al         ; zápis na řídicí port obvodu 8253

        mov  ax, 1193180 / %1 ; dělitel
        out  0x42, al         ; nastaveni dolniho bajtu delitele
        mov  al, ah
        out  0x42, al         ; nastaveni horniho bajtu delitele
%endmacro

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        play_pitch 440

        sound_enable
        wait_key

        sound_disable
        wait_key

        exit
