bits 16

; glb main : () void
section .text
	global	_main
_main:
	push	bp
	mov	bp, sp
	 sub	sp,         10
; RPN'ized expression: "( cls ) "
; Expanded expression: " cls ()0 "
; Fused expression:    "( cls )0 "
	call	_cls
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
; loc     buffer : (@-6) : * char
; loc     <something> : * char
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

section .rodata
L6:
	db	"Bekijken;Uitvoeren;Terug"
	times	1 db 0

section .text
; RPN'ized expression: "alpha ( L6 choose ) = "
; Expanded expression: "(@-4)  L6  choose ()2 =(2) "
; Fused expression:    "( L6 , choose )2 =(170) *(@-4) ax "
	push	L6
	call	_choose
	sub	sp, -2
	mov	[bp-4], ax
; RPN'ized expression: "( cls ) "
; Expanded expression: " cls ()0 "
; Fused expression:    "( cls )0 "
	call	_cls
; if
; RPN'ized expression: "alpha 0 == "
; Expanded expression: "(@-4) *(2) 0 == "
; Fused expression:    "== *(@-4) 0 IF! "
	mov	ax, [bp-4]
	cmp	ax, 0
	jne	L7
; {
; loc             base : (@-8) : int
; RPN'ized expression: "base 0 = "
; Expanded expression: "(@-8) 0 =(2) "
; Fused expression:    "=(170) *(@-8) 0 "
	mov	ax, 0
	mov	[bp-8], ax
; while
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
L9:
; {

section .rodata
L11:
	db	"Viewer"
	times	1 db 0

section .text

section .rodata
L12:
	db	"+ volgende 512 | - vorige 512 | e terug"
	times	1 db 0

section .text
; RPN'ized expression: "( L12 , L11 setTitle ) "
; Expanded expression: " L12  L11  setTitle ()4 "
; Fused expression:    "( L12 , L11 , setTitle )4 "
	push	L12
	push	L11
	call	_setTitle
	sub	sp, -4
; for
; loc                 i : (@-10) : int
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-10) 0 =(2) "
; Fused expression:    "=(170) *(@-10) 0 "
	mov	ax, 0
	mov	[bp-10], ax
L13:
; RPN'ized expression: "i 512 < "
; Expanded expression: "(@-10) *(2) 512 < "
; Fused expression:    "< *(@-10) 512 IF! "
	mov	ax, [bp-10]
	cmp	ax, 512
	jge	L16
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-10) ++p(2) "
; {
; RPN'ized expression: "( buffer base i + + *u putc ) "
; Expanded expression: " (@-6) *(2) (@-8) *(2) (@-10) *(2) + + *(-1)  putc ()2 "
; Fused expression:    "( + *(@-8) *(@-10) + *(@-6) ax *(-1) ax , putc )2 "
	mov	ax, [bp-8]
	add	ax, [bp-10]
	mov	cx, ax
	mov	ax, [bp-6]
	add	ax, cx
	mov	bx, ax
	mov	al, [bx]
	cbw
	push	ax
	call	_putc
	sub	sp, -2
; }
L14:
; Fused expression:    "++p(2) *(@-10) "
	mov	ax, [bp-10]
	inc	word [bp-10]
	jmp	L13
L16:
; loc                 x : (@-10) : char
; RPN'ized expression: "x ( getc ) = "
; Expanded expression: "(@-10)  getc ()0 =(-1) "
; Fused expression:    "( getc )0 =(170) *(@-10) ax "
	call	_getc
	mov	[bp-10], ax
; if
; RPN'ized expression: "x 43 == "
; Expanded expression: "(@-10) *(-1) 43 == "
; Fused expression:    "== *(@-10) 43 IF! "
	mov	al, [bp-10]
	cbw
	cmp	ax, 43
	jne	L17
; {
; RPN'ized expression: "base 512 += "
; Expanded expression: "(@-8) 512 +=(2) "
; Fused expression:    "+=(170) *(@-8) 512 "
	mov	ax, [bp-8]
	add	ax, 512
	mov	[bp-8], ax
; }
L17:
; if
; RPN'ized expression: "x 45 == "
; Expanded expression: "(@-10) *(-1) 45 == "
; Fused expression:    "== *(@-10) 45 IF! "
	mov	al, [bp-10]
	cbw
	cmp	ax, 45
	jne	L19
; {
; RPN'ized expression: "base 512 -= "
; Expanded expression: "(@-8) 512 -=(2) "
; Fused expression:    "-=(170) *(@-8) 512 "
	mov	ax, [bp-8]
	sub	ax, 512
	mov	[bp-8], ax
; }
L19:
; if
; RPN'ized expression: "x 101 == "
; Expanded expression: "(@-10) *(-1) 101 == "
; Fused expression:    "== *(@-10) 101 IF! "
	mov	al, [bp-10]
	cbw
	cmp	ax, 101
	jne	L21
; {
jmp _main
; }
L21:
; }
	jmp	L9
L10:
; }
	jmp	L8
L7:
; else
; if
; RPN'ized expression: "alpha 1 == "
; Expanded expression: "(@-4) *(2) 1 == "
; Fused expression:    "== *(@-4) 1 IF! "
	mov	ax, [bp-4]
	cmp	ax, 1
	jne	L23
; {
call 0x5000
; RPN'ized expression: "( getc ) "
; Expanded expression: " getc ()0 "
; Fused expression:    "( getc )0 "
	call	_getc
; }
	jmp	L24
