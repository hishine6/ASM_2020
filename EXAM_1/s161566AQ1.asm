TITLE EXAM_1

INCLUDE Irvine32.inc

printing PROTO,
	ps: PTR BYTE, start_s:dword, end_s:dword


.data
	source byte 25 dup (?)
	sourceN dword ?

	startword byte "Enter a string : ",0
	endword byte "Bye!",0

.code
main PROC

L1:
	mov edx, offset startword
	call writestring

	mov edx, offset source
	mov ecx, 24
	call readstring
	mov sourceN, eax

	cmp eax, 0
	je finish

	xor ebx, ebx
	mov edx, sourceN
	dec edx
L2:
	mov eax, edx
	sub eax, ebx
	cmp eax, 0
	jl L3

	INVOKE printing, ADDR source, ebx, edx

	inc ebx
	dec edx
	jmp L2
L3:
	inc edx
	dec ebx
	cmp ebx, 0
	je L5
L4:
	inc edx
	dec ebx
	cmp ebx, edx
	jg L5
	INVOKE printing,ADDR source, ebx, edx
	cmp ebx, 0
	je L5
	jmp L4
L5:
	call crlf
	jmp L1


finish:
	mov edx, offset endword
	call writestring
	exit
main ENDP

printing PROC USES eax ebx edx ecx,
	ps: PTR BYTE, start_s:dword, end_s:dword

	mov esi, ps
	mov edx, start_s
	mov ebx, end_s
	xor eax, eax
	
	mov ecx, start_s
	cmp ecx, 0
	je L1
blank:
	mov al, ' '
	call writechar
	loop blank

L1:
	cmp edx, ebx
	jg L2
	mov al, [esi+edx]
	call writechar
	inc edx
	jmp L1
L2:
	mov ecx, start_s
	cmp ecx, 0
	je L3

blank2:
	mov al, ' '
	call writechar
	loop blank2

L3:
	call crlf
	ret
printing ENDP

END main