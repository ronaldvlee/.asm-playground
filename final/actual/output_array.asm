; Name: Ronald Lee
; Email: ronaldvlee@csu.fullerton.edu
; Section: 240-3
; Date: 12-06-2023
global output_array
extern printf
extern scanf

segment .data
prompt1 db "What is the delay time you prefer (seconds)?  ", 0
prompt2 db "What is the maximum frequency of your cpu (GHz)?  ", 0
prompt3 db "Here are the data", 10, 0
output_format db "0x%016lx = %.7E", 10, 0
float_f db "%lf", 0
digit_f db "%ld", 10 ,0
constant dq 1000000000.0

segment .bss
    align 64
    storedata resb 832
    
    delaytime resq 1
    cpufreq resq 1
    tot_delay resq 1

segment .text

output_array:
     ; Back up components
    push        rbp
    mov         rbp, rsp
    push        rbx
    push        rcx
    push        rdx
    push        rsi
    push        rdi
    push        r8 
    push        r9 
    push        r10
    push        r11
    push        r12
    push        r13
    push        r14
    push        r15
    pushf

    ; Save all the floating-point numbers
    mov         rax, 7
    mov         rdx, 0
    xsave       [storedata]

    xor         r13, r13     ; r13 keeps track of the index of the loop
    mov         r14, rdi     ; rdi contains the array
    mov         r15, rsi     ; rsi contains the count of the array

    ; print prompt 1
    mov rax,    0
    mov rdi,    prompt1
    call        printf

    ; scan for delay time
    mov rax,    0
    mov rdi,    float_f
    mov rsi,    delaytime
    call scanf

    ; print prompt 2
    mov rax,    0
    mov rdi,    prompt2
    call        printf

    ; scan for cpufreq
    mov rax,    0
    mov rdi,    float_f
    mov rsi,    cpufreq
    call scanf

    ; calc time in tics and store in xmm15
    movsd xmm15, qword [delaytime]
    movsd xmm14, qword [cpufreq]
    mulsd xmm15, [constant]
    mulsd xmm15, xmm14 

    ; here are the data
    mov rax,    0
    mov rdi,    prompt3
    call printf
output_loop:
    ; If the index reach the count, end the loop
    cmp         r13, r15
    jge         output_finished

    ; Print the number inside the array in hex and scientific format
    mov         rax, 1
    mov         rdi, output_format
    mov         rsi, [r14 + r13  * 8]
    movsd       xmm0, [r14 + r13 * 8]
    call        printf

    ; get the time on clock before delay and put into r10
    xor         rax, rax
    xor         rdx, rdx
    cpuid
    rdtsc
    shl         rdx, 32
    or          rax, rdx
    mov         r10, rax

    ; adding the delay time to the current time
    push        r15        ; pushing r15 to backup cus no more registers
    cvtsd2si    r15, xmm15 ; convert xmm15 to r15
    add         r10, r15
    pop         r15        ; replacing r15 back into its original val
    
    delay_block:
        ; get the time on clock and put into r12
        xor rax, rax
        xor rdx, rdx
        cpuid
        rdtsc
        shl rdx, 32
        or rax, rdx
        mov r12, rax

        cmp r12, r10
        jg delay_done
        
        jmp delay_block

    delay_done:
    ; Increase the index and repeat the loop
    inc         r13
    jmp         output_loop

output_finished:
    ; Restore all the floating-point numbers
    mov         rax, 7
    mov         rdx, 0
    xrstor      [storedata]

    ;Restore the original values to the GPRs
    popf
    pop         r15
    pop         r14
    pop         r13
    pop         r12
    pop         r11
    pop         r10
    pop         r9 
    pop         r8 
    pop         rdi
    pop         rsi
    pop         rdx
    pop         rcx
    pop         rbx
    pop         rbp

    ; Clean up
    ret



