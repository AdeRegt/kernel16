bits 16

; glb main : () void
section .text
	global	_main
_main:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; RPN'ized expression: "( hideCursor ) "
; Expanded expression: " hideCursor ()0 "
; Fused expression:    "( hideCursor )0 "
	call	_hideCursor
; if

section .rodata
L5:
	db	"AUTORUN BIN"
	times	1 db 0

section .text
; RPN'ized expression: "( 16384 , L5 fread ) "
; Expanded expression: " 16384  L5  fread ()4 "
; Fused expression:    "( 16384 , L5 , fread )4  "
	push	16384
	push	L5
	call	_fread
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L3
; {
call 0x4000
; }
L3:
; if

section .rodata
L8:
	db	"FILEMAN BIN"
	times	1 db 0

section .text
; RPN'ized expression: "( 16384 , L8 fread ) "
; Expanded expression: " 16384  L8  fread ()4 "
; Fused expression:    "( 16384 , L8 , fread )4  "
	push	16384
	push	L8
	call	_fread
	sub	sp, -4
; JumpIfZero
	test	ax, ax
	je	L6
; {
call 0x4000
; }
	jmp	L7
L6:
; else
; {

section .rodata
L9:
	db	"Unable to load filemanager"
	times	1 db 0

section .text
; RPN'ized expression: "( L9 printf ) "
; Expanded expression: " L9  printf ()2 "
; Fused expression:    "( L9 , printf )2 "
	push	L9
	call	_printf
	sub	sp, -2
; }
L7:
; for
L10:
	jmp	L10
L13:
; Fused expression:    "0  "
	mov	ax, 0
L1:
	leave
	ret

; glb hideCursor : () void
section .text
	global	_hideCursor
_hideCursor:
	push	bp
	mov	bp, sp
	;sub	sp,          0
mov ch, 32
mov ah, 1
mov al, 3
int 10h
L14:
	leave
	ret

; glb fexists : (
; prm     filename : * char
;     ) char
section .text
	global	_fexists
_fexists:
	push	bp
	mov	bp, sp
	 sub	sp,         16
; loc     filename : (@4) : * char
; loc     filelist : (@-2) : * char
; RPN'ized expression: "filelist ( getFileList ) = "
; Expanded expression: "(@-2)  getFileList ()0 =(2) "
; Fused expression:    "( getFileList )0 =(170) *(@-2) ax "
	call	_getFileList
	mov	[bp-2], ax
; loc     probing : (@-4) : int
; RPN'ized expression: "probing 0 = "
; Expanded expression: "(@-4) 0 =(2) "
; Fused expression:    "=(170) *(@-4) 0 "
	mov	ax, 0
	mov	[bp-4], ax
; loc     insmod : (@-6) : int
; RPN'ized expression: "insmod 0 = "
; Expanded expression: "(@-6) 0 =(2) "
; Fused expression:    "=(170) *(@-6) 0 "
	mov	ax, 0
	mov	[bp-6], ax
; while
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
L18:
; {
; loc         thx : (@-8) : char
; RPN'ized expression: "thx filelist insmod + *u = "
; Expanded expression: "(@-8) (@-2) *(2) (@-6) *(2) + *(-1) =(-1) "
; Fused expression:    "+ *(@-2) *(@-6) =(167) *(@-8) *ax "
	mov	ax, [bp-2]
	add	ax, [bp-6]
	mov	bx, ax
	mov	al, [bx]
	cbw
	mov	[bp-8], ax
; if
; RPN'ized expression: "thx 0 == "
; Expanded expression: "(@-8) *(-1) 0 == "
; Fused expression:    "== *(@-8) 0 IF! "
	mov	al, [bp-8]
	cbw
	cmp	ax, 0
	jne	L20
; {
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L16
; }
L20:
; loc         tmp : (@-10) : int
; RPN'ized expression: "tmp 1 = "
; Expanded expression: "(@-10) 1 =(2) "
; Fused expression:    "=(170) *(@-10) 1 "
	mov	ax, 1
	mov	[bp-10], ax
; for
; loc         i : (@-12) : int
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-12) 0 =(2) "
; Fused expression:    "=(170) *(@-12) 0 "
	mov	ax, 0
	mov	[bp-12], ax
L22:
; RPN'ized expression: "i 11 < "
; Expanded expression: "(@-12) *(2) 11 < "
; Fused expression:    "< *(@-12) 11 IF! "
	mov	ax, [bp-12]
	cmp	ax, 11
	jge	L25
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-12) ++p(2) "
; {
; loc             X : (@-14) : char
; RPN'ized expression: "X filelist insmod ++p + *u = "
; Expanded expression: "(@-14) (@-2) *(2) (@-6) ++p(2) + *(-1) =(-1) "
; Fused expression:    "++p(2) *(@-6) + *(@-2) ax =(167) *(@-14) *ax "
	mov	ax, [bp-6]
	inc	word [bp-6]
	mov	cx, ax
	mov	ax, [bp-2]
	add	ax, cx
	mov	bx, ax
	mov	al, [bx]
	cbw
	mov	[bp-14], ax
; loc             Y : (@-16) : char
; RPN'ized expression: "Y filename i + *u = "
; Expanded expression: "(@-16) (@4) *(2) (@-12) *(2) + *(-1) =(-1) "
; Fused expression:    "+ *(@4) *(@-12) =(167) *(@-16) *ax "
	mov	ax, [bp+4]
	add	ax, [bp-12]
	mov	bx, ax
	mov	al, [bx]
	cbw
	mov	[bp-16], ax
; if
; RPN'ized expression: "X Y != "
; Expanded expression: "(@-14) *(-1) (@-16) *(-1) != "
; Fused expression:    "!= *(@-14) *(@-16) IF! "
	mov	al, [bp-14]
	cbw
	movsx	cx, byte [bp-16]
	cmp	ax, cx
	je	L26
; {
; RPN'ized expression: "tmp 0 = "
; Expanded expression: "(@-10) 0 =(2) "
; Fused expression:    "=(170) *(@-10) 0 "
	mov	ax, 0
	mov	[bp-10], ax
; }
L26:
; }
L23:
; Fused expression:    "++p(2) *(@-12) "
	mov	ax, [bp-12]
	inc	word [bp-12]
	jmp	L22
