;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; SIMD instrukce na platformě 80×86: instrukční sada MMX
; https://www.root.cz/clanky/simd-instrukce-na-platforme-80x86-instrukcni-sada-mmx/
;

[bits 32]
 
%include "linux_macros.asm"

;-----------------------------------------------------------------------------
section .data

hex_message:
         times 8 db '?'
         db ' '
         hex_message_length equ $ - hex_message


;-----------------------------------------------------------------------------
section .bss

id_string: resb 12

 
;-----------------------------------------------------------------------------
section .text
        global _start                ; tento symbol ma byt dostupny i linkeru

_start:
        ; ziskani indexu nejvyssi volatelne funkce CPUID
        xor eax, eax                 ; nulta kategorie
        cpuid
        mov     edx, eax             ; hodnota, ktera se ma vytisknout
        mov     ebx, hex_message     ; buffer, ktery se zaplni hexa cislicemi
        call    hex2string           ; zavolani prislusne subrutiny
        print_string   hex_message, hex_message_length    ; tisk hexadecimalni hodnoty

        ; test podpory MMX
        mov eax, 1                   ; prvni kategorie
        cpuid
        mov     ebx, hex_message     ; buffer, ktery se zaplni hexa cislicemi
        call    hex2string           ; zavolani prislusne subrutiny
        print_string   hex_message, hex_message_length    ; tisk hexadecimalni hodnoty

        ; vypis CPU ID
        xor eax, eax                 ; nulta kategorie
        cpuid
        mov [id_string], ebx         ; prvni ctyri znaky ID
        mov [id_string+4], edx       ; dalsi ctyri znaky ID
        mov [id_string+8], ecx       ; posledni ctyri znaky ID
        print_string id_string, 12   ; tisk 12 znaku CPU ID

        exit                         ; ukonceni procesu


%include "hex2string.asm"
