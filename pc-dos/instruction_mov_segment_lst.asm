     1                                  ; Instrukcni soubor mikroprocesoru Intel 80386.
     2                                  ; Presuny dat do a ze segmentovych registru.
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
    13                                  ; ukonceni procesu a navrat do DOSu
    14                                  %macro exit 0
    15                                          ret
    16                                  %endmacro
    17                                  
    18                                  ; vyprazdneni bufferu klavesnice a cekani na klavesu
    19                                  %macro wait_key 0
    20                                          xor     ax, ax
    21                                          int     0x16
    22                                  %endmacro
    23                                  
    24                                  ;-----------------------------------------------------------------------------
    25                                  org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)
    26                                  
    27                                  start:
    28 00000000 8CD8                    	mov  ax, ds
    29 00000002 8CC0                    	mov  ax, es
    30 00000004 8CE0                    	mov  ax, fs
    31 00000006 8CE8                    	mov  ax, gs
    32 00000008 8CD0                    	mov  ax, ss
    33 0000000A 8CC8                    	mov  ax, cs
    34                                  
    35 0000000C 31C0                    	xor  ax, ax
    36 0000000E 8ED8                    	mov  ds, ax
    37 00000010 8EC0                    	mov  es, ax
    38 00000012 8EE0                    	mov  fs, ax
    39 00000014 8EE8                    	mov  gs, ax
    40 00000016 8ED0                    	mov  ss, ax
    41 00000018 8EC8                    	mov  cs, ax  ; toto neni dobry napad!!!
    42                                  
    43                                          wait_key
    20 0000001A 31C0                <1>  xor ax, ax
    21 0000001C CD16                <1>  int 0x16
    44                                          exit
    15 0000001E C3                  <1>  ret