L25:
; if
; RPN'ized expression: "tmp 1 == "
; Expanded expression: "(@-10) *(2) 1 == "
; Fused expression:    "== *(@-10) 1 IF! "
	mov	ax, [bp-10]
	cmp	ax, 1
	jne	L28
; {
; goto second
	jmp	L30
; }
L28:
; loc         X : (@-12) : char
; RPN'ized expression: "X filelist insmod ++p + *u = "
; Expanded expression: "(@-12) (@-2) *(2) (@-6) ++p(2) + *(-1) =(-1) "
; Fused expression:    "++p(2) *(@-6) + *(@-2) ax =(167) *(@-12) *ax "
	mov	ax, [bp-6]
	inc	word [bp-6]
	mov	cx, ax
	mov	ax, [bp-2]
	add	ax, cx
	mov	bx, ax
	mov	al, [bx]
	cbw
	mov	[bp-12], ax
; if
; RPN'ized expression: "X 0 == "
; Expanded expression: "(@-12) *(-1) 0 == "
; Fused expression:    "== *(@-12) 0 IF! "
	mov	al, [bp-12]
	cbw
	cmp	ax, 0
	jne	L31
; {
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L16
; }
L31:
; RPN'ized expression: "probing ++p "
; Expanded expression: "(@-4) ++p(2) "
; Fused expression:    "++p(2) *(@-4) "
	mov	ax, [bp-4]
	inc	word [bp-4]
; }
	jmp	L18
L19:
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L16
; second:
L30:
; return
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
; Fused expression:    "1  "
	mov	ax, 1
L16:
	leave
	ret

; glb fnew : (
; prm     filename : * char
;     ) char
section .text
	global	_fnew
_fnew:
	push	bp
	mov	bp, sp
	;sub	sp,          0
; loc     filename : (@4) : * char
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
L33:
	leave
	ret

; glb fread : (
; prm     filename : * char
; prm     location : * void
;     ) char
section .text
	global	_fread
_fread:
	push	bp
	mov	bp, sp
	 sub	sp,         16
; loc     filename : (@4) : * char
; loc     location : (@6) : * void
; loc     filelist : (@-2) : * char
; RPN'ized expression: "filelist ( getFileList ) = "
; Expanded expression: "(@-2)  getFileList ()0 =(2) "
; Fused expression:    "( getFileList )0 =(170) *(@-2) ax "
	call	_getFileList
	mov	[bp-2], ax
; loc     probing : (@-4) : int
; RPN'ized expression: "probing 0 = "
; Expanded expression: "(@-4) 0 =(2) "
; Fused expression:    "=(170) *(@-4) 0 "
	mov	ax, 0
	mov	[bp-4], ax
; loc     insmod : (@-6) : int
; RPN'ized expression: "insmod 0 = "
; Expanded expression: "(@-6) 0 =(2) "
; Fused expression:    "=(170) *(@-6) 0 "
	mov	ax, 0
	mov	[bp-6], ax
; while
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
L37:
; {
; loc         thx : (@-8) : char
; RPN'ized expression: "thx filelist insmod + *u = "
; Expanded expression: "(@-8) (@-2) *(2) (@-6) *(2) + *(-1) =(-1) "
; Fused expression:    "+ *(@-2) *(@-6) =(167) *(@-8) *ax "
	mov	ax, [bp-2]
	add	ax, [bp-6]
	mov	bx, ax
	mov	al, [bx]
	cbw
	mov	[bp-8], ax
; if
; RPN'ized expression: "thx 0 == "
; Expanded expression: "(@-8) *(-1) 0 == "
; Fused expression:    "== *(@-8) 0 IF! "
	mov	al, [bp-8]
	cbw
	cmp	ax, 0
	jne	L39
; {
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L35
; }
L39:
; loc         tmp : (@-10) : int
; RPN'ized expression: "tmp 1 = "
; Expanded expression: "(@-10) 1 =(2) "
; Fused expression:    "=(170) *(@-10) 1 "
	mov	ax, 1
	mov	[bp-10], ax
; for
; loc         i : (@-12) : int
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-12) 0 =(2) "
; Fused expression:    "=(170) *(@-12) 0 "
	mov	ax, 0
	mov	[bp-12], ax
