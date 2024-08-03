section .data
    hello db 'Hello, world!', 0xA  ; The string to print with a newline character
    hello_len equ $ - hello        ; The length of the string
    rootster db 'Rootster', 0xA    ; The string to print with a newline character
    rootster_len equ $ - rootster  ; The length of the string

section .bss

section .text
global _start

_start:
    ; Print "Hello, world!" to the console
    mov rax, 1                    ; syscall: write
    mov rdi, 1                    ; file descriptor: stdout
    mov rsi, hello                ; pointer to the string
    mov rdx, hello_len            ; length of the string
    syscall                       ; invoke syscall

    ; Allocate memory on the heap using brk
    mov rax, 12                   ; syscall: brk
    mov rdi, 0                    ; argument: 0 to get current break
    syscall                       ; invoke syscall

    ; Store current break in rbx
    mov rbx, rax                  ; rbx now holds the current break

    ; Set new program break to allocate space for 'rootster' string
    add rbx, rootster_len         ; increase by the length of rootster string
    mov rax, 12                   ; syscall: brk
    mov rdi, rbx                  ; new break value
    syscall                       ; invoke syscall

    ; Check if allocation was successful
    test rax, rax
    js allocation_failed

    ; Copy "Rootster" to the allocated memory
    lea rsi, [rootster]           ; source address
    mov rdi, rbx                  ; destination address (new break)
    mov rcx, rootster_len         ; length of the string
    rep movsb                     ; copy bytes from rsi to rdi

    ; Print "Rootster" from the allocated memory
    mov rax, 1                    ; syscall: write
    mov rdi, 1                    ; file descriptor: stdout
    mov rsi, rbx                  ; pointer to the allocated memory
    mov rdx, rootster_len         ; length of the string
    syscall                       ; invoke syscall

    ; Exit the program
    mov rax, 60                   ; syscall: exit
    xor rdi, rdi                  ; status: 0
    syscall                       ; invoke syscall

allocation_failed:
    ; Handle allocation failure (if needed)
    ; Exit with status 1
    mov rax, 60                   ; syscall: exit
    mov rdi, 1                    ; status: 1
    syscall                       ; invoke syscall
