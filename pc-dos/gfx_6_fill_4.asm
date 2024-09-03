; Vykresleni vertikalni sady pixelu.
;
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; Struktura obrazové paměti grafické karty CGA, blokové přenosy a základy optimalizace
; https://www.root.cz/clanky/struktura-obrazove-pameti-graficke-karty-cga-blokove-prenosy-a-zaklady-optimalizace/
; 
; preklad pomoci:
;     nasm -f bin -o gfx_6.com gfx_6_ver_fill_4.asm
;
; nebo pouze:
;     nasm -o gfx_6.com gfx_6_ver_fill_4.asm


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

; nastaveni grafickeho rezimu
%macro gfx_mode 1
        mov     ah, 0
        mov     al, %1
        int     0x10
%endmacro

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        gfx_mode 6        ; nastaveni grafickeho rezimu 640x200 se 2 barvami
        wait_key

        mov ax, 0xb800    ; video segment
        mov es, ax        ; do segmentoveho registru ES
        xor bx, bx        ; adresa pro zapis barev pixelu
        mov cx, 640*200/8 ; pocitadlo smycky
fill_loop:
        call wait_sync
        mov al, 255       ; zapisovana kombinace barev pixelu
        mov [es:bx], al   ; zapis barev osmi pixelu
        inc bx            ; na dalsi pixel
        loop fill_loop    ; snizeni hodnoty CX, skok pri nenulovosti vysledku

        wait_key          ; cekani na stisk klavesy
        exit              ; navrat do DOSu

wait_sync:
        mov dx, 0x3da      ; adresa stavoveho registru graficke karty CGA
wait_sync_end:
        in al, dx          ; precteni hodnoty stavoveho registru
        test al, 8         ; odmaskovat priznak vertikalniho synchronizacniho pulsu
        jnz wait_sync_end  ; probiha - cekat na konec
wait_sync_start:
        in al, dx          ; precteni hodnoty stavoveho registru
        test al, 8         ; odmaskovat priznak vertikalniho synchronizacniho pulsu
        jz wait_sync_start ; neprobiha - cekat na zacatek
        ret                ; ok - synchronizacni kurz probiha, lze zapisovat do pameti

