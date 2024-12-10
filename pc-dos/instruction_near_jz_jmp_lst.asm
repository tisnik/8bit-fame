     1                                  ; Instrukcni soubor mikroprocesoru Intel 80386.
     2                                  ;
     3                                  ; Tento demonstracni priklad je pouzity v serialu o programovani
     4                                  ; grafickych dem a her na PC v DOSu:
     5                                  ; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
     6                                  ;
     7                                  ;-----------------------------------------------------------------------------
     8                                  
     9                                  BITS 16         ; 16bitovy vystup pro DOS
    10                                  CPU 386         ; specifikace pouziteho instrukcniho souboru
    11                                  
    12                                  ;-----------------------------------------------------------------------------
    13                                  org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)
    14                                  
    15                                  start:
    16 00000000 B90A00                          mov     cx, 10       ; pocatecni hodnota pocitadla
    17                                  opak:
    18                                          ; tisk retezce na obrazovku
    19 00000003 BA[1600]                        mov     dx, message
    20 00000006 B409                            mov     ah, 9
    21 00000008 CD21                            int     0x21
    22                                          
    23 0000000A 49                              dec     cx            ; snizeni pocitadla o jednicku
    24 0000000B 0F840300                        jz      near konec    ; skok, pokus se dosahne nuly
    25                                  
    26 0000000F E9F1FF                          jmp     near opak     ; opakujeme smycku
    27                                  konec:
    28                                          ; ukonceni procesu a navrat do DOSu
    29 00000012 B44C                            mov     ah, 0x4c
    30 00000014 CD21                            int     0x21
    31                                  
    32                                  
    33                                          ; retezec ukonceny znakem $
    34                                          ; (tato data jsou soucasti vysledneho souboru typu COM)
    35 00000016 48656C6C6F2C20776F-     message db "Hello, world!", 0x0d, 0x0a, "$"
    35 0000001F 726C64210D0A24     
