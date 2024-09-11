     1                                  ;-----------------------------------------------------------------------------
     2                                  org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)
     3                                  
     4                                  start:
     5 00000000 B90A00                          mov     cx, 10       ; pocatecni hodnota pocitadla
     6                                  opak:
     7                                          ; tisk retezce na obrazovku
     8 00000003 BA[1300]                        mov     dx, message
     9 00000006 B409                            mov     ah, 9
    10 00000008 CD21                            int     0x21
    11                                          
    12 0000000A 49                              dec     cx            ; snizeni pocitadla o jednicku
    13 0000000B 7402                            jz      konec         ; skok, pokus se dosahne nuly
    14                                  
    15 0000000D EBF4                            jmp     opak          ; opakujeme smycku
    16                                  konec:
    17                                          ; ukonceni procesu a navrat do DOSu
    18 0000000F B44C                            mov     ah, 0x4c
    19 00000011 CD21                            int     0x21
    20                                  
    21                                  
    22                                          ; retezec ukonceny znakem $
    23                                          ; (tato data jsou soucasti vysledneho souboru typu COM)
    24 00000013 48656C6C6F2C20776F-     message db "Hello, world!", 0x0d, 0x0a, "$"
    24 0000001C 726C64210D0A24     
