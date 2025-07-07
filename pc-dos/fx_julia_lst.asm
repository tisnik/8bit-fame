;-----------------------------------------------------------------------------
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; Výpočty v systému pevné řádové čárky na platformě IBM PC
; https://www.root.cz/clanky/vypocty-v-systemu-pevne-radove-carky-na-platforme-ibm-pc/
;
;-----------------------------------------------------------------------------

     1                                  ;-----------------------------------------------------------------------------
     2                                  org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)
     3                                  
     4                                  ; konstanty
     5                                  P       equ     65536                   ; poloha desetinne tecky v X-pointu
     6                                  K       equ     4*P/128                 ; vzdalenost mezi dvema body (krok smycky)
     7                                  MIN     equ     -2*P                    ; minimalni a maximalni hodnota konstant fraktalu
     8                                  
     9                                  section .text
    10                                  
    11                                  start:
    12 00000000 EB00                            jmp main                        ; skok na zacatek kodu
    13                                  
    14                                  %include "io.asm"                       ; nacist symboly, makra a podprogramy
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
    15                                  
    16                                  
    17                                  main:
    18 00000002 B81300                          mov     ax, 13h                 ; graficky rezim 320x200x256
    19 00000005 CD10                            int     10h
    20                                  
    21                                  
    22 00000007 B108                            mov     CL,8
    23 00000009 6800A0                          push    0A000h                  ; do ES adresu video RAM
    24 0000000C 07                              pop     ES
    25                                  
    26                                  OPAK:
    27 0000000D BF602D                          mov     DI,11520+96             ; aby se fraktal vykreslil
    28 00000010 BD9FCC                          mov     BP,52608-320+95
    29 00000013 66A1[0000]                      mov     EAX, dword [CX_]        ; doprostred obrazovky
    30 00000017 660306[0800]                    add     EAX, dword [PCX]        ; posun konstanty
    31 0000001C 66A3[0000]                      mov     dword [CX_],EAX
    32 00000020 663DC0D40100                    cmp     EAX,120000              ; kontrola CX_
    33 00000026 7F0A                            jg      short UP                ; CX_ osciluje mezi -100000 a 100000
    34 00000028 663D402BFEFF                    cmp     EAX,-120000
    35 0000002E 7C02                            jl      short UP
    36 00000030 EB22                            jmp     short PP
    37 00000032 66F71E[0800]            UP:     neg     dword [PCX]             ; posun na opacnou stranu
    38 00000037 668106[0400]701700-             add     dword [CY_],6000        ; posun CY_
    38 0000003F 00                 
    39 00000040 66813E[0400]C0D401-             cmp     dword [CY_],120000      ; kontrola CY_
    39 00000048 00                 
    40 00000049 7C09                            jl      short PP
    41 0000004B 66C706[0400]80C7FE-             mov     dword [CY_],-80000
    41 00000053 FF                 
    42                                  PP:
    43 00000054 66C706[0200]0000FE-             mov     dword [ZX1],MIN
    43 0000005C FF                 
    44 0000005D C606[0000]40                    mov     byte [X],64             ; fraktal bude velikosti 128x128
    45                                  FORX:
    46 00000062 66C706[0600]0000FE-             mov     dword [ZY1],MIN
    46 0000006A FF                 
    47 0000006B C606[0100]80                    mov     byte [Y],128
    48                                  FORY:
    49 00000070 B510                            mov     CH,16                   ; pocet iteraci
    50 00000072 66A1[0200]                      mov     EAX, dword [ZX1]
    51 00000076 66A3[0A00]                      mov     dword [ZX2],EAX         ; ZX2:=ZX1
    52 0000007A 668B36[0600]                    mov     ESI, dword [ZY1]
    53                                  
    54                                  REP_:
    55 0000007F 66A1[0A00]                      mov     EAX, [ZX2]
    56 00000083 66D3F8                          sar     EAX,CL                  ; ZX3:=ZX2^2
    57 00000086 66F7E8                          imul    EAX
    58 00000089 66A3[1200]                      mov     [ZX3],EAX
    59                                  
    60 0000008D 6689F0                          mov     EAX,ESI
    61 00000090 66D3F8                          sar     EAX,CL                  ; ZY3:=ZY2^2
    62 00000093 66F7E8                          imul    EAX
    63 00000096 66A3[1600]                      mov     [ZY3],EAX
    64                                  
    65 0000009A 66A1[0A00]                      mov     EAX, [ZX2]
    66 0000009E 66D3F8                          sar     EAX,CL                  ; ZX2 div 256
    67 000000A1 66C1FE07                        sar     ESI,7                   ; ZY2 div 256 * 2
    68 000000A5 66F7EE                          imul    ESI
    69                                  
    70 000000A8 660306[0400]                    add     EAX, [CY_]               ; ZY2:=ZX2*ZY2+CY_
    71 000000AD 6689C6                          mov     ESI,EAX
    72                                  
    73 000000B0 66A1[1200]                      mov     EAX, [ZX3]
    74 000000B4 662B06[1600]                    sub     EAX, [ZY3]
    75 000000B9 660306[0000]                    add     EAX, [CX_]
    76 000000BE 66A3[0A00]                      mov     [ZX2],EAX               ; ZX2:=ZX3^2-ZY3^2+CX_
    77                                  
    78 000000C2 FECD                            dec     CH                      ; pocitadlo iteraci
    79 000000C4 7411                            jz      short POKRAC
    80 000000C6 66A1[1200]                      mov     EAX, [ZX3]
    81 000000CA 660306[1600]                    add     EAX, [ZY3]
    82 000000CF 663D00000400                    cmp     EAX,4*P                 ; kontrola bailout
    83 000000D5 72A8                            jc      short REP_
    84                                  
    85                                  POKRAC:
    86 000000D7 88E8                            mov     AL,CH                   ; pocet iteraci
    87 000000D9 0410                            add     AL,16                   ; uprava barvy
    88 000000DB AA                              stosb                           ; vykreslit prvni bod
    89 000000DC 26884600                        mov     [ES:BP],AL              ; vykreslit druhy bod
    90 000000E0 4D                              dec     BP
    91 000000E1 668106[0600]000800-             add     dword [ZY1],K           ; ZY1:=ZY1+K
    91 000000E9 00                 
    92 000000EA FE0E[0100]                      dec     byte [Y]                ; Y:=Y-1
    93 000000EE 7580                            jnz     short FORY
    94 000000F0 81C7C000                        add     DI,320-128              ; dalsi radek
    95 000000F4 81EDC000                        sub     BP,320-128
    96 000000F8 668106[0200]000800-             add     dword [ZX1],K           ; ZX1:=ZX1+K
    96 00000100 00                 
    97 00000101 FE0E[0000]                      dec     byte [X]                ; X:=X-1
    98 00000105 0F8559FF                        jnz     FORX
    99                                  
   100 00000109 B401                            mov     AH,01h                  ; je klavesa v bufferu ?
   101 0000010B CD16                            int     16h
   102 0000010D 0F84FCFE                        jz      OPAK                    ; opakovat do stisku klavesy
   103                                  finish:
   104                                          wait_key                        ; cekani na klavesu
    22 00000111 31C0                <1>  xor ax, ax
    23 00000113 CD16                <1>  int 0x16
   105                                          exit                            ; navrat do DOSu
    16 00000115 B44C                <1>  mov ah, 0x4c
    17 00000117 CD21                <1>  int 0x21
   106                                  
   107                                  
   108                                  section .data
   109                                  
   110 00000000 6079FEFF                CX_     dd -100000                      ; imaginarni konstanta pro iteraci
   111 00000004 80C7FEFF                CY_     dd -80000
   112 00000008 70170000                PCX     dd 6000                         ; posun realne casti konstanty
   113                                  
   114                                  
   115                                  section .bss
   116                                  
   117 00000000 ??                      X       resb  1                         ; pozice ve fraktalu
   118 00000001 ??                      Y       resb  1
   119 00000002 ????????                ZX1     resd  1                         ; komplexni cisla
   120 00000006 ????????                ZY1     resd  1                         ; komplexni cisla
   121 0000000A ????????                ZX2     resd  1                         ; komplexni cisla
   122 0000000E ????????                ZY2     resd  1                         ; komplexni cisla
   123 00000012 ????????                ZX3     resd  1                         ; komplexni cisla
   124 00000016 ????????                ZY3     resd  1                         ; komplexni cisla
   125                                  
   126                                  
   127                                  
   128                                  ; finito
