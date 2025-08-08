[bits 32]
 
%include "linux_macros.asm"

;-----------------------------------------------------------------------------
section .data

hex_message:
         times 8 db '?'
         db ' '
         hex_message_length equ $ - hex_message

rdrand_supported:
         db 10, "RDRAND supported"
         rdrand_supported_length equ $ - rdrand_supported

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

        ; test podpory RDRAND
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
        bt ecx, 30                   ; test bitu cislo 30: podpora RDRAND
        jnc rdrand_not_supported
        print_string  rdrand_supported, rdrand_supported_length
rdrand_not_supported:

        exit                         ; ukonceni procesu


%include "hex2string.asm"
