find_max:
        mov     rcx, rdi
        test    esi, esi
        je      .L7
        lea     eax, [rsi-1]
        cmp     eax, 5
        jbe     .L8
        mov     edx, esi
        pcmpeqd xmm3, xmm3
        pxor    xmm2, xmm2
        mov     rax, rdi
        shr     edx, 2
        pslld   xmm3, 31
        sal     rdx, 4
        add     rdx, rdi
.L4:
        movdqu  xmm1, XMMWORD PTR [rax]
        movdqa  xmm4, xmm2
        add     rax, 16
        psubd   xmm4, xmm3
        movdqa  xmm0, xmm1
        psubd   xmm0, xmm3
        pcmpgtd xmm0, xmm4
        pand    xmm1, xmm0
        pandn   xmm0, xmm2
        movdqa  xmm2, xmm0
        por     xmm2, xmm1
        cmp     rax, rdx
        jne     .L4
        movdqa  xmm1, xmm2
        movdqa  xmm4, xmm2
        psrldq  xmm1, 8
        psubd   xmm4, xmm3
        movdqa  xmm0, xmm1
        psubd   xmm0, xmm3
        pcmpgtd xmm0, xmm4
        pand    xmm1, xmm0
        pandn   xmm0, xmm2
        por     xmm0, xmm1
        movdqa  xmm2, xmm0
        movdqa  xmm4, xmm0
        psrldq  xmm2, 4
        psubd   xmm4, xmm3
        movdqa  xmm1, xmm2
        psubd   xmm1, xmm3
        pcmpgtd xmm1, xmm4
        pand    xmm2, xmm1
        pandn   xmm1, xmm0
        por     xmm1, xmm2
        movd    eax, xmm1
        test    sil, 3
        je      .L1
        mov     edx, esi
        and     edx, -4
        mov     edi, edx
        lea     rcx, [rcx+rdi*4]
.L3:
        mov     edi, DWORD PTR [rcx]
        cmp     eax, edi
        cmovb   eax, edi
        lea     edi, [rdx+1]
        cmp     edi, esi
        jnb     .L1
        mov     edi, DWORD PTR [rcx+4]
        cmp     eax, edi
        cmovb   eax, edi
        lea     edi, [rdx+2]
        cmp     edi, esi
        jnb     .L1
        mov     edi, DWORD PTR [rcx+8]
        cmp     eax, edi
        cmovb   eax, edi
        lea     edi, [rdx+3]
        cmp     edi, esi
        jnb     .L1
        mov     edi, DWORD PTR [rcx+12]
        cmp     eax, edi
        cmovb   eax, edi
        lea     edi, [rdx+4]
        cmp     edi, esi
        jnb     .L1
        mov     edi, DWORD PTR [rcx+16]
        cmp     eax, edi
        cmovb   eax, edi
        add     edx, 5
        cmp     edx, esi
        jnb     .L1
        mov     edx, DWORD PTR [rcx+20]
        cmp     eax, edx
        cmovb   eax, edx
        ret
.L7:
        xor     eax, eax
.L1:
        ret
.L8:
        xor     edx, edx
        xor     eax, eax
        jmp     .L3
