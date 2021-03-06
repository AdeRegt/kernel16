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

; glb printf : (
; prm     a : * char
;     ) void
section .text
	global	_printf
_printf:
	push	bp
	mov	bp, sp
	 sub	sp,          2
; loc     a : (@4) : * char
; loc     func : (
; prm         a : * char
;         ) void
; loc     f : (@-2) : * (
; prm         a : * char
;         ) void
; loc     <something> : * (
; prm         a : * char
;         ) void
; RPN'ized expression: "f 3 (something8) = "
; Expanded expression: "(@-2) 3 =(2) "
; Fused expression:    "=(170) *(@-2) 3 "
	mov	ax, 3
	mov	[bp-2], ax
; RPN'ized expression: "( a f ) "
; Expanded expression: " (@4) *(2)  (@-2) *(2) ()2 "
; Fused expression:    "( *(2) (@4) , *(2) (@-2) )2 "
	push	word [bp+4]
	mov	ax, [bp-2]
	call	ax
	sub	sp, -2
L6:
	leave
	ret

; glb putc : (
; prm     a : char
;     ) void
section .text
	global	_putc
_putc:
	push	bp
	mov	bp, sp
	 sub	sp,          2
; loc     a : (@4) : char
; loc     func : (
; prm         a : char
;         ) void
; loc     f : (@-2) : * (
; prm         a : char
;         ) void
; loc     <something> : * (
; prm         a : char
;         ) void
; RPN'ized expression: "f 6 (something11) = "
; Expanded expression: "(@-2) 6 =(2) "
; Fused expression:    "=(170) *(@-2) 6 "
	mov	ax, 6
	mov	[bp-2], ax
; RPN'ized expression: "( a f ) "
; Expanded expression: " (@4) *(-1)  (@-2) *(2) ()2 "
; Fused expression:    "( *(-1) (@4) , *(2) (@-2) )2 "
	mov	al, [bp+4]
	cbw
	push	ax
	mov	ax, [bp-2]
	call	ax
	sub	sp, -2
L9:
	leave
	ret

; glb curpos : (
; prm     a : char
; prm     b : char
;     ) void
section .text
	global	_curpos
_curpos:
	push	bp
	mov	bp, sp
	 sub	sp,          4
; loc     a : (@4) : char
; loc     b : (@6) : char
; loc     func : (
; prm         a : char
; prm         b : char
;         ) int
; loc     f : (@-2) : * (
; prm         a : char
; prm         b : char
;         ) int
; loc     <something> : * (
; prm         a : char
; prm         b : char
;         ) int
; RPN'ized expression: "f 9 (something14) = "
; Expanded expression: "(@-2) 9 =(2) "
; Fused expression:    "=(170) *(@-2) 9 "
	mov	ax, 9
	mov	[bp-2], ax
; loc     v : (@-4) : int
; RPN'ized expression: "v ( b , a f ) = "
; Expanded expression: "(@-4)  (@6) *(-1)  (@4) *(-1)  (@-2) *(2) ()4 =(2) "
; Fused expression:    "( *(-1) (@6) , *(-1) (@4) , *(2) (@-2) )4 =(170) *(@-4) ax "
	mov	al, [bp+6]
	cbw
	push	ax
	mov	al, [bp+4]
	cbw
	push	ax
	mov	ax, [bp-2]
	call	ax
	sub	sp, -4
	mov	[bp-4], ax
L12:
	leave
	ret

; glb cls : () char
section .text
	global	_cls
_cls:
	push	bp
	mov	bp, sp
	 sub	sp,          2
; loc     func : () char
; loc     f : (@-2) : * () char
; loc     <something> : * () char
; RPN'ized expression: "f 12 (something17) = "
; Expanded expression: "(@-2) 12 =(2) "
; Fused expression:    "=(170) *(@-2) 12 "
	mov	ax, 12
	mov	[bp-2], ax
; return
; RPN'ized expression: "( f ) "
; Expanded expression: " (@-2) *(2) ()0 "
; Fused expression:    "( *(2) (@-2) )0  "
	mov	ax, [bp-2]
	call	ax
L15:
	leave
	ret

; glb fexists : (
; prm     a : * char
;     ) char
section .text
	global	_fexists
_fexists:
	push	bp
	mov	bp, sp
	 sub	sp,          2
; loc     a : (@4) : * char
; loc     func : (
; prm         a : * char
;         ) char
; loc     f : (@-2) : * (
; prm         a : * char
;         ) char
; loc     <something> : * (
; prm         a : * char
;         ) char
; RPN'ized expression: "f 15 (something20) = "
; Expanded expression: "(@-2) 15 =(2) "
; Fused expression:    "=(170) *(@-2) 15 "
	mov	ax, 15
	mov	[bp-2], ax
