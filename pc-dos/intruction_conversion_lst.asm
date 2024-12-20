     1                                  ; Instrukcni soubor mikroprocesoru Intel 80386.
     2                                  ; Test instrukci pro konverzi dat.
     3                                  ;
     4                                  ; Tento demonstracni priklad je pouzity v serialu o programovani
     5                                  ; grafickych dem a her na PC v DOSu:
     6                                  ; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
     7                                  ;
     8                                  ;-----------------------------------------------------------------------------
     9                                  
    10                                  BITS 16         ; 16bitovy vystup pro DOS
    11                                  CPU 386         ; specifikace pouziteho instrukcniho souboru
    12                                  
    13                                  ;-----------------------------------------------------------------------------
    14                                  org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)
    15                                  
    16                                  start:
    17 00000000 98                              cbw
    18 00000001 99                              cwd
    19 00000002 6698                            cwde
    20 00000004 6699                            cdq
