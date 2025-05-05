        ifndef  ??version
?debug  macro
        endm
publicdll macro name
        public  name
        endm
$comm   macro   name,dist,size,count
        comm    dist name:BYTE:count*size
        endm
        else
$comm   macro   name,dist,size,count
        comm    dist name[size]:BYTE:count
        endm
        endif
        ?debug  S "memset.c"
        ?debug  C E98F9AA15A086D656D7365742E63
_TEXT   segment byte public 'CODE'
_TEXT   ends
DGROUP  group   _DATA,_BSS
        assume  cs:_TEXT,ds:DGROUP
_DATA   segment word public 'DATA'
d@      label   byte
d@w     label   word
_DATA   ends
_BSS    segment word public 'BSS'
b@      label   byte
b@w     label   word
_BSS    ends
_TEXT   segment byte public 'CODE'
   ;    
   ;    void * memset(void *dest, register int val, register size_t len) {
   ;    
        assume  cs:_TEXT
memset  proc    near
        push    bp
        mov     bp,sp
        push    si
        push    di
        mov     bx,word ptr [bp+4]
        mov     dx,word ptr [bp+6]
        mov     di,word ptr [bp+8]
   ;    
   ;        register unsigned char *ptr = (unsigned char*)dest;
   ;    
        mov     si,bx
        jmp     short @1@74
@1@50:
   ;    
   ;        while (len-- > 0)
   ;            *ptr++ = val;
   ;    
        mov     al,dl
        mov     byte ptr [si],al
        inc     si
@1@74:
        mov     ax,di
        dec     di
        or      ax,ax
        ja      short @1@50
   ;    
   ;        return dest;
   ;    
        mov     ax,bx
   ;    
   ;    }
   ;    
        pop     di
        pop     si
        pop     bp
        ret     
memset  endp
        ?debug  C E9
_TEXT   ends
_DATA   segment word public 'DATA'
s@      label   byte
_DATA   ends
_TEXT   segment byte public 'CODE'
_TEXT   ends
        public  memset
        end
