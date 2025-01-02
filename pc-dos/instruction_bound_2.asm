; Instrukcni soubor mikroprocesoru Intel 80286.
; Instrukce BOUND - korektni verze programu.
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU 286         ; specifikace pouziteho instrukcniho souboru

INT_5_VECTOR equ 5*4 ; adresa vektoru preruseni

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
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        xor  ax, ax
        mov  es, ax
        mov  di, INT_5_VECTOR   ; ES:DI obsahuje adresu, na ktere je adresa obsluhy preruseni 5

        cli                     ; zakaz preruseni
        lea  ax, int5_handler   ; zmena offsetove casti adresy
        mov  es:[di], ax

        mov  ax, cs             ; zmena segmentove casti adresy
        mov  es:[di+2], ax
        sti                     ; povoleni preruseni

        mov  ax, 99             ; nacteni indexu
        bound ax, [bounds]      ; test indexu

        mov  ax, 100            ; nacteni indexu
        bound ax, [bounds]      ; test indexu

        mov  ax, 101            ; nacteni indexu
        bound ax, [bounds]      ; test indexu

        print done_msg          ; vypis zpravy, ze koncime

        wait_key
        exit                    ; a skutecne skoncime

int5_handler:                   ; obsluha preruseni cislo 5
        pusha                   ; ulozit vsechny registry
        print index_out_of_bounds_msg
        popa                    ; obnovit vsechny registry
        pop ax
        add ax, 4               ; preskocit samotnou instrukci BOUND
        push ax
        sti                     ; povoleni maskovatelnych preruseni
        iret                    ; navrat z preruseni -> nyni se ovsem vracime ZA instrukci BOUND

;-----------------------------------------------------------------------------
bounds  dw 0, 99

        ; retezec ukonceny znakem $
        ; (tato data jsou soucasti vysledneho souboru typu COM)
index_out_of_bounds_msg db "index out of bounds!", 13, 10, "$"

        ; retezec ukonceny znakem $
        ; (tato data jsou soucasti vysledneho souboru typu COM)
done_msg     db "done.", 13, 10, "$"