L41:
; RPN'ized expression: "i 11 < "
; Expanded expression: "(@-12) *(2) 11 < "
; Fused expression:    "< *(@-12) 11 IF! "
	mov	ax, [bp-12]
	cmp	ax, 11
	jge	L44
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-12) ++p(2) "
; {
; loc             X : (@-14) : char
; RPN'ized expression: "X filelist insmod ++p + *u = "
; Expanded expression: "(@-14) (@-2) *(2) (@-6) ++p(2) + *(-1) =(-1) "
; Fused expression:    "++p(2) *(@-6) + *(@-2) ax =(167) *(@-14) *ax "
	mov	ax, [bp-6]
	inc	word [bp-6]
	mov	cx, ax
	mov	ax, [bp-2]
	add	ax, cx
	mov	bx, ax
	mov	al, [bx]
	cbw
	mov	[bp-14], ax
; loc             Y : (@-16) : char
; RPN'ized expression: "Y filename i + *u = "
; Expanded expression: "(@-16) (@4) *(2) (@-12) *(2) + *(-1) =(-1) "
; Fused expression:    "+ *(@4) *(@-12) =(167) *(@-16) *ax "
	mov	ax, [bp+4]
	add	ax, [bp-12]
	mov	bx, ax
	mov	al, [bx]
	cbw
	mov	[bp-16], ax
; if
; RPN'ized expression: "X Y != "
; Expanded expression: "(@-14) *(-1) (@-16) *(-1) != "
; Fused expression:    "!= *(@-14) *(@-16) IF! "
	mov	al, [bp-14]
	cbw
	movsx	cx, byte [bp-16]
	cmp	ax, cx
	je	L45
; {
; RPN'ized expression: "tmp 0 = "
; Expanded expression: "(@-10) 0 =(2) "
; Fused expression:    "=(170) *(@-10) 0 "
	mov	ax, 0
	mov	[bp-10], ax
; }
L45:
; }
L42:
; Fused expression:    "++p(2) *(@-12) "
	mov	ax, [bp-12]
	inc	word [bp-12]
	jmp	L41
L44:
; if
; RPN'ized expression: "tmp 1 == "
; Expanded expression: "(@-10) *(2) 1 == "
; Fused expression:    "== *(@-10) 1 IF! "
	mov	ax, [bp-10]
	cmp	ax, 1
	jne	L47
; {
; goto second
	jmp	L49
; }
L47:
; loc         X : (@-12) : char
; RPN'ized expression: "X filelist insmod ++p + *u = "
; Expanded expression: "(@-12) (@-2) *(2) (@-6) ++p(2) + *(-1) =(-1) "
; Fused expression:    "++p(2) *(@-6) + *(@-2) ax =(167) *(@-12) *ax "
	mov	ax, [bp-6]
	inc	word [bp-6]
	mov	cx, ax
	mov	ax, [bp-2]
	add	ax, cx
	mov	bx, ax
	mov	al, [bx]
	cbw
	mov	[bp-12], ax
; if
; RPN'ized expression: "X 0 == "
; Expanded expression: "(@-12) *(-1) 0 == "
; Fused expression:    "== *(@-12) 0 IF! "
	mov	al, [bp-12]
	cbw
	cmp	ax, 0
	jne	L50
; {
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L35
; }
L50:
; RPN'ized expression: "probing ++p "
; Expanded expression: "(@-4) ++p(2) "
; Fused expression:    "++p(2) *(@-4) "
	mov	ax, [bp-4]
	inc	word [bp-4]
; }
	jmp	L37
L38:
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L35
; second:
L49:
; return
; RPN'ized expression: "( location , probing loadFileByID ) "
; Expanded expression: " (@6) *(2)  (@-4) *(2)  loadFileByID ()4 "
; Fused expression:    "( *(2) (@6) , *(2) (@-4) , loadFileByID )4 signed char  "
	push	word [bp+6]
	push	word [bp-4]
	call	_loadFileByID
	sub	sp, -4
	cbw
L35:
	leave
	ret

; glb fwrite : (
; prm     filename : * char
; prm     location : * void
; prm     size : int
;     ) char
section .text
	global	_fwrite
_fwrite:
	push	bp
	mov	bp, sp
	 sub	sp,         16
; loc     filename : (@4) : * char
; loc     location : (@6) : * void
; loc     size : (@8) : int
; if
; RPN'ized expression: "( filename fexists ) 0 == "
; Expanded expression: " (@4) *(2)  fexists ()2 0 == "
; Fused expression:    "( *(2) (@4) , fexists )2 == ax 0 IF! "
	push	word [bp+4]
	call	_fexists
	sub	sp, -2
	cmp	ax, 0
	jne	L54
; {
; RPN'ized expression: "( filename fnew ) "
; Expanded expression: " (@4) *(2)  fnew ()2 "
; Fused expression:    "( *(2) (@4) , fnew )2 "
	push	word [bp+4]
	call	_fnew
	sub	sp, -2
; }
L54:
; loc     filelist : (@-2) : * char
; RPN'ized expression: "filelist ( getFileList ) = "
; Expanded expression: "(@-2)  getFileList ()0 =(2) "
; Fused expression:    "( getFileList )0 =(170) *(@-2) ax "
	call	_getFileList
	mov	[bp-2], ax
; loc     probing : (@-4) : int
; RPN'ized expression: "probing 0 = "
; Expanded expression: "(@-4) 0 =(2) "
; Fused expression:    "=(170) *(@-4) 0 "
	mov	ax, 0
	mov	[bp-4], ax
