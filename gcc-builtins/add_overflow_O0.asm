        .file   "add_overflow.c"
        .intel_syntax noprefix
        .text
        .globl  add_overflow_signed_char
        .type   add_overflow_signed_char, @function
add_overflow_signed_char:
.LFB0:
        .cfi_startproc
        push    rbp
        .cfi_def_cfa_offset 16
        .cfi_offset 6, -16
        mov     rbp, rsp
        .cfi_def_cfa_register 6
        mov     edx, edi
        mov     eax, esi
        mov     BYTE PTR [rbp-20], dl
        mov     BYTE PTR [rbp-24], al
        movsx   edx, BYTE PTR [rbp-20]
        movsx   eax, BYTE PTR [rbp-24]
        mov     ecx, 0
        add     al, dl
        jno     .L2
        mov     ecx, 1
.L2:
        mov     BYTE PTR [rbp-2], al
        mov     eax, ecx
        and     eax, 1
        mov     BYTE PTR [rbp-1], al
        movzx   eax, BYTE PTR [rbp-1]
        pop     rbp
        .cfi_def_cfa 7, 8
        ret
        .cfi_endproc
.LFE0:
        .size   add_overflow_signed_char, .-add_overflow_signed_char
        .globl  add_overflow_unsigned_char
        .type   add_overflow_unsigned_char, @function
add_overflow_unsigned_char:
.LFB1:
        .cfi_startproc
        push    rbp
        .cfi_def_cfa_offset 16
        .cfi_offset 6, -16
        mov     rbp, rsp
        .cfi_def_cfa_register 6
        mov     edx, edi
        mov     eax, esi
        mov     BYTE PTR [rbp-20], dl
        mov     BYTE PTR [rbp-24], al
        movzx   eax, BYTE PTR [rbp-20]
        movzx   edx, BYTE PTR [rbp-24]
        mov     ecx, 0
        add     al, dl
        jnc     .L6
        mov     ecx, 1
.L6:
        mov     BYTE PTR [rbp-2], al
        mov     eax, ecx
        and     eax, 1
        mov     BYTE PTR [rbp-1], al
        movzx   eax, BYTE PTR [rbp-1]
        pop     rbp
        .cfi_def_cfa 7, 8
        ret
        .cfi_endproc
.LFE1:
        .size   add_overflow_unsigned_char, .-add_overflow_unsigned_char
        .globl  add_overflow_signed_short
        .type   add_overflow_signed_short, @function
add_overflow_signed_short:
.LFB2:
        .cfi_startproc
        push    rbp
        .cfi_def_cfa_offset 16
        .cfi_offset 6, -16
        mov     rbp, rsp
        .cfi_def_cfa_register 6
        mov     edx, edi
        mov     eax, esi
        mov     WORD PTR [rbp-20], dx
        mov     WORD PTR [rbp-24], ax
        movsx   edx, WORD PTR [rbp-20]
        movsx   eax, WORD PTR [rbp-24]
        mov     ecx, 0
        add     ax, dx
        jno     .L10
        mov     ecx, 1
.L10:
        mov     WORD PTR [rbp-4], ax
        mov     eax, ecx
        mov     BYTE PTR [rbp-1], al
        and     BYTE PTR [rbp-1], 1
        movzx   eax, BYTE PTR [rbp-1]
        pop     rbp
        .cfi_def_cfa 7, 8
        ret
        .cfi_endproc
.LFE2:
        .size   add_overflow_signed_short, .-add_overflow_signed_short
        .globl  add_overflow_unsigned_short
        .type   add_overflow_unsigned_short, @function
add_overflow_unsigned_short:
.LFB3:
        .cfi_startproc
        push    rbp
        .cfi_def_cfa_offset 16
        .cfi_offset 6, -16
        mov     rbp, rsp
        .cfi_def_cfa_register 6
        mov     edx, edi
        mov     eax, esi
        mov     WORD PTR [rbp-20], dx
        mov     WORD PTR [rbp-24], ax
        movzx   eax, WORD PTR [rbp-20]
        movzx   edx, WORD PTR [rbp-24]
        mov     ecx, 0
        add     ax, dx
        jnc     .L14
        mov     ecx, 1
.L14:
        mov     WORD PTR [rbp-4], ax
        mov     eax, ecx
        mov     BYTE PTR [rbp-1], al
        and     BYTE PTR [rbp-1], 1
        movzx   eax, BYTE PTR [rbp-1]
        pop     rbp
        .cfi_def_cfa 7, 8
        ret
        .cfi_endproc
