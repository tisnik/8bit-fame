     1                                  ;-----------------------------------------------------------------------------
     2                                  org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)
     3                                  
     4                                  section .text
     5                                  
     6                                  start:
     7 00000000 EB00                            jmp main                   ; skok na zacatek kodu
     8                                  
     9                                  %include "io.asm"                  ; nacist symboly, makra a podprogramy
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
    10                                  
    11                                  
    12                                  main:
    13 00000002 B81300                          mov     ax, 13h            ; graficky rezim 320x200x256
    14 00000005 CD10                            int     10h
    15                                  
    16 00000007 6800A0                          push    0xa000
    17 0000000A 07                              pop     ES                 ; segment obrazove pameti karty VGA
    18                                  
    19 0000000B D906[DD00]                          fld dword [initb]
    20 0000000F D91E[D100]                          fstp dword [b]
    21 00000013 C706[D900]0000                      mov word[loop1],0
    22 00000019 EB04                                jmp @A1
    23                                      @L1:
    24 0000001B FF06[D900]                          inc word [loop1]
    25                                      @A1:
    26 0000001F D906[D100]                          fld dword[b]
    27 00000023 D806[E500]                          fadd dword[lp]
    28 00000027 D91E[D100]                          fstp dword[b]
    29 0000002B D906[E100]                          fld dword[inita]
    30 0000002F D91E[D500]                          fstp dword[a]
    31 00000033 C706[DB00]0000                      mov word[loop2],0
    32 00000039 EB04                                jmp @A2
    33                                  
    34                                      @L2:
    35 0000003B FF06[DB00]                          inc word [loop2]
    36                                  
    37                                      @A2:
    38 0000003F D906[D500]                          fld dword[a]
    39 00000043 D806[E900]                          fadd dword[lp2]
    40 00000047 D91E[D500]                          fstp dword[a]
    41 0000004B E82100                              call iterate
    42                                  
    43 0000004E 3B1E[F100]                          cmp bx,word [maxi]
    44 00000052 7303                                jae @NOPUT
    45 00000054 E85E00                              call putpixel
    46                                  
    47                                     @NOPUT:
    48 00000057 813E[DB00]4001                      cmp word[loop2],320
    49 0000005D 75DC                                jne @L2
    50 0000005F 813E[D900]C800                      cmp word[loop1],200
    51 00000065 75B4                                jne @L1
    52                                  
    53                                  finish:
    54                                          wait_key                   ; cekani na klavesu
    22 00000067 31C0                <1>  xor ax, ax
    23 00000069 CD16                <1>  int 0x16
    55                                          exit                       ; navrat do DOSu
    16 0000006B B44C                <1>  mov ah, 0x4c
    17 0000006D CD21                <1>  int 0x21
    56                                  
    57                                  iterate:
    58 0000006F D906[D500]                          fld dword [a]
    59 00000073 D906[D100]                          fld dword [b]
    60 00000077 DB06[ED00]                          fild dword [bout]
    61 0000007B 31DB                                xor bx,bx
    62 0000007D D9EE                                fldz
    63 0000007F D9EE                                fldz
    64 00000081 D9EE                                fldz
    65 00000083 D9EE                                fldz
    66                                      @ITER:
    67 00000085 D8CB                                fmul st0,st3
    68 00000087 DCC0                                fadd st0,st0
    69 00000089 D8C5                                fadd st0,st5
    70 0000008B D9F7                                fincstp
    71 0000008D D8E1                                fsub st0,st1
    72 0000008F D8C5                                fadd st0,st5
    73 00000091 DDD2                                fst  st2
    74 00000093 DCC8                                fmul st0,st0
    75 00000095 43                                  inc  bx
    76 00000096 DDD6                                fst  st6
    77 00000098 D9F6                                fdecstp
    78 0000009A DDD2                                fst  st2
    79 0000009C DCCA                                fmul st2,st0
    80 0000009E D9F6                                fdecstp
    81 000000A0 D8C3                                fadd st0,st3
    82 000000A2 D8DD                                fcomp st5
    83 000000A4 DFE0                                fnstsw ax
    84 000000A6 80E441                              and ah,41h
    85 000000A9 7406                                jz @OK
    86 000000AB 3B1E[F100]                          cmp bx,word [maxi]
    87 000000AF 72D4                                jb @ITER
    88                                      @OK:
    89 000000B1 9BDBE3                              finit
    90 000000B4 C3                                  ret
    91                                  
    92                                  putpixel:
    93 000000B5 52                                  push dx
    94 000000B6 B84001                              mov ax,320
    95 000000B9 F726[D900]                          mul word [loop1]
    96 000000BD 89C7                                mov di,ax
    97 000000BF 033E[DB00]                          add di,word [loop2]
    98 000000C3 83D200                              adc dx,0
    99 000000C6 59                                  pop cx
   100 000000C7 39CA                                cmp dx,cx
   101                                  
   102                                     @NOPAGING:
   103 000000C9 021E[F300]                          add bl,byte [color]
   104 000000CD 26881D                              mov es:[di],bl
   105 000000D0 C3                                  ret
   106                                  
   107 000000D1 00000000                  b    :DD 0
   108 000000D5 00000000                  a    :DD 0
   109 000000D9 0000                      loop1:DW 0
   110 000000DB 0000                      loop2:DW 0
   111 000000DD 9A9999BF                  initb:DD -1.2
   112 000000E1 9A9919C0                  inita:DD -2.4
   113 000000E5 A69B443C                  lp   :DD 0.012
   114 000000E9 A69B443C                  lp2  :DD 0.012
   115 000000ED 04000000                  bout :DD 4
   116 000000F1 6400                      maxi :DW 100
   117 000000F3 FE                        color:DB -2
