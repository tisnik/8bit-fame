; Prechod z realneho rezimu do rezimu chraneneho a zpet.
; Kompatibilni i s cipem Intel 80286
;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU  286        ; specifikace pouziteho instrukcniho souboru

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
org  0x100                     ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
    smsw ax                    ; prenos MSW do registru AX
    test ax, 0x1               ; test nejnizsiho bitu MSW

    jz not_prot_mode           ; nulovy bit? -> nejsme v chranenem rezimu
    print in_protected_mode_msg
    jmp end
not_prot_mode:                 ; nenulovy bit? -> jsme v chranenem rezimu
    print entering_protected_mode_msg
    cli                        ; zakazat preruseni

    smsw ax
    or   al, 1                 ; nastaveni priznaku chraneneho rezimu
    lmsw ax

    jmp .flush_cache_1         ; vymazani instrukcni cache
.flush_cache_1:

    ; nyni jsme v chranenem rezimu, ale bez nastavene tabulky deskriptoru
    ; prakticky jakykoli zapis zpusobi zamrznuti systemu!!!

    ; navrat z chraneneho rezimu
    ; toto nelze provest tak jednoduse, jak to vypada
    smsw ax
    and  al, ~1                ; zruseni priznaku chraneneho rezimu

    lmsw ax
    jmp .flush_cache_2         ; vymazani instrukcni cache
.flush_cache_2:

    sti                        ; povolit preruseni

    print back_in_real_mode_msg
end:
    wait_key                   ; cekani na stisk klavesy
    exit                       ; navrat do DOSu

; datova cast
in_protected_mode_msg:
    db "Processor already in protected mode - exiting", 0x0a, 0x0d, "$"

entering_protected_mode_msg:
    db "Entering protected mode", 0x0a, 0x0d, "$"

back_in_real_mode_msg:
    db "Back in real mode", 0x0a, 0x0d, "$"

