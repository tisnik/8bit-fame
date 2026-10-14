; Imported symbols

; Exported symbols
	.export bytecode_start

	.include "target.inc"

; TOKENS:
	.importzp	TOK_1
	.importzp	TOK_ADD_VAR
	.importzp	TOK_BYTE
	.importzp	TOK_BYTE_PUT
	.importzp	TOK_END
	.importzp	TOK_INT_STR
	.importzp	TOK_PRINT_STR
	.importzp	TOK_VAR_LOAD
	.importzp	TOK_VAR_STORE
;-----------------------------
; Macro to get variable ID from name
	.import __HEAP_RUN__
.macro makevar name
	.byte <((.ident (.concat ("fb_var_", name)) - __HEAP_RUN__)/2)
.endmacro
; Variables
	.segment "HEAP"
	.export fb_var_X
fb_var_X:	.res 2	; word variable
	.export fb_var_Y
fb_var_Y:	.res 2	; word variable
	.export fb_var_Z
fb_var_Z:	.res 2	; word variable
;-----------------------------
; Bytecode
	.segment "BYTECODE"
bytecode_start:
@FastBasic_LINE_1:	; LINE 1
	.byte	TOK_1
	.byte	TOK_VAR_STORE
	makevar	"X"
@FastBasic_LINE_2:	; LINE 2
	.byte	TOK_BYTE
	.byte	2
	.byte	TOK_VAR_STORE
	makevar	"Y"
@FastBasic_LINE_3:	; LINE 3
	.byte	TOK_VAR_LOAD
	makevar	"X"
	.byte	TOK_ADD_VAR
	makevar	"Y"
	.byte	TOK_VAR_STORE
	makevar	"Z"
@FastBasic_LINE_4:	; LINE 4
	.byte	TOK_VAR_LOAD
	makevar	"Z"
	.byte	TOK_INT_STR
	.byte	TOK_PRINT_STR
	.byte	TOK_BYTE_PUT
	.byte	155
	.byte	TOK_END
