Module: C:\fill_a.c
GROUP: 'DGROUP' CONST,CONST2,_DATA

Segment: _TEXT BYTE USE16 00000022 bytes
0000                          fill_array_:
0000    50                        push        ax 
0001    B8 06 00                  mov         ax,0x0006 
0004    E8 00 00                  call        __STK 
0007    58                        pop         ax 
0008    51                        push        cx 
0009    56                        push        si 
000A    89 C6                     mov         si,ax 
000C    89 D9                     mov         cx,bx 
000E    31 C0                     xor         ax,ax 
0010                          L$1:
0010    39 D0                     cmp         ax,dx 
0012    7D 0B                     jge         L$2 
0014    89 C3                     mov         bx,ax 
0016    D1 E3                     shl         bx,0x01 
0018    01 F3                     add         bx,si 
001A    89 0F                     mov         word ptr [bx],cx 
001C    40                        inc         ax 
001D    EB F1                     jmp         L$1 
001F                          L$2:
001F    5E                        pop         si 
0020    59                        pop         cx 
0021    C3                        ret         

Routine Size: 34 bytes,    Routine Base: _TEXT + 0000

No disassembly errors

Segment: CONST WORD USE16 00000000 bytes

Segment: CONST2 WORD USE16 00000000 bytes

Segment: _DATA WORD USE16 00000000 bytes

