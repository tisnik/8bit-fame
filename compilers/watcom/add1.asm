Module: C:\add.c
GROUP: 'DGROUP' CONST,CONST2,_DATA

Segment: _TEXT BYTE USE16 0000000B bytes
0000                          add_:
0000    50                        push        ax 
0001    B8 02 00                  mov         ax,0x0002 
0004    E8 00 00                  call        __STK 
0007    58                        pop         ax 
0008    01 D0                     add         ax,dx 
000A    C3                        ret         

Routine Size: 11 bytes,    Routine Base: _TEXT + 0000

No disassembly errors

Segment: CONST WORD USE16 00000000 bytes

Segment: CONST2 WORD USE16 00000000 bytes

Segment: _DATA WORD USE16 00000000 bytes

