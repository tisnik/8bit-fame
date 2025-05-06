Module: c:\memset.c
GROUP: 'DGROUP' CONST,CONST2,_DATA

Segment: _TEXT BYTE USE16 00000016 bytes
0000                          memset_:
0000    51                        push        cx 
0001    89 C1                     mov         cx,ax 
0003    89 D8                     mov         ax,bx 
0005    89 CB                     mov         bx,cx 
0007                          L$1:
0007    48                        dec         ax 
0008    3D FF FF                  cmp         ax,0xffff 
000B    74 05                     je          L$2 
000D    88 17                     mov         byte ptr [bx],dl 
000F    43                        inc         bx 
0010    EB F5                     jmp         L$1 
0012                          L$2:
0012    89 C8                     mov         ax,cx 
0014    59                        pop         cx 
0015    C3                        ret         

Routine Size: 22 bytes,    Routine Base: _TEXT + 0000

No disassembly errors

Segment: CONST WORD USE16 00000000 bytes

Segment: CONST2 WORD USE16 00000000 bytes

Segment: _DATA WORD USE16 00000000 bytes

