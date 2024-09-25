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
    49 00000000 B008                            mov  al, 8
    50 00000002 FEC0                            inc  al
    51                                          print_hex al
    24 00000004 BB[FE00]            <1>  mov bx, hex_digits
    25 00000007 88C1                <1>  mov cl, %1
    26                              <1> 
    27 00000009 88C8                <1>  mov al, cl
    28 0000000B 24F0                <1>  and al, 0xf0
    29 0000000D D0E8                <1>  shr al, 1
    30 0000000F D0E8                <1>  shr al, 1
    31 00000011 D0E8                <1>  shr al, 1
    32 00000013 D0E8                <1>  shr al, 1
    33                              <1> 
    34 00000015 D7                  <1>  xlat
    35 00000016 A2[F900]            <1>  mov [message], al
    36                              <1> 
    37 00000019 88C8                <1>  mov al, cl
    38 0000001B 240F                <1>  and al, 0x0f
    39 0000001D D7                  <1>  xlat
    40 0000001E A2[FA00]            <1>  mov [message + 1], al
    41                              <1> 
    42                              <1>  print message
    17 00000021 BA[F900]            <2>  mov dx, %1
    18 00000024 B409                <2>  mov ah, 9
    19 00000026 CD21                <2>  int 0x21
    52                                  
    53 00000028 B009                            mov  al, 9
    54 0000002A FEC0                            inc  al
    55                                          print_hex al
    24 0000002C BB[FE00]            <1>  mov bx, hex_digits
    25 0000002F 88C1                <1>  mov cl, %1
    26                              <1> 
    27 00000031 88C8                <1>  mov al, cl
    28 00000033 24F0                <1>  and al, 0xf0
    29 00000035 D0E8                <1>  shr al, 1
    30 00000037 D0E8                <1>  shr al, 1
    31 00000039 D0E8                <1>  shr al, 1
    32 0000003B D0E8                <1>  shr al, 1
    33                              <1> 
    34 0000003D D7                  <1>  xlat
    35 0000003E A2[F900]            <1>  mov [message], al
    36                              <1> 
    37 00000041 88C8                <1>  mov al, cl
    38 00000043 240F                <1>  and al, 0x0f
    39 00000045 D7                  <1>  xlat
    40 00000046 A2[FA00]            <1>  mov [message + 1], al
    41                              <1> 
    42                              <1>  print message
    17 00000049 BA[F900]            <2>  mov dx, %1
    18 0000004C B409                <2>  mov ah, 9
    19 0000004E CD21                <2>  int 0x21
    56                                  
    57 00000050 B008                            mov  al, 8
    58 00000052 FEC0                            inc  al
    59 00000054 27                              daa
    60                                          print_hex al
    24 00000055 BB[FE00]            <1>  mov bx, hex_digits
    25 00000058 88C1                <1>  mov cl, %1
    26                              <1> 
    27 0000005A 88C8                <1>  mov al, cl
    28 0000005C 24F0                <1>  and al, 0xf0
    29 0000005E D0E8                <1>  shr al, 1
    30 00000060 D0E8                <1>  shr al, 1
    31 00000062 D0E8                <1>  shr al, 1
    32 00000064 D0E8                <1>  shr al, 1
    33                              <1> 
    34 00000066 D7                  <1>  xlat
    35 00000067 A2[F900]            <1>  mov [message], al
    36                              <1> 
    37 0000006A 88C8                <1>  mov al, cl
    38 0000006C 240F                <1>  and al, 0x0f
    39 0000006E D7                  <1>  xlat
    40 0000006F A2[FA00]            <1>  mov [message + 1], al
    41                              <1> 
    42                              <1>  print message
    17 00000072 BA[F900]            <2>  mov dx, %1
    18 00000075 B409                <2>  mov ah, 9
    19 00000077 CD21                <2>  int 0x21
    61                                  
    62 00000079 B009                            mov  al, 9
    63 0000007B FEC0                            inc  al
    64 0000007D 27                              daa
    65                                          print_hex al
    24 0000007E BB[FE00]            <1>  mov bx, hex_digits
    25 00000081 88C1                <1>  mov cl, %1
    26                              <1> 
    27 00000083 88C8                <1>  mov al, cl
    28 00000085 24F0                <1>  and al, 0xf0
    29 00000087 D0E8                <1>  shr al, 1
    30 00000089 D0E8                <1>  shr al, 1
    31 0000008B D0E8                <1>  shr al, 1
    32 0000008D D0E8                <1>  shr al, 1
    33                              <1> 
    34 0000008F D7                  <1>  xlat
    35 00000090 A2[F900]            <1>  mov [message], al
    36                              <1> 
    37 00000093 88C8                <1>  mov al, cl
    38 00000095 240F                <1>  and al, 0x0f
    39 00000097 D7                  <1>  xlat
    40 00000098 A2[FA00]            <1>  mov [message + 1], al
    41                              <1> 
    42                              <1>  print message
    17 0000009B BA[F900]            <2>  mov dx, %1
    18 0000009E B409                <2>  mov ah, 9
    19 000000A0 CD21                <2>  int 0x21
    66                                  
    67 000000A2 B008                            mov  al, 8
    68 000000A4 FEC0                            inc  al
    69 000000A6 37                              aaa
    70                                          print_hex al
    24 000000A7 BB[FE00]            <1>  mov bx, hex_digits
    25 000000AA 88C1                <1>  mov cl, %1
    26                              <1> 
    27 000000AC 88C8                <1>  mov al, cl
    28 000000AE 24F0                <1>  and al, 0xf0
    29 000000B0 D0E8                <1>  shr al, 1
    30 000000B2 D0E8                <1>  shr al, 1
    31 000000B4 D0E8                <1>  shr al, 1
    32 000000B6 D0E8                <1>  shr al, 1
    33                              <1> 
    34 000000B8 D7                  <1>  xlat
    35 000000B9 A2[F900]            <1>  mov [message], al
    36                              <1> 
    37 000000BC 88C8                <1>  mov al, cl
    38 000000BE 240F                <1>  and al, 0x0f
    39 000000C0 D7                  <1>  xlat
    40 000000C1 A2[FA00]            <1>  mov [message + 1], al
    41                              <1> 
    42                              <1>  print message
    17 000000C4 BA[F900]            <2>  mov dx, %1
    18 000000C7 B409                <2>  mov ah, 9
    19 000000C9 CD21                <2>  int 0x21
    71                                  
    72 000000CB B009                            mov  al, 9
    73 000000CD FEC0                            inc  al
    74 000000CF 37                              aaa
    75                                          print_hex al
    24 000000D0 BB[FE00]            <1>  mov bx, hex_digits
    25 000000D3 88C1                <1>  mov cl, %1
    26                              <1> 
    27 000000D5 88C8                <1>  mov al, cl
    28 000000D7 24F0                <1>  and al, 0xf0
    29 000000D9 D0E8                <1>  shr al, 1
    30 000000DB D0E8                <1>  shr al, 1
    31 000000DD D0E8                <1>  shr al, 1
    32 000000DF D0E8                <1>  shr al, 1
    33                              <1> 
    34 000000E1 D7                  <1>  xlat
    35 000000E2 A2[F900]            <1>  mov [message], al
    36                              <1> 
    37 000000E5 88C8                <1>  mov al, cl
    38 000000E7 240F                <1>  and al, 0x0f
    39 000000E9 D7                  <1>  xlat
    40 000000EA A2[FA00]            <1>  mov [message + 1], al
    41                              <1> 
    42                              <1>  print message
    17 000000ED BA[F900]            <2>  mov dx, %1
    18 000000F0 B409                <2>  mov ah, 9
    19 000000F2 CD21                <2>  int 0x21
    76                                  
    77                                          wait_key
    11 000000F4 31C0                <1>  xor ax, ax
    12 000000F6 CD16                <1>  int 0x16
    78                                          exit
     6 000000F8 C3                  <1>  ret
    79                                  
    80                                          ; retezec ukonceny znakem $
    81                                          ; (tato data jsou soucasti vysledneho souboru typu COM)
    82 000000F9 01010D0A24              message db 0x01, 0x01, 0x0d, 0x0a, "$"
    83                                  
    84                                          ; prevodni tabulka hodnoty 0-15 na ASCII znak
    85 000000FE 303132333435363738-     hex_digits db "0123456789abcdef"
    85 00000107 39616263646566     
