;-----------------------------------------------------------------------------
; MODE    RESOLUTION  BITS PER PIXEL  MAXIMUM COLORS
; 0x0100  640x400     8               256
; 0x0101  640x480     8               256
; 0x0102  800x600     4               16
; 0x0103  800x600     8               256
; 0x010D  320x200     15              32k
; 0x010E  320x200     16              64k
; 0x010F  320x200     24/32           16m
; 0x0110  640x480     15              32k
; 0x0111  640x480     16              64k
; 0x0112  640x480     24/32           16m
; 0x0113  800x600     15              32k
; 0x0114  800x600     16              64k
; 0x0115  800x600     24/32           16m
; 0x0116  1024x768    15              32k
; 0x0117  1024x768    16              64k
; 0x0118  1024x768    24/32           16m
;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        jmp main                   ; skok na zacatek kodu

%include "io.asm"                  ; nacist symboly, makra a podprogramy
%include "print.asm"               ; nacist symboly, makra a podprogramy




main:
        push ds
        pop  es                    ; nastaveni CS=DS=ES

        mov  bx, 0x103             ; cislo rezimu
        mov  ax, 0x4f02            ; nastaveni grafickeho rezimu
        int      0x10

        cmp ax, 0x004f             ; test, zda bylo volani funkce BIOSu uspesne
        jne     failed

success:
        call grayscale_palette     ; nastaveni palety se stupni sedi

        mov ax, cs
        mov ds, ax
        mov si, image              ; nyni DS:SI obsahuje adresu prvniho bajtu v obrazku

        mov ax, 0xa000             ; video RAM v textovem rezimu
        mov es, ax
        xor di, di                 ; nyni ES:DI obsahuje adresu prvniho pixelu ve video RAM

        mov cx, 320*200/2          ; pocet zapisovanych bajtu (=pixelu)
        rep movsw                  ; prenos celeho obrazku

        jmp     finish

failed:
        print_string failed_msg

finish:
        wait_key            ; cekani na klavesu
        exit                ; navrat do DOSu


set_video_window:
        ; ocekava se, ze DL je nastaven korektne!
	mov ax, 0x4f05             ; nastaveni okna
	mov bx, 0x0000             ; okno A
	int     0x10               ; volani VBE
	ret                        ; navrat ze subrutiny

; paleta ve stupnich sedi
grayscale_palette:
        mov ax, 0x1010             ; cislo sluzby a podsluzby VGA BIOSu
        xor bl, bl                 ; index barvy
next_dac:
        mov ch, bl                 ; prvni barvova slozka
        shr ch, 1
        shr ch, 1
        mov cl, ch                 ; druha barvova slozka
        mov dh, ch                 ; treti barvova slozka
        int 0x10                   ; modifikace mapovani v DAC
        inc bl                     ; zvysit index v DAC
        jnz next_dac               ; nastavit dalsi barvu, dokud nedosahneme hodnoty 256
	ret                        ; navrat ze subrutiny


; datova cast
section .data

success_msg:     db "Success", 0x0a, 0x0d, "$"
failed_msg:      db "Failed", 0x0a, 0x0d, "$"

; pridani binarnich dat s rastrovym obrazkem
image:
    incbin "image_320x200.bin"
