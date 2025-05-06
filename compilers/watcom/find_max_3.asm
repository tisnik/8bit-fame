Module: C:\find_max.c
GROUP: 'DGROUP' CONST,CONST2,_DATA

Segment: _TEXT PARA USE32 00000023 bytes
0000                          find_max_:
0000    53                        push        ebx 
0001    51                        push        ecx 
0002    56                        push        esi 
0003    89 D3                     mov         ebx,edx 
0005    31 C9                     xor         ecx,ecx 
0007    31 D2                     xor         edx,edx 
0009    85 DB                     test        ebx,ebx 
000B    76 10                     jbe         L$3 
000D                          L$1:
000D    8B 30                     mov         esi,dword ptr [eax] 
000F    39 F1                     cmp         ecx,esi 
0011    73 02                     jae         L$2 
0013    89 F1                     mov         ecx,esi 
0015                          L$2:
0015    42                        inc         edx 
0016    83 C0 04                  add         eax,0x00000004 
0019    39 DA                     cmp         edx,ebx 
001B    72 F0                     jb          L$1 
001D                          L$3:
001D    89 C8                     mov         eax,ecx 
001F    5E                        pop         esi 
0020    59                        pop         ecx 
0021    5B                        pop         ebx 
0022    C3                        ret         

Routine Size: 35 bytes,    Routine Base: _TEXT + 0000

No disassembly errors

Segment: CONST DWORD USE32 00000000 bytes

Segment: CONST2 DWORD USE32 00000000 bytes

Segment: _DATA DWORD USE32 00000000 bytes

