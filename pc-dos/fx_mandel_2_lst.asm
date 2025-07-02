     1                                  ;-----------------------------------------------------------------------------
     2                                  org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)
     3                                  
     4                                  ; konstanty
     5                                  P       equ     4096               ; poloha desetinne tecky v X-pointu
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
    34 0000000D B106                            mov     CL, 6              ; posun pro FX format
    35                                  
    36 0000000F 66C706[0000]00E0FF-     mforx:  mov     dword [cx_], MIN   ; od -2 (imaginarni osa)
    36 00000017 FF                 
    37 00000018 BE4001                          mov     SI, SLOUPCU        ; x
    38 0000001B B528                    mfory:  mov     CH, MAXITER        ; pocet iteraci
    39 0000001D 6631C0                          xor     EAX, EAX           ;
    40 00000020 6689C5                          mov     EBP, EAX           ; nastaveni real.casti zacatku
    41 00000023 66A3[0400]                      mov     dword [zy1], EAX   ; nastaveni imag.casti zacatku
    42                                  iter_loop:                         ; *** iteracni smycka ***
    43 00000027 6689E8                          mov     EAX, EBP           ;
    44 0000002A 66D3F8                          sar     EAX, CL            ;
    45 0000002D 66F7E8                          imul    EAX                ; zx2:=zx1^2 (v X-pointu)
    46 00000030 66A3[0800]                      mov     dword [zx2], EAX   ;
    47                                  
    48 00000034 66A1[0400]                      mov     EAX, dword [zy1]   ;
    49 00000038 66D3F8                          sar     EAX, CL            ; 
    50 0000003B 66F7E8                          imul    EAX                ; zy2:=zy1^2 (v X-pointu)
    51 0000003E 66A3[0C00]                      mov     dword [zy2], EAX   ;
    52                                  
    53 00000042 6689E8                          mov     EAX, EBP           ;
    54 00000045 66D3F8                          sar     EAX, CL            ; zx1 div 256 (pro mul v X-pointu)
    55                                  
    56 00000048 668B1E[0400]                    mov     EBX, [zy1]         ;
    57 0000004D 66C1FB05                        sar     EBX, 5             ; zy1 div 256 * 2 (pro mul v X-pointu)
    58                                  
    59 00000051 66F7EB                          imul    EBX                ; zy1:=2*zx1*zy1
    60 00000054 660306[0000]                    add     EAX, [cy_]         ; zy1:=2*zx1*zy1+CY (u Mandelbrota poc.iter.)
    61 00000059 66A3[0400]                      mov     [zy1], EAX         ; ulozit novou hodnotu zy1
    62                                  
    63 0000005D 66A1[0800]                      mov     EAX, [zx2]         ;
    64 00000061 662B06[0C00]                    sub     EAX, [zy2]         ; zx2:=zx2-zy2=zx1^2-zy1^2
    65 00000066 660306[0000]                    add     EAX, [cx_]         ;
    66 0000006B 6689C5                          mov     EBP, EAX           ; zx1:=zx1^2-zy1^2+CX
    67                                  
    68 0000006E FECD                            dec     CH                 ; pocitadlo iteraci
    69 00000070 7411                            jz      short mpokrac      ; konec iteraci ?
    70 00000072 66A1[0800]                      mov     EAX, [zx2]         ;
    71 00000076 660306[0C00]                    add     EAX, [zy2]         ; ==zx1^2+zy1^2
    72 0000007B 663D00400000                    cmp     EAX, BAILOUT*P     ; kontrola na bailout (abs[Z]<4)
    73 00000081 72A4                            jc      short iter_loop    ; abs[Z]<4 =>dalsi iterace
    74                                  mpokrac:
    75 00000083 88E8                            mov     AL, CH             ; pocet iteraci
    76 00000085 0420                            add     AL, 32             ; posun na vhodne barvy v palete
    77 00000087 AA                              stosb                      ; vykreslit pixel+posun na dalsi pixel
    78 00000088 668306[0000]40                  add     dword [cx_], K     ; cy_:=cy_+K
    79 0000008E 4E                              dec     si
    80 0000008F 758A                            jnz     short mfory        ; Y!=0 ->dalsi radek
    81                                  
    82 00000091 668306[0000]55                  add     dword [cy_], L     ; cx_:=cx_+K
    83 00000097 81FF00FA                        cmp     di, 64000          ; konec obrazku ?
    84 0000009B 0F8570FF                        jne     mforx
    85                                  
    86                                  finish:
    87                                          wait_key                   ; cekani na klavesu
    22 0000009F 31C0                <1>  xor ax, ax
    23 000000A1 CD16                <1>  int 0x16
    88                                          exit                       ; navrat do DOSu
    16 000000A3 B44C                <1>  mov ah, 0x4c
    17 000000A5 CD21                <1>  int 0x21
    89                                  
    90                                  
    91                                  section .data
    92                                  
    93 00000000 00E0FFFF                cy_     dd MIN                     ; poloha v komplexni rovine rovine
    94                                  
    95                                  section .bss
    96                                  
    97 00000000 ????????                cx_     resd 1                     ;
    98 00000004 ????????                zy1     resd 1                     ; aktualni poloha v komplexni rovine
    99 00000008 ????????                zx2     resd 1                     ; zx2=zx1^2 (aby se to nemuselo pocitat 2x)
   100 0000000C ????????                zy2     resd 1                     ; zy2=zy1^2
   101                                  
   102                                  
   103                                  
   104                                  ; finito
