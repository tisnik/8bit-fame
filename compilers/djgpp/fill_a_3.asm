        .file   "fill_a.c"
        .intel_syntax noprefix
        .section .text
        .globl  _fill_array
_fill_array:
LFB0:
        .cfi_startproc
        push    ebp
        .cfi_def_cfa_offset 8
        .cfi_offset 5, -8
        xor     eax, eax
        mov     ebp, esp
        .cfi_def_cfa_register 5
        mov     edx, DWORD PTR [ebp+8]
        mov     ecx, DWORD PTR [ebp+16]
L2:
        cmp     eax, DWORD PTR [ebp+12]
        jge     L6
        mov     DWORD PTR [edx+eax*4], ecx
        inc     eax
        jmp     L2
L6:
        pop     ebp
        .cfi_restore 5
        .cfi_def_cfa 4, 4
        ret
        .cfi_endproc
LFE0:
        .ident  "GCC: (GNU) 9.3.0"
