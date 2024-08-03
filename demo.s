section  .data
rootster db "Rootster", 0xA; Define the string "Rootster" with newline
rootster_len equ $ - rootster; Calculate length of "Rootster"

section .bss; Uninitialized data section
added   resb 2; Reserve 2 bytes for added (to be initialized)

section .text
global  _start

_start:
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

	;        Exit the program
	mov      rax, 60; syscall number for sys_exit
	xor      rdi, rdi; exit code 0
	syscall; invoke operating system to exit

roots:
	db "roots", 0xA; Define the string "roots" with newline
