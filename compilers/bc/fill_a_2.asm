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
        ?debug  S "c:\fill_a.c"
        ?debug  C E9897EA85A0B633A5C66696C6C5F612E63
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
   ;    void fill_array(int *array, int size, int value) {
   ;    
        assume  cs:_TEXT
_fill_array     proc    near
        push    bp
        mov     bp,sp
        push    si
        push    di
        mov     di,word ptr [bp+4]
        mov     dx,word ptr [bp+6]
        mov     cx,word ptr [bp+8]
   ;    
   ;        int i;
   ;        for (i=0; i<size; i++) {
   ;    
        xor     si,si
        jmp     short @1@98
@1@50:
   ;    
   ;            array[i] = value;
   ;    
        mov     bx,si
        shl     bx,1
        mov     ax,cx
        mov     word ptr [bx+di],ax
        inc     si
@1@98:
        cmp     si,dx
        jl      short @1@50
   ;    
   ;        }
   ;    }
   ;    
        pop     di
        pop     si
        pop     bp
        ret     
_fill_array     endp
        ?debug  C E9
_TEXT   ends
_DATA   segment word public 'DATA'
s@      label   byte
_DATA   ends
_TEXT   segment byte public 'CODE'
_TEXT   ends
        public  _fill_array
        end
