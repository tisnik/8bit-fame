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
        mov     ebp, esp
        .cfi_def_cfa_register 5
        sub     esp, 16
        mov     DWORD PTR [ebp-4], 0
        jmp     L2
L3:
        mov     eax, DWORD PTR [ebp-4]
        lea     edx, [0+eax*4]
        mov     eax, DWORD PTR [ebp+8]
        add     edx, eax
        mov     eax, DWORD PTR [ebp+16]
        mov     DWORD PTR [edx], eax
        inc     DWORD PTR [ebp-4]
L2:
        mov     eax, DWORD PTR [ebp-4]
        cmp     eax, DWORD PTR [ebp+12]
        jl      L3
        nop
        nop
        leave
        .cfi_restore 5
        .cfi_def_cfa 4, 4
        ret
        .cfi_endproc
LFE0:
        .ident  "GCC: (GNU) 9.3.0"
