; Program typu "Hello, world!" urceny pro DOS a prelozitelny assemblerem NASM
;
; preklad pomoci:
;     nasm -f bin -o hello.com hello_wait.asm
;
; nebo pouze:
;     nasm -o hello.com hello_wait.asm

 
;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        ; tisk retezce na obrazovku
        mov     dx, message
        mov     ah, 9
        int     0x21

        ; vyprazdneni bufferu klavesnice a cekani na klavesu
        xor     ax, ax
        int     0x16

        ; ukonceni procesu a navrat do DOSu
        mov     ah, 0x4c
        int     0x21

        ; retezec ukonceny znakem $
message db "Hello, world!", 0x0d, 0x0a, "$"