; loc     insmod : (@-6) : int
; RPN'ized expression: "insmod 0 = "
; Expanded expression: "(@-6) 0 =(2) "
; Fused expression:    "=(170) *(@-6) 0 "
	mov	ax, 0
	mov	[bp-6], ax
; while
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
L56:
; {
; loc         thx : (@-8) : char
; RPN'ized expression: "thx filelist insmod + *u = "
; Expanded expression: "(@-8) (@-2) *(2) (@-6) *(2) + *(-1) =(-1) "
; Fused expression:    "+ *(@-2) *(@-6) =(167) *(@-8) *ax "
	mov	ax, [bp-2]
	add	ax, [bp-6]
	mov	bx, ax
	mov	al, [bx]
	cbw
	mov	[bp-8], ax
; if
; RPN'ized expression: "thx 0 == "
; Expanded expression: "(@-8) *(-1) 0 == "
; Fused expression:    "== *(@-8) 0 IF! "
	mov	al, [bp-8]
	cbw
	cmp	ax, 0
	jne	L58
; {
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L52
; }
L58:
; loc         tmp : (@-10) : int
; RPN'ized expression: "tmp 1 = "
; Expanded expression: "(@-10) 1 =(2) "
; Fused expression:    "=(170) *(@-10) 1 "
	mov	ax, 1
	mov	[bp-10], ax
; for
; loc         i : (@-12) : int
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-12) 0 =(2) "
; Fused expression:    "=(170) *(@-12) 0 "
	mov	ax, 0
	mov	[bp-12], ax
L60:
; RPN'ized expression: "i 11 < "
; Expanded expression: "(@-12) *(2) 11 < "
; Fused expression:    "< *(@-12) 11 IF! "
	mov	ax, [bp-12]
	cmp	ax, 11
	jge	L63
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-12) ++p(2) "
; {
; loc             X : (@-14) : char
; RPN'ized expression: "X filelist insmod ++p + *u = "
; Expanded expression: "(@-14) (@-2) *(2) (@-6) ++p(2) + *(-1) =(-1) "
; Fused expression:    "++p(2) *(@-6) + *(@-2) ax =(167) *(@-14) *ax "
	mov	ax, [bp-6]
	inc	word [bp-6]
	mov	cx, ax
	mov	ax, [bp-2]
	add	ax, cx
	mov	bx, ax
	mov	al, [bx]
	cbw
	mov	[bp-14], ax
; loc             Y : (@-16) : char
; RPN'ized expression: "Y filename i + *u = "
; Expanded expression: "(@-16) (@4) *(2) (@-12) *(2) + *(-1) =(-1) "
; Fused expression:    "+ *(@4) *(@-12) =(167) *(@-16) *ax "
	mov	ax, [bp+4]
	add	ax, [bp-12]
	mov	bx, ax
	mov	al, [bx]
	cbw
	mov	[bp-16], ax
; if
; RPN'ized expression: "X Y != "
; Expanded expression: "(@-14) *(-1) (@-16) *(-1) != "
; Fused expression:    "!= *(@-14) *(@-16) IF! "
	mov	al, [bp-14]
	cbw
	movsx	cx, byte [bp-16]
	cmp	ax, cx
	je	L64
; {
; RPN'ized expression: "tmp 0 = "
; Expanded expression: "(@-10) 0 =(2) "
; Fused expression:    "=(170) *(@-10) 0 "
	mov	ax, 0
	mov	[bp-10], ax
; }
L64:
; }
L61:
; Fused expression:    "++p(2) *(@-12) "
	mov	ax, [bp-12]
	inc	word [bp-12]
	jmp	L60
L63:
; if
; RPN'ized expression: "tmp 1 == "
; Expanded expression: "(@-10) *(2) 1 == "
; Fused expression:    "== *(@-10) 1 IF! "
	mov	ax, [bp-10]
	cmp	ax, 1
	jne	L66
; {
; goto second
	jmp	L68
; }
L66:
; loc         X : (@-12) : char
; RPN'ized expression: "X filelist insmod ++p + *u = "
; Expanded expression: "(@-12) (@-2) *(2) (@-6) ++p(2) + *(-1) =(-1) "
; Fused expression:    "++p(2) *(@-6) + *(@-2) ax =(167) *(@-12) *ax "
	mov	ax, [bp-6]
	inc	word [bp-6]
	mov	cx, ax
	mov	ax, [bp-2]
	add	ax, cx
	mov	bx, ax
	mov	al, [bx]
	cbw
	mov	[bp-12], ax
; if
; RPN'ized expression: "X 0 == "
; Expanded expression: "(@-12) *(-1) 0 == "
; Fused expression:    "== *(@-12) 0 IF! "
	mov	al, [bp-12]
	cbw
	cmp	ax, 0
	jne	L69
; {
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L52
; }
L69:
; RPN'ized expression: "probing ++p "
; Expanded expression: "(@-4) ++p(2) "
; Fused expression:    "++p(2) *(@-4) "
	mov	ax, [bp-4]
	inc	word [bp-4]
; }
	jmp	L56
L57:
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L52
; second:
L68:
; return
; RPN'ized expression: "( size , location , probing writeFileByID ) "
; Expanded expression: " (@8) *(2)  (@6) *(2)  (@-4) *(2)  writeFileByID ()6 "
; Fused expression:    "( *(2) (@8) , *(2) (@6) , *(2) (@-4) , writeFileByID )6 signed char  "
	push	word [bp+8]
	push	word [bp+6]
	push	word [bp-4]
	call	_writeFileByID
	sub	sp, -6
	cbw
