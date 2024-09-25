     1                                  ;-----------------------------------------------------------------------------
     2                                  
     3                                  BITS 16         ; 16bitovy vystup pro DOS
     4                                  CPU 8086        ; specifikace pouziteho instrukcniho souboru
     5                                  
     6                                  ;-----------------------------------------------------------------------------
     7                                  org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)
     8                                  
     9                                  start:
    10 00000000 01D8                            add ax, bx
    11 00000002 8B07                            mov ax, [bx]
    12 00000004 8B04                            mov ax, [si]
    13 00000006 8B05                            mov ax, [di]
    14 00000008 8B4600                          mov ax, [bp]
    15                                  
    16 0000000B 8B471F                          mov ax, [bx+0x1f]
    17 0000000E 8B441F                          mov ax, [si+0x1f]
    18 00000011 8B451F                          mov ax, [di+0x1f]
    19 00000014 8B461F                          mov ax, [bp+0x1f]
    20                                  
    21 00000017 8B87FFEE                        mov ax, [bx+0xeeff]
    22 0000001B 8B84FFEE                        mov ax, [si+0xeeff]
    23 0000001F 8B85FFEE                        mov ax, [di+0xeeff]
    24 00000023 8B86FFEE                        mov ax, [bp+0xeeff]
    25                                  
    26 00000027 8B02                            mov ax, [bp+si]
    27 00000029 8B03                            mov ax, [bp+di]
    28 0000002B 8B421F                          mov ax, [bp+si+0x1f]
    29 0000002E 8B83FFEE                        mov ax, [bp+di+0xeeff]
    30 00000032 B02A                            mov al, 42
    31 00000034 B82A00                          mov ax, 42
    32 00000037 FE067B00                        inc byte [123]
    33 0000003B FF067B00                        inc word [123]
    34 0000003F FE061027                        inc byte [10000]
    35 00000043 FF061027                        inc word [10000]
