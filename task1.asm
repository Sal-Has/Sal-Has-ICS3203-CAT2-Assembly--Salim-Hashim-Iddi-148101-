; 64-bit Number Classification Program
; Demonstrates control flow and conditional logic using precise jump instructions

section .data
    ; Define string messages for different classifications
    prompt db 'Enter a number: ', 0       ; User input prompt
    positive_msg db 'POSITIVE', 10, 0     ; Message for positive numbers
    negative_msg db 'NEGATIVE', 10, 0     ; Message for negative numbers
    zero_msg db 'ZERO', 10, 0             ; Message for zero
    error_msg db 'Invalid input', 10, 0   ; Error message for invalid input

section .bss
    input resb 20   ; Buffer to store input string (max 20 characters)
    number resq 1   ; Parsed integer value

section .text
    global _start

; String to Integer Conversion Function
; Handles parsing of input string, including negative numbers
string_to_int:
    ; Initialize registers for conversion process
    xor rax, rax    ; Clear result register
    xor rcx, rcx    ; Clear index register
    xor r8, r8      ; Clear sign flag
    xor r9, r9      ; Clear temporary digit register

    ; Check for negative sign
    ; Conditional jump to handle negative number input
    cmp byte [input], '-'
    jne .convert_loop  ; Jump to conversion if not negative
    inc r8             ; Set sign flag for negative number
    inc rcx            ; Skip minus sign

.convert_loop:
    ; Character-by-character conversion
    ; Uses conditional jumps for input validation
    movzx r9, byte [input + rcx]
    
    ; Conditional jumps for input termination and validation
    cmp r9b, 0      ; Check for null terminator
    je .done        ; Jump to done if end of string
    cmp r9b, 10     ; Check for newline
    je .done        ; Jump to done if newline
    cmp r9b, '0'    ; Validate digit lower bound
    jl .error       ; Jump to error if below '0'
    cmp r9b, '9'    ; Validate digit upper bound
    jg .error       ; Jump to error if above '9'

    ; Digit conversion logic
    sub r9b, '0'    ; Convert character to numeric value
    imul rax, 10    ; Shift existing digits
    add rax, r9     ; Add new digit

    ; Unconditional jump to continue conversion
    inc rcx
    jmp .convert_loop

.done:
    ; Handle sign conversion
    test r8, r8     ; Check sign flag
    jz .return      ; Jump to return if positive
    neg rax         ; Negate value if negative

.return:
    mov [number], rax
    ret

.error:
    ; Error handling using system calls
    ; Unconditional jump ensures error message is displayed
    mov rax, 1
    mov rdi, 1
    mov rsi, error_msg
    mov rdx, 13
    syscall
    jmp exit

_start:
    ; Input prompt display
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, 16
    syscall

    ; Read user input
    mov rax, 0
    mov rdi, 0
    mov rsi, input
    mov rdx, 20
    syscall

    ; Convert and parse input
    call string_to_int

    ; Retrieve parsed number
    mov rax, [number]

    ; Number classification using conditional jumps
    ; Precise comparisons to determine number type
    cmp rax, 0      ; Compare with zero
    jg positive_case ; Jump if greater than zero
    jl negative_case ; Jump if less than zero
    je zero_case     ; Jump if exactly zero

; Classification case handlers with unconditional exit jumps
positive_case:
    mov rax, 1
    mov rdi, 1
    mov rsi, positive_msg
    mov rdx, 9
    syscall
    jmp exit        ; Ensure program terminates after classification

negative_case:
    mov rax, 1
    mov rdi, 1
    mov rsi, negative_msg
    mov rdx, 9
    syscall
    jmp exit        ; Prevent fall-through execution

zero_case:
    mov rax, 1
    mov rdi, 1
    mov rsi, zero_msg
    mov rdx, 5
    syscall

exit:
    ; Program termination
    mov rax, 60
    xor rdi, rdi
    syscall