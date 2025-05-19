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
        mov     edx, DWORD PTR [ebp+8]
        mov     ecx, DWORD PTR [ebp+16]
        add     ecx, edx
        mov     eax, edx
L2:
        cmp     eax, ecx
        je      L6
        inc     eax
        mov     bl, BYTE PTR [ebp+12]
        mov     BYTE PTR [eax-1], bl
        jmp     L2
L6:
        pop     ebx
        .cfi_restore 3
        mov     eax, edx
        pop     ebp
        .cfi_restore 5
        .cfi_def_cfa 4, 4
        ret
        .cfi_endproc
LFE0:
        .ident  "GCC: (GNU) 9.3.0"
