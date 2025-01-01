; Operační kódy instrukcí LMSW a SMSW
; Kompatibilni i s cipem Intel 80286
;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU  286        ; specifikace pouziteho instrukcniho souboru

;-----------------------------------------------------------------------------

org  0x100                     ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
    lmsw ax
    lmsw bp
    lmsw [old_msw]
    lmsw [old_msw+DI]
    lmsw [old_msw+DI+0x100]

    smsw ax
    smsw bp
    smsw [old_msw]
    smsw [old_msw+DI]
    smsw [old_msw+DI+0x100]

; datova cast
old_msw: dw 0
