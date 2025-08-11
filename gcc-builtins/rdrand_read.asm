        .file   "rdrand_read.c"
        .intel_syntax noprefix
        .text
        .section        .rodata.str1.1,"aMS",@progbits,1
.LC0:
        .string "%d %x\n"
        .text
        .globl  main
        .type   main, @function
main:
.LFB11:
        .cfi_startproc
        push    rbx
        .cfi_def_cfa_offset 16
        .cfi_offset 3, -16
        sub     rsp, 16
        .cfi_def_cfa_offset 32
        mov     ebx, 0
        jmp     .L2
.L3:
        rdrand  esi
        mov     DWORD PTR [rsp+12], esi
        mov     eax, 1
        cmovc   esi, eax
        mov     edx, DWORD PTR [rsp+12]
        mov     edi, OFFSET FLAT:.LC0
        mov     eax, 0
        call    printf
        add     ebx, 1
.L2:
        cmp     ebx, 9
        jle     .L3
        mov     eax, 1
        add     rsp, 16
        .cfi_def_cfa_offset 16
        pop     rbx
        .cfi_def_cfa_offset 8
        ret
        .cfi_endproc
.LFE11:
        .size   main, .-main
        .ident  "GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
        .section        .note.GNU-stack,"",@progbits
