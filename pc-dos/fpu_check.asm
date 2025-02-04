;-----------------------------------------------------------------------------
; Otestovani, jestli je k dispozici matematický koprocesor.
; Kompatibilni s cipem Intel 80286
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/

; Clanek, kde je tento demonstracni priklad pouzit:
; Matematické koprocesory na platformě 80×86 prakticky
; https://www.root.cz/clanky/matematicke-koprocesory-na-platforme-80x86-prakticky/
;
;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS

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

; tisk retezce na obrazovku
%macro print 1
        mov     dx, %1
        mov     ah, 9
        int     0x21
%endmacro

;-----------------------------------------------------------------------------
org  0x100                         ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        jmp main                   ; skok na zacatek kodu

main:
        fninit
        mov cx, 100                ; nechame koprocesor "vydechnout"

 .wait:
        loop .wait

        fnstcw word [test_word]    ; ulozeni ridiciho slova
        cmp word [test_word], 0x03FF  ; vychozi bitova pole ukladana cipem 8087
        je  fpu_8087_present

        cmp word [test_word], 0x037F  ; vychozi bitova pole ukladana cipem 80287 a vyssim
        je  fpu_present

        print fpu_not_present_message
        jmp end
fpu_8087_present:
        print fpu_8087_present_message
        jmp end
fpu_present:
        print fpu_present_message
end:
        wait_key                   ; cekani na stisk klavesy
        exit                       ; navrat do DOSu

; datova cast
test_word: dw 0

fpu_8087_present_message:
    db "Math coprocessor 8087 is present", 0x0a, 0x0d, "$"

fpu_present_message:
    db "Math coprocessor >8087 is present", 0x0a, 0x0d, "$"

fpu_not_present_message:
    db "Math coprocessor is NOT present", 0x0a, 0x0d, "$"
