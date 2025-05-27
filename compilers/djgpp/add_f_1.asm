        .file   "add_f.c"
        .intel_syntax noprefix
        .section .text
        .globl  _add
_add:
LFB0:
        .cfi_startproc
        push    ebp
        .cfi_def_cfa_offset 8
        .cfi_offset 5, -8
        mov     ebp, esp
        .cfi_def_cfa_register 5
        fld     DWORD PTR [ebp+8]
        fadd    DWORD PTR [ebp+12]
        pop     ebp
        .cfi_restore 5
        .cfi_def_cfa 4, 4
        ret
        .cfi_endproc
LFE0:
        .ident  "GCC: (GNU) 9.3.0"