L23:
; else
; if
; RPN'ized expression: "alpha 2 == "
; Expanded expression: "(@-4) *(2) 2 == "
; Fused expression:    "== *(@-4) 2 IF! "
	mov	ax, [bp-4]
	cmp	ax, 2
	jne	L25
; {
; }
L25:
L24:
L8:
; }
	jmp	L5
L4:
; else
; {

section .rodata
L27:
	db	"INIT: Unable to load file"
	times	1 db 0

section .text
; RPN'ized expression: "( L27 printf ) "
; Expanded expression: " L27  printf ()2 "
; Fused expression:    "( L27 , printf )2 "
	push	L27
	call	_printf
	sub	sp, -2
; }
L5:
jmp _main
; for
L28:
	jmp	L28
L31:
; Fused expression:    "0  "
	mov	ax, 0
L1:
	leave
	ret

; glb loadFileByID : (
; prm     number : int
; prm     targetbuff : * char
;     ) char
section .text
	global	_loadFileByID
_loadFileByID:
	push	bp
	mov	bp, sp
	 sub	sp,         12
; loc     number : (@4) : int
; loc     targetbuff : (@6) : * char
; loc     buffer : (@-2) : * char
; loc     <something> : * char
; RPN'ized expression: "buffer 4096 (something34) = "
; Expanded expression: "(@-2) 4096 =(2) "
; Fused expression:    "=(170) *(@-2) 4096 "
	mov	ax, 4096
	mov	[bp-2], ax
; if
; RPN'ized expression: "( buffer , 19 , 0 , 1 readSectorsDeviceLBA ) "
; Expanded expression: " (@-2) *(2)  19  0  1  readSectorsDeviceLBA ()8 "
; Fused expression:    "( *(2) (@-2) , 19 , 0 , 1 , readSectorsDeviceLBA )8  "
	push	word [bp-2]
	push	19
	push	0
	push	1
	call	_readSectorsDeviceLBA
	sub	sp, -8
; JumpIfZero
	test	ax, ax
	je	L35
; {
; loc         index : (@-4) : int
; RPN'ized expression: "index 0 = "
; Expanded expression: "(@-4) 0 =(2) "
; Fused expression:    "=(170) *(@-4) 0 "
	mov	ax, 0
	mov	[bp-4], ax
; loc         deze : (@-6) : char
; RPN'ized expression: "deze 0 = "
; Expanded expression: "(@-6) 0 =(-1) "
; Fused expression:    "=(170) *(@-6) 0 "
	mov	ax, 0
	mov	[bp-6], ax
; loc         andere : (@-8) : int
; RPN'ized expression: "andere 0 = "
; Expanded expression: "(@-8) 0 =(2) "
; Fused expression:    "=(170) *(@-8) 0 "
	mov	ax, 0
	mov	[bp-8], ax
; for
; loc         i : (@-10) : int
; RPN'ized expression: "i 1 = "
; Expanded expression: "(@-10) 1 =(2) "
; Fused expression:    "=(170) *(@-10) 1 "
	mov	ax, 1
	mov	[bp-10], ax
L37:
; RPN'ized expression: "i 20 < "
; Expanded expression: "(@-10) *(2) 20 < "
; Fused expression:    "< *(@-10) 20 IF! "
	mov	ax, [bp-10]
	cmp	ax, 20
	jge	L40
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-10) ++p(2) "
; {
; loc             semaphore : (@-12) : int
; RPN'ized expression: "semaphore i 32 * = "
; Expanded expression: "(@-12) (@-10) *(2) 32 * =(2) "
; Fused expression:    "* *(@-10) 32 =(170) *(@-12) ax "
	mov	ax, [bp-10]
	imul	ax, ax, 32
	mov	[bp-12], ax
; if
; RPN'ized expression: "buffer semaphore 11 + + *u 15 != "
; Expanded expression: "(@-2) *(2) (@-12) *(2) 11 + + *(-1) 15 != "
; Fused expression:    "+ *(@-12) 11 + *(@-2) ax != *ax 15 IF! "
	mov	ax, [bp-12]
	add	ax, 11
	mov	cx, ax
	mov	ax, [bp-2]
	add	ax, cx
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 15
	je	L41
; {
; if
; RPN'ized expression: "number index == "
; Expanded expression: "(@4) *(2) (@-4) *(2) == "
; Fused expression:    "== *(@4) *(@-4) IF! "
	mov	ax, [bp+4]
	cmp	ax, [bp-4]
	jne	L43
; {
; RPN'ized expression: "deze buffer semaphore 26 + + *u = "
; Expanded expression: "(@-6) (@-2) *(2) (@-12) *(2) 26 + + *(-1) =(-1) "
; Fused expression:    "+ *(@-12) 26 + *(@-2) ax =(119) *(@-6) *ax "
	mov	ax, [bp-12]
	add	ax, 26
	mov	cx, ax
	mov	ax, [bp-2]
	add	ax, cx
	mov	bx, ax
	mov	al, [bx]
	cbw
	mov	[bp-6], al
	cbw
; RPN'ized expression: "andere buffer semaphore 28 + + *u = "
; Expanded expression: "(@-8) (@-2) *(2) (@-12) *(2) 28 + + *(-1) =(2) "
; Fused expression:    "+ *(@-12) 28 + *(@-2) ax =(167) *(@-8) *ax "
	mov	ax, [bp-12]
	add	ax, 28
	mov	cx, ax
	mov	ax, [bp-2]
	add	ax, cx
	mov	bx, ax
	mov	al, [bx]
	cbw
	mov	[bp-8], ax
; break
	jmp	L40
; }
L43:
; RPN'ized expression: "index ++p "
; Expanded expression: "(@-4) ++p(2) "
; Fused expression:    "++p(2) *(@-4) "
	mov	ax, [bp-4]
	inc	word [bp-4]
; }
L41:
; }
L38:
; Fused expression:    "++p(2) *(@-10) "
	mov	ax, [bp-10]
	inc	word [bp-10]
	jmp	L37
