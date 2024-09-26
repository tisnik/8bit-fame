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
    49                                          print_hex 0x00
    24 00000000 BB[9A00]            <1>  mov bx, hex_digits
    25 00000003 B100                <1>  mov cl, %1
    26                              <1> 
    27 00000005 88C8                <1>  mov al, cl
    28 00000007 24F0                <1>  and al, 0xf0
    29 00000009 D0E8                <1>  shr al, 1
    30 0000000B D0E8                <1>  shr al, 1
    31 0000000D D0E8                <1>  shr al, 1
    32 0000000F D0E8                <1>  shr al, 1
    33                              <1> 
    34 00000011 D7                  <1>  xlat
    35 00000012 A2[9500]            <1>  mov [message], al
    36                              <1> 
    37 00000015 88C8                <1>  mov al, cl
    38 00000017 240F                <1>  and al, 0x0f
    39 00000019 D7                  <1>  xlat
    40 0000001A A2[9600]            <1>  mov [message + 1], al
    41                              <1> 
    42                              <1>  print message
    17 0000001D BA[9500]            <2>  mov dx, %1
    18 00000020 B409                <2>  mov ah, 9
    19 00000022 CD21                <2>  int 0x21
    50                                          print_hex 0x12
    24 00000024 BB[9A00]            <1>  mov bx, hex_digits
    25 00000027 B112                <1>  mov cl, %1
    26                              <1> 
    27 00000029 88C8                <1>  mov al, cl
    28 0000002B 24F0                <1>  and al, 0xf0
    29 0000002D D0E8                <1>  shr al, 1
    30 0000002F D0E8                <1>  shr al, 1
    31 00000031 D0E8                <1>  shr al, 1
    32 00000033 D0E8                <1>  shr al, 1
    33                              <1> 
    34 00000035 D7                  <1>  xlat
    35 00000036 A2[9500]            <1>  mov [message], al
    36                              <1> 
    37 00000039 88C8                <1>  mov al, cl
    38 0000003B 240F                <1>  and al, 0x0f
    39 0000003D D7                  <1>  xlat
    40 0000003E A2[9600]            <1>  mov [message + 1], al
    41                              <1> 
    42                              <1>  print message
    17 00000041 BA[9500]            <2>  mov dx, %1
    18 00000044 B409                <2>  mov ah, 9
    19 00000046 CD21                <2>  int 0x21
    51                                          print_hex 0xab
    24 00000048 BB[9A00]            <1>  mov bx, hex_digits
    25 0000004B B1AB                <1>  mov cl, %1
    26                              <1> 
    27 0000004D 88C8                <1>  mov al, cl
    28 0000004F 24F0                <1>  and al, 0xf0
    29 00000051 D0E8                <1>  shr al, 1
    30 00000053 D0E8                <1>  shr al, 1
    31 00000055 D0E8                <1>  shr al, 1
    32 00000057 D0E8                <1>  shr al, 1
    33                              <1> 
    34 00000059 D7                  <1>  xlat
    35 0000005A A2[9500]            <1>  mov [message], al
    36                              <1> 
    37 0000005D 88C8                <1>  mov al, cl
    38 0000005F 240F                <1>  and al, 0x0f
    39 00000061 D7                  <1>  xlat
    40 00000062 A2[9600]            <1>  mov [message + 1], al
    41                              <1> 
    42                              <1>  print message
    17 00000065 BA[9500]            <2>  mov dx, %1
    18 00000068 B409                <2>  mov ah, 9
    19 0000006A CD21                <2>  int 0x21
    52                                          print_hex 0xff
    24 0000006C BB[9A00]            <1>  mov bx, hex_digits
    25 0000006F B1FF                <1>  mov cl, %1
    26                              <1> 
    27 00000071 88C8                <1>  mov al, cl
    28 00000073 24F0                <1>  and al, 0xf0
    29 00000075 D0E8                <1>  shr al, 1
    30 00000077 D0E8                <1>  shr al, 1
    31 00000079 D0E8                <1>  shr al, 1
    32 0000007B D0E8                <1>  shr al, 1
    33                              <1> 
    34 0000007D D7                  <1>  xlat
    35 0000007E A2[9500]            <1>  mov [message], al
    36                              <1> 
    37 00000081 88C8                <1>  mov al, cl
    38 00000083 240F                <1>  and al, 0x0f
    39 00000085 D7                  <1>  xlat
    40 00000086 A2[9600]            <1>  mov [message + 1], al
    41                              <1> 
    42                              <1>  print message
    17 00000089 BA[9500]            <2>  mov dx, %1
    18 0000008C B409                <2>  mov ah, 9
    19 0000008E CD21                <2>  int 0x21
    53                                          wait_key
    11 00000090 31C0                <1>  xor ax, ax
    12 00000092 CD16                <1>  int 0x16
    54                                          exit
     6 00000094 C3                  <1>  ret
    55                                  
    56                                          ; retezec ukonceny znakem $
    57                                          ; (tato data jsou soucasti vysledneho souboru typu COM)
    58 00000095 01010D0A24              message db 0x01, 0x01, 0x0d, 0x0a, "$"
    59                                  
    60                                          ; prevodni tabulka hodnoty 0-15 na ASCII znak
    61 0000009A 303132333435363738-     hex_digits db "0123456789abcdef"
    61 000000A3 39616263646566     