L52:
	leave
	ret

; glb writeFileByID : (
; prm     number : int
; prm     targetbuff : * void
; prm     size : int
;     ) char
section .text
	global	_writeFileByID
_writeFileByID:
	push	bp
	mov	bp, sp
	 sub	sp,         14
; loc     number : (@4) : int
; loc     targetbuff : (@6) : * void
; loc     size : (@8) : int
; loc     buffer : (@-2) : * char
; loc     <something> : * char
; RPN'ized expression: "buffer 4096 (something73) = "
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
	je	L74
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
; loc         samatics : (@-10) : int
; RPN'ized expression: "samatics 0 = "
; Expanded expression: "(@-10) 0 =(2) "
; Fused expression:    "=(170) *(@-10) 0 "
	mov	ax, 0
	mov	[bp-10], ax
; for
; loc         i : (@-12) : int
; RPN'ized expression: "i 1 = "
; Expanded expression: "(@-12) 1 =(2) "
; Fused expression:    "=(170) *(@-12) 1 "
	mov	ax, 1
	mov	[bp-12], ax
L76:
; RPN'ized expression: "i 20 < "
; Expanded expression: "(@-12) *(2) 20 < "
; Fused expression:    "< *(@-12) 20 IF! "
	mov	ax, [bp-12]
	cmp	ax, 20
	jge	L79
; RPN'ized expression: "i ++p "
; Expanded expression: "(@-12) ++p(2) "
; {
; loc             semaphore : (@-14) : int
; RPN'ized expression: "semaphore i 32 * = "
; Expanded expression: "(@-14) (@-12) *(2) 32 * =(2) "
; Fused expression:    "* *(@-12) 32 =(170) *(@-14) ax "
	mov	ax, [bp-12]
	imul	ax, ax, 32
	mov	[bp-14], ax
; RPN'ized expression: "samatics semaphore = "
; Expanded expression: "(@-10) (@-14) *(2) =(2) "
; Fused expression:    "=(170) *(@-10) *(@-14) "
	mov	ax, [bp-14]
	mov	[bp-10], ax
; if
; RPN'ized expression: "buffer semaphore 11 + + *u 15 != "
; Expanded expression: "(@-2) *(2) (@-14) *(2) 11 + + *(-1) 15 != "
; Fused expression:    "+ *(@-14) 11 + *(@-2) ax != *ax 15 IF! "
	mov	ax, [bp-14]
	add	ax, 11
	mov	cx, ax
	mov	ax, [bp-2]
	add	ax, cx
	mov	bx, ax
	mov	al, [bx]
	cbw
	cmp	ax, 15
	je	L80
; {
; if
; RPN'ized expression: "number index == "
; Expanded expression: "(@4) *(2) (@-4) *(2) == "
; Fused expression:    "== *(@4) *(@-4) IF! "
	mov	ax, [bp+4]
	cmp	ax, [bp-4]
	jne	L82
; {
; RPN'ized expression: "deze buffer semaphore 26 + + *u = "
; Expanded expression: "(@-6) (@-2) *(2) (@-14) *(2) 26 + + *(-1) =(-1) "
; Fused expression:    "+ *(@-14) 26 + *(@-2) ax =(119) *(@-6) *ax "
	mov	ax, [bp-14]
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
; Expanded expression: "(@-8) (@-2) *(2) (@-14) *(2) 28 + + *(-1) =(2) "
; Fused expression:    "+ *(@-14) 28 + *(@-2) ax =(167) *(@-8) *ax "
	mov	ax, [bp-14]
	add	ax, 28
	mov	cx, ax
	mov	ax, [bp-2]
	add	ax, cx
	mov	bx, ax
	mov	al, [bx]
	cbw
	mov	[bp-8], ax
; break
	jmp	L79
; }
L82:
; RPN'ized expression: "index ++p "
; Expanded expression: "(@-4) ++p(2) "
; Fused expression:    "++p(2) *(@-4) "
	mov	ax, [bp-4]
	inc	word [bp-4]
; }
L80:
; }
L77:
; Fused expression:    "++p(2) *(@-12) "
	mov	ax, [bp-12]
	inc	word [bp-12]
	jmp	L76
L79:
; loc         prosizeA : (@-12) : int
; RPN'ized expression: "prosizeA andere 512 / 1 + = "
; Expanded expression: "(@-12) (@-8) *(2) 512 / 1 + =(2) "
; Fused expression:    "/ *(@-8) 512 + ax 1 =(170) *(@-12) ax "
	mov	ax, [bp-8]
	cwd
	mov	cx, 512
	idiv	cx
	inc	ax
	mov	[bp-12], ax
; loc         prosizeB : (@-14) : int
; RPN'ized expression: "prosizeB size 512 / 1 + = "
; Expanded expression: "(@-14) (@8) *(2) 512 / 1 + =(2) "
; Fused expression:    "/ *(@8) 512 + ax 1 =(170) *(@-14) ax "
	mov	ax, [bp+8]
	cwd
	mov	cx, 512
	idiv	cx
	inc	ax
	mov	[bp-14], ax
