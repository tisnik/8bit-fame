Module: C:\find_max.c
GROUP: 'DGROUP' CONST,CONST2,_DATA

Segment: _TEXT BYTE USE16 00000027 bytes
0000                          find_max_:
0000    50                        push        ax 
0001    B8 06 00                  mov         ax,0x0006 
0004    E8 00 00                  call        __STK 
0007    58                        pop         ax 
0008    53                        push        bx 
0009    51                        push        cx 
000A    89 D1                     mov         cx,dx 
000C    31 D2                     xor         dx,dx 
000E    89 C3                     mov         bx,ax 
0010    31 C0                     xor         ax,ax 
0012                          L$1:
0012    39 C8                     cmp         ax,cx 
0014    73 0C                     jae         L$3 
0016    3B 17                     cmp         dx,word ptr [bx] 
0018    73 02                     jae         L$2 
001A    8B 17                     mov         dx,word ptr [bx] 
001C                          L$2:
001C    83 C3 02                  add         bx,0x0002 
001F    40                        inc         ax 
0020    EB F0                     jmp         L$1 
0022                          L$3:
0022    89 D0                     mov         ax,dx 
0024    59                        pop         cx 
0025    5B                        pop         bx 
0026    C3                        ret         

Routine Size: 39 bytes,    Routine Base: _TEXT + 0000

No disassembly errors

Segment: CONST WORD USE16 00000000 bytes

Segment: CONST2 WORD USE16 00000000 bytes

Segment: _DATA WORD USE16 00000000 bytes

