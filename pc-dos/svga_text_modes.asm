;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        jmp main                   ; skok na zacatek kodu

%include "io.asm"                  ; nacist symboly, makra a podprogramy
%include "print.asm"               ; nacist symboly, makra a podprogramy

main:
        mov  byte [dec_message+10], ' '  ; trik -> nechceme odradkovat po tisku hodnoty
        mov  byte [dec_message+11], ' '

        push ds
        pop  es                    ; nastaveni CS=DS=ES

        clc                        ; ziskani zakladnich informaci o VESA rezimech
        mov  di, vesa_block_info
        mov ax, 0x4f00
        int     0x10

        cmp ax, 0x004f             ; test, zda bylo volani funkce BIOSu uspesne
        jne     failed

        mov es, [VideoModesSegment] ; tabulka s cisly grafickych rezimu
        mov bx, [VideoModesOffset]

next_mode:
        xor eax, eax
        mov ax, es:[bx]            ; nacteni cisla rezimu
        cmp ax, -1                 ; jde o posledni zaznam?
        je  last_mode              ; ano -> koncime
        inc bx                     ; offset pro dalsi rezim
        inc bx

        mov ax, es:[bx]            ; znovu nacist cislo rezimu
        call print_mode_info       ; a vypsat podrobejsi informace o nem

        jmp next_mode              ; pokracujeme
last_mode:
        jmp     finish

failed:
        print_string failed_msg

finish:
        wait_key                   ; cekani na klavesu
        exit                       ; navrat do DOSu


print_mode_info:
        pushad                     ; uschovat pracovni registry
        push es                    ; pro pozdejsi obnovu na konci subrutiny
        push ds
        pop  es                    ; nastaveni CS=DS=ES
        mov  dx, ax

        clc                        ; ziskani zakladnich informaci o grafickem rezimu
        mov  di, graphics_mode_block_info
        mov  cx, ax                ; cislo rezimu
        mov  ax, 0x4f01
        int      0x10

        cmp ax, 0x004f             ; test, zda bylo volani funkce BIOSu uspesne
        jne     not_text_mode

        mov ax, [ModeAttributes]   ; bit cislo 4 je u textovych rezimu nastaven na hodnotu 0
        and ax, 16                 ; test bitu cislo 4
        jnz  not_text_mode

        ; je to textovy rezim!
        mov ax, dx                 ; tisk cisla rezimu
        print_dec_16

        mov ax, [XResolution]      ; horizontalni rozliseni ve znacich
        print_dec_16

        mov ax, [YResolution]      ; vertikalni rozliseni ve znacich
        print_dec_16

        mov ax, [XCharSize]        ; sirka znaku v pixelech
        print_dec_8

        mov ax, [YCharSize]        ; vyska znaku v pixelech
        print_dec_8

        print_string eoln          ; na konci odradkovat

not_text_mode:
        pop es                     ; obnoveni vsech relevantnich registru
        popad
        ret                        ; a navrat ze subrutiny



; datova cast
section .data

success_msg:     db "Success", 0x0a, 0x0d, "$"
failed_msg:      db "Failed", 0x0a, 0x0d, "$"
eoln:            db 0x0a, 0x0d, "$"

section .bss
vesa_block_info:
        Signature               resb 4
        Version                 resw 1
        OEMNamePtr              resd 1
        Capabilities            resd 1

        VideoModesOffset        resw 1
        VideoModesSegment       resw 1

        CountOf64KBlocks        resw 1
        OEMSoftwareRevision     resw 1
        OEMVendorNamePtr        resd 1
        OEMProductNamePtr       resd 1
        OEMProductRevisionPtr   resd 1
        Reserved                resb 222
        OEMData                 resb 256

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