; RPN'ized expression: "buffer samatics 28 + + *u size = "
; Expanded expression: "(@-2) *(2) (@-10) *(2) 28 + + (@8) *(2) =(-1) "
; Fused expression:    "+ *(@-10) 28 + *(@-2) ax =(122) *ax *(@8) "
	mov	ax, [bp-10]
	add	ax, 28
	mov	cx, ax
	mov	ax, [bp-2]
	add	ax, cx
	mov	bx, ax
	mov	ax, [bp+8]
	mov	[bx], al
	cbw
; RPN'ized expression: "( buffer , 19 , 0 , 1 writeSectorsDeviceLBA ) "
; Expanded expression: " (@-2) *(2)  19  0  1  writeSectorsDeviceLBA ()8 "
; Fused expression:    "( *(2) (@-2) , 19 , 0 , 1 , writeSectorsDeviceLBA )8 "
	push	word [bp-2]
	push	19
	push	0
	push	1
	call	_writeSectorsDeviceLBA
	sub	sp, -8
; if
; RPN'ized expression: "prosizeB prosizeA == "
; Expanded expression: "(@-14) *(2) (@-12) *(2) == "
; Fused expression:    "== *(@-14) *(@-12) IF! "
	mov	ax, [bp-14]
	cmp	ax, [bp-12]
	jne	L84
; {
; return
; RPN'ized expression: "( targetbuff , deze 31 + , 0 , andere 512 / 1 + writeSectorsDeviceLBA ) "
; Expanded expression: " (@6) *(2)  (@-6) *(-1) 31 +  0  (@-8) *(2) 512 / 1 +  writeSectorsDeviceLBA ()8 "
; Fused expression:    "( *(2) (@6) , + *(@-6) 31 , 0 , / *(@-8) 512 + ax 1 , writeSectorsDeviceLBA )8 signed char  "
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
	call	_writeSectorsDeviceLBA
	sub	sp, -8
	cbw
	jmp	L71
; }
	jmp	L85
L84:
; else
; {

section .rodata
L86:
	db	"__SIZE DIFFERENT__"
	times	1 db 0

section .text
; RPN'ized expression: "( L86 printf ) "
; Expanded expression: " L86  printf ()2 "
; Fused expression:    "( L86 , printf )2 "
	push	L86
	call	_printf
	sub	sp, -2
; }
L85:
; }
L74:
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
L71:
	leave
	ret

; glb loadFileByID : (
; prm     number : int
; prm     targetbuff : * void
;     ) char
section .text
	global	_loadFileByID
_loadFileByID:
	push	bp
	mov	bp, sp
	 sub	sp,         12
; loc     number : (@4) : int
; loc     targetbuff : (@6) : * void
; loc     buffer : (@-2) : * char
; loc     <something> : * char
; RPN'ized expression: "buffer 4096 (something89) = "
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
	je	L90
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
L92:
; RPN'ized expression: "i 20 < "
; Expanded expression: "(@-10) *(2) 20 < "
; Fused expression:    "< *(@-10) 20 IF! "
	mov	ax, [bp-10]
	cmp	ax, 20
	jge	L95
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
	je	L96
; {
; if
; RPN'ized expression: "number index == "
; Expanded expression: "(@4) *(2) (@-4) *(2) == "
; Fused expression:    "== *(@4) *(@-4) IF! "
	mov	ax, [bp+4]
	cmp	ax, [bp-4]
	jne	L98
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
	jmp	L95
; }
L98:
; RPN'ized expression: "index ++p "
; Expanded expression: "(@-4) ++p(2) "
; Fused expression:    "++p(2) *(@-4) "
	mov	ax, [bp-4]
	inc	word [bp-4]
; }
L96:
; }
L93:
; Fused expression:    "++p(2) *(@-10) "
	mov	ax, [bp-10]
	inc	word [bp-10]
	jmp	L92
L95:
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
	jmp	L87
; }
L90:
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
L87:
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
L102:
; {
; RPN'ized expression: "( cls ) "
; Expanded expression: " cls ()0 "
; Fused expression:    "( cls )0 "
	call	_cls

section .rodata
L104:
	db	"Select an option"
	times	1 db 0

section .text

section .rodata
L105:
	db	"[^] [v] to navigate | [Enter] to select"
	times	1 db 0

section .text
; RPN'ized expression: "( L105 , L104 setTitle ) "
; Expanded expression: " L105  L104  setTitle ()4 "
; Fused expression:    "( L105 , L104 , setTitle )4 "
	push	L105
	push	L104
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
	jne	L106
; {

section .rodata
L108:
	db	">>> "
	times	1 db 0

section .text
; RPN'ized expression: "( L108 printf ) "
; Expanded expression: " L108  printf ()2 "
; Fused expression:    "( L108 , printf )2 "
	push	L108
	call	_printf
	sub	sp, -2
; }
	jmp	L107
L106:
; else
; {

section .rodata
L109:
	db	"--- "
	times	1 db 0

section .text
; RPN'ized expression: "( L109 printf ) "
; Expanded expression: " L109  printf ()2 "
; Fused expression:    "( L109 , printf )2 "
	push	L109
	call	_printf
	sub	sp, -2
; }
L107:
; while
; RPN'ized expression: "1 "
; Expanded expression: "1 "
; Expression value: 1
L110:
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
	jne	L112
; {
; RPN'ized expression: "rowpointer ++p "
; Expanded expression: "(@-4) ++p(2) "
; Fused expression:    "++p(2) *(@-4) "
	mov	ax, [bp-4]
	inc	word [bp-4]
; break
	jmp	L111
; }
	jmp	L113
L112:
; else
; if
; RPN'ized expression: "deze 59 == "
; Expanded expression: "(@-8) *(-1) 59 == "
; Fused expression:    "== *(@-8) 59 IF! "
	mov	al, [bp-8]
	cbw
	cmp	ax, 59
	jne	L114
; {

section .rodata
L116:
	db	10,13
	times	1 db 0

section .text
; RPN'ized expression: "( L116 printf ) "
; Expanded expression: " L116  printf ()2 "
; Fused expression:    "( L116 , printf )2 "
	push	L116
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
	jne	L117
; {

section .rodata
L119:
	db	">>> "
	times	1 db 0

section .text
; RPN'ized expression: "( L119 printf ) "
; Expanded expression: " L119  printf ()2 "
; Fused expression:    "( L119 , printf )2 "
	push	L119
	call	_printf
	sub	sp, -2
; }
	jmp	L118
L117:
; else
; {

section .rodata
L120:
	db	"--- "
	times	1 db 0

section .text
; RPN'ized expression: "( L120 printf ) "
; Expanded expression: " L120  printf ()2 "
; Fused expression:    "( L120 , printf )2 "
	push	L120
	call	_printf
	sub	sp, -2
; }
L118:
; }
	jmp	L115
L114:
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
L115:
L113:
; }
	jmp	L110
