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
        ?debug  S "c:\add_f.c"
        ?debug  C E9ACA6AF5A0A633A5C6164645F662E63
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
   ;    float add(float x, float y) {
   ;    
        assume  cs:_TEXT
_add    proc    near
        push    bp
        mov     bp,sp
   ;    
   ;        return x+y;
   ;    
        fld     dword ptr [bp+4]
        fadd    dword ptr [bp+8]
        jmp     short @1@50
@1@50:
   ;    
   ;    }
   ;    
        pop     bp
        ret     
_add    endp
        ?debug  C E9
_TEXT   ends
_DATA   segment word public 'DATA'
s@      label   byte
_DATA   ends
_TEXT   segment byte public 'CODE'
_TEXT   ends
        public  _add
        end
