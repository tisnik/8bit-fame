        .file   "add_overflow.c"
        .intel_syntax noprefix
        .text
        .globl  add_overflow_signed_char
        .type   add_overflow_signed_char, @function
add_overflow_signed_char:
.LFB0:
        .cfi_startproc
        add     dil, sil
        seto    al
        ret
        .cfi_endproc
.LFE0:
        .size   add_overflow_signed_char, .-add_overflow_signed_char
        .globl  add_overflow_unsigned_char
        .type   add_overflow_unsigned_char, @function
add_overflow_unsigned_char:
.LFB1:
        .cfi_startproc
        add     sil, dil
        setc    al
        ret
        .cfi_endproc
.LFE1:
        .size   add_overflow_unsigned_char, .-add_overflow_unsigned_char
        .globl  add_overflow_signed_short
        .type   add_overflow_signed_short, @function
add_overflow_signed_short:
.LFB2:
        .cfi_startproc
        add     di, si
        seto    al
        ret
        .cfi_endproc
.LFE2:
        .size   add_overflow_signed_short, .-add_overflow_signed_short
        .globl  add_overflow_unsigned_short
        .type   add_overflow_unsigned_short, @function
add_overflow_unsigned_short:
.LFB3:
        .cfi_startproc
        add     si, di
        setc    al
        ret
        .cfi_endproc
.LFE3:
        .size   add_overflow_unsigned_short, .-add_overflow_unsigned_short
        .globl  add_overflow_signed_int
        .type   add_overflow_signed_int, @function
add_overflow_signed_int:
.LFB4:
        .cfi_startproc
        add     edi, esi
        seto    al
        ret
        .cfi_endproc
.LFE4:
        .size   add_overflow_signed_int, .-add_overflow_signed_int
        .globl  add_overflow_unsigned_int
        .type   add_overflow_unsigned_int, @function
add_overflow_unsigned_int:
.LFB5:
        .cfi_startproc
        add     edi, esi
        setc    al
        ret
        .cfi_endproc
.LFE5:
        .size   add_overflow_unsigned_int, .-add_overflow_unsigned_int
        .globl  add_overflow_signed_long
        .type   add_overflow_signed_long, @function
add_overflow_signed_long:
.LFB6:
        .cfi_startproc
        add     rdi, rsi
        seto    al
        ret
        .cfi_endproc
.LFE6:
        .size   add_overflow_signed_long, .-add_overflow_signed_long
        .globl  add_overflow_unsigned_long
        .type   add_overflow_unsigned_long, @function
add_overflow_unsigned_long:
.LFB7:
        .cfi_startproc
        add     rdi, rsi
        setc    al
        ret
        .cfi_endproc
.LFE7:
        .size   add_overflow_unsigned_long, .-add_overflow_unsigned_long
        .ident  "GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
        .section        .note.GNU-stack,"",@progbits
