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

section .rodata
L3:
	db	"==========================================================",10,13
	times	1 db 0

section .text
; RPN'ized expression: "( L3 printf ) "
; Expanded expression: " L3  printf ()2 "
; Fused expression:    "( L3 , printf )2 "
	push	L3
	call	_printf
	sub	sp, -2

section .rodata
L4:
	db	"S A N D E R S L A N D O   O P E R A T I N G   S Y S T E M ",10,13
	times	1 db 0

section .text
; RPN'ized expression: "( L4 printf ) "
; Expanded expression: " L4  printf ()2 "
; Fused expression:    "( L4 , printf )2 "
	push	L4
	call	_printf
	sub	sp, -2

section .rodata
L5:
	db	"==========================================================",10,13
	times	1 db 0

section .text
; RPN'ized expression: "( L5 printf ) "
; Expanded expression: " L5  printf ()2 "
; Fused expression:    "( L5 , printf )2 "
	push	L5
	call	_printf
	sub	sp, -2
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
; if
; RPN'ized expression: "( alpha loadFileByID ) "
; Expanded expression: " (@-4) *(2)  loadFileByID ()2 "
; Fused expression:    "( *(2) (@-4) , loadFileByID )2  "
	push	word [bp-4]
	call	_loadFileByID
	sub	sp, -2
; JumpIfZero
	test	ax, ax
	je	L6
; {

section .rodata
L8:
	db	"Bekijken;Uitvoeren;Terug"
	times	1 db 0

section .text
; RPN'ized expression: "alpha ( L8 choose ) = "
; Expanded expression: "(@-4)  L8  choose ()2 =(2) "
; Fused expression:    "( L8 , choose )2 =(170) *(@-4) ax "
	push	L8
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
	jne	L9
; {
; loc             base : (@-6) : int
; RPN'ized expression: "base 0 = "
; Expanded expression: "(@-6) 0 =(2) "
; Fused expression:    "=(170) *(@-6) 0 "
	mov	ax, 0
	mov	[bp-6], ax
; loc             buffer : (@-8) : * char
; loc             <something> : * char
; RPN'ized expression: "buffer 20480 (something11) = "
; Expanded expression: "(@-8) 20480 =(2) "
; Fused expression:    "=(170) *(@-8) 20480 "
	mov	ax, 20480
	mov	[bp-8], ax
; while
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
L12:
; {

section .rodata
L14:
	db	"Viewer"
	times	1 db 0

section .text

section .rodata
L15:
	db	"+ volgende 512 | - vorige 512 | e terug"
	times	1 db 0

section .text
; RPN'ized expression: "( L15 , L14 setTitle ) "
; Expanded expression: " L15  L14  setTitle ()4 "
; Fused expression:    "( L15 , L14 , setTitle )4 "
	push	L15
	push	L14
	call	_setTitle
	sub	sp, -4
; for
; loc                 i : (@-10) : int
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-10) 0 =(2) "
; Fused expression:    "=(170) *(@-10) 0 "
	mov	ax, 0
	mov	[bp-10], ax
L16:
; RPN'ized expression: "i 512 < "
; Expanded expression: "(@-10) *(2) 512 < "
; Fused expression:    "< *(@-10) 512 IF! "
	mov	ax, [bp-10]
	cmp	ax, 512
	jge	L19
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-10) ++p(2) "
; {
; RPN'ized expression: "( buffer base i + + *u putc ) "
; Expanded expression: " (@-8) *(2) (@-6) *(2) (@-10) *(2) + + *(-1)  putc ()2 "
; Fused expression:    "( + *(@-6) *(@-10) + *(@-8) ax *(-1) ax , putc )2 "
	mov	ax, [bp-6]
	add	ax, [bp-10]
	mov	cx, ax
	mov	ax, [bp-8]
	add	ax, cx
	mov	bx, ax
	mov	al, [bx]
	cbw
	push	ax
	call	_putc
	sub	sp, -2
; }
L17:
; Fused expression:    "++p(2) *(@-10) "
	mov	ax, [bp-10]
	inc	word [bp-10]
	jmp	L16
L19:
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
	jne	L20
; {
; RPN'ized expression: "base 512 += "
; Expanded expression: "(@-6) 512 +=(2) "
; Fused expression:    "+=(170) *(@-6) 512 "
	mov	ax, [bp-6]
	add	ax, 512
	mov	[bp-6], ax
; }
L20:
; if
; RPN'ized expression: "x 45 == "
; Expanded expression: "(@-10) *(-1) 45 == "
; Fused expression:    "== *(@-10) 45 IF! "
	mov	al, [bp-10]
	cbw
	cmp	ax, 45
	jne	L22
; {
; RPN'ized expression: "base 512 -= "
; Expanded expression: "(@-6) 512 -=(2) "
; Fused expression:    "-=(170) *(@-6) 512 "
	mov	ax, [bp-6]
	sub	ax, 512
	mov	[bp-6], ax
; }
L22:
; if
; RPN'ized expression: "x 101 == "
; Expanded expression: "(@-10) *(-1) 101 == "
; Fused expression:    "== *(@-10) 101 IF! "
	mov	al, [bp-10]
	cbw
	cmp	ax, 101
	jne	L24
; {
jmp _main
; }
L24:
; }
	jmp	L12
