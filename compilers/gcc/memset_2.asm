memset:
        test    edx, edx
        je      .L2
        mov     edx, edx
        movzx   esi, sil
        jmp     memset
.L2:
        mov     rax, rdi
        ret