L111:

section .rodata
L121:
	db	10,13
	times	1 db 0

section .text
; RPN'ized expression: "( L121 printf ) "
; Expanded expression: " L121  printf ()2 "
; Fused expression:    "( L121 , printf )2 "
	push	L121
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
	jne	L122
; {
; if
; RPN'ized expression: "pointer 0 != "
; Expanded expression: "(@-2) *(2) 0 != "
; Fused expression:    "!= *(@-2) 0 IF! "
	mov	ax, [bp-2]
	cmp	ax, 0
	je	L124
; {
; RPN'ized expression: "pointer --p "
; Expanded expression: "(@-2) --p(2) "
; Fused expression:    "--p(2) *(@-2) "
	mov	ax, [bp-2]
	dec	word [bp-2]
; }
L124:
; }
	jmp	L123
L122:
; else
; if
; RPN'ized expression: "et 80 == "
; Expanded expression: "(@-8) *(-1) 80 == "
; Fused expression:    "== *(@-8) 80 IF! "
	mov	al, [bp-8]
	cbw
	cmp	ax, 80
	jne	L126
; {
; if
; RPN'ized expression: "pointer rowpointer != "
; Expanded expression: "(@-2) *(2) (@-4) *(2) != "
; Fused expression:    "!= *(@-2) *(@-4) IF! "
	mov	ax, [bp-2]
	cmp	ax, [bp-4]
	je	L128
; {
; RPN'ized expression: "pointer ++p "
; Expanded expression: "(@-2) ++p(2) "
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
; }
L128:
; }
	jmp	L127
L126:
; else
; if
; RPN'ized expression: "et 28 == "
; Expanded expression: "(@-8) *(-1) 28 == "
; Fused expression:    "== *(@-8) 28 IF! "
	mov	al, [bp-8]
	cbw
	cmp	ax, 28
	jne	L130
; {
; break
	jmp	L103
; }
L130:
L127:
L123:
; }
	jmp	L102
L103:
; return
; RPN'ized expression: "pointer "
; Expanded expression: "(@-2) *(2) "
; Fused expression:    "*(2) (@-2)  "
	mov	ax, [bp-2]
L100:
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
L134:
; RPN'ized expression: "i 24 < "
; Expanded expression: "(@-2) *(2) 24 < "
; Fused expression:    "< *(@-2) 24 IF! "
	mov	ax, [bp-2]
	cmp	ax, 24
	jge	L137
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
L135:
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L134
L137:
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
L138:
	db	"SanderOS16"
	times	1 db 0

section .text
; RPN'ized expression: "( L138 printf ) "
; Expanded expression: " L138  printf ()2 "
; Fused expression:    "( L138 , printf )2 "
	push	L138
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
L132:
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
; RPN'ized expression: "buffer 4096 (something141) = "
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
	je	L142
; {
; for
; loc         index : (@-108) : int
; RPN'ized expression: "index 0 = "
; Expanded expression: "(@-108) 0 =(2) "
; Fused expression:    "=(170) *(@-108) 0 "
	mov	ax, 0
	mov	[bp-108], ax
L144:
; RPN'ized expression: "index 20 < "
; Expanded expression: "(@-108) *(2) 20 < "
; Fused expression:    "< *(@-108) 20 IF! "
	mov	ax, [bp-108]
	cmp	ax, 20
	jge	L147
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
	je	L148
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
	jne	L150
; {
; break
	jmp	L147
; }
L150:
; if
; RPN'ized expression: "first "
; Expanded expression: "(@-106) *(-1) "
; Fused expression:    "*(-1) (@-106)  "
	mov	al, [bp-106]
	cbw
; JumpIfZero
	test	ax, ax
	je	L152
; {
; RPN'ized expression: "first 0 = "
; Expanded expression: "(@-106) 0 =(-1) "
; Fused expression:    "=(122) *(@-106) 0 "
	mov	ax, 0
	mov	[bp-106], al
	cbw
; }
	jmp	L153
L152:
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
L153:
; for
; loc                 i : (@-110) : int
; RPN'ized expression: "i 0 = "
; Expanded expression: "(@-110) 0 =(2) "
; Fused expression:    "=(170) *(@-110) 0 "
	mov	ax, 0
	mov	[bp-110], ax
L154:
; RPN'ized expression: "i 11 < "
; Expanded expression: "(@-110) *(2) 11 < "
; Fused expression:    "< *(@-110) 11 IF! "
	mov	ax, [bp-110]
	cmp	ax, 11
	jge	L157
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
L155:
; Fused expression:    "++p(2) *(@-110) "
	mov	ax, [bp-110]
	inc	word [bp-110]
	jmp	L154
L157:
; }
L148:
; }
L145:
; Fused expression:    "++p(2) *(@-108) "
	mov	ax, [bp-108]
	inc	word [bp-108]
	jmp	L144
