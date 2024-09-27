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
    22                                  ; tisk hexadecimalni hodnoty
    23                                  %macro print_hex 1
    24                                          mov     bx, hex_digits
    25                                          mov     cl, %1                ; zapamatovat si predanou hodnotu
    26                                  
    27                                          mov     al, cl                ; do AL se vlozi horni hexa cifra
    28                                          and     al, 0xf0
    29                                          shr     al, 1
    30                                          shr     al, 1
    31                                          shr     al, 1
    32                                          shr     al, 1
    33                                  
    34                                          xlat                          ; prevod hodnoty 0-15 na ASCII znak
    35                                          mov     [message], al         ; zapis ASCII znaku do retezce
    36                                  
    37                                          mov     al, cl                ; do BL se vlozi dolni hexa cifra
    38                                          and     al, 0x0f
    39                                          xlat                          ; prevod hodnoty 0-15 na ASCII znak
    40                                          mov     [message + 1], al     ; zapis ASCII znaku do retezce
    41                                  
    42                                          print   message
    43                                  %endmacro
    44                                  
    45                                  ;-----------------------------------------------------------------------------
    46                                  org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)
    47                                  
    48                                  start:
    49 00000000 B006                            mov  al, 6
    50 00000002 B407                            mov  ah, 7
    51 00000004 F6E4                            mul  ah
    52                                          print_hex al
    24 00000006 BB[3400]            <1>  mov bx, hex_digits
    25 00000009 88C1                <1>  mov cl, %1
    26                              <1> 
    27 0000000B 88C8                <1>  mov al, cl
    28 0000000D 24F0                <1>  and al, 0xf0
    29 0000000F D0E8                <1>  shr al, 1
    30 00000011 D0E8                <1>  shr al, 1
    31 00000013 D0E8                <1>  shr al, 1
    32 00000015 D0E8                <1>  shr al, 1
    33                              <1> 
    34 00000017 D7                  <1>  xlat
    35 00000018 A2[2F00]            <1>  mov [message], al
    36                              <1> 
    37 0000001B 88C8                <1>  mov al, cl
    38 0000001D 240F                <1>  and al, 0x0f
    39 0000001F D7                  <1>  xlat
    40 00000020 A2[3000]            <1>  mov [message + 1], al
    41                              <1> 
    42                              <1>  print message
    17 00000023 BA[2F00]            <2>  mov dx, %1
    18 00000026 B409                <2>  mov ah, 9
    19 00000028 CD21                <2>  int 0x21
    53                                  
    54                                          wait_key
    11 0000002A 31C0                <1>  xor ax, ax
    12 0000002C CD16                <1>  int 0x16
    55                                          exit
     6 0000002E C3                  <1>  ret
    56                                  
    57                                          ; retezec ukonceny znakem $
    58                                          ; (tato data jsou soucasti vysledneho souboru typu COM)
    59 0000002F 01010D0A24              message db 0x01, 0x01, 0x0d, 0x0a, "$"
    60                                  
    61                                          ; prevodni tabulka hodnoty 0-15 na ASCII znak
    62 00000034 303132333435363738-     hex_digits db "0123456789abcdef"
    62 0000003D 39616263646566     
