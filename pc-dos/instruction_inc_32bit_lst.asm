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
    27 00000000 30C0                            xor  al, al
    28 00000002 FEC0                            inc  al
    29                                  
    30 00000004 31C0                            xor  ax, ax
    31 00000006 40                              inc  ax
    32                                  
    33 00000007 6631C0                          xor  eax, eax
    34 0000000A 6640                            inc  eax
    35                                  
    36                                          wait_key
    19 0000000C 31C0                <1>  xor ax, ax
    20 0000000E CD16                <1>  int 0x16
    37                                          exit
    14 00000010 C3                  <1>  ret
