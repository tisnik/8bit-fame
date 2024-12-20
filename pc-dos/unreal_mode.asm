; Nastaveni nerealneho rezimu s tim, ze pres registry DS a ES je mozne adresovat celou
; dostupnou pamet (limit 4GB)
;
; Inspirovano:
; https://pastebin.com/68W8cn0d
; (ovsem pozor, tento kod obsahuje chyby):
;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU  386        ; specifikace pouziteho instrukcniho souboru

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

bits 16
org 0x100

start:
    smsw ax                    ; prenos MSW do registru AX
    test ax, 0x1               ; test nejnizsiho bitu MSW

    jz not_prot_mode           ; nulovy bit? -> nejsme v chranenem rezimu
    print in_protected_mode_msg
    jmp end

not_prot_mode:                 ; nenulovy bit? -> jsme v chranenem rezimu
    print entering_protected_mode_msg
    cli

    ; nastaveni globalni tabulky deskriptoru
    mov eax, ds                ; adresa ulozena v DS (nasobime sestnacti)
    shl eax, 4
    add  [global_descriptor_table.gdtr+2], eax  ; oprava adresy tabulky deskriptoru

    ; nacteni globalni tabulky deskriptoru
    lgdt [global_descriptor_table.gdtr]

    mov cx, ds                 ; ulozeni DS, aby se mohl obnovit po navratu z chraneneho rezimu

    mov eax, cr0
    or  al, 1                  ; nastaveni priznaku chraneneho rezimu
    mov cr0, eax

    jmp .flush_cache_1         ; vymazani instrukcni cache
.flush_cache_1:

    ; nyni jsme v 16bitovem chranenem rezimu
    ; nemenime CS, takze neni nutne prejit do 32bitoveho rezimu
    mov bx, FLAT_SEL           ; druhy zaznam v tabulce deskriptoru
    mov ss, bx                 ; SS a DS bez limitu (naplni se cache s deskriptory)
    mov ds, bx
    mov es, bx                 ; stejne tak ostatni segmentove registry
    mov fs, bx
    mov gs, bx

    mov eax, cr0
    and al, ~1                 ; zruseni priznaku chraneneho rezimu
    mov cr0, eax

    jmp .flush_cache_2         ; vymazani instrukcni cache
.flush_cache_2:

    ; nyni jsme v nerealnem rezimu
    mov ss, cx                 ; obnoveni segmentovych registru
    mov ds, cx

    sti

    print back_in_real_mode_msg

    ; otestovani nerealneho rezimu
    ; pristoupime k VideoRAM pres nulty segment, coz by nemelo
    ; byt v beznem realnem rezimu mozne
    ; nyni ovsem ES odkazuje na prvni deskriptor s volnym rozsahem

    attribute equ 0x57<<8
    mov word es:[dword 0xb8000+80*10*3+0],  attribute | 'U'
    mov word es:[dword 0xb8000+80*10*3+2],  attribute | 'N'
    mov word es:[dword 0xb8000+80*10*3+4],  attribute | 'R'
    mov word es:[dword 0xb8000+80*10*3+6],  attribute | 'E'
    mov word es:[dword 0xb8000+80*10*3+8],  attribute | 'A'
    mov word es:[dword 0xb8000+80*10*3+10], attribute | 'L'

end:
    wait_key                   ; cekani na stisk klavesy
    exit                       ; navrat do DOSu

; datova cast

; pomocne makro pro vytvoreni jednoho zaznamu v tabulce deskriptoru
%define MAKE_GDT_DESC(base, limit, access, flags) \
    (((base & 0x00FFFFFF) << 16) | \
    ((base & 0xFF000000) << 32) | \
    (limit & 0x0000FFFF) | \
    ((limit & 0x000F0000) << 32) | \
    ((access & 0xFF) << 40) | \
    ((flags & 0x0F) << 52))

align 4                        ; pro jistotu: potrebujeme zarovnani na 32 bitu

global_descriptor_table:
FLAT_SEL  equ .flat_descriptor  - .start

.start:
.null_descriptor:
    dq 0
.flat_descriptor:
    dq MAKE_GDT_DESC(0, 0xffffffff, 10010010b, 1100b)
                                ; 32-bit data, granularita 4KB, limit 0xffffffff, base=0
.end:

.gdtr:
    dw .end - .start - 1
                                ; velikost tabulky deskriptoru -1
    dd .start                   ; tato hodnota se musi upravit v runtime

in_protected_mode_msg:
    db "Processor already in protected mode - exiting", 0x0a, 0x0d, "$"

entering_protected_mode_msg:
    db "Entering protected mode", 0x0a, 0x0d, "$"

back_in_real_mode_msg:
    db "Back in UNreal mode", 0x0a, 0x0d, "$"

; finito
