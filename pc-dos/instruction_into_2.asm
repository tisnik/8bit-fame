; Instrukcni soubor mikroprocesoru Intel 80286.
; Instrukce INTO.
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU 286         ; specifikace pouziteho instrukcniho souboru

INT_4_VECTOR equ 4*4 ; adresa vektoru preruseni

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
        mov  di, INT_4_VECTOR   ; ES:DI obsahuje adresu, na ktere je adresa obsluhy preruseni 4

        cli                     ; zakaz preruseni
	lea  ax, int4_handler   ; zmena offsetove casti adresy
	mov  es:[di], ax

	mov  ax, cs             ; zmena segmentove casti adresy
	mov  es:[di+2], ax
        sti                     ; povoleni preruseni

        mov  al, 100
	add  al, al             ; soucet dvou hodnot
	into                    ; test na preteceni -> vyvolani preruseni

        print done_msg          ; vypis zpravy, ze koncime

        wait_key
        exit                    ; a skutecne skoncime

int4_handler:                   ; obsluha preruseni cislo 4
        pusha                   ; ulozit vsechny registry
    	print overflow_msg
        popa                    ; obnovit vsechny registry
        sti                     ; povoleni maskovatelnych preruseni
        iret                    ; navrat z preruseni

;-----------------------------------------------------------------------------

        ; retezec ukonceny znakem $
        ; (tato data jsou soucasti vysledneho souboru typu COM)
overflow_msg db "overflow!", 13, 10, "$"

        ; retezec ukonceny znakem $
        ; (tato data jsou soucasti vysledneho souboru typu COM)
done_msg     db "done.", 13, 10, "$"
