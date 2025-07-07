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
     5                                  P       equ     65536              ; poloha desetinne tecky v X-pointu
     6                                  K       equ     4*P/256            ; vzdalenost mezi dvema body (krok smycky)
     7                                  L       equ     4*P/192
     8                                  MIN     equ     -2*P               ; minimalni a maximalni hodnota konstant fraktalu
     9                                                                     ; v komplexni rovine
    10                                  MAXITER equ     40                 ; maximalni pocet iteraci
    11                                  BAILOUT equ     4
    12                                  
    13                                  section .text
    14                                  
    15                                  start:
    16 00000000 EB00                            jmp main                   ; skok na zacatek kodu
    17                                  
    18                                  %include "io.asm"                  ; nacist symboly, makra a podprogramy
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
    19                                  
    20                                  
    21                                  main:
    22 00000002 B81300                          mov     ax, 13h            ; graficky rezim 320x200x256
    23 00000005 CD10                            int     10h
    24                                  
    25                                  ;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    26                                  ;: MANDELBROTOVA MNOZINA                                                    ::
    27                                  ;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    28                                  
    29 00000007 6800A0                          push    0xa000
    30 0000000A 07                              pop     ES                 ; segment obrazove pameti karty VGA
    31                                  
    32 0000000B BF200A                          mov     DI, 320*8+32       ; zacatek vykreslovani na obrazovce
    33 0000000E BDC000                          mov     BP, 192            ; BP==[x] fraktal bude velikosti 256x192 pixelu
    34 00000011 66C706[0000]0000FE-     mforx:  mov     dword [cx_], MIN   ; od -2 (imaginarni osa)
    34 00000019 FF                 
    35 0000001A BE0001                          mov     SI, 256            ; SI==[y]
    36 0000001D B128                    mfory:  mov     CL, MAXITER        ; maximalni pocet iteraci
    37 0000001F 6631C0                          xor     EAX, EAX           ;
    38 00000022 66A3[0400]                      mov     dword [zx1], EAX   ; nastaveni real.casti zacatku
    39 00000026 66A3[0800]                      mov     dword [zy1], EAX   ; nastaveni imag.casti zacatku
    40                                  
    41                                  iter_loop:                         ; *** iteracni smycka ***
    42 0000002A 66A1[0400]                      mov     EAX, dword [zx1]   ;
    43 0000002E 66C1F808                        sar     EAX, 8             ;
    44 00000032 66F7E8                          imul    EAX                ; zx2:=zx1^2 (v X-pointu)
    45 00000035 66A3[0C00]                      mov     dword [zx2], EAX   ;
    46                                  
    47 00000039 66A1[0800]                      mov     EAX, dword [zy1]   ;
    48 0000003D 66C1F808                        sar     EAX, 8             ;
    49 00000041 66F7E8                          imul    EAX                ; zy2:=zy1^2 (v X-pointu)
    50 00000044 66A3[1000]                      mov     dword [zy2], EAX   ;
    51                                  
    52 00000048 66A1[0400]                      mov     EAX, [zx1]         ;
    53 0000004C 66C1F808                        sar     EAX, 8             ; zx1 div 256 (pro mul v X-pointu)
    54                                  
    55 00000050 668B1E[0800]                    mov     EBX, [zy1]         ;
    56 00000055 66C1FB07                        sar     EBX, 7             ; zy1 div 256 * 2 (pro mul v X-pointu)
    57                                  
    58 00000059 66F7EB                          imul    EBX                ; zy1:=2*zx1*zy1
    59 0000005C 660306[0000]                    add     EAX, [cy_]         ; zy1:=2*zx1*zy1+CY (u Mandelbrota poc.iter.)
    60 00000061 66A3[0800]                      mov     [zy1], EAX         ; ulozit novou hodnotu zy1
    61                                  
    62 00000065 66A1[0C00]                      mov     EAX, [zx2]         ;
    63 00000069 662B06[1000]                    sub     EAX, [zy2]         ; zx2:=zx2-zy2=zx1^2-zy1^2
    64 0000006E 660306[0000]                    add     EAX, [cx_]         ;
    65 00000073 66A3[0400]                      mov     [zx1], EAX         ; zx1:=zx1^2-zy1^2+CX
    66                                  
    67 00000077 FEC9                            dec     CL                 ; upravit pocitadlo iteraci
    68 00000079 7411                            jz      short mpokrac      ; konec iteraci ?
    69 0000007B 66A1[0C00]                      mov     EAX, [zx2]         ;
    70 0000007F 660306[1000]                    add     EAX, [zy2]         ; ==zx1^2+zy1^2
    71 00000084 663D00000400                    cmp     EAX, BAILOUT*P     ; kontrola na bailout (abs[Z]<4)
    72 0000008A 729E                            jc      short iter_loop    ; abs[Z]<4 =>dalsi iterace
    73                                  mpokrac:
    74 0000008C 88C8                            mov     AL, CL             ; pocet iteraci
    75 0000008E 0420                            add     AL, 32             ; posun na vhodne barvy v palete
    76 00000090 AA                              stosb                      ; vykreslit pixel+posun na dalsi pixel
    77 00000091 668106[0000]000400-             add     dword [cx_], K     ; cy_:=cy_+K
    77 00000099 00                 
    78 0000009A 4E                              dec     si
    79 0000009B 7580                            jnz     mfory              ; Y!=0 ->dalsi radek
    80 0000009D 83C740                          add     DI, 320-256        ; dalsi radek na obrazovce
    81 000000A0 668106[0000]550500-             add     dword [cy_], L     ; cx_:=cx_+K
    81 000000A8 00                 
    82 000000A9 4D                              dec     BP                 ; x=x-1
    83 000000AA 0F8563FF                        jnz     mforx              ; X!=0 ->dalsi radek
    84                                  
    85                                  finish:
    86                                          wait_key                   ; cekani na klavesu
    22 000000AE 31C0                <1>  xor ax, ax
    23 000000B0 CD16                <1>  int 0x16
    87                                          exit                       ; navrat do DOSu
    16 000000B2 B44C                <1>  mov ah, 0x4c
    17 000000B4 CD21                <1>  int 0x21
    88                                  
    89                                  
    90                                  section .data
    91                                  
    92 00000000 0000FEFF                cy_     dd MIN                     ; poloha v komplexni rovine rovine
    93                                  
    94                                  section .bss
    95                                  
    96 00000000 ????????                cx_     resd 1                     ;
    97 00000004 ????????                zx1     resd 1                     ;
    98 00000008 ????????                zy1     resd 1                     ; aktualni poloha v komplexni rovine
    99 0000000C ????????                zx2     resd 1                     ; zx2=zx1^2 (aby se to nemuselo pocitat 2x)
   100 00000010 ????????                zy2     resd 1                     ; zy2=zy1^2
   101                                  
   102                                  
   103                                  
   104                                  ; finito
