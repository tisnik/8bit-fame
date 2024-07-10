; Program typu "Hello, world!" urceny pro DOS a prelozitelny assemblerem NASM
; Vyuziti maker pro zjednoduseni hlavni casti programu
;
; preklad pomoci:
;     nasm -f bin -o hello.com hello_macros.asm
;
; nebo pouze:
;     nasm -o hello.com hello_macros.asm

 
;-----------------------------------------------------------------------------

; ukonceni procesu a navrat do DOSu
%macro exit 0
        mov     ah, 0x4c
        int     0x21
%endmacro

; vyprazdneni bufferu klavesnice a cekani na klavesu
%macro wait_key 0
        xor     ax, ax
        int     0x16
%endmacro

; tisk retezce na obrazovku
%macro print 1
        mov     dx, %1
        mov     ah, 9
        int     0x21
%endmacro

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        print message
        wait_key
        exit

        ; retezec ukonceny znakem $
message db "Hello, world!", 0x0d, 0x0a, "$"