L13:
; }
	jmp	L10
L9:
; else
; if
; RPN'ized expression: "alpha 1 == "
; Expanded expression: "(@-4) *(2) 1 == "
; Fused expression:    "== *(@-4) 1 IF! "
	mov	ax, [bp-4]
	cmp	ax, 1
	jne	L26
; {
call 0x5000
; RPN'ized expression: "( getc ) "
; Expanded expression: " getc ()0 "
; Fused expression:    "( getc )0 "
	call	_getc
; }
	jmp	L27
L26:
; else
; if
; RPN'ized expression: "alpha 2 == "
; Expanded expression: "(@-4) *(2) 2 == "
; Fused expression:    "== *(@-4) 2 IF! "
	mov	ax, [bp-4]
	cmp	ax, 2
	jne	L28
; {
; }
L28:
L27:
L10:
; }
	jmp	L7
L6:
; else
; {

section .rodata
L30:
	db	"INIT: Unable to load file"
	times	1 db 0

section .text
; RPN'ized expression: "( L30 printf ) "
; Expanded expression: " L30  printf ()2 "
; Fused expression:    "( L30 , printf )2 "
	push	L30
	call	_printf
	sub	sp, -2
; }
L7:
jmp _main
; for
L31:
	jmp	L31
L34:
; Fused expression:    "0  "
	mov	ax, 0
L1:
	leave
	ret

; glb loadFileByID : (
; prm     number : int
;     ) char
section .text
	global	_loadFileByID
_loadFileByID:
	push	bp
	mov	bp, sp
	 sub	sp,         12
; loc     number : (@4) : int
; loc     buffer : (@-2) : * char
; loc     <something> : * char
; RPN'ized expression: "buffer 4096 (something37) = "
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
	je	L38
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
L40:
; RPN'ized expression: "i 20 < "
; Expanded expression: "(@-10) *(2) 20 < "
; Fused expression:    "< *(@-10) 20 IF! "
	mov	ax, [bp-10]
	cmp	ax, 20
	jge	L43
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
	je	L44
; {
; if
; RPN'ized expression: "number index == "
; Expanded expression: "(@4) *(2) (@-4) *(2) == "
; Fused expression:    "== *(@4) *(@-4) IF! "
	mov	ax, [bp+4]
	cmp	ax, [bp-4]
	jne	L46
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
	jmp	L43
; }
L46:
; RPN'ized expression: "index ++p "
; Expanded expression: "(@-4) ++p(2) "
; Fused expression:    "++p(2) *(@-4) "
	mov	ax, [bp-4]
	inc	word [bp-4]
; }
L44:
; }
L41:
; Fused expression:    "++p(2) *(@-10) "
	mov	ax, [bp-10]
	inc	word [bp-10]
	jmp	L40
L43:
; return
; RPN'ized expression: "( 20480 , deze 31 + , 0 , andere 512 / 1 + readSectorsDeviceLBA ) "
; Expanded expression: " 20480  (@-6) *(-1) 31 +  0  (@-8) *(2) 512 / 1 +  readSectorsDeviceLBA ()8 "
; Fused expression:    "( 20480 , + *(@-6) 31 , 0 , / *(@-8) 512 + ax 1 , readSectorsDeviceLBA )8 signed char  "
	push	20480
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
	jmp	L35
