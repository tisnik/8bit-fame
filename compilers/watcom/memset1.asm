Module: C:\memset.c
GROUP: 'DGROUP' CONST,CONST2,_DATA

Segment: _TEXT BYTE USE16 0000001E bytes
0000                          memset_:
0000    50                        push        ax 
0001    B8 04 00                  mov         ax,0x0004 
0004    E8 00 00                  call        __STK 
0007    58                        pop         ax 
0008    51                        push        cx 
0009    89 C1                     mov         cx,ax 
000B    89 D8                     mov         ax,bx 
000D    89 CB                     mov         bx,cx 
000F                          L$1:
000F    48                        dec         ax 
0010    3D FF FF                  cmp         ax,0xffff 
0013    74 05                     je          L$2 
0015    88 17                     mov         byte ptr [bx],dl 
0017    43                        inc         bx 
0018    EB F5                     jmp         L$1 
001A                          L$2:
001A    89 C8                     mov         ax,cx 
001C    59                        pop         cx 
001D    C3                        ret         

Routine Size: 30 bytes,    Routine Base: _TEXT + 0000

No disassembly errors

Segment: CONST WORD USE16 00000000 bytes

Segment: CONST2 WORD USE16 00000000 bytes

Segment: _DATA WORD USE16 00000000 bytes