L40:
; return
; RPN'ized expression: "( targetbuff , deze 31 + , 0 , andere 512 / 1 + readSectorsDeviceLBA ) "
; Expanded expression: " (@6) *(2)  (@-6) *(-1) 31 +  0  (@-8) *(2) 512 / 1 +  readSectorsDeviceLBA ()8 "
; Fused expression:    "( *(2) (@6) , + *(@-6) 31 , 0 , / *(@-8) 512 + ax 1 , readSectorsDeviceLBA )8 signed char  "
	push	word [bp+6]
	mov	al, [bp-6]
	cbw
	add	ax, 31
	push	ax
	push	0
	mov	ax, [bp-8]
	cwd
	mov	cx, 512
	idiv	cx
	inc	ax
	push	ax
	call	_readSectorsDeviceLBA
	sub	sp, -8
	cbw
	jmp	L32
; }
L35:
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
L32:
	leave
	ret

; glb choose : (
; prm     alpha : * char
;     ) int
section .text
	global	_choose
_choose:
	push	bp
	mov	bp, sp
	 sub	sp,          8
; loc     alpha : (@4) : * char
; loc     pointer : (@-2) : int
; RPN'ized expression: "pointer 0 = "
; Expanded expression: "(@-2) 0 =(2) "
; Fused expression:    "=(170) *(@-2) 0 "
	mov	ax, 0
	mov	[bp-2], ax
