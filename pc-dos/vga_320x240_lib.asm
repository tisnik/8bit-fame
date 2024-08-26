; Graficky rezim karty VGA s rozlisenim 320x240 pixelu.
; Vyuziti souboru se symboly, makry a podprogramy.
; Vypnuti zretezeni bitovych rovin.
; Vykresleni rastroveho obrazku postupne do vsech bitovych rovin.
; Odskrolovani obrazku.
; Pouziti knihovnich funkci.
;
; preklad pomoci:
;     nasm -f bin -o vga.com vga_320x240_lib.asm
;
; nebo pouze:
;     nasm -o vga.com vga_320x240_lib.asm

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        jmp main            ; skok na zacatek kodu

%include "io.asm"           ; nacist symboly, makra a podprogramy
%include "vga_lib.asm"      ; nacist symboly, makra a podprogramy

main:

        call gfx_mode_x     ; nastavit rezim X

        mov ax, cs
        mov ds, ax          ; zajistit, ze bude mozne adresovat cely obrazek

        mov ax, 0xa000      ; video RAM v textovem rezimu
        mov es, ax

        select_bitplane 1   ; prvni bitplane
        xor ax, ax          ; offset pixelu
        call move_image_part; prenest obrazek
        wait_key            ; cekani na klavesu

        select_bitplane 2   ; druha bitplane
        mov ax, 1
        call move_image_part; prenest obrazek
        wait_key            ; cekani na klavesu

        select_bitplane 4   ; treti bitplane
        mov ax, 2
        call move_image_part; prenest obrazek
        wait_key            ; cekani na klavesu

        select_bitplane 8   ; ctvrta bitplane
        mov ax, 3
        call move_image_part; prenest obrazek
        wait_key            ; cekani na klavesu

        mov cx, 40          ; pocet radku, o ktere budeme scrollovat
        xor bx, bx          ; adresa zacatku vykreslovani

opak:
        add bx, 80          ; prechod na dalsi adresu, od ktere se bude vykreslovat
        call wait_sync      ; cekani na sync.
                            ; zmena adresy
        set_video_ram_start b
        loop opak

        wait_key            ; cekani na klavesu
        exit                ; navrat do DOSu

move_image_part:
        move_one_bitplane image, 40*80, 320*200/4
        ret


; pridani binarnich dat s rastrovym obrazkem
image:
    incbin "image_320x200.bin"
