%ifndef LINUX_MACROS_LIB
%define LINUX_MACROS_LIB

; Linux kernel system call table
sys_exit  equ 1
sys_write equ 4
 
 
; makro pro tisk retezce na obrazovku
%macro print_string 2
        mov   eax, sys_write        ; cislo syscallu pro funkci "write"
        mov   ebx, 1                ; standardni vystup
        mov   ecx, %1               ; adresa retezce, ktery se ma vytisknout
        mov   edx, %2               ; delka retezce
        int   80h                   ; volani Linuxoveho kernelu
%endmacro


; makro pro tisk 32bitove hexadecimalni hodnoty
; na standardni vystup
%macro print_hex 2
        push ebx                    ; uschovat EBX pro dalsi pouziti
        mov     edx, %1             ; zapamatovat si hodnotu pro tisk
        mov     ebx, hex_message    ; buffer, ktery se zaplni hexa cislicemi
        mov     byte [ebx+8], %2    ; oddelovac, konec radku, atd.
        call    hex2string          ; zavolani prislusne subrutiny
        print_string   hex_message, hex_message_length    ; tisk hexadecimalni hodnoty
        pop ebx                     ; obnovit EBX
%endmacro


; makro pro vypis obsahu MMX vektoru
%macro print_mmx_reg_as_hex 1
        mov  ebx, mmx_tmp           ; adresa bufferu
        movq [ebx], %1              ; ulozeni do pameti (8 bajtu)
        mov  eax, [ebx+4]           ; nacteni casti MMX vektoru do celociselneho registru
        print_hex eax, ' '          ; zobrazeni obsahu tohoto registru v hexadecimalnim tvaru
        mov  eax, [ebx]             ; nacteni casti MMX vektoru do celociselneho registru
        print_hex eax, 0x0a         ; zobrazeni obsahu tohoto registru v hexadecimalnim tvaru
%endmacro
 

; makro pro ukonceni procesu 
%macro exit 0
        mov   eax,sys_exit          ; cislo sycallu pro funkci "exit"
        mov   ebx,0                 ; exit code = 0
        int   80h                   ; volani Linuxoveho kernelu
%endmacro


%endif