; return
; RPN'ized expression: "( a f ) "
; Expanded expression: " (@4) *(2)  (@-2) *(2) ()2 "
; Fused expression:    "( *(2) (@4) , *(2) (@-2) )2  "
	push	word [bp+4]
	mov	ax, [bp-2]
	call	ax
	sub	sp, -2
L18:
	leave
	ret

; glb fnew : (
; prm     a : * char
;     ) char
section .text
	global	_fnew
_fnew:
	push	bp
	mov	bp, sp
	 sub	sp,          2
; loc     a : (@4) : * char
; loc     func : (
; prm         a : * char
;         ) char
; loc     f : (@-2) : * (
; prm         a : * char
;         ) char
; loc     <something> : * (
; prm         a : * char
;         ) char
; RPN'ized expression: "f 18 (something23) = "
; Expanded expression: "(@-2) 18 =(2) "
; Fused expression:    "=(170) *(@-2) 18 "
	mov	ax, 18
	mov	[bp-2], ax
; return
; RPN'ized expression: "( a f ) "
; Expanded expression: " (@4) *(2)  (@-2) *(2) ()2 "
; Fused expression:    "( *(2) (@4) , *(2) (@-2) )2  "
	push	word [bp+4]
	mov	ax, [bp-2]
	call	ax
	sub	sp, -2
L21:
	leave
	ret

; glb fread : (
; prm     a : * char
; prm     b : * void
;     ) char
section .text
	global	_fread
_fread:
	push	bp
	mov	bp, sp
	 sub	sp,          2
; loc     a : (@4) : * char
; loc     b : (@6) : * void
; loc     func : (
; prm         a : * char
; prm         b : * void
;         ) char
; loc     f : (@-2) : * (
; prm         a : * char
; prm         b : * void
;         ) char
; loc     <something> : * (
; prm         a : * char
; prm         b : * void
;         ) char
; RPN'ized expression: "f 21 (something26) = "
; Expanded expression: "(@-2) 21 =(2) "
; Fused expression:    "=(170) *(@-2) 21 "
	mov	ax, 21
	mov	[bp-2], ax
; return
; RPN'ized expression: "( b , a f ) "
; Expanded expression: " (@6) *(2)  (@4) *(2)  (@-2) *(2) ()4 "
; Fused expression:    "( *(2) (@6) , *(2) (@4) , *(2) (@-2) )4  "
	push	word [bp+6]
	push	word [bp+4]
	mov	ax, [bp-2]
	call	ax
	sub	sp, -4
L24:
	leave
	ret

; glb fwrite : (
; prm     a : * char
; prm     b : * void
;     ) char
section .text
	global	_fwrite
_fwrite:
	push	bp
	mov	bp, sp
	 sub	sp,          2
; loc     a : (@4) : * char
; loc     b : (@6) : * void
; loc     func : (
; prm         a : * char
; prm         b : * void
;         ) char
; loc     f : (@-2) : * (
; prm         a : * char
; prm         b : * void
;         ) char
; loc     <something> : * (
; prm         a : * char
; prm         b : * void
;         ) char
; RPN'ized expression: "f 24 (something29) = "
; Expanded expression: "(@-2) 24 =(2) "
; Fused expression:    "=(170) *(@-2) 24 "
	mov	ax, 24
	mov	[bp-2], ax
; return
; RPN'ized expression: "( b , a f ) "
; Expanded expression: " (@6) *(2)  (@4) *(2)  (@-2) *(2) ()4 "
; Fused expression:    "( *(2) (@6) , *(2) (@4) , *(2) (@-2) )4  "
	push	word [bp+6]
	push	word [bp+4]
	mov	ax, [bp-2]
	call	ax
	sub	sp, -4
L27:
	leave
	ret

; glb choose : (
; prm     a : * char
;     ) int
section .text
	global	_choose
_choose:
	push	bp
	mov	bp, sp
	 sub	sp,          2
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
; RPN'ized expression: "f 27 (something32) = "
; Expanded expression: "(@-2) 27 =(2) "
; Fused expression:    "=(170) *(@-2) 27 "
	mov	ax, 27
	mov	[bp-2], ax
; return
; RPN'ized expression: "( a f ) "
; Expanded expression: " (@4) *(2)  (@-2) *(2) ()2 "
; Fused expression:    "( *(2) (@4) , *(2) (@-2) )2  "
	push	word [bp+4]
	mov	ax, [bp-2]
	call	ax
	sub	sp, -2
L30:
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
; RPN'ized expression: "f 30 (something35) = "
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
L33:
	leave
	ret

