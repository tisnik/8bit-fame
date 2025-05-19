        .file   "memset.c"
        .intel_syntax noprefix
        .section .text
        .globl  _memset
_memset:
LFB0:
        .cfi_startproc
        push    ebp
        .cfi_def_cfa_offset 8
        .cfi_offset 5, -8
        mov     ebp, esp
        .cfi_def_cfa_register 5
        push    ebx
        .cfi_offset 3, -12
        mov     ecx, DWORD PTR [ebp+16]
        mov     ebx, DWORD PTR [ebp+8]
        jmp     L2
L3:
        mov     eax, ebx
        lea     ebx, [eax+1]
        mov     dl, BYTE PTR [ebp+12]
        mov     BYTE PTR [eax], dl
L2:
        mov     eax, ecx
        lea     ecx, [eax-1]
        test    eax, eax
        jne     L3
        mov     eax, DWORD PTR [ebp+8]
        pop     ebx
        .cfi_restore 3
        pop     ebp
        .cfi_restore 5
        .cfi_def_cfa 4, 4
        ret
        .cfi_endproc
LFE0:
        .ident  "GCC: (GNU) 9.3.0"
