Module: C:\fill_a.c
GROUP: 'DGROUP' CONST,CONST2,_DATA

Segment: _TEXT BYTE USE16 0000001B bytes
0000                          fill_array_:
0000    51                        push        cx 
0001    56                        push        si 
0002    89 C6                     mov         si,ax 
0004    89 D1                     mov         cx,dx 
0006    89 DA                     mov         dx,bx 
0008    89 F3                     mov         bx,si 
000A    31 C0                     xor         ax,ax 
000C                          L$1:
000C    39 C8                     cmp         ax,cx 
000E    7D 08                     jge         L$2 
0010    40                        inc         ax 
0011    89 17                     mov         word ptr [bx],dx 
0013    83 C3 02                  add         bx,0x0002 
0016    EB F4                     jmp         L$1 
0018                          L$2:
0018    5E                        pop         si 
0019    59                        pop         cx 
001A    C3                        ret         

Routine Size: 27 bytes,    Routine Base: _TEXT + 0000

No disassembly errors

Segment: CONST WORD USE16 00000000 bytes

Segment: CONST2 WORD USE16 00000000 bytes

Segment: _DATA WORD USE16 00000000 bytes

