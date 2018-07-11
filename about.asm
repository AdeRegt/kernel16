bits 16

org 0x5000
; glb main : () void
section .text
	global	_main
_main:
	push	bp
	mov	bp, sp
	;sub	sp,          0

section .rodata
L3:
	db	"About SanderOS"
	times	1 db 0

section .text

section .rodata
L4:
	db	"Press any key to continue"
	times	1 db 0

section .text
; RPN'ized expression: "( L4 , L3 setTitle ) "
; Expanded expression: " L4  L3  setTitle ()4 "
; Fused expression:    "( L4 , L3 , setTitle )4 "
	push	L4
	push	L3
	call	_setTitle
	sub	sp, -4

section .rodata
L5:
	db	"Created by:",10,13,"Sander",10,13,"Daniel"
	times	1 db 0

section .text
; RPN'ized expression: "( L5 printf ) "
; Expanded expression: " L5  printf ()2 "
; Fused expression:    "( L5 , printf )2 "
	push	L5
	call	_printf
	sub	sp, -2
; RPN'ized expression: "( getc ) "
; Expanded expression: " getc ()0 "
; Fused expression:    "( getc )0 "
	call	_getc
; Fused expression:    "0  "
	mov	ax, 0
L1:
	leave
	ret

; glb setTitle : (
; prm     a : * char
; prm     b : * char
;     ) void
section .text
	global	_setTitle
_setTitle:
	push	bp
	mov	bp, sp
	 sub	sp,          4
; loc     a : (@4) : * char
; loc     b : (@6) : * char
; loc     func : (
; prm         a : * char
; prm         b : * char
;         ) int
; loc     f : (@-2) : * (
; prm         a : * char
; prm         b : * char
;         ) int
; loc     <something> : * (
; prm         a : * char
; prm         b : * char
;         ) int
; RPN'ized expression: "f 30 (something8) = "
; Expanded expression: "(@-2) 30 =(2) "
; Fused expression:    "=(170) *(@-2) 30 "
	mov	ax, 30
	mov	[bp-2], ax
; loc     v : (@-4) : int
; RPN'ized expression: "v ( b , a f ) = "
; Expanded expression: "(@-4)  (@6) *(2)  (@4) *(2)  (@-2) *(2) ()4 =(2) "
; Fused expression:    "( *(2) (@6) , *(2) (@4) , *(2) (@-2) )4 =(170) *(@-4) ax "
	push	word [bp+6]
	push	word [bp+4]
	mov	ax, [bp-2]
	call	ax
	sub	sp, -4
	mov	[bp-4], ax
L6:
	leave
	ret

; glb printf : (
; prm     a : * char
;     ) void
section .text
	global	_printf
_printf:
	push	bp
	mov	bp, sp
	 sub	sp,          4
; loc     a : (@4) : * char
; loc     func : (
; prm         a : * char
;         ) int
; loc     f : (@-2) : * (
; prm         a : * char
;         ) int
; loc     <something> : * (
; prm         a : * char
;         ) int
; RPN'ized expression: "f 3 (something11) = "
; Expanded expression: "(@-2) 3 =(2) "
; Fused expression:    "=(170) *(@-2) 3 "
	mov	ax, 3
	mov	[bp-2], ax
; loc     v : (@-4) : int
; RPN'ized expression: "v ( a f ) = "
; Expanded expression: "(@-4)  (@4) *(2)  (@-2) *(2) ()2 =(2) "
; Fused expression:    "( *(2) (@4) , *(2) (@-2) )2 =(170) *(@-4) ax "
	push	word [bp+4]
	mov	ax, [bp-2]
	call	ax
	sub	sp, -2
	mov	[bp-4], ax
L9:
	leave
	ret

; glb getc : () char
section .text
	global	_getc
_getc:
	push	bp
	mov	bp, sp
	 sub	sp,          2
; loc     func : () char
; loc     f : (@-2) : * () char
; loc     <something> : * () char
; RPN'ized expression: "f 39 (something14) = "
; Expanded expression: "(@-2) 39 =(2) "
; Fused expression:    "=(170) *(@-2) 39 "
	mov	ax, 39
	mov	[bp-2], ax
; return
; RPN'ized expression: "( f ) "
; Expanded expression: " (@-2) *(2) ()0 "
; Fused expression:    "( *(2) (@-2) )0  "
	mov	ax, [bp-2]
	call	ax
L12:
	leave
	ret



; Syntax/declaration table/stack:
; Bytes used: 175/15360


; Macro table:
; Macro __SMALLER_C__ = `0x0100`
; Macro __SMALLER_C_16__ = ``
; Macro __SMALLER_C_SCHAR__ = ``
; Bytes used: 63/5120


; Identifier table:
; Ident 
; Ident __floatsisf
; Ident __floatunsisf
; Ident __fixsfsi
; Ident __fixunssfsi
; Ident __addsf3
; Ident __subsf3
; Ident __negsf2
; Ident __mulsf3
; Ident __divsf3
; Ident __lesf2
; Ident __gesf2
; Ident main
; Ident setTitle
; Ident a
; Ident b
; Ident printf
; Ident getc
; Bytes used: 159/5632

; Next label number: 15
; Compilation succeeded.
