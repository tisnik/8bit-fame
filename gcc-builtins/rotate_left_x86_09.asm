rotate_left_8bit:
        mov     eax, edi
        mov     ecx, esi
        ror     al, cl
        ret

rotate_left_16bit:
        mov     eax, edi
        mov     ecx, esi
        ror     ax, cl
        ret

rotate_left_32bit:
        mov     eax, edi
        mov     ecx, esi
        ror     eax, cl
        ret

rotate_left_64bit:
        mov     rax, rdi
        mov     ecx, esi
        ror     rax, cl
        ret
