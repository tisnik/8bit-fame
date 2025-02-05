;-----------------------------------------------------------------------------
; Otestovani, jestli je nainstalovan matematicky koprocesor.
; Kompatibilni i s cipem Intel 80286
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; Matematické koprocesory na platformě 80×86 prakticky
; https://www.root.cz/clanky/matematicke-koprocesory-na-platforme-80x86-prakticky/
;
;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU  286        ; specifikace pouziteho instrukcniho souboru

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
org  0x100                     ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        smsw ax                    ; prenos MSW do registru AX
        test ax, 0x4               ; test tretiho nejnizsiho bitu MSW (EM)

        jz fpu_present             ; nulovy bit? -> 80287 je nainstalovan
        print fpu_not_present_message  ; nenulovy bit? -> koprocesor chybi
        jmp end
fpu_present:
        print fpu_present_message
end:
        wait_key                   ; cekani na stisk klavesy
        exit                       ; navrat do DOSu

; datova cast
fpu_present_message:
    db "FP unit is present", 0x0a, 0x0d, "$"

fpu_not_present_message:
    db "FP unit is NOT present", 0x0a, 0x0d, "$"
