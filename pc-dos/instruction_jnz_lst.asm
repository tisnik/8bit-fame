     1                                  BITS 16         ; 16bitovy vystup pro DOS
     2                                  CPU 8086        ; specifikace pouziteho instrukcniho souboru
     3                                  
     4                                  ;-----------------------------------------------------------------------------
     5                                  org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)
     6                                  
     7                                  start:
     8 00000000 B90A00                          mov     cx, 10       ; pocatecni hodnota pocitadla
     9                                  opak:
    10                                          ; tisk retezce na obrazovku
    11 00000003 BA[1100]                        mov     dx, message
    12 00000006 B409                            mov     ah, 9
    13 00000008 CD21                            int     0x21
    14                                          
    15 0000000A 49                              dec     cx            ; snizeni pocitadla o jednicku
    16 0000000B 75F6                            jnz     opak          ; skok, dokud se nedosahne nuly
    17                                  
    18                                          ; ukonceni procesu a navrat do DOSu
    19 0000000D B44C                            mov     ah, 0x4c
    20 0000000F CD21                            int     0x21
    21                                  
    22                                          ; retezec ukonceny znakem $
    23                                          ; (tato data jsou soucasti vysledneho souboru typu COM)
    24 00000011 48656C6C6F2C20776F-     message db "Hello, world!", 0x0d, 0x0a, "$"
    24 0000001A 726C64210D0A24     
