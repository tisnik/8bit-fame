; Instrukcni soubor mikroprocesoru Intel 8088 a Intel 8086
;
;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU 8086        ; specifikace pouziteho instrukcniho souboru

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        mov     cx, 10       ; pocatecni hodnota pocitadla
opak:
        ; tisk retezce na obrazovku
        mov     dx, message
        mov     ah, 9
        int     0x21
        
        dec     cx            ; snizeni pocitadla o jednicku
        jz      konec         ; skok, pokus se dosahne nuly

        jmp     opak          ; opakujeme smycku
konec:
        ; ukonceni procesu a navrat do DOSu
        mov     ah, 0x4c
        int     0x21


        ; retezec ukonceny znakem $
        ; (tato data jsou soucasti vysledneho souboru typu COM)
message db "Hello, world!", 0x0d, 0x0a, "$"
