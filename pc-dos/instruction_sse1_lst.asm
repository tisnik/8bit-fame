     1                                  ; Instrukcni soubor mikroprocesoru Intel 8088 a Intel 8086
     2                                  ;
     3                                  ; Tento demonstracni priklad je pouzity v serialu o programovani
     4                                  ; grafickych dem a her na PC v DOSu:
     5                                  ; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
     6                                  ;
     7                                  ;-----------------------------------------------------------------------------
     8                                  
     9                                  BITS 16         ; 16bitovy vystup pro DOS
    10                                  CPU   p3        ; specifikace pouziteho instrukcniho souboru
    11                                  
    12                                  ; ukonceni procesu a navrat do DOSu
    13                                  %macro exit 0
    14                                          ret
    15                                  %endmacro
    16                                  
    17                                  ; vyprazdneni bufferu klavesnice a cekani na klavesu
    18                                  %macro wait_key 0
    19                                          xor     ax, ax
    20                                          int     0x16
    21                                  %endmacro
    22                                  
    23                                  ; tisk retezce na obrazovku
    24                                  %macro print 1
    25                                          mov     dx, %1
    26                                          mov     ah, 9
    27                                          int     0x21
    28                                  %endmacro
    29                                  
    30                                  ; tisk hexadecimalni hodnoty
    31                                  %macro print_hex 1
    32                                          mov     bx, hex_digits
    33                                          mov     cl, %1                ; zapamatovat si predanou hodnotu
    34                                  
    35                                          mov     al, cl                ; do AL se vlozi horni hexa cifra
    36                                          and     al, 0xf0
    37                                          shr     al, 1
    38                                          shr     al, 1
    39                                          shr     al, 1
    40                                          shr     al, 1
    41                                  
    42                                          xlat                          ; prevod hodnoty 0-15 na ASCII znak
    43                                          mov     [message], al         ; zapis ASCII znaku do retezce
    44                                  
    45                                          mov     al, cl                ; do BL se vlozi dolni hexa cifra
    46                                          and     al, 0x0f
    47                                          xlat                          ; prevod hodnoty 0-15 na ASCII znak
    48                                          mov     [message + 1], al     ; zapis ASCII znaku do retezce
    49                                  
    50                                          print   message
    51                                  %endmacro
    52                                  
    53                                  ;-----------------------------------------------------------------------------
    54                                  org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)
    55                                  
    56                                  start:
    57 00000000 F30F1006[0B00]                  movss  xmm0, [mem]
    58                                  
    59                                          wait_key
    19 00000006 31C0                <1>  xor ax, ax
    20 00000008 CD16                <1>  int 0x16
    60                                          exit
    14 0000000A C3                  <1>  ret
    61                                  
    62                                  mem:
    63 0000000B 00000000                        dd 0.00
    64 0000000F 00000080                        dd -0.00
    65 00000013 0000803F                        dd 1.0
    66 00000017 00000040                        dd 2.0
    67                                  
    68                                          ; retezec ukonceny znakem $
    69                                          ; (tato data jsou soucasti vysledneho souboru typu COM)
    70 0000001B 01010D0A24              message db 0x01, 0x01, 0x0d, 0x0a, "$"
    71                                  
    72                                          ; prevodni tabulka hodnoty 0-15 na ASCII znak
    73 00000020 303132333435363738-     hex_digits db "0123456789abcdef"
    73 00000029 39616263646566     