; }
L38:
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
L35:
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
L50:
; {
; RPN'ized expression: "( cls ) "
; Expanded expression: " cls ()0 "
; Fused expression:    "( cls )0 "
	call	_cls

section .rodata
L52:
	db	"Selecteer een optie"
	times	1 db 0

section .text

section .rodata
L53:
	db	"Pijltjestoetsen: Navigeer | 9 : Selecteer"
	times	1 db 0

section .text
; RPN'ized expression: "( L53 , L52 setTitle ) "
; Expanded expression: " L53  L52  setTitle ()4 "
; Fused expression:    "( L53 , L52 , setTitle )4 "
	push	L53
	push	L52
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
	jne	L54
; {

section .rodata
L56:
	db	">>> "
	times	1 db 0

section .text
; RPN'ized expression: "( L56 printf ) "
; Expanded expression: " L56  printf ()2 "
; Fused expression:    "( L56 , printf )2 "
	push	L56
	call	_printf
	sub	sp, -2
; }
	jmp	L55
L54:
; else
; {

section .rodata
L57:
	db	"--- "
	times	1 db 0

section .text
; RPN'ized expression: "( L57 printf ) "
; Expanded expression: " L57  printf ()2 "
; Fused expression:    "( L57 , printf )2 "
	push	L57
	call	_printf
	sub	sp, -2
; }
L55:
; while
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
L58:
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
	jne	L60
; {
; RPN'ized expression: "rowpointer ++p "
; Expanded expression: "(@-4) ++p(2) "
; Fused expression:    "++p(2) *(@-4) "
	mov	ax, [bp-4]
	inc	word [bp-4]
; break
	jmp	L59
; }
	jmp	L61
L60:
; else
; if
; RPN'ized expression: "deze 59 == "
; Expanded expression: "(@-8) *(-1) 59 == "
; Fused expression:    "== *(@-8) 59 IF! "
	mov	al, [bp-8]
	cbw
	cmp	ax, 59
	jne	L62
; {

section .rodata
L64:
	db	10,13
	times	1 db 0

section .text
; RPN'ized expression: "( L64 printf ) "
; Expanded expression: " L64  printf ()2 "
; Fused expression:    "( L64 , printf )2 "
	push	L64
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
	jne	L65
; {

section .rodata
L67:
	db	">>> "
	times	1 db 0

section .text
; RPN'ized expression: "( L67 printf ) "
; Expanded expression: " L67  printf ()2 "
; Fused expression:    "( L67 , printf )2 "
	push	L67
	call	_printf
	sub	sp, -2
; }
	jmp	L66
L65:
; else
; {

section .rodata
L68:
	db	"--- "
	times	1 db 0

section .text
; RPN'ized expression: "( L68 printf ) "
; Expanded expression: " L68  printf ()2 "
; Fused expression:    "( L68 , printf )2 "
	push	L68
	call	_printf
	sub	sp, -2
; }
L66:
; }
	jmp	L63
L62:
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
L63:
L61:
; }
	jmp	L58
L59:

section .rodata
L69:
	db	10,13
	times	1 db 0

section .text
; RPN'ized expression: "( L69 printf ) "
; Expanded expression: " L69  printf ()2 "
; Fused expression:    "( L69 , printf )2 "
	push	L69
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
	jne	L70
; {
; if
; RPN'ized expression: "pointer 0 != "
; Expanded expression: "(@-2) *(2) 0 != "
; Fused expression:    "!= *(@-2) 0 IF! "
	mov	ax, [bp-2]
	cmp	ax, 0
	je	L72
; {
; RPN'ized expression: "pointer --p "
; Expanded expression: "(@-2) --p(2) "
; Fused expression:    "--p(2) *(@-2) "
	mov	ax, [bp-2]
	dec	word [bp-2]
; }
L72:
; }
	jmp	L71
L70:
; else
; if
; RPN'ized expression: "et 80 == "
; Expanded expression: "(@-8) *(-1) 80 == "
; Fused expression:    "== *(@-8) 80 IF! "
	mov	al, [bp-8]
	cbw
	cmp	ax, 80
	jne	L74
; {
; if
; RPN'ized expression: "pointer rowpointer != "
; Expanded expression: "(@-2) *(2) (@-4) *(2) != "
; Fused expression:    "!= *(@-2) *(@-4) IF! "
	mov	ax, [bp-2]
	cmp	ax, [bp-4]
	je	L76
; {
; RPN'ized expression: "pointer ++p "
; Expanded expression: "(@-2) ++p(2) "
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
; }
L76:
; }
	jmp	L75
L74:
; else
; if
; RPN'ized expression: "et 13 == "
; Expanded expression: "(@-8) *(-1) 13 == "
; Fused expression:    "== *(@-8) 13 IF! "
	mov	al, [bp-8]
	cbw
	cmp	ax, 13
	jne	L78
; {
; break
	jmp	L51
; }
L78:
L75:
L71:
; }
	jmp	L50
