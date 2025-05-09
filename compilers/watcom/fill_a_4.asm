Module: C:\fill_a.c
GROUP: 'DGROUP' CONST,CONST2,_DATA

Segment: _TEXT BYTE USE32 00000013 bytes
0000                          fill_array_:
0000    51                        push        ecx 
0001    89 D1                     mov         ecx,edx 
0003    31 D2                     xor         edx,edx 
0005                          L$1:
0005    39 CA                     cmp         edx,ecx 
0007    7D 08                     jge         L$2 
0009    42                        inc         edx 
000A    89 18                     mov         dword ptr [eax],ebx 
000C    83 C0 04                  add         eax,0x00000004 
000F    EB F4                     jmp         L$1 
0011                          L$2:
0011    59                        pop         ecx 
0012    C3                        ret         

Routine Size: 19 bytes,    Routine Base: _TEXT + 0000

No disassembly errors

Segment: CONST DWORD USE32 00000000 bytes

Segment: CONST2 DWORD USE32 00000000 bytes

Segment: _DATA DWORD USE32 00000000 bytes

