section .data
    LOW_LEVEL      dd 30
    MODERATE_LEVEL dd 70
    HIGH_LEVEL     dd 90

    low_msg        db 'Water level low: Systems stopped', 10
    low_msg_len    equ $ - low_msg

    moderate_msg   db 'Water level moderate: Motor running at low speed', 10
    moderate_msg_len equ $ - moderate_msg

    high_msg       db 'HIGH WATER ALERT: Emergency mode activated!', 10
    high_msg_len   equ $ - high_msg

section .bss
    sensor_value   resd 1
    motor_status   resb 1
    alarm_status   resb 1

section .text
global _start

_start:
    ; LOW LEVEL SCENARIO
    mov     dword [sensor_value], 20
    call    process_water_level

    ; MODERATE LEVEL SCENARIO
    mov     dword [sensor_value], 50
    call    process_water_level

    ; HIGH LEVEL SCENARIO
    mov     dword [sensor_value], 95
    call    process_water_level

    ; Exit program
    mov     rax, 60
    xor     rdi, rdi
    syscall

process_water_level:
    mov     eax, [sensor_value]

    cmp     eax, [LOW_LEVEL]
    jbe     stop_systems

    cmp     eax, [MODERATE_LEVEL]
    jbe     low_speed_motor

    cmp     eax, [HIGH_LEVEL]
    jae     emergency_mode

    jmp     stop_systems

low_speed_motor:
    mov     byte [motor_status], 1
    mov     byte [alarm_status], 0
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, moderate_msg
    mov     rdx, moderate_msg_len
    syscall
    ret

emergency_mode:
    mov     byte [motor_status], 0
    mov     byte [alarm_status], 1
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, high_msg
    mov     rdx, high_msg_len
    syscall
    ret

stop_systems:
    mov     byte [motor_status], 0
    mov     byte [alarm_status], 0
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, low_msg
    mov     rdx, low_msg_len
    syscall
    ret