rotate_left_8bit:
        mov     eax, edi
        mov     ecx, esi
        rol     al, cl
        ret

rotate_left_16bit:
        mov     eax, edi
        mov     ecx, esi
        rol     ax, cl
        ret

rotate_left_32bit:
        mov     eax, edi
        mov     ecx, esi
        rol     eax, cl
        ret

rotate_left_64bit:
        mov     rax, rdi
        mov     ecx, esi
        rol     rax, cl
        ret
