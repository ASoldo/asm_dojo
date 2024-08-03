section .data
    hello db 'Hello, world!', 0xA  ; The string to print with a newline character
    hello_len equ $ - hello        ; The length of the string
    rootster db 'Rootster', 0xA ; The string to print with a newline character
    rootster_len equ $ - rootster ; The length of the string

section .text
global _start

_start:
    ; Print "Hello, world!" to the console
    mov rax, 1        ; syscall: write
    mov rdi, 1        ; file descriptor: stdout
    mov rsi, hello    ; pointer to the string
    mov rdx, hello_len ; length of the string
    syscall           ; invoke syscall

    mov rax, 1       ; syscall: write
    mov rdi, 1       ; file descriptor: stdout
    mov rsi, rootster   ; pointer to the string
    mov rdx, rootster_len ; length of the string
    syscall         ; invoke syscall

    ; Exit the program
    mov rax, 60       ; syscall: exit
    xor rdi, rdi      ; status: 0
    syscall           ; invoke syscall
