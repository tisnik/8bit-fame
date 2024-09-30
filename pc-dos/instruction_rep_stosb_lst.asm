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
    17 00000000 BA[1F00]            <1>  mov dx, %1
    18 00000003 B409                <1>  mov ah, 9
    19 00000005 CD21                <1>  int 0x21
    27                                  
    28 00000007 0E                              push cs
    29 00000008 07                              pop  es   ; ES:DI obsahuje adresu prvniho znaku ve zprave
    30 00000009 BF[1F00]                        mov di, message
    31                                  
    32 0000000C B02A                            mov al, "*"
    33 0000000E B90500                          mov cx, 5
    34 00000011 F3AA                            rep stosb ; zapis peti hvezdicek
    35                                  
    36                                          print message
    17 00000013 BA[1F00]            <1>  mov dx, %1
    18 00000016 B409                <1>  mov ah, 9
    19 00000018 CD21                <1>  int 0x21
    37                                  
    38                                          wait_key
    11 0000001A 31C0                <1>  xor ax, ax
    12 0000001C CD16                <1>  int 0x16
    39                                          exit
     6 0000001E C3                  <1>  ret
    40                                  
    41                                          ; retezec ukonceny znakem $
    42                                          ; (tato data jsou soucasti vysledneho souboru typu COM)
    43 0000001F 48656C6C6F2C20776F-     message db "Hello, world!", 0x0d, 0x0a, "$"
    43 00000028 726C64210D0A24     
