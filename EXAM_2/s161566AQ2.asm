TITLE EXAM_1

INCLUDE Irvine32.inc
READ PROTO,
	ps: PTR BYTE, pt : PTR DWORD, L_S:dword

.data
	buffer byte 248 dup (?)
	bufferN dword ?
	capacity byte "Enter Capacity : ", 0
	cap dword ?
	readweight byte "Enter Weights : ",0ah,0dh,0
	weight dword 16 dup (?)
	total_num dword ?
	readprofits byte "Enter Profits(the same # of weights) : ",0ah,0dh,0
	profit dword 16 dup(?)
	endword byte "Bye!",0
	resultword byte "Max Profit = ",0

	biggest dword 0
	index dword 0

.code
main PROC

L1:
	mov eax, 0
	mov biggest, eax
	mov index, eax

	mov edx, offset capacity
	call writestring

	call readint
	mov cap, eax

	cmp cap, 0
	je finish

	mov edx, offset readweight
	call writestring

	mov edx, offset buffer
	mov ecx, 248
	call readstring
	mov bufferN, eax

	INVOKE READ, ADDR buffer, ADDR weight, bufferN
	mov total_num, eax

	mov edx, offset readprofits
	call writestring

	mov edx, offset buffer
	mov ecx, 248
	call readstring
	mov bufferN, eax

	INVOKE READ, ADDR buffer, ADDR profit, bufferN
	
	mov ecx, 0FFFFh
L2:
	push ecx
	call FIND
	pop ecx
	loop L2
	mov eax, biggest

	mov edx, offset resultword
	call writestring
	call writedec
	call crlf



	mov ecx, total_num
	mov ebx, index
L3:
	mov eax, 0
	shr ebx, 1
	jnc L4
	mov eax, 1
L4:
	call writedec
	mov al, ' '
	call writechar
	loop L3
	call crlf
	call crlf
	jmp L1
finish:
	mov edx, offset endword
	call writestring
	exit
main ENDP


FIND PROC
	;ecx gets the  number

	mov esi, offset weight
	mov edi, offset profit

	xor eax, eax	;total weight save
	xor ebx, ebx	;total profit save
	xor edx, edx	;indexing
	push ecx
L1:
	cmp ecx, 0
	je FIN
	shr ecx, 1
	jnc L2
	add eax, [esi+edx]
	add ebx, [edi+edx]
L2:
	add edx,4
	jmp L1

	
FIN:
	pop ecx
	cmp eax, cap
	jg NO
	cmp ebx, biggest
	jl NO
	mov biggest, ebx
	mov index,  ecx
NO:
	ret
FIND ENDP




READ PROC USES esi edi ecx ebx edx,
	ps: PTR BYTE, pt : PTR DWORD, L_S:dword

	mov esi, ps
	mov edi, pt
	mov ecx, L_S
	xor ebx, ebx				;set ebx to 0
	xor edx, edx				;set edx to 0
	xor eax, eax				;set eax to 0
	push 0						;return value: store the return value in stack, initially 0

First:							;read Each character in the buffer and...	
	cmp BYTE PTR [esi], ' '		;If the read character is 'BLANK'
	jne Check_Sign
	cmp eax, 0					;If you read a 'NUMBER' character before you read a 'BLANK'-->Is eax 1?
	je Read_next

	cmp edx, 0					;If the currently saved number is <0
	je Add_To_Array
	neg ebx						;do neg function to the currently saved number

Add_To_Array:					
	mov [edi], ebx				;Save the currently saved number to the Array
	add edi, TYPE SDWORD		
	xor ebx, ebx				;set ebx to 0		
	xor edx, edx				;set edx to 0
	pop eax						;pop the return value saved in the stack
	inc eax						;increase the return value (number of the number saved in the array)
	push eax					;push back the return value to the stack
	xor eax, eax				;set eax to 0
	jmp Read_next				

Check_Sign:									
	cmp BYTE PTR[esi], '+'		;If the read character is '+'
	je Read_next				;do nothing

	cmp BYTE PTR[esi], '-'		;If the read character is '-'
	jne Check_Number
	mov edx, 1					;set edx to 1
	jmp Read_next

Check_Number:					;If the read character is a 'NUMBER'						
	push edx					;'mul' uses edx, so save edx in stack
	mov eax, 10					;because eax is going to be set to 1 at the end of this part, doesn't matter what the previous eax was
	mul ebx						
	mov ebx, eax				;multiply 10 to currently reading number
	xor eax, eax
	mov al, [esi]				;get the ascii code of the read character 'NUMBER'
	sub al, 30h					;change it to integer format by subtracting 30h(48), ASCII code of '0' is 30h
	add ebx, eax				;add to current number
	pop edx						;restore edx
	mov eax, 1					;set eax to 1(meaning there is a number currently reading, there is a number saved in ebx)

Read_next:
	add esi, TYPE BYTE 			;Target the next character of inBuffer 
	loop First


	cmp eax, 0					;If you read a 'NUMBER' character, and didn't save in the Array
	je L1
	cmp edx, 0					;If the currently saved number is <0
	je L2
	neg ebx						;do neg function to the currently saved number
L2:
	mov [edi], ebx				;Save the currently saved number to the Array
	pop eax						;increasing the return value
	inc eax
	push eax
L1:
	pop eax						;save the return value in eax
	ret							;thus returning the number of saved integers by eax
READ ENDP


END main