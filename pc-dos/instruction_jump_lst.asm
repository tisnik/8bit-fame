     1                                  BITS 16         ; 16bitovy vystup pro DOS
     2                                  CPU 8086        ; specifikace pouziteho instrukcniho souboru
     3                                  
     4                                  ;-----------------------------------------------------------------------------
     5                                  org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)
     6                                  
     7                                  start:
     8 00000000 EB0D                            jmp     cil1
     9                                  
    10                                  zpet:
    11                                          ; tisk retezce na obrazovku
    12 00000002 BA[1100]                        mov     dx, message
    13 00000005 B409                            mov     ah, 9
    14 00000007 CD21                            int     0x21
    15                                  
    16                                          ; ukonceni procesu a navrat do DOSu
    17 00000009 B44C                            mov     ah, 0x4c
    18 0000000B CD21                            int     0x21
    19                                  
    20 0000000D EB12                    cil2:   jmp cil3
    21 0000000F EBFC                    cil1:   jmp cil2
    22                                  
    23                                          ; retezec ukonceny znakem $
    24                                          ; (tato data jsou soucasti vysledneho souboru typu COM)
    25 00000011 48656C6C6F2C20776F-     message db "Hello, world!", 0x0d, 0x0a, "$"
    25 0000001A 726C64210D0A24     
    26                                  
    27 00000021 EBDF                    cil3:   jmp zpet
