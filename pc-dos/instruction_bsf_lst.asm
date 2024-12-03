     1                                  ; Instrukcni soubor mikroprocesoru Intel 80386.
     2                                  ; Test instrukce BSF.
     3                                  ;
     4                                  ; Tento demonstracni priklad je pouzity v serialu o programovani
     5                                  ; grafickych dem a her na PC v DOSu:
     6                                  ; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
     7                                  ;
     8                                  ;-----------------------------------------------------------------------------
     9                                  
    10                                  BITS 16         ; 16bitovy vystup pro DOS
    11                                  CPU 386         ; specifikace pouziteho instrukcniho souboru
    12                                  
    13                                  ; ukonceni procesu a navrat do DOSu
    14                                  %macro exit 0
    15                                          ret
    16                                  %endmacro
    17                                  
    18                                  ; vyprazdneni bufferu klavesnice a cekani na klavesu
    19                                  %macro wait_key 0
    20                                          xor     ax, ax
    21                                          int     0x16
    22                                  %endmacro
    23                                  
    24                                  ; tisk retezce na obrazovku
    25                                  %macro print 1
    26                                          mov     dx, %1
    27                                          mov     ah, 9
    28                                          int     0x21
    29                                  %endmacro
    30                                  
    31                                  ; tisk hexadecimalni hodnoty
    32                                  %macro print_hex 1
    33                                          mov     bx, hex_digits
    34                                          mov     cl, %1                ; zapamatovat si predanou hodnotu
    35                                  
    36                                          mov     al, cl                ; do AL se vlozi horni hexa cifra
    37                                          and     al, 0xf0
    38                                          shr     al, 1
    39                                          shr     al, 1
    40                                          shr     al, 1
    41                                          shr     al, 1
    42                                  
    43                                          xlat                          ; prevod hodnoty 0-15 na ASCII znak
    44                                          mov     [message], al         ; zapis ASCII znaku do retezce
    45                                  
    46                                          mov     al, cl                ; do BL se vlozi dolni hexa cifra
    47                                          and     al, 0x0f
    48                                          xlat                          ; prevod hodnoty 0-15 na ASCII znak
    49                                          mov     [message + 1], al     ; zapis ASCII znaku do retezce
    50                                  
    51                                          print   message
    52                                  %endmacro
    53                                  
    54                                  ;-----------------------------------------------------------------------------
    55                                  org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)
    56                                  
    57                                  start:
    58 00000000 66BB00000300                    mov  ebx, 0x00030000 ; nastavení bitu
    59 00000006 660FBCC3                	bsf  eax, ebx        ; vyhledání prvního nenulového bitu
    60                                          print_hex al         ; výsledek je v EAX, ovšem nám stačí jen AL
    33 0000000A BB[3800]            <1>  mov bx, hex_digits
    34 0000000D 88C1                <1>  mov cl, %1
    35                              <1> 
    36 0000000F 88C8                <1>  mov al, cl
    37 00000011 24F0                <1>  and al, 0xf0
    38 00000013 D0E8                <1>  shr al, 1
    39 00000015 D0E8                <1>  shr al, 1
    40 00000017 D0E8                <1>  shr al, 1
    41 00000019 D0E8                <1>  shr al, 1
    42                              <1> 
    43 0000001B D7                  <1>  xlat
    44 0000001C A2[3300]            <1>  mov [message], al
    45                              <1> 
    46 0000001F 88C8                <1>  mov al, cl
    47 00000021 240F                <1>  and al, 0x0f
    48 00000023 D7                  <1>  xlat
    49 00000024 A2[3400]            <1>  mov [message + 1], al
    50                              <1> 
    51                              <1>  print message
    26 00000027 BA[3300]            <2>  mov dx, %1
    27 0000002A B409                <2>  mov ah, 9
    28 0000002C CD21                <2>  int 0x21
    61                                  
    62                                          wait_key
    20 0000002E 31C0                <1>  xor ax, ax
    21 00000030 CD16                <1>  int 0x16
    63                                          exit
    15 00000032 C3                  <1>  ret
    64                                  
    65                                          ; retezec ukonceny znakem $
    66                                          ; (tato data jsou soucasti vysledneho souboru typu COM)
    67 00000033 01010D0A24              message db 0x01, 0x01, 0x0d, 0x0a, "$"
    68                                  
    69                                          ; prevodni tabulka hodnoty 0-15 na ASCII znak
    70 00000038 303132333435363738-     hex_digits db "0123456789abcdef"
    70 00000041 39616263646566     
