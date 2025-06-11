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

        mov  bx, 0x115             ; cislo rezimu
        mov  ax, 0x4f02            ; nastaveni grafickeho rezimu
        int      0x10

        cmp ax, 0x004f             ; test, zda bylo volani funkce BIOSu uspesne
        jne     failed

success:
	mov  di, 0                 ; posun v ramci segmentu A000
	call fill_video_segment

	mov  dx, 2
	call set_video_window
	mov  di, 1                 ; posun v ramci segmentu A000
	call fill_video_segment

	mov  dx, 4
	call set_video_window
	mov  di, 2                 ; posun v ramci segmentu A000
	call fill_video_segment

	mov  dx, 6
	call set_video_window
	mov  di, 3                 ; posun v ramci segmentu A000
	call fill_video_segment


        jmp     finish

failed:
        print_string failed_msg

finish:
        wait_key            ; cekani na klavesu
        exit                ; navrat do DOSu

fill_video_segment:
        mov ax, 0xa000             ; video RAM v grafickem rezimu
        mov es, ax
        ;mov di, 0                  ; nyni ES:DI obsahuje adresu prvniho pixelu ve video RAM

        mov cx, 65536/4            ; pocet zapisovanych slozek
        mov al, 0                  ; kod pixelu
opak:
        stosb                      ; zapis barvove slozky
	add di, 3
        inc al                     ; dalsi barva (intenzita)
        loop opak                  ; opakujeme CX-krat
	ret                        ; navrat ze subrutiny

set_video_window:
        ; ocekava se, ze DL je nastaven korektne!
	mov ax, 0x4f05             ; nastaveni okna
	mov bx, 0x0000             ; okno A
	int     0x10               ; volani VBE
	ret                        ; navrat ze subrutiny


; datova cast
section .data

success_msg:     db "Success", 0x0a, 0x0d, "$"
failed_msg:      db "Failed", 0x0a, 0x0d, "$"

section .bss
graphics_mode_block_info:
        ModeAttributes      resw 1 ; mode attributes
        WinAAttributes      resb 1 ; window A attributes
        WinBAttributes      resb 1 ; window B attributes
        WinGranularity      resw 1 ; window granularity
        WinSize             resw 1 ; window size
        WinASegment         resw 1 ; window A start segment
        WinBSegment         resw 1 ; window B start segment
        WinFuncPtr          resd 1 ; pointer to windor function
        BytesPerScanLine    resw 1 ; bytes per scan line

        XResolution         resw 1 ; horizontal resolution
        YResolution         resw 1 ; vertical resolution
        XCharSize           resb 1 ; character cell width
        YCharSize           resb 1 ; character cell height
        NumberOfPlanes      resb 1 ; number of memory planes
        BitsPerPixel        resb 1 ; bits per pixel
        NumberOfBanks       resb 1 ; number of banks
        MemoryModel         resb 1 ; memory model type
        BankSize            resb 1 ; bank size in kb
        NumberOfImagePages  resb 1 ; number of images
        Reserved1           resb 1 ; reserved for page function

        RedMaskSize         resb 1 ; size of direct color red mask in bits
        RedFieldPosition    resb 1 ; bit position of LSB of red mask
        GreenMaskSize       resb 1 ; size of direct color green mask in bits
        GreenFieldPosition  resb 1 ; bit position of LSB of green mask
        BlueMaskSize        resb 1 ; size of direct color blue mask in bits
        BlueFieldPosition   resb 1 ; bit position of LSB of blue mask
        RsvdMaskSize        resb 1 ; size of direct color reserved mask in bits
        DirectColorModeInfo resb 1 ; Direct Color mode attributes
        Reserved2           resb 216 ; remainder of ModeInfoBlock