; while
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
L47:
; {
; RPN'ized expression: "( cls ) "
; Expanded expression: " cls ()0 "
; Fused expression:    "( cls )0 "
	call	_cls

section .rodata
L49:
	db	"Selecteer een optie"
	times	1 db 0

section .text

section .rodata
L50:
	db	"Pijltjestoetsen: Navigeer | 9 : Selecteer"
	times	1 db 0

section .text
; RPN'ized expression: "( L50 , L49 setTitle ) "
; Expanded expression: " L50  L49  setTitle ()4 "
; Fused expression:    "( L50 , L49 , setTitle )4 "
	push	L50
	push	L49
	call	_setTitle
	sub	sp, -4
; RPN'ized expression: "( 80 , 112 , 0 , pointer 1 + draw ) "
; Expanded expression: " 80  112  0  (@-2) *(2) 1 +  draw ()8 "
; Fused expression:    "( 80 , 112 , 0 , + *(@-2) 1 , draw )8 "
	push	80
	push	112
	push	0
	mov	ax, [bp-2]
	inc	ax
	push	ax
	call	_draw
	sub	sp, -8
; RPN'ized expression: "( 0 , 1 curpos ) "
; Expanded expression: " 0  1  curpos ()4 "
; Fused expression:    "( 0 , 1 , curpos )4 "
	push	0
	push	1
	call	_curpos
	sub	sp, -4
; loc         rowpointer : (@-4) : int
; RPN'ized expression: "rowpointer 0 = "
; Expanded expression: "(@-4) 0 =(2) "
; Fused expression:    "=(170) *(@-4) 0 "
	mov	ax, 0
	mov	[bp-4], ax
; loc         beta : (@-6) : int
; RPN'ized expression: "beta 0 = "
; Expanded expression: "(@-6) 0 =(2) "
; Fused expression:    "=(170) *(@-6) 0 "
	mov	ax, 0
	mov	[bp-6], ax
; if
; RPN'ized expression: "rowpointer pointer == "
; Expanded expression: "(@-4) *(2) (@-2) *(2) == "
; Fused expression:    "== *(@-4) *(@-2) IF! "
	mov	ax, [bp-4]
	cmp	ax, [bp-2]
	jne	L51
; {

section .rodata
L53:
	db	">>> "
	times	1 db 0

section .text
; RPN'ized expression: "( L53 printf ) "
; Expanded expression: " L53  printf ()2 "
; Fused expression:    "( L53 , printf )2 "
	push	L53
	call	_printf
	sub	sp, -2
; }
	jmp	L52
L51:
; else
; {

section .rodata
L54:
	db	"--- "
	times	1 db 0

section .text
; RPN'ized expression: "( L54 printf ) "
; Expanded expression: " L54  printf ()2 "
; Fused expression:    "( L54 , printf )2 "
	push	L54
	call	_printf
	sub	sp, -2
; }
L52:
; while
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
L55:
; {
; loc             deze : (@-8) : char
; RPN'ized expression: "deze alpha beta ++p + *u = "
; Expanded expression: "(@-8) (@4) *(2) (@-6) ++p(2) + *(-1) =(-1) "
; Fused expression:    "++p(2) *(@-6) + *(@4) ax =(167) *(@-8) *ax "
	mov	ax, [bp-6]
	inc	word [bp-6]
	mov	cx, ax
	mov	ax, [bp+4]
	add	ax, cx
	mov	bx, ax
	mov	al, [bx]
	cbw
	mov	[bp-8], ax
; if
; RPN'ized expression: "deze 0 == "
; Expanded expression: "(@-8) *(-1) 0 == "
; Fused expression:    "== *(@-8) 0 IF! "
	mov	al, [bp-8]
	cbw
	cmp	ax, 0
	jne	L57
; {
; RPN'ized expression: "rowpointer ++p "
; Expanded expression: "(@-4) ++p(2) "
; Fused expression:    "++p(2) *(@-4) "
	mov	ax, [bp-4]
	inc	word [bp-4]
; break
	jmp	L56
; }
	jmp	L58
L57:
; else
; if
; RPN'ized expression: "deze 59 == "
; Expanded expression: "(@-8) *(-1) 59 == "
; Fused expression:    "== *(@-8) 59 IF! "
	mov	al, [bp-8]
	cbw
	cmp	ax, 59
	jne	L59
; {

section .rodata
L61:
	db	10,13
	times	1 db 0

section .text
; RPN'ized expression: "( L61 printf ) "
; Expanded expression: " L61  printf ()2 "
; Fused expression:    "( L61 , printf )2 "
	push	L61
	call	_printf
	sub	sp, -2
; RPN'ized expression: "rowpointer ++p "
; Expanded expression: "(@-4) ++p(2) "
; Fused expression:    "++p(2) *(@-4) "
	mov	ax, [bp-4]
	inc	word [bp-4]
; if
; RPN'ized expression: "rowpointer pointer == "
; Expanded expression: "(@-4) *(2) (@-2) *(2) == "
; Fused expression:    "== *(@-4) *(@-2) IF! "
	mov	ax, [bp-4]
	cmp	ax, [bp-2]
	jne	L62
; {

section .rodata
L64:
	db	">>> "
	times	1 db 0

section .text
; RPN'ized expression: "( L64 printf ) "
; Expanded expression: " L64  printf ()2 "
; Fused expression:    "( L64 , printf )2 "
	push	L64
	call	_printf
	sub	sp, -2
; }
	jmp	L63
L62:
; else
; {

section .rodata
L65:
	db	"--- "
	times	1 db 0

section .text
; RPN'ized expression: "( L65 printf ) "
; Expanded expression: " L65  printf ()2 "
; Fused expression:    "( L65 , printf )2 "
	push	L65
	call	_printf
	sub	sp, -2
; }
L63:
; }
	jmp	L60
L59:
; else
; {
; RPN'ized expression: "( deze putc ) "
; Expanded expression: " (@-8) *(-1)  putc ()2 "
; Fused expression:    "( *(-1) (@-8) , putc )2 "
	mov	al, [bp-8]
	cbw
	push	ax
	call	_putc
	sub	sp, -2
; }
L60:
L58:
; }
	jmp	L55
L56:

section .rodata
L66:
	db	10,13
	times	1 db 0

section .text
; RPN'ized expression: "( L66 printf ) "
; Expanded expression: " L66  printf ()2 "
; Fused expression:    "( L66 , printf )2 "
	push	L66
	call	_printf
	sub	sp, -2
; loc         et : (@-8) : char
; RPN'ized expression: "et ( getsc ) = "
; Expanded expression: "(@-8)  getsc ()0 =(-1) "
; Fused expression:    "( getsc )0 =(170) *(@-8) ax "
	call	_getsc
	mov	[bp-8], ax
; if
; RPN'ized expression: "et 72 == "
; Expanded expression: "(@-8) *(-1) 72 == "
; Fused expression:    "== *(@-8) 72 IF! "
	mov	al, [bp-8]
	cbw
	cmp	ax, 72
	jne	L67
; {
; if
; RPN'ized expression: "pointer 0 != "
; Expanded expression: "(@-2) *(2) 0 != "
; Fused expression:    "!= *(@-2) 0 IF! "
	mov	ax, [bp-2]
	cmp	ax, 0
	je	L69
; {
; RPN'ized expression: "pointer --p "
; Expanded expression: "(@-2) --p(2) "
; Fused expression:    "--p(2) *(@-2) "
	mov	ax, [bp-2]
	dec	word [bp-2]
; }
L69:
; }
	jmp	L68
L67:
; else
; if
; RPN'ized expression: "et 80 == "
; Expanded expression: "(@-8) *(-1) 80 == "
; Fused expression:    "== *(@-8) 80 IF! "
	mov	al, [bp-8]
	cbw
	cmp	ax, 80
	jne	L71
; {
; if
; RPN'ized expression: "pointer rowpointer != "
; Expanded expression: "(@-2) *(2) (@-4) *(2) != "
; Fused expression:    "!= *(@-2) *(@-4) IF! "
	mov	ax, [bp-2]
	cmp	ax, [bp-4]
	je	L73
; {
; RPN'ized expression: "pointer ++p "
; Expanded expression: "(@-2) ++p(2) "
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
; }
L73:
; }
	jmp	L72
L71:
; else
; if
; RPN'ized expression: "et 28 == "
; Expanded expression: "(@-8) *(-1) 28 == "
; Fused expression:    "== *(@-8) 28 IF! "
	mov	al, [bp-8]
	cbw
	cmp	ax, 28
	jne	L75
; {
; break
	jmp	L48
; }
L75:
L72:
L68:
; }
	jmp	L47
L48:
; return
; RPN'ized expression: "pointer "
; Expanded expression: "(@-2) *(2) "
; Fused expression:    "*(2) (@-2)  "
	mov	ax, [bp-2]
L45:
	leave
	ret

; glb setTitle : (
; prm     front : * char
; prm     back : * char
;     ) void
section .text
	global	_setTitle
_setTitle:
	push	bp
	mov	bp, sp
	 sub	sp,          2
