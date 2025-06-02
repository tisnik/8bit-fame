	ifndef	??version
?debug	macro
	endm
publicdll macro	name
	public	name
	endm
$comm	macro	name,dist,size,count
	comm	dist name:BYTE:count*size
	endm
	else
$comm	macro	name,dist,size,count
	comm	dist name[size]:BYTE:count
	endm
	endif
	?debug	V 300h
	?debug	S "array.c"
	?debug	C E90CAEBE5A0761727261792E63
	?debug	C E900186B171B433A5C424F524C414E44435C494E434C5544455C73+
	?debug	C 7464696F2E68
	?debug	C E900186B171B433A5C424F524C414E44435C494E434C5544455C5F+
	?debug	C 646566732E68
	?debug	C E900186B171B433A5C424F524C414E44435C494E434C5544455C5F+
	?debug	C 6E756C6C2E68
_TEXT	segment byte public 'CODE'
_TEXT	ends
DGROUP	group	_DATA,_BSS
	assume	cs:_TEXT,ds:DGROUP
_DATA	segment word public 'DATA'
d@	label	byte
d@w	label	word
_DATA	ends
_BSS	segment word public 'BSS'
b@	label	byte
b@w	label	word
_BSS	ends
_TEXT	segment byte public 'CODE'
   ;	
   ;	int main(void) {
   ;	
	assume	cs:_TEXT
_main	proc	near
	push	bp
	mov	bp,sp
	sub	sp,8
   ;	
   ;	#define LENGTH 100000
   ;	    long i;
   ;	    unsigned char *array = (unsigned char*)farmalloc(LENGTH);
   ;	
	mov	ax,1
	mov	dx,34464
	push	ax
	push	dx
	call	near ptr _farmalloc
	pop	cx
	pop	cx
	cwd	
	mov	word ptr [bp-6],dx
	mov	word ptr [bp-8],ax
   ;	
   ;	    for (i=0; i<LENGTH; i++) {
   ;	
	mov	word ptr [bp-2],0
	mov	word ptr [bp-4],0
	jmp	short @1@114
@1@58:
   ;	
   ;		array[i] = 0;
   ;	
	les	bx,dword ptr [bp-8]
	add	bx,word ptr [bp-4]
	mov	byte ptr es:[bx],0
	add	word ptr [bp-4],1
	adc	word ptr [bp-2],0
@1@114:
	cmp	word ptr [bp-2],1
	jl	short @1@58
	jne	short @1@198
	cmp	word ptr [bp-4],34464
	jb	short @1@58
@1@198:
   ;	
   ;	    }
   ;	    return 0;
   ;	
	xor	ax,ax
	jmp	short @1@226
@1@226:
   ;	
   ;	}
   ;	
	mov	sp,bp
	pop	bp
	ret	
_main	endp
	?debug	C E9
	?debug	C FA00000000
_TEXT	ends
_DATA	segment word public 'DATA'
s@	label	byte
_DATA	ends
_TEXT	segment byte public 'CODE'
_TEXT	ends
	extrn	_farmalloc:near
	public	_main
_s@	equ	s@
	end
