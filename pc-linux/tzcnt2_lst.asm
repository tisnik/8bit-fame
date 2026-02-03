     1                                  [bits 32]
     2                                   
     3                                  %include "linux_macros.asm"
     1                              <1> %ifndef LINUX_MACROS_LIB
     2                              <1> %define LINUX_MACROS_LIB
     3                              <1> 
     4                              <1> ; Linux kernel system call table
     5                              <1> sys_exit  equ 1
     6                              <1> sys_write equ 4
     7                              <1>  
     8                              <1>  
     9                              <1> ; makro pro tisk retezce na obrazovku
    10                              <1> %macro print_string 2
    11                              <1>         mov   eax, sys_write        ; cislo syscallu pro funkci "write"
    12                              <1>         mov   ebx, 1                ; standardni vystup
    13                              <1>         mov   ecx, %1               ; adresa retezce, ktery se ma vytisknout
    14                              <1>         mov   edx, %2               ; delka retezce
    15                              <1>         int   80h                   ; volani Linuxoveho kernelu
    16                              <1> %endmacro
    17                              <1> 
    18                              <1> 
    19                              <1> ; makro pro tisk 32bitove hexadecimalni hodnoty
    20                              <1> ; na standardni vystup
    21                              <1> %macro print_hex 2
    22                              <1>         push ebx                    ; uschovat EBX pro dalsi pouziti
    23                              <1>         mov     edx, %1             ; zapamatovat si hodnotu pro tisk
    24                              <1>         mov     ebx, hex_message    ; buffer, ktery se zaplni hexa cislicemi
    25                              <1>         mov     byte [ebx+8], %2    ; oddelovac, konec radku, atd.
    26                              <1>         call    hex2string          ; zavolani prislusne subrutiny
    27                              <1>         print_string   hex_message, hex_message_length    ; tisk hexadecimalni hodnoty
    28                              <1>         pop ebx                     ; obnovit EBX
    29                              <1> %endmacro
    30                              <1> 
    31                              <1> 
    32                              <1> ; makro pro vypis obsahu MMX vektoru
    33                              <1> %macro print_mmx_reg_as_hex 1
    34                              <1>         mov  ebx, mmx_tmp           ; adresa bufferu
    35                              <1>         movq [ebx], %1              ; ulozeni do pameti (8 bajtu)
    36                              <1>         mov  eax, [ebx+4]           ; nacteni casti MMX vektoru do celociselneho registru
    37                              <1>         print_hex eax, ' '          ; zobrazeni obsahu tohoto registru v hexadecimalnim tvaru
    38                              <1>         mov  eax, [ebx]             ; nacteni casti MMX vektoru do celociselneho registru
    39                              <1>         print_hex eax, 0x0a         ; zobrazeni obsahu tohoto registru v hexadecimalnim tvaru
    40                              <1> %endmacro
    41                              <1>  
    42                              <1> ; makro pro vypis obsahu SSE vektoru
    43                              <1> %macro print_sse_reg_as_hex 1
    44                              <1>         mov  ebx, sse_tmp           ; adresa bufferu
    45                              <1>         movups [ebx], %1            ; ulozeni do pameti (16 bajtu)
    46                              <1>         mov  eax, [ebx+12]          ; nacteni casti SSE vektoru do celociselneho registru
    47                              <1>         print_hex eax, ' '          ; zobrazeni obsahu tohoto registru v hexadecimalnim tvaru
    48                              <1>         mov  eax, [ebx+8]           ; nacteni casti SSE vektoru do celociselneho registru
    49                              <1>         print_hex eax, ' '          ; zobrazeni obsahu tohoto registru v hexadecimalnim tvaru
    50                              <1>         mov  eax, [ebx+4]           ; nacteni casti SSE vektoru do celociselneho registru
    51                              <1>         print_hex eax, ' '          ; zobrazeni obsahu tohoto registru v hexadecimalnim tvaru
    52                              <1>         mov  eax, [ebx]             ; nacteni casti SSE vektoru do celociselneho registru
    53                              <1>         print_hex eax, 0x0a         ; zobrazeni obsahu tohoto registru v hexadecimalnim tvaru
    54                              <1> %endmacro
    55                              <1>  
    56                              <1>  
    57                              <1> ; makro pro vypis obsahu AVX vektoru
    58                              <1> %macro print_avx_reg_as_hex 1
    59                              <1>         mov  ebx, avx_tmp           ; adresa bufferu
    60                              <1>         vmovdqu [ebx], %1           ; ulozeni do pameti (32 bajtu)
    61                              <1>         mov  eax, [ebx+28]          ; nacteni casti AVX vektoru do celociselneho registru
    62                              <1>         print_hex eax, ' '          ; zobrazeni obsahu tohoto registru v hexadecimalnim tvaru
    63                              <1>         mov  eax, [ebx+24]          ; nacteni casti AVX vektoru do celociselneho registru
    64                              <1>         print_hex eax, ' '          ; zobrazeni obsahu tohoto registru v hexadecimalnim tvaru
    65                              <1>         mov  eax, [ebx+20]          ; nacteni casti AVX vektoru do celociselneho registru
    66                              <1>         print_hex eax, ' '          ; zobrazeni obsahu tohoto registru v hexadecimalnim tvaru
    67                              <1>         mov  eax, [ebx+16]          ; nacteni casti AVX vektoru do celociselneho registru
    68                              <1>         print_hex eax, ' '          ; zobrazeni obsahu tohoto registru v hexadecimalnim tvaru
    69                              <1>         mov  eax, [ebx+12]          ; nacteni casti AVX vektoru do celociselneho registru
    70                              <1>         print_hex eax, ' '          ; zobrazeni obsahu tohoto registru v hexadecimalnim tvaru
    71                              <1>         mov  eax, [ebx+8]           ; nacteni casti AVX vektoru do celociselneho registru
    72                              <1>         print_hex eax, ' '          ; zobrazeni obsahu tohoto registru v hexadecimalnim tvaru
    73                              <1>         mov  eax, [ebx+4]           ; nacteni casti AVX vektoru do celociselneho registru
    74                              <1>         print_hex eax, ' '          ; zobrazeni obsahu tohoto registru v hexadecimalnim tvaru
    75                              <1>         mov  eax, [ebx]             ; nacteni casti AVX vektoru do celociselneho registru
    76                              <1>         print_hex eax, 0x0a         ; zobrazeni obsahu tohoto registru v hexadecimalnim tvaru
    77                              <1> %endmacro
    78                              <1> 
    79                              <1> ; makro pro ukonceni procesu 
    80                              <1> %macro exit 0
    81                              <1>         mov   eax,sys_exit          ; cislo sycallu pro funkci "exit"
    82                              <1>         mov   ebx,0                 ; exit code = 0
    83                              <1>         int   80h                   ; volani Linuxoveho kernelu
    84                              <1> %endmacro
    85                              <1> 
    86                              <1> 
    87                              <1> %endif
     4                                  
     5                                  ;-----------------------------------------------------------------------------
     6                                  section .data
     7                                  
     8                                  hex_message:
     9 00000000 3F<rep 8h>                       times 8 db '?'
    10 00000008 0A                      	 db 0x0a
    11                                           hex_message_length equ $ - hex_message
    12                                  
    13                                  ;-----------------------------------------------------------------------------
    14                                  section .bss
    15                                  
    16 00000000 ????????????????        id_string: resb 8
    17                                  
    18                                   
    19                                  ;-----------------------------------------------------------------------------
    20                                  section .text
    21                                          global _start                ; tento symbol ma byt dostupny i linkeru
    22                                  
    23                                  _start:
    24 00000000 B842000000              	mov     eax, 0x42            ; == 0b04000010
    25 00000005 F30FBCD0                	rep bsf   edx, eax
    26                                  
    27 00000009 BB[00000000]                    mov     ebx, hex_message     ; buffer, ktery se zaplni hexa cislicemi
    28 0000000E E822000000                      call    hex2string           ; zavolani prislusne subrutiny
    29                                          print_string   hex_message, hex_message_length    ; tisk hexadecimalni hodnoty
    11 00000013 B804000000          <1>  mov eax, sys_write
    12 00000018 BB01000000          <1>  mov ebx, 1
    13 0000001D B9[00000000]        <1>  mov ecx, %1
    14 00000022 BA09000000          <1>  mov edx, %2
    15 00000027 CD80                <1>  int 80h
    30                                  
    31                                          exit                         ; ukonceni procesu
    81 00000029 B801000000          <1>  mov eax,sys_exit
    82 0000002E BB00000000          <1>  mov ebx,0
    83 00000033 CD80                <1>  int 80h
    32                                  
    33                                  
    34                                  %include "hex2string.asm"
     1                              <1> %ifndef HEX_2_STRING_LIB
     2                              <1> %define HEX_2_STRING_LIB
     3                              <1> 
     4                              <1> ; subrutina urcena pro prevod 32bitove hexadecimalni hodnoty na retezec
     5                              <1> ; Vstup: EDX - hodnota, ktera se ma prevest na retezec
     6                              <1> ;        EBX - adresa jiz drive alokovaneho retezce (resp. osmice bajtu)
     7                              <1> hex2string:
     8 00000035 B908000000          <1>                   mov ecx,  8               ; pocet opakovani smycky
     9                              <1> 
    10 0000003A C1C204              <1> .print_one_digit: rol edx, 4                ; rotace doleva znamena, ze se do spodnich 4 bitu nasune dalsi cifra
    11 0000003D 88D0                <1>                   mov al, dl                ; nechceme porusit obsah vstupni hodnoty v EDX, proto pouzijeme AL
    12 0000003F 240F                <1>                   and al, 0x0f              ; maskovani, potrebujeme pracovat jen s jednou cifrou
    13 00000041 3C0A                <1>                   cmp al, 10                ; je cifra vetsi nebo rovna 10?
    14 00000043 7C02                <1>                   jl  .store_digit          ; neni, pouze prevest 0..9 na ASCII hodnotu '0'..'9'
    15                              <1> 
    16 00000045 0407                <1> .alpha_digit:     add al, 'A'-10-'0'        ; prevod hodnoty 10..15 na znaky 'A'..'F'
    17                              <1> 
    18 00000047 0430                <1> .store_digit:     add al, '0'
    19 00000049 8803                <1>                   mov [ebx], al             ; ulozeni cifry do retezce
    20 0000004B 43                  <1> 		  inc ebx                   ; dalsi cifra
    21 0000004C E2EC                <1> 		  loop .print_one_digit     ; a opakovani smycky, dokud se nedosahlo nuly
    22                              <1> 
    23 0000004E C3                  <1>                   ret                       ; navrat ze subrutiny
    24                              <1> 
    25                              <1> %endif
