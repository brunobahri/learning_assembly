section .data

salve:
	db	`Coe, maninho!\n`	
	db	`Qual é seu nome?\n`	
slen:	equ	$ - salve		
tmj:	db	'Tmj, '		
flen:	equ	$ - tmj		
final:	db	`!\n`			
BUFF:	equ	50			

section .bss

nome:	resb	BUFF			

section .text

    global  _start

_start:

	
	mov	rax,	1
	mov	rdi,	rax
	mov	rsi,	salve
	mov	rdx,	slen
	syscall

	
	mov	rax,	0	
	mov	rdi,	rax	
	mov	rsi,	nome	
	mov	rdx,	BUFF	
	syscall			

	
	mov	rax,	1
	mov	rdi,	rax
	mov	rsi,	tmj
	mov	rdx,	flen
	syscall

lftrim:
	
	mov	rax,	0			
.loop:
        cmp	byte [nome + rax],	0xa	
        je	.trim				
        cmp	byte [nome + rax],	0	
        je	.endsub				
        inc	rax				
        jmp	.loop				
.trim:
	mov	byte [nome + rax],	0	
	inc	rax				
	jmp	.loop				
.endsub:


	mov	rax,	1
	mov	rdi,	rax
	mov	rsi,	nome
	mov	rdx,	BUFF
	syscall

	mov	rax,	1
	mov	rdi,	rax
	mov	rsi,	final
	mov	rdx,	2
	syscall


	mov	rax,	60
	mov	rdi,	0
	syscall