L147:
; }
	jmp	L143
L142:
; else
; {

section .rodata
L158:
	db	"DEV: cannot read",10,13
	times	1 db 0

section .text
; RPN'ized expression: "( L158 printf ) "
; Expanded expression: " L158  printf ()2 "
; Fused expression:    "( L158 , printf )2 "
	push	L158
	call	_printf
	sub	sp, -2
; }
L143:
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
L139:
	leave
	ret

; glb writeSectorsDeviceLBA : (
; prm     sectorcount : char
; prm     device : char
; prm     lba : int
; prm     buffer : * void
;     ) char
section .text
	global	_writeSectorsDeviceLBA
_writeSectorsDeviceLBA:
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
; RPN'ized expression: "( buffer , device , head , sector , track , sectorcount writeSectorsDevice ) "
; Expanded expression: " (@10) *(2)  (@6) *(-1)  (@-2) *(-1)  (@-6) *(-1)  (@-4) *(-1)  (@4) *(-1)  writeSectorsDevice ()12 "
; Fused expression:    "( *(2) (@10) , *(-1) (@6) , *(-1) (@-2) , *(-1) (@-6) , *(-1) (@-4) , *(-1) (@4) , writeSectorsDevice )12 "
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
	call	_writeSectorsDevice
	sub	sp, -12
L159:
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
L161:
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
L163:
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
	je	L167
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
	jmp	L165
.skip:
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L165
; }
	jmp	L168
L167:
; else
; {
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L165
; }
L168:
L165:
	leave
	ret

; glb writeSectorsDevice : (
; prm     sectorcount : char
; prm     cylinder : char
; prm     sector : char
; prm     head : char
; prm     device : char
; prm     buffer : * void
;     ) char
section .text
	global	_writeSectorsDevice
_writeSectorsDevice:
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
	je	L171
; {
mov si, [bp+14]
mov bx, ds
mov es, bx
mov bx, si
mov ah, 0x03
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
	jmp	L169
.skip:
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L169
; }
	jmp	L172
L171:
; else
; {
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
	jmp	L169
; }
L172:
L169:
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
	jmp	L173
.skip:
; return
; RPN'ized expression: "0 "
; Expanded expression: "0 "
; Expression value: 0
; Fused expression:    "0  "
	mov	ax, 0
L173:
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
L175:
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
L177:
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
L179:
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
L183:
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
	je	L184
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
	jmp	L183
L184:
L181:
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
L185:
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
L189:
; RPN'ized expression: "y 20 < "
; Expanded expression: "(@-2) *(2) 20 < "
; Fused expression:    "< *(@-2) 20 IF! "
	mov	ax, [bp-2]
	cmp	ax, 20
	jge	L192
; RPN'ized expression: "y ++p "
; Expanded expression: "(@-2) ++p(2) "
; {

section .rodata
L193:
	db	"                                                                          ",10,13
	times	1 db 0

section .text
; RPN'ized expression: "( L193 printf ) "
; Expanded expression: " L193  printf ()2 "
; Fused expression:    "( L193 , printf )2 "
	push	L193
	call	_printf
	sub	sp, -2
; }
L190:
; Fused expression:    "++p(2) *(@-2) "
	mov	ax, [bp-2]
	inc	word [bp-2]
	jmp	L189
L192:
mov ah,0x02
mov dh,0
mov dl,0
mov bh,0
int 0x10
L187:
	leave
	ret



; Syntax/declaration table/stack:
; Bytes used: 1035/15360


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
; Ident hideCursor
; Ident fexists
; Ident filename
; Ident fnew
; Ident fread
; Ident location
; Ident fwrite
; Ident size
; Ident writeFileByID
; Ident number
; Ident targetbuff
; Ident loadFileByID
; Ident choose
; Ident alpha
; Ident setTitle
; Ident front
; Ident back
; Ident getFileList
; Ident writeSectorsDeviceLBA
; Ident sectorcount
; Ident device
; Ident lba
; Ident buffer
; Ident readSectorsDeviceLBA
; Ident draw
; Ident x
; Ident y
; Ident color
; Ident times
; Ident readSectorsDevice
; Ident cylinder
; Ident sector
; Ident head
; Ident writeSectorsDevice
; Ident resetDevice
; Ident getc
; Ident getsc
; Ident putc
; Ident a
; Ident printf
; Ident text
; Ident curpos
; Ident cls
; Bytes used: 527/5632

; Next label number: 194
; Compilation succeeded.
