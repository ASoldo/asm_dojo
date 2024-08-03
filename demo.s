;inclue  example https:         // pastebin.com/N1ZdmhLw
;updated include example https: // pastebin.com/wCNZs3RN
SYS_EXIT equ 60

%macro exit 0
mov    rax, SYS_EXIT
xor    rdi, rdi
syscall
%endmacro

%macro print 1
mov    rax, %1
call   print_rax_digit
%endmacro

section  .data
delay    dq 2, 500000000
rootster db "Rootster", 0xA; Define the string "Rootster" with newline
rootster_len equ $ - rootster; Calculate length of "Rootster"

hello db "What is your name: ", 0xA; Define the string "Hello, Roots" with newline
hello_len equ $ - hello; Calculate length of "Hello, Roots"

wellcome db "Wellcome, "; Define the string "Wellcome, " with newline
wellcome_len equ $ - wellcome; Calculate length of "Wellcome, "

digit db 0, 0xA
digit_len equ $ - digit

section .bss; Uninitialized data section
added   resb 2; Reserve 2 bytes for added (to be initialized)
name    resb 16; Reserve 16 bytes for name

section .text
global  _start

_start:
	push 1
	push 2
	push 3
	push 4

	mov rax, 35
	mov rdi, delay
	mov rsi, 0
	syscall

	pop  rax
	call print_rax_digit

	pop  rax
	call print_rax_digit

	pop  rax
	call print_rax_digit

	pop  rax
	call print_rax_digit

	mov rax, 7

	call print_rax_digit

	print 6
	print 6
	print 6

	call     print_hello
	call     get_name
	call     print_wellcome
	call     print_name
	;        Write "Rootster" to stdout
	mov      rax, 1; syscall number for sys_write
	mov      rdi, 1; file descriptor 1 is stdout
	mov      rsi, rootster; address of string to output
	mov      rdx, rootster_len; number of bytes to write
	syscall; invoke operating system to do the write

	;        Write "roots" to stdout
	mov      rax, 1; syscall number for sys_write
	mov      rdi, 1; file descriptor 1 is stdout
	mov      rsi, roots; address of string to output
	mov      rdx, 6; number of bytes to write
	syscall; invoke operating system to do the write

	;   Initialize and write "added" to stdout
	mov byte [added], 0x30; Initialize first byte of added to '0'
	mov byte [added+1], 0xA; Initialize second byte of added to newline

	lea rsi, [added]; Load the effective address of added into rsi
	mov al, [rsi]; Move the byte at the address in rsi to al
	add al, 0x20; Add 0x20 to the value in al (ASCII 'P')
	mov [rsi], al; Move the value in al back to the address in rsi

	mov      rax, 1; syscall number for sys_write
	mov      rdi, 1; file descriptor 1 is stdout
	mov      rsi, added; address of string to output
	mov      rdx, 2; number of bytes to write
	syscall; invoke operating system to do the write

	;         Exit the program
	;mov      rax, 60; syscall number for sys_exit
	;xor      rdi, rdi; exit code 0
	;syscall; invoke operating system to exit

	exit

roots:
	db "roots", 0xA; Define the string "roots" with newline

print_hello:
	mov rax, 1
	mov rdi, 1
	mov rsi, hello
	mov rdx, hello_len
	syscall
	ret

print_wellcome:
	mov rax, 1
	mov rdi, 1
	mov rsi, wellcome
	mov rdx, wellcome_len
	syscall
	ret

print_name:
	mov rax, 1
	mov rdi, 1
	mov rsi, name
	mov rdx, 16
	syscall
	ret

get_name:
	mov rax, 0
	mov rdi, 0
	mov rsi, name
	mov rdx, 16
	syscall
	ret

print_rax_digit:
	add rax, 48
	mov [digit], al
	mov rax, 1
	mov rdi, 1
	mov rsi, digit
	mov rdx, digit_len
	syscall
	ret
