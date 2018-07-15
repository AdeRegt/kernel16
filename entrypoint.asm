jmp os_main
jmp _printf
jmp _putc
jmp _curpos
jmp _cls
jmp _fexists
jmp _fnew
jmp _fread
jmp _fwrite
jmp _choose
jmp _setTitle
jmp _getFileList
jmp _draw
jmp _getc
jmp _getsc
jmp _loadFileByID
jmp _writeFileByID

os_main:
	cli
	mov ax, 0
	mov ss, ax
	mov sp, 0FFFFh
	sti

	cld
	
	mov ax, 2000h
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	
	call _main
	
	
	%INCLUDE "kernel.asm"


l2hts:			; Calculate head, track and sector settings for int 13h
			; IN: logical sector in AX, OUT: correct registers for int 13h
	push bx
	push ax

	mov bx, ax			; Save logical sector

	mov dx, 0			; First the sector
	div word [SectorsPerTrack]
	add dl, 01h			; Physical sectors start at 1
	mov cl, dl			; Sectors belong in CL for int 13h
	mov ax, bx

	mov dx, 0			; Now calculate the head
	div word [SectorsPerTrack]
	mov dx, 0
	div word [Sides]
	mov dh, dl			; Head/side
	mov ch, al			; Track

	pop ax
	pop bx

	;mov dl, byte [device]		; Set correct device

	ret
	
	
SectorsPerTrack		dw 18		; Sectors per track (36/cylinder)
Sides			dw 2		; Number of sides/heads
