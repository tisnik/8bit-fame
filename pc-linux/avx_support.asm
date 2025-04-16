;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; 
; Rozšíření instrukční sady AVX a programy v assembleru
; https://www.root.cz/clanky/rozsireni-instrukcni-sady-avx-a-programy-v-assembleru/

[bits 32]
 
%include "linux_macros.asm"

;-----------------------------------------------------------------------------
section .data

hex_message:
         times 8 db '?'
         db ' '
         hex_message_length equ $ - hex_message

mmx_supported:
         db 10, "MMX supported"
         mmx_supported_length equ $ - mmx_supported

sse_supported:
         db 10, "SSE supported"
         sse_supported_length equ $ - sse_supported

sse2_supported:
         db 10, "SSE2 supported"
         sse2_supported_length equ $ - sse2_supported

avx_supported:
         db 10, "AVX supported"
         avx_supported_length equ $ - avx_supported

;-----------------------------------------------------------------------------
section .bss

id_string: resb 8

 
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

        ; test podpory SSE
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

        mov eax, 1                   ; prvni kategorie
        cpuid                        ; naplneni EDX a ECX
        bt edx, 23                   ; test bitu cislo 23: podpora MMX
        jnc mmx_not_supported
        print_string  mmx_supported, mmx_supported_length
mmx_not_supported:

        mov eax, 1                   ; prvni kategorie
        cpuid                        ; naplneni EDX a ECX
        bt edx, 25                   ; test bitu cislo 25 registru EDX: podpora SSE
        jnc sse_not_supported
        print_string  sse_supported, sse_supported_length
sse_not_supported:

        mov eax, 1                   ; prvni kategorie
        cpuid                        ; naplneni EDX a ECX
        bt edx, 26                   ; test bitu cislo 25 registru EDX: podpora SSE2
        jnc sse2_not_supported
        print_string  sse2_supported, sse2_supported_length
sse2_not_supported:

        mov eax, 1                   ; prvni kategorie
        cpuid                        ; naplneni EDX a ECX
        bt ecx, 28                   ; test bitu cislo 28 registru ECX: podpora AVX
        jnc avx_not_supported
        print_string  avx_supported, avx_supported_length
avx_not_supported:

        exit                         ; ukonceni procesu


%include "hex2string.asm"
