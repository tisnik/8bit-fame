     1                                  ;-----------------------------------------------------------------------------
     2                                  ; Zakladni aritmeticke operace provadene matematickym koprocesorem.
     3                                  ;
     4                                  ; Tento demonstracni priklad je pouzity v serialu o programovani
     5                                  ; grafickych dem a her na PC v DOSu:
     6                                  ; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
     7                                  
     8                                  ;-----------------------------------------------------------------------------
     9                                  
    10                                  org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)
    11                                  
    12                                  start:
    13 00000000 EB5C                            jmp main             ; skok na zacatek kodu
    14                                  
    15                                  %include "io.asm"            ; nacist symboly, makra a podprogramy
     1                              <1> ;-----------------------------------------------------------------------------
     2                              <1> ; Symboly, makra a subrutiny pro zjednoduseni I/O operaci
     3                              <1> ;-----------------------------------------------------------------------------
     4                              <1> 
     5                              <1> %ifndef IO_LIB
     6                              <1> %define IO_LIB
     7                              <1> 
     8                              <1> 
     9                              <1> ;-----------------------------------------------------------------------------
    10                              <1> ; makra
    11                              <1> ;-----------------------------------------------------------------------------
    12                              <1> 
    13                              <1> 
    14                              <1> ; ukonceni procesu a navrat do DOSu
    15                              <1> %macro exit 0
    16                              <1>         mov     ah, 0x4c
    17                              <1>         int     0x21
    18                              <1> %endmacro
    19                              <1> 
    20                              <1> ; vyprazdneni bufferu klavesnice a cekani na klavesu
    21                              <1> %macro wait_key 0
    22                              <1>         xor     ax, ax
    23                              <1>         int     0x16
    24                              <1> %endmacro
    25                              <1> 
    26                              <1> %endif
    16                                  %include "print.asm"         ; nacist symboly, makra a podprogramy
     1                              <1> ;-----------------------------------------------------------------------------
     2                              <1> ; Symboly, makra a subrutiny pro tisk hodnot na standardni vystup
     3                              <1> ;-----------------------------------------------------------------------------
     4                              <1> 
     5                              <1> %ifndef PRINT_LIB
     6                              <1> %define PRINT_LIB
     7                              <1> 
     8                              <1> 
     9                              <1> ;-----------------------------------------------------------------------------
    10                              <1> ; makra
    11                              <1> ;-----------------------------------------------------------------------------
    12                              <1> 
    13                              <1> ; makro pro tisk retezce na obrazovku
    14                              <1> %macro print_string 1
    15                              <1>         mov     dx, %1
    16                              <1>         mov     ah, 9
    17                              <1>         int     0x21
    18                              <1> %endmacro
    19                              <1> 
    20                              <1> ; makro pro tisk 32bitove hexadecimalni hodnoty
    21                              <1> ; na standardni vystup
    22                              <1> %macro print_hex 1
    23                              <1>         pusha                         ; uchovat vsechny registry
    24                              <1>         mov     edx, %1               ; zapamatovat si hodnotu pro tisk
    25                              <1>         mov     ebx, hex_message      ; buffer, ktery se zaplni hexa cislicemi
    26                              <1>         call    hex2string            ; zavolani prislusne subrutiny
    27                              <1>         print_string   hex_message    ; tisk hexadecimalni hodnoty
    28                              <1>         popa                          ; obnovit vsechny registry
    29                              <1> %endmacro
    30                              <1> 
    31                              <1> ; makro pro vypis 32bitove desitkove hodnoty na standardni vystup
    32                              <1> %macro print_dec 1
    33                              <1>         pusha                         ; uschovat vsechny registry na zasobnik
    34                              <1>         mov     eax, %1               ; hodnotu pro tisk ulozit do registru EAX
    35                              <1>         mov     ebx, dec_message      ; buffer, ktery se zaplni desitkovymi cisticemi
    36                              <1>         call    decimal2string        ; zavolani prislusne subrutiny pro prevod na string
    37                              <1>         print_string   dec_message    ; tisk hexadecimalni hodnoty
    38                              <1>         popa                          ; obnovit vsechny registry
    39                              <1> %endmacro
    40                              <1> 
    41                              <1> ; makro pro vypis obsahu FP hodnoty z vrcholu zasobniku ve forme hexadecimalniho cisla
    42                              <1> %macro print_float32_as_hex 0
    43                              <1>         fstp dword [float32] ; ulozeni do pameti (4 bajty)
    44                              <1>         mov  eax, [float32]  ; nacteni FP hodnoty do celociselneho registru
    45                              <1>         print_hex eax        ; zobrazeni obsahu tohoto registru v hexadecimalnim tvaru
    46                              <1> %endmacro
    47                              <1> 
    48                              <1> ; makro pro vypis obsahu FP hodnoty z vrcholu zasobniku ve forme hexadecimalniho cisla
    49                              <1> %macro print_float64_as_hex 0
    50                              <1>         fstp qword [float64] ; ulozeni do pameti (8 bajtu)
    51                              <1>         mov  eax, [float64+4]; nacteni FP hodnoty do celociselneho registru
    52                              <1>         print_hex eax        ; zobrazeni obsahu tohoto registru v hexadecimalnim tvaru
    53                              <1>         mov  eax, [float64]  ; nacteni FP hodnoty do celociselneho registru
    54                              <1>         print_hex eax        ; zobrazeni obsahu tohoto registru v hexadecimalnim tvaru
    55                              <1> %endmacro
    56                              <1> 
    57                              <1> 
    58                              <1> ;-----------------------------------------------------------------------------
    59                              <1> ; subrutiny
    60                              <1> ;-----------------------------------------------------------------------------
    61                              <1> 
    62                              <1> ; subrutina urcena pro prevod 32bitove hexadecimalni hodnoty na retezec
    63                              <1> ; Vstup: EDX - hodnota, ktera se ma prevest na retezec
    64                              <1> ;        EBX - adresa jiz drive alokovaneho retezce (resp. osmice bajtu)
    65                              <1> hex2string:
    66 00000002 B108                <1>                   mov cl,  8                ; pocet opakovani smycky
    67                              <1> 
    68 00000004 66C1C204            <1> .print_one_digit: rol edx, 4                ; rotace doleva znamena, ze se do spodnich 4 bitu nasune dalsi cifra
    69 00000008 88D0                <1>                   mov al, dl                ; nechceme porusit obsah vstupni hodnoty v EDX, proto pouzijeme AL
    70 0000000A 240F                <1>                   and al, 0x0f              ; maskovani, potrebujeme pracovat jen s jednou cifrou
    71 0000000C 3C0A                <1>                   cmp al, 10                ; je cifra vetsi nebo rovna 10?
    72 0000000E 7C02                <1>                   jl  .store_digit          ; neni, pouze prevest 0..9 na ASCII hodnotu '0'..'9'
    73                              <1> 
    74 00000010 0407                <1> .alpha_digit:     add al, 'A'-10-'0'        ; prevod hodnoty 10..15 na znaky 'A'..'F'
    75                              <1> 
    76 00000012 0430                <1> .store_digit:     add al, '0'
    77 00000014 678803              <1>                   mov [ebx], al             ; ulozeni cifry do retezce
    78 00000017 6643                <1>                   inc ebx                   ; dalsi ulozeni v retezci o znak dale
    79 00000019 FEC9                <1>                   dec cl                    ; snizeni pocitadla smycky
    80 0000001B 75E7                <1>                   jnz .print_one_digit      ; a opakovani smycky, dokud se nedosahlo nuly
    81                              <1> 
    82 0000001D C3                  <1>                   ret                       ; navrat ze subrutiny
    83                              <1> 
    84                              <1> 
    85                              <1> ; subrutina urcena pro prevod 32bitove desitkove hodnoty na retezec
    86                              <1> ; Vstup: EDX - hodnota, ktera se ma prevest na retezec
    87                              <1> ;        EBX - adresa jiz drive alokovaneho retezce (resp. minimalne deseti bajtu)
    88                              <1> decimal2string:
    89 0000001E 66B90A000000        <1>                   mov ecx, 10              ; celkovy pocet zapisovanych cifer/znaku
    90 00000024 6689CF              <1>                   mov edi, ecx             ; instrukce DIV vyzaduje deleni registrem, pouzijme tedy EDI
    91                              <1> 
    92                              <1> .next_digit:
    93 00000027 6631D2              <1>                   xor edx, edx             ; delenec je dvojice EDX:EAX, vynulujeme tedy horni registr EDX
    94 0000002A 66F7F7              <1>                   div edi                  ; deleni hodnoty ulozene v EDX:EAX deseti (delitelem je EDI)
    95                              <1>                                            ; vysledek se ulozi do EAX, zbytek do EDX
    96                              <1>                                            ; pri deleni deseti je jistota, ze zbytek je jen cislo 0..9
    97                              <1> 
    98 0000002D 80C230              <1>                   add dl, '0'              ; prevod hodnoty 0..9 na znak '0'-'9'
    99                              <1> 
   100 00000030 6788540BFF          <1>                   mov [ebx+ecx-1], dl      ; zapis retezce (od posledniho znaku)
   101                              <1> 
   102 00000035 6649                <1>                   dec ecx                  ; presun na predchozi znak v retezci a soucasne snizeni hodnoty pocitadla
   103 00000037 75EE                <1>                   jnz .next_digit          ; uz jsme dosli k poslednimu cislu?
   104                              <1> 
   105 00000039 C3                  <1>                   ret                      ; navrat ze subrutiny
   106                              <1> 
   107                              <1> 
   108                              <1> ;-----------------------------------------------------------------------------
   109                              <1> ; buffery
   110                              <1> ;-----------------------------------------------------------------------------
   111                              <1> 
   112                              <1>         ; retezec ukonceny znakem $
   113                              <1>         ; (tato data jsou soucasti vysledneho souboru typu COM)
   114                              <1> hex_message:
   115 0000003A 3F<rep 8h>          <1>          times 8 db '?', 
   116 00000042 0D0A24              <1>          db 0x0d, 0x0a, "$"
   117                              <1> 
   118                              <1>         ; retezec ukonceny znakem $
   119                              <1>         ; (tato data jsou soucasti vysledneho souboru typu COM)
   120                              <1> dec_message:
   121 00000045 3F<rep Ah>          <1>          times 10 db '?', 
   122 0000004F 0D0A24              <1>          db 0x0d, 0x0a, "$"
   123                              <1> 
   124 00000052 00000000            <1> float32: dd 0
   125 00000056 0000000000000000    <1> float64: dq 0
   126                              <1> 
   127                              <1> %endif
    17                                  
    18                                  main:
    19 0000005E D9E8                            fld1                 ; nacteni FP konstanty 1.0
    20 00000060 D9E8                            fld1                 ; nacteni FP konstanty 1.0
    21 00000062 DEC1                            faddp                ; soucet dvou hodnot na zasobniku
    22                                          print_float32_as_hex ; zobrazeni FP hodnoty v hexadecimalnim tvaru
    43 00000064 D91E[5200]          <1>  fstp dword [float32]
    44 00000068 66A1[5200]          <1>  mov eax, [float32]
    45                              <1>  print_hex eax
    23 0000006C 60                  <2>  pusha
    24 0000006D 6689C2              <2>  mov edx, %1
    25 00000070 66BB[3A000000]      <2>  mov ebx, hex_message
    26 00000076 E889FF              <2>  call hex2string
    27                              <2>  print_string hex_message
    15 00000079 BA[3A00]            <3>  mov dx, %1
    16 0000007C B409                <3>  mov ah, 9
    17 0000007E CD21                <3>  int 0x21
    28 00000080 61                  <2>  popa
    23                                  
    24 00000081 D9E8                            fld1                 ; nacteni FP konstanty 1.0
    25 00000083 D9E8                            fld1                 ; nacteni FP konstanty 1.0
    26 00000085 D9E8                            fld1                 ; nacteni FP konstanty 1.0
    27 00000087 DEC1                            faddp                ; soucet dvou hodnot na zasobniku
    28 00000089 DEC1                            faddp                ; soucet dvou hodnot na zasobniku
    29                                          print_float32_as_hex ; zobrazeni FP hodnoty v hexadecimalnim tvaru
    43 0000008B D91E[5200]          <1>  fstp dword [float32]
    44 0000008F 66A1[5200]          <1>  mov eax, [float32]
    45                              <1>  print_hex eax
    23 00000093 60                  <2>  pusha
    24 00000094 6689C2              <2>  mov edx, %1
    25 00000097 66BB[3A000000]      <2>  mov ebx, hex_message
    26 0000009D E862FF              <2>  call hex2string
    27                              <2>  print_string hex_message
    15 000000A0 BA[3A00]            <3>  mov dx, %1
    16 000000A3 B409                <3>  mov ah, 9
    17 000000A5 CD21                <3>  int 0x21
    28 000000A7 61                  <2>  popa
    30                                  
    31 000000A8 D9E8                            fld1                 ; nacteni FP konstanty 1.0
    32 000000AA D9E8                            fld1                 ; nacteni FP konstanty 1.0
    33 000000AC DEC1                            faddp                ; soucet dvou hodnot na zasobniku
    34                                  
    35 000000AE D9E8                            fld1                 ; nacteni FP konstanty 1.0
    36 000000B0 D9E8                            fld1                 ; nacteni FP konstanty 1.0
    37 000000B2 D9E8                            fld1                 ; nacteni FP konstanty 1.0
    38 000000B4 DEC1                            faddp                ; soucet dvou hodnot na zasobniku
    39 000000B6 DEC1                            faddp                ; soucet dvou hodnot na zasobniku
    40                                  
    41 000000B8 DEC9                            fmulp                ; nyni jsou na zasobniku ulozeny hodnoty 2 a 3 ktere vynasobime
    42                                          print_float32_as_hex ; zobrazeni FP hodnoty v hexadecimalnim tvaru
    43 000000BA D91E[5200]          <1>  fstp dword [float32]
    44 000000BE 66A1[5200]          <1>  mov eax, [float32]
    45                              <1>  print_hex eax
    23 000000C2 60                  <2>  pusha
    24 000000C3 6689C2              <2>  mov edx, %1
    25 000000C6 66BB[3A000000]      <2>  mov ebx, hex_message
    26 000000CC E833FF              <2>  call hex2string
    27                              <2>  print_string hex_message
    15 000000CF BA[3A00]            <3>  mov dx, %1
    16 000000D2 B409                <3>  mov ah, 9
    17 000000D4 CD21                <3>  int 0x21
    28 000000D6 61                  <2>  popa
    43                                  
    44                                          wait_key             ; cekani na klavesu
    22 000000D7 31C0                <1>  xor ax, ax
    23 000000D9 CD16                <1>  int 0x16
    45                                          exit                 ; navrat do DOSu
    16 000000DB B44C                <1>  mov ah, 0x4c
    17 000000DD CD21                <1>  int 0x21
