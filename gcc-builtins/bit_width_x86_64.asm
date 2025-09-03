bit_width_8bit:
        xor     eax, eax
        and     edi, 255
        je      .L1
        bsr     edi, edi
        lea     eax, [rdi+1]
.L1:
        ret

bit_width_16bit:
        xor     eax, eax
        and     edi, 65535
        je      .L6
        bsr     edi, edi
        lea     eax, [rdi+1]
.L6:
        ret

bit_width_32bit:
        bsr     eax, edi
        xor     edx, edx
        add     eax, 1
        test    edi, edi
        cmove   eax, edx
        ret

bit_width_64bit:
        bsr     rax, rdi
        xor     edx, edx
        add     eax, 1
        test    rdi, rdi
        cmove   eax, edx
        ret
