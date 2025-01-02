     1                                  ; Instrukcni soubor mikroprocesoru Intel 80386.
     2                                  ;
     3                                  ; Tento demonstracni priklad je pouzity v serialu o programovani
     4                                  ; grafickych dem a her na PC v DOSu:
     5                                  ; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
     6                                  ;
     7                                  ;-----------------------------------------------------------------------------
     8                                  
     9                                  BITS 16         ; 16bitovy vystup pro DOS
    10                                  CPU 386         ; specifikace pouziteho instrukcniho souboru
    11                                  
    12                                  ; ukonceni procesu a navrat do DOSu
    13                                  %macro exit 0
    14                                          ret
    15                                  %endmacro
    16                                  
    17                                  ; vyprazdneni bufferu klavesnice a cekani na klavesu
    18                                  %macro wait_key 0
    19                                          xor     ax, ax
    20                                          int     0x16
    21                                  %endmacro
    22                                  
    23                                  ;-----------------------------------------------------------------------------
    24                                  org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)
    25                                  
    26                                  start:
    27 00000000 B001                            mov  al, 1
    28 00000002 B401                            mov  ah, 1
    29 00000004 00C4                            add  ah, al
    30                                  
    31 00000006 B80100                          mov  ax, 1
    32 00000009 BB0100                          mov  bx, 1
    33 0000000C 01D8                            add  ax, bx
    34                                  
    35 0000000E 66B801000000                    mov  eax, 1
    36 00000014 66BB01000000                    mov  ebx, 1
    37 0000001A 6601D8                          add  eax, ebx
    38                                  
    39                                          wait_key
    19 0000001D 31C0                <1>  xor ax, ax
    20 0000001F CD16                <1>  int 0x16
    40                                          exit
    14 00000021 C3                  <1>  ret
