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
    11 00000003 BA[1300]                        mov     dx, message
    12 00000006 B409                            mov     ah, 9
    13 00000008 CD21                            int     0x21
    14                                          
    15 0000000A 49                              dec     cx            ; snizeni pocitadla o jednicku
    16 0000000B 7402                            jz      konec         ; skok, pokus se dosahne nuly
    17                                  
    18 0000000D EBF4                            jmp     opak          ; opakujeme smycku
    19                                  konec:
    20                                          ; ukonceni procesu a navrat do DOSu
    21 0000000F B44C                            mov     ah, 0x4c
    22 00000011 CD21                            int     0x21
    23                                  
    24                                  
    25                                          ; retezec ukonceny znakem $
    26                                          ; (tato data jsou soucasti vysledneho souboru typu COM)
    27 00000013 48656C6C6F2C20776F-     message db "Hello, world!", 0x0d, 0x0a, "$"
    27 0000001C 726C64210D0A24     
