; Pouziti casovace, obnoveni puvodni rutiny po ukonceni programu
;
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
;
; preklad pomoci:
;     nasm -f bin -o timer_restore_better_struct.com timer_restore_better_struct.asm
;
; nebo pouze:
;     nasm -o timer_restore_better_struct.com timer_restore_better_struct.asm

;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU 286         ; specifikace pouziteho instrukcniho souboru

IRQ_0_VECTOR equ 0x0020  ; adresa vektoru preruseni pro IRQ 0
 
;-----------------------------------------------------------------------------

; ukonceni procesu a navrat do DOSu
%macro exit 0
        ret
%endmacro

; vyprazdneni bufferu klavesnice a cekani na klavesu
%macro wait_key 0
        xor     ax, ax
        int     0x16          ; vyvolani sluzby BIOSu
%endmacro

; tisk jedineho znaku pres DOS
%macro print_char 1
        mov     ah, 0x02      ; cislo sluzby DOSu
        mov     dl, %1        ; kod zapisovaneho znaku
        int     0x21          ; vyvolani sluzby DOSu
%endmacro

; ulozeni puvodniho vektoru preruseni
%macro store_original_vector 2
    	xor  ax, ax
        mov  es, ax
        mov  si, %1             ; ES:SI obsahuje adresu, na ktere je adresa obsluhy preruseni 0x08
        lea  di, %2
        mov  ax, es:[si]        ; ulozeni puvodni adresy (segment + offset) do
        mov  cs:[di], ax        ; uloziste original_handler
        mov  ax, es:[si+2]
        mov  cs:[di+2], ax
%endmacro

; obnoveni puvodniho vektoru preruseni
%macro restore_original_vector 2
    	xor  ax, ax
        mov  es, ax
        cli                     ; zakaz preruseni
	lea  si, %2             ; uloziste
        mov  di, %1             ; adresa vektoru
	mov  ax, cs:[si]        ; obnoveni puvodniho handleru
        mov  es:[di], ax
	mov  ax, cs:[si+2]
        mov  es:[di+2], ax
        sti                     ; povoleni preruseni
%endmacro

; nastaveni noveho vektoru preruseni
%macro set_irq_handler 2
        mov  di, %1             ; ES:DI obsahuje adresu, na ktere je adresa obsluhy preruseni 0x08
        cli                     ; zakaz preruseni
	lea  ax, %2             ; zmena offsetove casti adresy
	mov  es:[di], ax

	mov  ax, cs             ; zmena segmentove casti adresy
	mov  es:[di+2], ax
        sti                     ; povoleni preruseni
%endmacro

; oznameni, ze preruseni je u konce radici preruseni 
%macro end_interrupt 0
    	mov al, 0x20
	out 0x20, al
%endmacro

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        print_char '>'          ; oznameni uzivateli, ze jsme pripraveni

        store_original_vector IRQ_0_VECTOR, original_handler
        set_irq_handler IRQ_0_VECTOR, int8_handler

        wait_key                ; cekani na stisk klavesy
        print_char '.'          ; oznameni uzivateli, ze ukoncujeme proces

        restore_original_vector IRQ_0_VECTOR, original_handler

        exit                    ; ukonceni procesu
 

int8_handler:                   ; nova obsluha preruseni
        pusha                   ; ulozit vsechny registry
        print_char 't'          ; t=tick

        end_interrupt           ; oznameni, ze preruseni je u konce radici preruseni 

        popa                    ; obnovit vsechny registry
        sti                     ; povoleni maskovatelnych preruseni
        iret                    ; navrat z preruseni


original_handler: dw 0, 0
