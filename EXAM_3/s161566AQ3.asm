TITLE EXAM_3

INCLUDE Irvine32.inc
READ PROTO,
	ps: PTR BYTE, pt : PTR DWORD, L_S:dword
SORT PROTO,
	ps: PTR DWORD, L_S:DWORD
FIND PROTO,
	ps: PTR DWORD, RUBBY_NUM:DWORD

.data
	buffer byte 248 dup (?)
	bufferN dword ?

	rubby dword 60 dup (?)
	rubbyN dword ?

	startword byte "Enter Ruby Sizes : ",0Ah,0Dh,0
	resultword byte "Max Profit = ",0
	endword byte "Bye!",0

.code
main PROC

L1:
	mov edx, offset startword
	call writestring

	mov edx, offset buffer
	mov ecx, 248
	call readstring
	mov bufferN, eax

	cmp bufferN, 0
	je finish

	INVOKE READ, ADDR buffer, ADDR rubby, bufferN
	mov rubbyN, eax
	cmp rubbyN, 2
	jl no_sort
	INVOKE SORT, ADDR rubby, rubbyN
no_sort:
	INVOKE FIND, ADDR rubby, rubbyN


	mov edx, offset resultword
	call writestring
	call writedec
	call crlf
	call crlf

	jmp L1
finish:
	mov edx, offset endword
	call writestring
	exit
main ENDP

FIND PROC USES ebx ecx edx,
	ps: PTR DWORD, RUBBY_NUM:DWORD

	mov esi, ps
	mov ecx, RUBBY_NUM
	xor edx, edx
	xor ebx, ebx
L1:
	mov ebx, [esi]
	mov eax, ebx
	push edx
	mul ecx
	pop edx
	cmp edx, eax
	jg L2
	mov edx, eax
L2:
	add esi, 4
	loop L1
	mov eax, edx
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


SORT PROC USES ebx eax ecx,
	ps: PTR DWORD, L_S:DWORD

	mov edi, ps
	mov edx, L_S

	dec edx												 
	mov ecx, edx										;save n-1 to ecx, where n is the number of saved integers 
outer_loop:										
	xor ebx, ebx										;set ebx to zero(the index register), since you have to compare from the begining
inner_loop:
	cmp ebx, ecx										;if ebx >= ecx the inner loop ends
	jge last
	mov eax, [edi + ebx * type SDWORD + type SDWORD]	;compare a integer with the following integer 
	cmp eax, [edi + ebx * type SDWORD]					;compare two consecutive numbers in a array
	jg next
	push [edi + ebx * type SDWORD]						;if the bigger one comes first, swap the two integers
	mov [edi + ebx * type SDWORD], eax					
	pop [edi + ebx * type SDWORD + type SDWORD]			;swap them using stack, eax register
next:
	inc ebx												;target the next integer of the array
	jmp inner_loop
last:
	loop outer_loop

	ret
SORT ENDP

END main