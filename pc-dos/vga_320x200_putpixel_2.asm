; Graficky rezim karty VGA s rozlisenim 320x200 pixelu.
; Pouziti predpocitane tabulky.
; Vykresleni barevnych usecek.
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; preklad pomoci:
;     nasm -f bin -o vga.com vga_320x200_putpixel_2.asm
;
; nebo pouze:
;     nasm -o vga.com vga_320x200_putpixel_2.asm



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
        gfx_mode 0x13       ; nastaveni rezimu 320x200 s 256 barvami
        mov ax, 0xa000      ; video RAM v textovem rezimu
        mov es, ax
        xor di, di          ; nyni ES:DI obsahuje adresu prvniho pixelu ve video RAM

        mov ax, 0
opak:
        mov bx, ax          ; y-ová souřadnice

        push ax
        push bx
        mov cl, al          ; barva
        call putpixel       ; vykreslení pixelu
        pop bx
        pop ax

        push ax
        push bx
        mov cl, al          ; barva
        add ax, 10          ; horizontalni posun useky
        call putpixel       ; vykreslení pixelu
        pop bx
        pop ax

        inc ax              ; pusun x+=1, y+=1
        cmp ax, 200         ; hranice obrazovky?
        jne opak            ; ne-opakujeme

        wait_key            ; cekani na klavesu
        exit                ; navrat do DOSu

; Vykresleni pixelu
; AX - x-ova souradnice
; BX - y-ova souradnice (staci len BL)
; CL - barva
putpixel:
        mov dx, 0xa000     ; zacatek stranky video RAM
        mov es, dx         ; nyni obsahuje ES stranku video RAM

        mov di, ax         ; horizontalni posun pocitany v bajtech
        add bx, bx         ; adresujeme slova, ne bajty
        mov si, offsets
        mov ax, [si+bx]    ; nacist y-ovy posun z tabulky
        add di, ax         ; pricist y-ovy posun

        mov [es:di], cl    ; vlastni vykresleni pixelu

        ret

offsets:
        dw 0, 320,640,960,1280,1600,1920,2240,2560,2880,3200,3520,3840,4160,4480,4800,5120,
        dw 5440,5760,6080,6400,6720,7040,7360,7680,8000,8320,8640,8960,9280,9600,9920,10240,
        dw 10560,10880,11200,11520,11840,12160,12480,12800,13120,13440,13760,14080,14400,14720,15040,15360,
        dw 15680,16000,16320,16640,16960,17280,17600,17920,18240,18560,18880,19200,19520,19840,20160,20480,
        dw 20800,21120,21440,21760,22080,22400,22720,23040,23360,23680,24000,24320,24640,24960,25280,25600,
        dw 25920,26240,26560,26880,27200,27520,27840,28160,28480,28800,29120,29440,29760,30080,30400,30720,
        dw 31040,31360,31680,32000,32320,32640,32960,33280,33600,33920,34240,34560,34880,35200,35520,35840,
        dw 36160,36480,36800,37120,37440,37760,38080,38400,38720,39040,39360,39680,40000,40320,40640,40960,
        dw 41280,41600,41920,42240,42560,42880,43200,43520,43840,44160,44480,44800,45120,45440,45760,46080,
        dw 46400,46720,47040,47360,47680,48000,48320,48640,48960,49280,49600,49920,50240,50560,50880,51200,
        dw 51520,51840,52160,52480,52800,53120,53440,53760,54080,54400,54720,55040,55360,55680,56000,56320,
        dw 56640,56960,57280,57600,57920,58240,58560,58880,59200,59520,59840,60160,60480,60800,61120,61440,
        dw 61760,62080,62400,62720,63040,63360,63680,