; loc     front : (@4) : * char
; loc     back : (@6) : * char
; RPN'ized expression: "( 0 , 0 curpos ) "
; Expanded expression: " 0  0  curpos ()4 "
; Fused expression:    "( 0 , 0 , curpos )4 "
	push	0
	push	0
	call	_curpos
	sub	sp, -4
; RPN'ized expression: "( 80 , 42 , 0 , 0 draw ) "
; Expanded expression: " 80  42  0  0  draw ()8 "
; Fused expression:    "( 80 , 42 , 0 , 0 , draw )8 "
	push	80
	push	42
	push	0
	push	0
	call	_draw
	sub	sp, -8
; for
; loc     i : (@-2) : int
; RPN'ized expression: "i 1 = "
; Expanded expression: "(@-2) 1 =(2) "
; Fused expression:    "=(170) *(@-2) 1 "
	mov	ax, 1
	mov	[bp-2], ax
L79:
; RPN'ized expression: "i 24 < "
; Expanded expression: "(@-2) *(2) 24 < "
; Fused expression:    "< *(@-2) 24 IF! "
	mov	ax, [bp-2]
	cmp	ax, 24
	jge	L82
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-2) ++p(2) "
; {
; RPN'ized expression: "( 80 , 96 , 0 , i draw ) "
; Expanded expression: " 80  96  0  (@-2) *(2)  draw ()8 "
; Fused expression:    "( 80 , 96 , 0 , *(2) (@-2) , draw )8 "
	push	80
	push	96
	push	0
	push	word [bp-2]
	call	_draw
	sub	sp, -8
; }
L80:
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L79
L82:
; RPN'ized expression: "( 80 , 42 , 0 , 24 draw ) "
; Expanded expression: " 80  42  0  24  draw ()8 "
; Fused expression:    "( 80 , 42 , 0 , 24 , draw )8 "
	push	80
	push	42
	push	0
	push	24
	call	_draw
	sub	sp, -8
; RPN'ized expression: "( 2 , 0 curpos ) "
; Expanded expression: " 2  0  curpos ()4 "
; Fused expression:    "( 2 , 0 , curpos )4 "
	push	2
	push	0
	call	_curpos
	sub	sp, -4
; RPN'ized expression: "( front printf ) "
; Expanded expression: " (@4) *(2)  printf ()2 "
; Fused expression:    "( *(2) (@4) , printf )2 "
	push	word [bp+4]
	call	_printf
	sub	sp, -2
; RPN'ized expression: "( 68 , 0 curpos ) "
; Expanded expression: " 68  0  curpos ()4 "
; Fused expression:    "( 68 , 0 , curpos )4 "
	push	68
	push	0
	call	_curpos
	sub	sp, -4

section .rodata
L83:
	db	"SanderOS16"
	times	1 db 0

section .text
; RPN'ized expression: "( L83 printf ) "
; Expanded expression: " L83  printf ()2 "
; Fused expression:    "( L83 , printf )2 "
	push	L83
	call	_printf
	sub	sp, -2
; RPN'ized expression: "( 2 , 24 curpos ) "
; Expanded expression: " 2  24  curpos ()4 "
; Fused expression:    "( 2 , 24 , curpos )4 "
	push	2
	push	24
	call	_curpos
	sub	sp, -4
; RPN'ized expression: "( back printf ) "
; Expanded expression: " (@6) *(2)  printf ()2 "
; Fused expression:    "( *(2) (@6) , printf )2 "
	push	word [bp+6]
	call	_printf
	sub	sp, -2
; RPN'ized expression: "( 0 , 1 curpos ) "
; Expanded expression: " 0  1  curpos ()4 "
; Fused expression:    "( 0 , 1 , curpos )4 "
	push	0
	push	1
	call	_curpos
	sub	sp, -4
L77:
	leave
	ret

; glb getFileList : () * char
section .text
	global	_getFileList
_getFileList:
	push	bp
	mov	bp, sp
	 sub	sp,        110
; loc     buffer : (@-2) : * char
; loc     <something> : * char
; RPN'ized expression: "buffer 4096 (something86) = "
; Expanded expression: "(@-2) 4096 =(2) "
; Fused expression:    "=(170) *(@-2) 4096 "
	mov	ax, 4096
	mov	[bp-2], ax
; RPN'ized expression: "100 "
; Expanded expression: "100 "
; Expression value: 100
; loc     filebuffer : (@-102) : [100u] char
; loc     x : (@-104) : int
; RPN'ized expression: "x 0 = "
; Expanded expression: "(@-104) 0 =(2) "
; Fused expression:    "=(170) *(@-104) 0 "
	mov	ax, 0
	mov	[bp-104], ax
; loc     first : (@-106) : char
; RPN'ized expression: "first 1 = "
; Expanded expression: "(@-106) 1 =(-1) "
; Fused expression:    "=(170) *(@-106) 1 "
	mov	ax, 1
	mov	[bp-106], ax
; if
; RPN'ized expression: "( buffer , 19 , 0 , 1 readSectorsDeviceLBA ) "
; Expanded expression: " (@-2) *(2)  19  0  1  readSectorsDeviceLBA ()8 "
; Fused expression:    "( *(2) (@-2) , 19 , 0 , 1 , readSectorsDeviceLBA )8  "
	push	word [bp-2]
	push	19
	push	0
	push	1
	call	_readSectorsDeviceLBA
	sub	sp, -8
; JumpIfZero
	test	ax, ax
	je	L87
