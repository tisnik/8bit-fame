; Program typu "Hello, world!" urceny pro DOS a prelozitelny assemblerem NASM
; Jednodussi ukonceni programu pomoci instrukce RET
;
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu.
;
; Clanek, kde je tento priklad pouzit:
; Vývoj her a grafických dem pro oslavovanou i nenáviděnou platformu PC (první kroky)
; https://www.root.cz/clanky/vyvoj-her-a-grafickych-dem-pro-oslavovanou-i-nenavidenou-platformu-pc-prvni-kroky/
;
;
; preklad pomoci:
;     nasm -f bin -o hello.com hello_shorter.asm
;
; nebo pouze:
;     nasm -o hello.com hello_shorter.asm

 
;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        ; tisk retezce na obrazovku
        mov     dx, message
        mov     ah, 9
        int     0x21

        ; ukonceni procesu a navrat do DOSu
        ret

        ; retezec ukonceny znakem $
message db "Hello, world!", 0x0d, 0x0a, "$"
