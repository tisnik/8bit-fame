;-----------------------------------------------------------------------------
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; Výpočty v systému pevné řádové čárky na platformě IBM PC (2. část)
; https://www.root.cz/clanky/vypocty-v-systemu-pevne-radove-carky-na-platforme-ibm-pc-2-cast/
;
;-----------------------------------------------------------------------------

     1                                  ;-----------------------------------------------------------------------------
     2                                  org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)
     3                                  
     4                                  ; konstanty
     5                                  P       equ     4096*2             ; poloha desetinne tecky v X-pointu
     6                                  K       equ     4*P/256            ; vzdalenost mezi dvema body (krok smycky)
     7                                  L       equ     4*P/192
     8                                  MIN     equ     -2*P               ; minimalni a maximalni hodnota konstant fraktalu
     9                                                                     ; v komplexni rovine
    10                                  MAXITER equ     40                 ; maximalni pocet iteraci
    11                                  BAILOUT equ     4
    12                                  SLOUPCU equ     320                ; pocet sloupcu na obrazovce
    13                                  
    14                                  section .text
    15                                  
    16                                  start:
    17 00000000 EB00                            jmp main                   ; skok na zacatek kodu
    18                                  
    19                                  %include "io.asm"                  ; nacist symboly, makra a podprogramy
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
    20                                  
    21                                  
    22                                  main:
    23 00000002 B81300                          mov     ax, 13h            ; graficky rezim 320x200x256
    24 00000005 CD10                            int     10h
    25                                  
    26                                  ;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    27                                  ;: MANDELBROTOVA MNOZINA                                                    ::
    28                                  ;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    29                                  
    30 00000007 6800A0                          push    0xa000
    31 0000000A 07                              pop     ES                 ; segment obrazove pameti karty VGA
    32                                  
    33 0000000B 31FF                            xor     DI, DI             ; zacatek vykreslovani na obrazovce
    34 0000000D B107                            mov     CL, 7              ; posun pro FX format
    35                                  
    36 0000000F C706[0000]00C0          mforx:  mov     word [cx_], MIN    ; od -2 (imaginarni osa)
    37 00000015 BE4001                          mov     SI, SLOUPCU        ; x
    38 00000018 B528                    mfory:  mov     CH, MAXITER        ; pocet iteraci
    39 0000001A 31C0                            xor     AX, AX             ;
    40 0000001C 89C5                            mov     BP, AX             ; nastaveni real.casti zacatku
    41 0000001E A3[0200]                        mov     word [zy1], AX     ; nastaveni imag.casti zacatku
    42                                  iter_loop:                         ; *** iteracni smycka ***
    43 00000021 89E8                            mov     AX, BP             ;
    44 00000023 D3F8                            sar     AX, CL             ;
    45 00000025 F7E8                            imul    AX                 ; zx2:=zx1^2 (v X-pointu)
    46 00000027 A3[0400]                        mov     word [zx2], AX     ;
    47 0000002A A1[0200]                        mov     AX, [zy1]          ;
    48 0000002D D3F8                            sar     AX,CL              ;
    49 0000002F F7E8                            imul    AX                 ; zy2:=zy1^2 (v X-pointu)
    50 00000031 A3[0600]                        mov     word [zy2], AX     ;
    51                                  
    52 00000034 89E8                            mov     AX, BP             ;
    53 00000036 D3F8                            sar     AX,CL              ; zx1 div 256 (pro mul v X-pointu)
    54 00000038 8B1E[0200]                      mov     BX, [zy1]          ;
    55 0000003C C1FB06                          sar     BX,6               ; zy1 div 256 * 2 (pro mul v X-pointu)
    56 0000003F F7EB                            imul    BX                 ; zy1:=2*zx1*zy1
    57 00000041 0306[0000]                      add     AX, [cy_]          ; zy1:=2*zx1*zy1+CY (u Mandelbrota poc.iter.)
    58 00000045 A3[0200]                        mov     [zy1], AX          ; ulozit
    59                                  
    60 00000048 A1[0400]                        mov     AX, [zx2]          ;
    61 0000004B 2B06[0600]                      sub     AX, [zy2]          ; zx2:=zx2-zy2=zx1^2-zy1^2
    62 0000004F 0306[0000]                      add     AX, [cx_]          ;
    63 00000053 89C5                            mov     BP, AX             ; zx1:=zx1^2-zy1^2+CX
    64 00000055 FECD                            dec     CH                 ; pocitadlo iteraci
    65 00000057 740C                            jz      short mpokrac      ; konec iteraci ?
    66 00000059 A1[0400]                        mov     AX, [zx2]          ;
    67 0000005C 0306[0600]                      add     AX, [zy2]          ; ==zx1^2+zy1^2
    68 00000060 3D0080                          cmp     AX, BAILOUT*P      ; kontrola na bailout (abs[Z]<4)
    69 00000063 72BC                            jc      short iter_loop    ; abs[Z]<4 =>dalsi iterace
    70                                  mpokrac:
    71 00000065 88E8                            mov     AL, CH             ; pocet iteraci
    72 00000067 0420                            add     AL, 32             ; posun na vhodne barvy v palete
    73 00000069 AA                              stosb                      ; vykreslit pixel+posun na dalsi pixel
    74 0000006A 8106[0000]8000                  add     word [cx_], K      ; cy_:=cy_+K
    75 00000070 4E                              dec     si
    76 00000071 75A5                            jnz     short mfory        ; Y!=0 ->dalsi radek
    77                                  
    78 00000073 8106[0000]AA00                  add     word [cy_], L      ; cx_:=cx_+L
    79 00000079 81FF00FA                        cmp     di, 64000          ; konec obrazku ?
    80 0000007D 7590                            jne     short mforx
    81                                  
    82                                  finish:
    83                                          wait_key                   ; cekani na klavesu
    22 0000007F 31C0                <1>  xor ax, ax
    23 00000081 CD16                <1>  int 0x16
    84                                          exit                       ; navrat do DOSu
    16 00000083 B44C                <1>  mov ah, 0x4c
    17 00000085 CD21                <1>  int 0x21
    85                                  
    86                                  
    87                                  section .data
    88                                  
    89 00000000 00C0                    cy_     dw MIN                     ; poloha v komplexni rovine rovine
    90                                  
    91                                  section .bss
    92                                  
    93 00000000 ????                    cx_     resw 1                     ;
    94 00000002 ????                    zy1     resw 1                     ; aktualni poloha v komplexni rovine
    95 00000004 ????                    zx2     resw 1                     ; zx2=zx1^2 (aby se to nemuselo pocitat 2x)
    96 00000006 ????                    zy2     resw 1                     ; zy2=zy1^2
    97                                  
    98                                  
    99                                  
   100                                  ; finito