.LFE3:
        .size   add_overflow_unsigned_short, .-add_overflow_unsigned_short
        .globl  add_overflow_signed_int
        .type   add_overflow_signed_int, @function
add_overflow_signed_int:
.LFB4:
        .cfi_startproc
        push    rbp
        .cfi_def_cfa_offset 16
        .cfi_offset 6, -16
        mov     rbp, rsp
        .cfi_def_cfa_register 6
        mov     DWORD PTR [rbp-20], edi
        mov     DWORD PTR [rbp-24], esi
        mov     ecx, 0
        mov     edx, DWORD PTR [rbp-20]
        mov     eax, DWORD PTR [rbp-24]
        add     eax, edx
        jno     .L18
        mov     ecx, 1
.L18:
        mov     DWORD PTR [rbp-8], eax
        mov     eax, ecx
        mov     BYTE PTR [rbp-1], al
        and     BYTE PTR [rbp-1], 1
        movzx   eax, BYTE PTR [rbp-1]
        pop     rbp
        .cfi_def_cfa 7, 8
        ret
        .cfi_endproc
.LFE4:
        .size   add_overflow_signed_int, .-add_overflow_signed_int
        .globl  add_overflow_unsigned_int
        .type   add_overflow_unsigned_int, @function
add_overflow_unsigned_int:
.LFB5:
        .cfi_startproc
        push    rbp
        .cfi_def_cfa_offset 16
        .cfi_offset 6, -16
        mov     rbp, rsp
        .cfi_def_cfa_register 6
        mov     DWORD PTR [rbp-20], edi
        mov     DWORD PTR [rbp-24], esi
        mov     ecx, 0
        mov     eax, DWORD PTR [rbp-20]
        mov     edx, DWORD PTR [rbp-24]
        add     eax, edx
        jnc     .L22
        mov     ecx, 1
.L22:
        mov     DWORD PTR [rbp-8], eax
        mov     eax, ecx
        mov     BYTE PTR [rbp-1], al
        and     BYTE PTR [rbp-1], 1
        movzx   eax, BYTE PTR [rbp-1]
        pop     rbp
        .cfi_def_cfa 7, 8
        ret
        .cfi_endproc
.LFE5:
        .size   add_overflow_unsigned_int, .-add_overflow_unsigned_int
        .globl  add_overflow_signed_long
        .type   add_overflow_signed_long, @function
add_overflow_signed_long:
.LFB6:
        .cfi_startproc
        push    rbp
        .cfi_def_cfa_offset 16
        .cfi_offset 6, -16
        mov     rbp, rsp
        .cfi_def_cfa_register 6
        mov     QWORD PTR [rbp-24], rdi
        mov     QWORD PTR [rbp-32], rsi
        mov     ecx, 0
        mov     rdx, QWORD PTR [rbp-24]
        mov     rax, QWORD PTR [rbp-32]
        add     rax, rdx
        jno     .L26
        mov     ecx, 1
.L26:
        mov     QWORD PTR [rbp-16], rax
        mov     rax, rcx
        mov     BYTE PTR [rbp-1], al
        and     BYTE PTR [rbp-1], 1
        movzx   eax, BYTE PTR [rbp-1]
        pop     rbp
        .cfi_def_cfa 7, 8
        ret
        .cfi_endproc
.LFE6:
        .size   add_overflow_signed_long, .-add_overflow_signed_long
        .globl  add_overflow_unsigned_long
        .type   add_overflow_unsigned_long, @function
add_overflow_unsigned_long:
.LFB7:
        .cfi_startproc
        push    rbp
        .cfi_def_cfa_offset 16
        .cfi_offset 6, -16
        mov     rbp, rsp
        .cfi_def_cfa_register 6
        mov     QWORD PTR [rbp-24], rdi
        mov     QWORD PTR [rbp-32], rsi
        mov     ecx, 0
        mov     rax, QWORD PTR [rbp-24]
        mov     rdx, QWORD PTR [rbp-32]
        add     rax, rdx
        jnc     .L30
        mov     ecx, 1
.L30:
        mov     QWORD PTR [rbp-16], rax
        mov     rax, rcx
        mov     BYTE PTR [rbp-1], al
        and     BYTE PTR [rbp-1], 1
        movzx   eax, BYTE PTR [rbp-1]
        pop     rbp
        .cfi_def_cfa 7, 8
        ret
        .cfi_endproc
.LFE7:
        .size   add_overflow_unsigned_long, .-add_overflow_unsigned_long
        .ident  "GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
        .section        .note.GNU-stack,"",@progbits
