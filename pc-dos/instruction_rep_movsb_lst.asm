     1                                  BITS 16         ; 16bitovy vystup pro DOS
     2                                  CPU 8086        ; specifikace pouziteho instrukcniho souboru
     3                                  
     4                                  ; ukonceni procesu a navrat do DOSu
     5                                  %macro exit 0
     6                                          ret
     7                                  %endmacro
     8                                  
     9                                  ; vyprazdneni bufferu klavesnice a cekani na klavesu
    10                                  %macro wait_key 0
    11                                          xor     ax, ax
    12                                          int     0x16
    13                                  %endmacro
    14                                  
    15                                  ; tisk retezce na obrazovku
    16                                  %macro print 1
    17                                          mov     dx, %1
    18                                          mov     ah, 9
    19                                          int     0x21
    20                                  %endmacro
    21                                  
    22                                  ;-----------------------------------------------------------------------------
    23                                  org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)
    24                                  
    25                                  start:
    26                                          print message
    17 00000000 BA[2200]            <1>  mov dx, %1
    18 00000003 B409                <1>  mov ah, 9
    19 00000005 CD21                <1>  int 0x21
    27                                  
    28 00000007 0E                              push cs
    29 00000008 07                              pop  es   ; ES:DI obsahuje adresu prvniho znaku ve zprave
    30 00000009 BF[2200]                        mov  di, message
    31                                  
    32 0000000C 0E                              push cs
    33 0000000D 1F                              pop  ds   ; DS:SI obsahuje adresu prvniho znaku ve zprave
    34 0000000E BE[3200]                        mov  si, replacement
    35                                  
    36 00000011 B90C00                          mov  cx, 12 ; pocet prepisovanych znaku
    37 00000014 F3A4                            rep movsb   ; precteni znaku a posun adresy
    38                                                      ; zapis znaku a posun adresy
    39                                  
    40                                          print message
    17 00000016 BA[2200]            <1>  mov dx, %1
    18 00000019 B409                <1>  mov ah, 9
    19 0000001B CD21                <1>  int 0x21
    41                                  
    42                                          wait_key
    11 0000001D 31C0                <1>  xor ax, ax
    12 0000001F CD16                <1>  int 0x16
    43                                          exit
     6 00000021 C3                  <1>  ret
    44                                  
    45                                          ; retezec ukonceny znakem $
    46                                          ; (tato data jsou soucasti vysledneho souboru typu COM)
    47 00000022 48656C6C6F2C20776F-     message     db "Hello, world!", 0x0d, 0x0a, "$"
    47 0000002B 726C64210D0A24     
    48 00000032 5A64726176696D2073-     replacement db "Zdravim svet"
    48 0000003B 766574             