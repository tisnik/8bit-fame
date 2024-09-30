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
    24                                          mov     cl, %1                ; zapamatovat si predanou hodnotu
    25                                          xor     bh, bh                ; vynulovat horni bajt offsetu
    26                                  
    27                                          mov     bl, cl                ; do BL se vlozi horni hexa cifra
    28                                          and     bl, 0xf0
    29                                          shr     bl, 1
    30                                          shr     bl, 1
    31                                          shr     bl, 1
    32                                          shr     bl, 1
    33                                  
    34                                          mov     al, [hex_digits + bx] ; prevod hodnoty 0-15 na ASCII znak
    35                                          mov     [message], al         ; zapis ASCII znaku do retezce
    36                                  
    37                                          mov     bl, cl                ; do BL se vlozi dolni hexa cifra
    38                                          and     bl, 0x0f
    39                                          mov     al, [hex_digits + bx] ; prevod hodnoty 0-15 na ASCII znak
    40                                          mov     [message + 1], al     ; zapis ASCII znaku do retezce
    41                                          print   message
    42                                  %endmacro
    43                                  
    44                                  ;-----------------------------------------------------------------------------
    45                                  org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)
    46                                  
    47                                  start:
    48                                          print_hex 0x00
    24 00000000 B100                <1>  mov cl, %1
    25 00000002 30FF                <1>  xor bh, bh
    26                              <1> 
    27 00000004 88CB                <1>  mov bl, cl
    28 00000006 80E3F0              <1>  and bl, 0xf0
    29 00000009 D0EB                <1>  shr bl, 1
    30 0000000B D0EB                <1>  shr bl, 1
    31 0000000D D0EB                <1>  shr bl, 1
    32 0000000F D0EB                <1>  shr bl, 1
    33                              <1> 
    34 00000011 8A87[B600]          <1>  mov al, [hex_digits + bx]
    35 00000015 A2[B100]            <1>  mov [message], al
    36                              <1> 
    37 00000018 88CB                <1>  mov bl, cl
    38 0000001A 80E30F              <1>  and bl, 0x0f
    39 0000001D 8A87[B600]          <1>  mov al, [hex_digits + bx]
    40 00000021 A2[B200]            <1>  mov [message + 1], al
    41                              <1>  print message
    17 00000024 BA[B100]            <2>  mov dx, %1
    18 00000027 B409                <2>  mov ah, 9
    19 00000029 CD21                <2>  int 0x21
    49                                          print_hex 0x12
    24 0000002B B112                <1>  mov cl, %1
    25 0000002D 30FF                <1>  xor bh, bh
    26                              <1> 
    27 0000002F 88CB                <1>  mov bl, cl
    28 00000031 80E3F0              <1>  and bl, 0xf0
    29 00000034 D0EB                <1>  shr bl, 1
    30 00000036 D0EB                <1>  shr bl, 1
    31 00000038 D0EB                <1>  shr bl, 1
    32 0000003A D0EB                <1>  shr bl, 1
    33                              <1> 
    34 0000003C 8A87[B600]          <1>  mov al, [hex_digits + bx]
    35 00000040 A2[B100]            <1>  mov [message], al
    36                              <1> 
    37 00000043 88CB                <1>  mov bl, cl
    38 00000045 80E30F              <1>  and bl, 0x0f
    39 00000048 8A87[B600]          <1>  mov al, [hex_digits + bx]
    40 0000004C A2[B200]            <1>  mov [message + 1], al
    41                              <1>  print message
    17 0000004F BA[B100]            <2>  mov dx, %1
    18 00000052 B409                <2>  mov ah, 9
    19 00000054 CD21                <2>  int 0x21
    50                                          print_hex 0xab
    24 00000056 B1AB                <1>  mov cl, %1
    25 00000058 30FF                <1>  xor bh, bh
    26                              <1> 
    27 0000005A 88CB                <1>  mov bl, cl
    28 0000005C 80E3F0              <1>  and bl, 0xf0
    29 0000005F D0EB                <1>  shr bl, 1
    30 00000061 D0EB                <1>  shr bl, 1
    31 00000063 D0EB                <1>  shr bl, 1
    32 00000065 D0EB                <1>  shr bl, 1
    33                              <1> 
    34 00000067 8A87[B600]          <1>  mov al, [hex_digits + bx]
    35 0000006B A2[B100]            <1>  mov [message], al
    36                              <1> 
    37 0000006E 88CB                <1>  mov bl, cl
    38 00000070 80E30F              <1>  and bl, 0x0f
    39 00000073 8A87[B600]          <1>  mov al, [hex_digits + bx]
    40 00000077 A2[B200]            <1>  mov [message + 1], al
    41                              <1>  print message
    17 0000007A BA[B100]            <2>  mov dx, %1
    18 0000007D B409                <2>  mov ah, 9
    19 0000007F CD21                <2>  int 0x21
    51                                          print_hex 0xff
    24 00000081 B1FF                <1>  mov cl, %1
    25 00000083 30FF                <1>  xor bh, bh
    26                              <1> 
    27 00000085 88CB                <1>  mov bl, cl
    28 00000087 80E3F0              <1>  and bl, 0xf0
    29 0000008A D0EB                <1>  shr bl, 1
    30 0000008C D0EB                <1>  shr bl, 1
    31 0000008E D0EB                <1>  shr bl, 1
    32 00000090 D0EB                <1>  shr bl, 1
    33                              <1> 
    34 00000092 8A87[B600]          <1>  mov al, [hex_digits + bx]
    35 00000096 A2[B100]            <1>  mov [message], al
    36                              <1> 
    37 00000099 88CB                <1>  mov bl, cl
    38 0000009B 80E30F              <1>  and bl, 0x0f
    39 0000009E 8A87[B600]          <1>  mov al, [hex_digits + bx]
    40 000000A2 A2[B200]            <1>  mov [message + 1], al
    41                              <1>  print message
    17 000000A5 BA[B100]            <2>  mov dx, %1
    18 000000A8 B409                <2>  mov ah, 9
    19 000000AA CD21                <2>  int 0x21
    52                                          wait_key
    11 000000AC 31C0                <1>  xor ax, ax
    12 000000AE CD16                <1>  int 0x16
    53                                          exit
     6 000000B0 C3                  <1>  ret
    54                                  
    55                                          ; retezec ukonceny znakem $
    56                                          ; (tato data jsou soucasti vysledneho souboru typu COM)
    57 000000B1 01010D0A24              message db 0x01, 0x01, 0x0d, 0x0a, "$"
    58                                  
    59                                          ; prevodni tabulka hodnoty 0-15 na ASCII znak
    60 000000B6 303132333435363738-     hex_digits db "0123456789abcdef"
    60 000000BF 39616263646566     
