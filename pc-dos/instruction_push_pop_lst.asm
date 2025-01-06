     1                                  ; Instrukcni soubor mikroprocesoru Intel 80386.
     2                                  ;
     3                                  ; Tento demonstracni priklad je pouzity v serialu o programovani
     4                                  ; grafickych dem a her na PC v DOSu:
     5                                  ; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
     6                                  ;
     7                                  ;-----------------------------------------------------------------------------
     8                                  
     9                                  BITS 16         ; 16bitovy vystup pro DOS
    10                                  CPU 286         ; specifikace pouziteho instrukcniho souboru
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
    27 00000000 0E                              push cs
    28 00000001 1E                              push ds
    29 00000002 16                              push ss
    30 00000003 06                              push es
    31                                  
    32 00000004 07                              pop  es
    33 00000005 17                              pop  ss
    34 00000006 1F                              pop  ds
    35 00000007 0F                              pop  cs
    35          ******************       warning: instruction obsolete and removed from the target CPU [-w+obsolete-removed]
    36                                  
    37                                          wait_key
    19 00000008 31C0                <1>  xor ax, ax
    20 0000000A CD16                <1>  int 0x16
    38                                          exit
    14 0000000C C3                  <1>  ret
