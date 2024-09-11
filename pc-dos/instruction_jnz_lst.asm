     1                                  ;-----------------------------------------------------------------------------
     2                                  org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)
     3                                  
     4                                  start:
     5 00000000 B90A00                          mov     cx, 10       ; pocatecni hodnota pocitadla
     6                                  opak:
     7                                          ; tisk retezce na obrazovku
     8 00000003 BA[1100]                        mov     dx, message
     9 00000006 B409                            mov     ah, 9
    10 00000008 CD21                            int     0x21
    11                                          
    12 0000000A 49                              dec     cx            ; snizeni pocitadla o jednicku
    13 0000000B 75F6                            jnz     opak          ; skok, dokud se nedosahne nuly
    14                                  
    15                                          ; ukonceni procesu a navrat do DOSu
    16 0000000D B44C                            mov     ah, 0x4c
    17 0000000F CD21                            int     0x21
    18                                  
    19                                          ; retezec ukonceny znakem $
    20                                          ; (tato data jsou soucasti vysledneho souboru typu COM)
    21 00000011 48656C6C6F2C20776F-     message db "Hello, world!", 0x0d, 0x0a, "$"
    21 0000001A 726C64210D0A24     
