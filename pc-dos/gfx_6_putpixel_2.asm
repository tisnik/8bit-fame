; Vykresleni pixelu, varianta s osmibitovym nasobenim.
;
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; 
; Hrátky s barvovou paletou a vykreslení jednotlivých pixelů kartou CGA
; https://www.root.cz/clanky/hratky-s-barvovou-paletou-a-vykresleni-jednotlivych-pixelu-kartou-cga/
;
;
; preklad pomoci:
;     nasm -f bin -o gfx_6.com gfx_6_putpixel_2.asm
;
; nebo pouze:
;     nasm -o gfx_6.com gfx_6_putpixel_2.asm

;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU 8086        ; specifikace pouziteho instrukcniho souboru


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
        gfx_mode 6      ; nastaveni grafickeho rezimu 320x200 se ctyrmi barvami

        mov ax, 0
opak:
        mov bx, ax      ; y-ová souřadnice
        push ax
        call putpixel   ; vykreslení pixelu
        pop ax
        inc ax          ; pusun x+=1, y+=1
        cmp ax, 200     ; hranice obrazovky?
        jne opak        ; ne-opakujeme

        wait_key        ; cekat na klavesu
        exit            ; navrat do DOSu


; Vykresleni pixelu
; AX - x-ova souradnice
; BX - y-ova souradnice (staci len BL)
putpixel:
        mov dx, 0xb800     ; zacatek prvni stranky Video RAM
        test bx, 1         ; test, zda se jedna o sudy nebo lichy radek na obrazovce
        jz odd_line
        add dx, 8192/16
odd_line:
        mov es, dx         ; nyni obsahuje ES bud prvni stranku Video RAM nebo stranku druhou

        mov cl, al
        and cl, 7          ; pouze spodni 3 bity x-ove souradnice

        shr ax, 1
        shr ax, 1
        shr ax, 1          ; x/8
        mov di, ax         ; horizontalni posun pocitany v bajtech

        mov al, bl         ; y-ova souradnice
        shr al, 1          ; ignorovat nejnizsi bit s lichym/sudym radkem
        mov dl, 80         ; vynasobit delkou radku v bajtech
        mul dl             ; AX - relativni posun v y-ovem smeru

        add di, ax         ; pricist vertikalni posun k posunu horizontalnimu

        mov al, 0x80       ; vypocitat masku pixelu
        shr al, cl
        stosb              ; vlastni vykresleni pixelu

        ret