; glb getFileList : () * char
section .text
	global	_getFileList
_getFileList:
	push	bp
	mov	bp, sp
	 sub	sp,          2
; loc     func : () * char
; loc     f : (@-2) : * () * char
; loc     <something> : * () * char
; RPN'ized expression: "f 33 (something38) = "
; Expanded expression: "(@-2) 33 =(2) "
; Fused expression:    "=(170) *(@-2) 33 "
	mov	ax, 33
	mov	[bp-2], ax
; return
; RPN'ized expression: "( f ) "
; Expanded expression: " (@-2) *(2) ()0 "
; Fused expression:    "( *(2) (@-2) )0  "
	mov	ax, [bp-2]
	call	ax
L36:
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
; RPN'ized expression: "f 39 (something41) = "
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
L39:
	leave
	ret

; glb getsc : () char
section .text
	global	_getsc
_getsc:
	push	bp
	mov	bp, sp
	 sub	sp,          2
; loc     func : () char
; loc     f : (@-2) : * () char
; loc     <something> : * () char
; RPN'ized expression: "f 42 (something44) = "
; Expanded expression: "(@-2) 42 =(2) "
; Fused expression:    "=(170) *(@-2) 42 "
	mov	ax, 42
	mov	[bp-2], ax
; return
; RPN'ized expression: "( f ) "
; Expanded expression: " (@-2) *(2) ()0 "
; Fused expression:    "( *(2) (@-2) )0  "
	mov	ax, [bp-2]
	call	ax
L42:
	leave
	ret

; glb loadFileByID : (
; prm     a : int
; prm     b : * void
;     ) char
section .text
	global	_loadFileByID
_loadFileByID:
	push	bp
	mov	bp, sp
	 sub	sp,          2
; loc     a : (@4) : int
; loc     b : (@6) : * void
; loc     func : (
; prm         a : int
; prm         b : * void
;         ) char
; loc     f : (@-2) : * (
; prm         a : int
; prm         b : * void
;         ) char
; loc     <something> : * (
; prm         a : int
; prm         b : * void
;         ) char
; RPN'ized expression: "f 45 (something47) = "
; Expanded expression: "(@-2) 45 =(2) "
; Fused expression:    "=(170) *(@-2) 45 "
	mov	ax, 45
	mov	[bp-2], ax
; return
; RPN'ized expression: "( b , a f ) "
; Expanded expression: " (@6) *(2)  (@4) *(2)  (@-2) *(2) ()4 "
; Fused expression:    "( *(2) (@6) , *(2) (@4) , *(2) (@-2) )4  "
	push	word [bp+6]
	push	word [bp+4]
	mov	ax, [bp-2]
	call	ax
	sub	sp, -4
L45:
	leave
	ret

; glb writeFileByID : (
; prm     a : int
; prm     b : * void
; prm     c : int
;     ) char
section .text
	global	_writeFileByID
_writeFileByID:
	push	bp
	mov	bp, sp
	 sub	sp,          2
; loc     a : (@4) : int
; loc     b : (@6) : * void
; loc     c : (@8) : int
; loc     func : (
; prm         a : int
; prm         b : * void
; prm         c : int
;         ) char
; loc     f : (@-2) : * (
; prm         a : int
; prm         b : * void
; prm         c : int
;         ) char
; loc     <something> : * (
; prm         a : int
; prm         b : * void
; prm         c : int
;         ) char
; RPN'ized expression: "f 48 (something50) = "
; Expanded expression: "(@-2) 48 =(2) "
; Fused expression:    "=(170) *(@-2) 48 "
	mov	ax, 48
	mov	[bp-2], ax
; return
; RPN'ized expression: "( c , b , a f ) "
; Expanded expression: " (@8) *(2)  (@6) *(2)  (@4) *(2)  (@-2) *(2) ()6 "
; Fused expression:    "( *(2) (@8) , *(2) (@6) , *(2) (@4) , *(2) (@-2) )6  "
	push	word [bp+8]
	push	word [bp+6]
	push	word [bp+4]
	mov	ax, [bp-2]
	call	ax
	sub	sp, -6
L48:
	leave
	ret



; Syntax/declaration table/stack:
; Bytes used: 615/15360


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
; Ident printf
; Ident a
; Ident putc
; Ident curpos
; Ident b
; Ident cls
; Ident fexists
; Ident fnew
; Ident fread
; Ident fwrite
; Ident choose
; Ident setTitle
; Ident getFileList
; Ident getc
; Ident getsc
; Ident loadFileByID
; Ident writeFileByID
; Ident c
; Bytes used: 268/5632

; Next label number: 51
; Compilation succeeded.