; {
; for
; loc         index : (@-108) : int
; RPN'ized expression: "index 0 = "
; Expanded expression: "(@-108) 0 =(2) "
; Fused expression:    "=(170) *(@-108) 0 "
	mov	ax, 0
	mov	[bp-108], ax
L89:
; RPN'ized expression: "index 20 < "
; Expanded expression: "(@-108) *(2) 20 < "
; Fused expression:    "< *(@-108) 20 IF! "
	mov	ax, [bp-108]
	cmp	ax, 20
	jge	L92
; RPN'ized expression: "index ++p "
; Expanded expression: "(@-108) ++p(2) "
; {
; if
; RPN'ized expression: "buffer index 32 * 11 + + *u 15 != "
; Expanded expression: "(@-2) *(2) (@-108) *(2) 32 * 11 + + *(-1) 15 != "
; Fused expression:    "* *(@-108) 32 + ax 11 + *(@-2) ax != *ax 15 IF! "
	mov	ax, [bp-108]
	imul	ax, ax, 32
	add	ax, 11
	mov	cx, ax
	mov	ax, [bp-2]
	add	ax, cx
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 15
	je	L93
; {
; if
; RPN'ized expression: "buffer index 32 * + *u 0 == "
; Expanded expression: "(@-2) *(2) (@-108) *(2) 32 * + *(-1) 0 == "
; Fused expression:    "* *(@-108) 32 + *(@-2) ax == *ax 0 IF! "
	mov	ax, [bp-108]
	imul	ax, ax, 32
	mov	cx, ax
	mov	ax, [bp-2]
	add	ax, cx
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 0
	jne	L95
; {
; break
	jmp	L92
; }
L95:
; if
; RPN'ized expression: "first "
; Expanded expression: "(@-106) *(-1) "
; Fused expression:    "*(-1) (@-106)  "
	mov	al, [bp-106]
	cbw
; JumpIfZero
	test	ax, ax
	je	L97
; {
; RPN'ized expression: "first 0 = "
; Expanded expression: "(@-106) 0 =(-1) "
; Fused expression:    "=(122) *(@-106) 0 "
	mov	ax, 0
	mov	[bp-106], al
	cbw
; }
	jmp	L98
L97:
; else
; {
; loc                     X : (@-110) : char
; RPN'ized expression: "X 59 = "
; Expanded expression: "(@-110) 59 =(-1) "
; Fused expression:    "=(170) *(@-110) 59 "
	mov	ax, 59
	mov	[bp-110], ax
; RPN'ized expression: "filebuffer x ++p + *u X = "
; Expanded expression: "(@-102) (@-104) ++p(2) + (@-110) *(-1) =(-1) "
; Fused expression:    "++p(2) *(@-104) + (@-102) ax =(119) *ax *(@-110) "
	mov	ax, [bp-104]
	inc	word [bp-104]
	mov	cx, ax
	lea	ax, [bp-102]
	add	ax, cx
	mov	bx, ax
	mov	al, [bp-110]
	cbw
	mov	[bx], al
	cbw
; }
L98:
; for
; loc                 i : (@-110) : int
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-110) 0 =(2) "
; Fused expression:    "=(170) *(@-110) 0 "
	mov	ax, 0
	mov	[bp-110], ax
L99:
; RPN'ized expression: "i 11 < "
; Expanded expression: "(@-110) *(2) 11 < "
; Fused expression:    "< *(@-110) 11 IF! "
	mov	ax, [bp-110]
	cmp	ax, 11
	jge	L102
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-110) ++p(2) "
; {
; RPN'ized expression: "filebuffer x ++p + *u buffer index 32 * i + + *u = "
; Expanded expression: "(@-102) (@-104) ++p(2) + (@-2) *(2) (@-108) *(2) 32 * (@-110) *(2) + + *(-1) =(-1) "
; Fused expression:    "++p(2) *(@-104) + (@-102) ax push-ax * *(@-108) 32 + ax *(@-110) + *(@-2) ax =(119) **sp *ax "
	mov	ax, [bp-104]
	inc	word [bp-104]
	mov	cx, ax
	lea	ax, [bp-102]
	add	ax, cx
	push	ax
	mov	ax, [bp-108]
	imul	ax, ax, 32
	add	ax, [bp-110]
	mov	cx, ax
	mov	ax, [bp-2]
	add	ax, cx
	mov	bx, ax
	mov	al, [bx]
	cbw
	pop	bx
	mov	[bx], al
	cbw
; }
L100:
; Fused expression:    "++p(2) *(@-110) "
	mov	ax, [bp-110]
	inc	word [bp-110]
	jmp	L99
L102:
; }
L93:
; }
L90:
; Fused expression:    "++p(2) *(@-108) "
	mov	ax, [bp-108]
	inc	word [bp-108]
	jmp	L89
L92:
; }
	jmp	L88
L87:
; else
; {

section .rodata
L103:
	db	"DEV: cannot read",10,13
	times	1 db 0

section .text
; RPN'ized expression: "( L103 printf ) "
; Expanded expression: " L103  printf ()2 "
; Fused expression:    "( L103 , printf )2 "
	push	L103
	call	_printf
	sub	sp, -2
; }
L88:
; RPN'ized expression: "filebuffer x + *u 0 = "
; Expanded expression: "(@-102) (@-104) *(2) + 0 =(-1) "
; Fused expression:    "+ (@-102) *(@-104) =(122) *ax 0 "
	lea	ax, [bp-102]
	add	ax, [bp-104]
	mov	bx, ax
	mov	ax, 0
	mov	[bx], al
	cbw
