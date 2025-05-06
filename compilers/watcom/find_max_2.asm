Module: C:\find_max.c
GROUP: 'DGROUP' CONST,CONST2,_DATA

Segment: _TEXT PARA USE16 00000021 bytes
0000                          find_max_:
0000    53                        push        bx 
0001    51                        push        cx 
0002    89 D1                     mov         cx,dx 
0004    89 C3                     mov         bx,ax 
0006    31 D2                     xor         dx,dx 
0008    31 C0                     xor         ax,ax 
000A    85 C9                     test        cx,cx 
000C    76 0E                     jbe         L$3 
000E                          L$1:
000E    3B 17                     cmp         dx,word ptr [bx] 
0010    73 02                     jae         L$2 
0012    8B 17                     mov         dx,word ptr [bx] 
0014                          L$2:
0014    40                        inc         ax 
0015    83 C3 02                  add         bx,0x0002 
0018    39 C8                     cmp         ax,cx 
001A    72 F2                     jb          L$1 
001C                          L$3:
001C    89 D0                     mov         ax,dx 
001E    59                        pop         cx 
001F    5B                        pop         bx 
0020    C3                        ret         

Routine Size: 33 bytes,    Routine Base: _TEXT + 0000

No disassembly errors

Segment: CONST WORD USE16 00000000 bytes

Segment: CONST2 WORD USE16 00000000 bytes

Segment: _DATA WORD USE16 00000000 bytes

