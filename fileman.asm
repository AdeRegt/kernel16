bits 16

org 0x4000
; glb main : () void
section .text
	global	_main
_main:
	push	bp
	mov	bp, sp
	 sub	sp,          8
; loc     filelist : (@-2) : * char
; RPN'ized expression: "filelist ( getFileList ) = "
; Expanded expression: "(@-2)  getFileList ()0 =(2) "
; Fused expression:    "( getFileList )0 =(170) *(@-2) ax "
	call	_getFileList
	mov	[bp-2], ax
; loc     alpha : (@-4) : int
; RPN'ized expression: "alpha ( filelist choose ) = "
; Expanded expression: "(@-4)  (@-2) *(2)  choose ()2 =(2) "
; Fused expression:    "( *(2) (@-2) , choose )2 =(170) *(@-4) ax "
	push	word [bp-2]
	call	_choose
	sub	sp, -2
	mov	[bp-4], ax
; RPN'ized expression: "( cls ) "
; Expanded expression: " cls ()0 "
; Fused expression:    "( cls )0 "
	call	_cls
; loc     buffer : (@-6) : * unsigned char
; loc     <something> : * unsigned char
; RPN'ized expression: "buffer 20480 (something3) = "
; Expanded expression: "(@-6) 20480 =(2) "
; Fused expression:    "=(170) *(@-6) 20480 "
	mov	ax, 20480
	mov	[bp-6], ax
; if
; RPN'ized expression: "( buffer , alpha loadFileByID ) "
; Expanded expression: " (@-6) *(2)  (@-4) *(2)  loadFileByID ()4 "
; Fused expression:    "( *(2) (@-6) , *(2) (@-4) , loadFileByID )4  "
	push	word [bp-6]
	push	word [bp-4]
	call	_loadFileByID
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L4
; {
; loc         func : () void
; loc         f : (@-8) : * () void
; loc         <something> : * () void
; RPN'ized expression: "f buffer (something6) = "
; Expanded expression: "(@-8) (@-6) *(2) =(2) "
; Fused expression:    "=(170) *(@-8) *(@-6) "
	mov	ax, [bp-6]
	mov	[bp-8], ax
; RPN'ized expression: "( f ) "
; Expanded expression: " (@-8) *(2) ()0 "
; Fused expression:    "( *(2) (@-8) )0 "
	mov	ax, [bp-8]
	call	ax
; }
	jmp	L5
L4:
; else
; {

section .rodata
L7:
	db	"UNABLE TO LOAD FILE"
	times	1 db 0

section .text
; RPN'ized expression: "( L7 printf ) "
; Expanded expression: " L7  printf ()2 "
; Fused expression:    "( L7 , printf )2 "
	push	L7
	call	_printf
	sub	sp, -2
; RPN'ized expression: "( getc ) "
; Expanded expression: " getc ()0 "
; Fused expression:    "( getc )0 "
	call	_getc
; }
L5:
jmp _main
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
; RPN'ized expression: "f 3 (something10) = "
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
L8:
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
; RPN'ized expression: "f 6 (something13) = "
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
L11:
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
; RPN'ized expression: "f 9 (something16) = "
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
L14:
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
; RPN'ized expression: "f 12 (something19) = "
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
L17:
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
; RPN'ized expression: "f 15 (something22) = "
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
L20:
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
; RPN'ized expression: "f 18 (something25) = "
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
L23:
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
; RPN'ized expression: "f 21 (something28) = "
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
L26:
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
; RPN'ized expression: "f 24 (something31) = "
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
L29:
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
; RPN'ized expression: "f 27 (something34) = "
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
L32:
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
; RPN'ized expression: "f 30 (something37) = "
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
L35:
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
; RPN'ized expression: "f 33 (something40) = "
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
L38:
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
; RPN'ized expression: "f 39 (something43) = "
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
L41:
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
; RPN'ized expression: "f 42 (something46) = "
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
L44:
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
; RPN'ized expression: "f 45 (something49) = "
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
L47:
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
; RPN'ized expression: "f 48 (something52) = "
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
L50:
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

; Next label number: 53
; Compilation succeeded.
