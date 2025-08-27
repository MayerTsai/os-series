extern idt_handler_keyboard
global idt_load

idt_load:
	lidt [rdi]
	ret

%macro PUSH_ALL_GPRS 0
	; save general-purpose registers
	push rax
	push rbx
	push rcx
	push rdx
	push rbp
	push rsi
	push rdi
	push r8
	push r9
	push r10
	push r11
	push r12
	push r13
	push r14
	push r15
%endmacro

%macro POP_ALL_GPRS 0
	; restore general-purpose registers
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop r10
	pop r9
	pop r8
	pop rdi
	pop rsi
	pop rbp
	pop rdx
	pop rcx
	pop rbx
	pop rax
%endmacro

%macro WRAPPED_HANDLER 1
	global %1_wrapped
	
	%1_wrapped:
		PUSH_ALL_GPRS

		call %1

		POP_ALL_GPRS
		
		iretq
%endmacro

WRAPPED_HANDLER idt_handler_keyboard