; return
; RPN'ized expression: "filebuffer "
; Expanded expression: "(@-102) "
; Fused expression:    "(@-102)  "
	lea	ax, [bp-102]
L84:
	leave
	ret

; glb readSectorsDeviceLBA : (
; prm     sectorcount : char
; prm     device : char
; prm     lba : int
; prm     buffer : * void
;     ) char
section .text
	global	_readSectorsDeviceLBA
_readSectorsDeviceLBA:
	push	bp
	mov	bp, sp
	 sub	sp,          6
; loc     sectorcount : (@4) : char
; loc     device : (@6) : char
; loc     lba : (@8) : int
; loc     buffer : (@10) : * void
; loc     head : (@-2) : char
; RPN'ized expression: "head 0 = "
; Expanded expression: "(@-2) 0 =(-1) "
; Fused expression:    "=(170) *(@-2) 0 "
	mov	ax, 0
	mov	[bp-2], ax
; loc     track : (@-4) : char
; RPN'ized expression: "track 0 = "
; Expanded expression: "(@-4) 0 =(-1) "
; Fused expression:    "=(170) *(@-4) 0 "
	mov	ax, 0
	mov	[bp-4], ax
; loc     sector : (@-6) : char
; RPN'ized expression: "sector 0 = "
; Expanded expression: "(@-6) 0 =(-1) "
; Fused expression:    "=(170) *(@-6) 0 "
	mov	ax, 0
	mov	[bp-6], ax
; RPN'ized expression: "head lba 18 2 * % 18 / = "
; Expanded expression: "(@-2) (@8) *(2) 36 % 18 / =(-1) "
; Fused expression:    "% *(@8) 36 / ax 18 =(122) *(@-2) ax "
	mov	ax, [bp+8]
	cwd
	mov	cx, 36
	idiv	cx
	mov	ax, dx
	cwd
	mov	cx, 18
	idiv	cx
	mov	[bp-2], al
	cbw
; RPN'ized expression: "track lba 18 2 * / = "
; Expanded expression: "(@-4) (@8) *(2) 36 / =(-1) "
; Fused expression:    "/ *(@8) 36 =(122) *(@-4) ax "
	mov	ax, [bp+8]
	cwd
	mov	cx, 36
	idiv	cx
	mov	[bp-4], al
	cbw
; RPN'ized expression: "sector lba 18 % 1 + = "
; Expanded expression: "(@-6) (@8) *(2) 18 % 1 + =(-1) "
; Fused expression:    "% *(@8) 18 + ax 1 =(122) *(@-6) ax "
	mov	ax, [bp+8]
	cwd
	mov	cx, 18
	idiv	cx
	mov	ax, dx
	inc	ax
	mov	[bp-6], al
	cbw
; RPN'ized expression: "( buffer , device , head , sector , track , sectorcount readSectorsDevice ) "
; Expanded expression: " (@10) *(2)  (@6) *(-1)  (@-2) *(-1)  (@-6) *(-1)  (@-4) *(-1)  (@4) *(-1)  readSectorsDevice ()12 "
; Fused expression:    "( *(2) (@10) , *(-1) (@6) , *(-1) (@-2) , *(-1) (@-6) , *(-1) (@-4) , *(-1) (@4) , readSectorsDevice )12 "
	push	word [bp+10]
	mov	al, [bp+6]
	cbw
	push	ax
	mov	al, [bp-2]
	cbw
	push	ax
	mov	al, [bp-6]
	cbw
	push	ax
	mov	al, [bp-4]
	cbw
	push	ax
	mov	al, [bp+4]
	cbw
	push	ax
	call	_readSectorsDevice
	sub	sp, -12
L104:
	leave
	ret

; glb draw : (
; prm     x : char
; prm     y : char
; prm     color : char
; prm     times : char
;     ) void
section .text
	global	_draw
_draw:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; loc     x : (@4) : char
; loc     y : (@6) : char
; loc     color : (@8) : char
; loc     times : (@10) : char
; RPN'ized expression: "( y , x curpos ) "
; Expanded expression: " (@6) *(-1)  (@4) *(-1)  curpos ()4 "
; Fused expression:    "( *(-1) (@6) , *(-1) (@4) , curpos )4 "
	mov	al, [bp+6]
	cbw
	push	ax
	mov	al, [bp+4]
	cbw
	push	ax
	call	_curpos
	sub	sp, -4
mov ah,0x09
mov al,0x00
mov bh,0x00
mov bl,[bp+8]
mov cx,[bp+10]
int 0x10
L106:
	leave
	ret

; glb readSectorsDevice : (
; prm     sectorcount : char
; prm     cylinder : char
; prm     sector : char
; prm     head : char
; prm     device : char
; prm     buffer : * void
;     ) char
section .text
	global	_readSectorsDevice
_readSectorsDevice:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; loc     sectorcount : (@4) : char
; loc     cylinder : (@6) : char
; loc     sector : (@8) : char
; loc     head : (@10) : char
; loc     device : (@12) : char
; loc     buffer : (@14) : * void
; if
; RPN'ized expression: "( device resetDevice ) "
; Expanded expression: " (@12) *(-1)  resetDevice ()2 "
; Fused expression:    "( *(-1) (@12) , resetDevice )2  "
	mov	al, [bp+12]
	cbw
	push	ax
	call	_resetDevice
	sub	sp, -2
; JumpIfZero
	test	ax, ax
	je	L110