L51:
; return
; RPN'ized expression: "pointer "
; Expanded expression: "(@-2) *(2) "
; Fused expression:    "*(2) (@-2)  "
	mov	ax, [bp-2]
L48:
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
L82:
; RPN'ized expression: "i 24 < "
; Expanded expression: "(@-2) *(2) 24 < "
; Fused expression:    "< *(@-2) 24 IF! "
	mov	ax, [bp-2]
	cmp	ax, 24
	jge	L85
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
L83:
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L82
L85:
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
L86:
	db	"SanderOS16"
	times	1 db 0

section .text
; RPN'ized expression: "( L86 printf ) "
; Expanded expression: " L86  printf ()2 "
; Fused expression:    "( L86 , printf )2 "
	push	L86
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
L80:
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
; RPN'ized expression: "buffer 4096 (something89) = "
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
	je	L90
; {
; for
; loc         index : (@-108) : int
; RPN'ized expression: "index 0 = "
; Expanded expression: "(@-108) 0 =(2) "
; Fused expression:    "=(170) *(@-108) 0 "
	mov	ax, 0
	mov	[bp-108], ax
L92:
; RPN'ized expression: "index 20 < "
; Expanded expression: "(@-108) *(2) 20 < "
; Fused expression:    "< *(@-108) 20 IF! "
	mov	ax, [bp-108]
	cmp	ax, 20
	jge	L95
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
	je	L96
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
	jne	L98
; {
; break
	jmp	L95
; }
L98:
; if
; RPN'ized expression: "first "
; Expanded expression: "(@-106) *(-1) "
; Fused expression:    "*(-1) (@-106)  "
	mov	al, [bp-106]
	cbw
; JumpIfZero
	test	ax, ax
	je	L100
; {
; RPN'ized expression: "first 0 = "
; Expanded expression: "(@-106) 0 =(-1) "
; Fused expression:    "=(122) *(@-106) 0 "
	mov	ax, 0
	mov	[bp-106], al
	cbw
; }
	jmp	L101
L100:
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
L101:
; for
; loc                 i : (@-110) : int
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-110) 0 =(2) "
; Fused expression:    "=(170) *(@-110) 0 "
	mov	ax, 0
	mov	[bp-110], ax
L102:
; RPN'ized expression: "i 11 < "
; Expanded expression: "(@-110) *(2) 11 < "
; Fused expression:    "< *(@-110) 11 IF! "
	mov	ax, [bp-110]
	cmp	ax, 11
	jge	L105
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
L103:
; Fused expression:    "++p(2) *(@-110) "
	mov	ax, [bp-110]
	inc	word [bp-110]
	jmp	L102
L105:
; }
L96:
; }
L93:
; Fused expression:    "++p(2) *(@-108) "
	mov	ax, [bp-108]
	inc	word [bp-108]
	jmp	L92
L95:
; }
	jmp	L91
L90:
; else
; {

section .rodata
L106:
	db	"DEV: cannot read",10,13
	times	1 db 0

section .text
; RPN'ized expression: "( L106 printf ) "
; Expanded expression: " L106  printf ()2 "
; Fused expression:    "( L106 , printf )2 "
	push	L106
	call	_printf
	sub	sp, -2
; }
L91:
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
L87:
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
L107:
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
L109:
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
	je	L113
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
	jmp	L111
.skip:
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L111
; }
	jmp	L114
L113:
; else
; {
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L111
; }
L114:
L111:
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
	jmp	L115
.skip:
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
L115:
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
L117:
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
L119:
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
L121:
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
L125:
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
	je	L126
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
	jmp	L125
L126:
L123:
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
L127:
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
L131:
; RPN'ized expression: "y 20 < "
; Expanded expression: "(@-2) *(2) 20 < "
; Fused expression:    "< *(@-2) 20 IF! "
	mov	ax, [bp-2]
	cmp	ax, 20
	jge	L134
; RPN'ized expression: "y ++p "
; Expanded expression: "(@-2) ++p(2) "
; {

section .rodata
L135:
	db	"                                                                          ",10,13
	times	1 db 0

section .text
; RPN'ized expression: "( L135 printf ) "
; Expanded expression: " L135  printf ()2 "
; Fused expression:    "( L135 , printf )2 "
	push	L135
	call	_printf
	sub	sp, -2
; }
L132:
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L131
L134:
mov ah,0x02
mov dh,0
mov dl,0
mov bh,0
int 0x10
L129:
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
; Ident loadFileByID
; Ident number
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
; Bytes used: 389/5632

; Next label number: 136
; Compilation succeeded.
