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
    27 00000000 0E                              push cs
    28 00000001 1E                              push ds
    29 00000002 16                              push ss
    30 00000003 06                              push es
    31 00000004 0FA0                            push fs
    32 00000006 0FA8                            push gs
    33                                  
    34 00000008 0FA9                            pop  gs
    35 0000000A 0FA1                            pop  fs
    36 0000000C 07                              pop  es
    37 0000000D 17                              pop  ss
    38 0000000E 1F                              pop  ds
    39 0000000F 0F                              pop  cs
    39          ******************       warning: instruction obsolete and removed from the target CPU [-w+obsolete-removed]
    40                                  
    41                                          wait_key
    19 00000010 31C0                <1>  xor ax, ax
    20 00000012 CD16                <1>  int 0x16
    42                                          exit
    14 00000014 C3                  <1>  ret