; {
mov si, [bp+14]
mov bx, ds
mov es, bx
mov bx, si
mov ah, 0x02
mov al, [bp+4]
mov ch, [bp+6]
mov cl, [bp+8]
mov dh, [bp+10]
mov dl, [bp+12]
int 0x13
jc .skip
; return
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
; Fused expression:    "1  "
	mov	ax, 1
	jmp	L108
.skip:
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L108
; }
	jmp	L111
L110:
; else
; {
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L108
; }
L111:
L108:
	leave
	ret

; glb resetDevice : (
; prm     device : char
;     ) char
section .text
	global	_resetDevice
_resetDevice:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; loc     device : (@4) : char
mov dl,[bp+4]
mov ax,0
int 0x13
jc .skip
; return
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
; Fused expression:    "1  "
	mov	ax, 1
	jmp	L112
.skip:
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
L112:
	leave
	ret

; glb getc : () char
section .text
	global	_getc
_getc:
	push	bp
	mov	bp, sp
	;sub	sp,          0
mov ax,0
int 0x16
L114:
	leave
	ret

; glb getsc : () char
section .text
	global	_getsc
_getsc:
	push	bp
	mov	bp, sp
	;sub	sp,          0
mov ax,0
int 0x16
mov al,ah
L116:
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
	;sub	sp,          0
; loc     a : (@4) : char
mov ah,0x0e
int 0x10
L118:
	leave
	ret

; glb printf : (
; prm     text : * char
;     ) void
section .text
	global	_printf
_printf:
	push	bp
	mov	bp, sp
	 sub	sp,          4
; loc     text : (@4) : * char
; loc     deze : (@-2) : char
; RPN'ized expression: "deze 0 = "
; Expanded expression: "(@-2) 0 =(-1) "
; Fused expression:    "=(170) *(@-2) 0 "
	mov	ax, 0
	mov	[bp-2], ax
; loc     i : (@-4) : int
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-4) 0 =(2) "
; Fused expression:    "=(170) *(@-4) 0 "
	mov	ax, 0
	mov	[bp-4], ax
; while
; RPN'ized expression: "deze text i ++p + *u = 0 != "
; Expanded expression: "(@-2) (@4) *(2) (@-4) ++p(2) + *(-1) =(-1) 0 != "
L122:
; Fused expression:    "++p(2) *(@-4) + *(@4) ax =(119) *(@-2) *ax != ax 0 IF! "
	mov	ax, [bp-4]
	inc	word [bp-4]
	mov	cx, ax
	mov	ax, [bp+4]
	add	ax, cx
	mov	bx, ax
	mov	al, [bx]
	cbw
	mov	[bp-2], al
	cbw
	cmp	ax, 0
	je	L123
; {
; RPN'ized expression: "( deze putc ) "
; Expanded expression: " (@-2) *(-1)  putc ()2 "
; Fused expression:    "( *(-1) (@-2) , putc )2 "
	mov	al, [bp-2]
	cbw
	push	ax
	call	_putc
	sub	sp, -2
; }
	jmp	L122
L123:
L120:
	leave
	ret

; glb curpos : (
; prm     x : char
; prm     y : char
;     ) void
section .text
	global	_curpos
_curpos:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; loc     x : (@4) : char
; loc     y : (@6) : char
mov ah,0x02
mov dh,[bp+4]
mov dl,[bp+6]
mov bh,0
int 0x10
L124:
	leave
	ret

; glb cls : () void
section .text
	global	_cls
_cls:
	push	bp
	mov	bp, sp
	 sub	sp,          2
mov ah,0x02
mov dh,0
mov dl,0
mov bh,0
int 0x10
; for
; loc     y : (@-2) : int
; RPN'ized expression: "y 0 = "
; Expanded expression: "(@-2) 0 =(2) "
; Fused expression:    "=(170) *(@-2) 0 "
	mov	ax, 0
	mov	[bp-2], ax
L128:
; RPN'ized expression: "y 20 < "
; Expanded expression: "(@-2) *(2) 20 < "
; Fused expression:    "< *(@-2) 20 IF! "
	mov	ax, [bp-2]
	cmp	ax, 20
	jge	L131
; RPN'ized expression: "y ++p "
; Expanded expression: "(@-2) ++p(2) "
; {

section .rodata
L132:
	db	"                                                                          ",10,13
	times	1 db 0

section .text
; RPN'ized expression: "( L132 printf ) "
; Expanded expression: " L132  printf ()2 "
; Fused expression:    "( L132 , printf )2 "
	push	L132
	call	_printf
	sub	sp, -2
; }
L129:
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L128
L131:
mov ah,0x02
mov dh,0
mov dl,0
mov bh,0
int 0x10
L126:
	leave
	ret



; Syntax/declaration table/stack:
; Bytes used: 630/15360


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
; Ident loadFileByID
; Ident number
; Ident targetbuff
; Ident choose
; Ident alpha
; Ident setTitle
; Ident front
; Ident back
; Ident getFileList
; Ident readSectorsDeviceLBA
; Ident sectorcount
; Ident device
; Ident lba
; Ident buffer
; Ident draw
; Ident x
; Ident y
; Ident color
; Ident times
; Ident readSectorsDevice
; Ident cylinder
; Ident sector
; Ident head
; Ident resetDevice
; Ident getc
; Ident getsc
; Ident putc
; Ident a
; Ident printf
; Ident text
; Ident curpos
; Ident cls
; Bytes used: 401/5632

; Next label number: 133
; Compilation succeeded.
