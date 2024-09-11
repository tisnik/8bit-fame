     1                                  ;-----------------------------------------------------------------------------
     2                                  org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)
     3                                  
     4                                  start:
     5 00000000 EB0D                            jmp     cil1
     6                                  
     7                                  zpet:
     8                                          ; tisk retezce na obrazovku
     9 00000002 BA[1100]                        mov     dx, message
    10 00000005 B409                            mov     ah, 9
    11 00000007 CD21                            int     0x21
    12                                  
    13                                          ; ukonceni procesu a navrat do DOSu
    14 00000009 B44C                            mov     ah, 0x4c
    15 0000000B CD21                            int     0x21
    16                                  
    17 0000000D EB12                    cil2:   jmp cil3
    18 0000000F EBFC                    cil1:   jmp cil2
    19                                  
    20                                          ; retezec ukonceny znakem $
    21                                          ; (tato data jsou soucasti vysledneho souboru typu COM)
    22 00000011 48656C6C6F2C20776F-     message db "Hello, world!", 0x0d, 0x0a, "$"
    22 0000001A 726C64210D0A24     
    23                                  
    24 00000021 EBDF                    cil3:   jmp zpet
