extern printf
extern scanf

extern fgets
extern stdin
extern strlen
extern atof

extern isfloat

global faraday

segment .data
    str_f db "%s", 0
    double_f db "%lf", 0

    prompt_invalid db 10, "Attention %s. Invalid inputs have been encountered. Please run the program again", 10, 10, 0

    prompt_name db "Please enter your name: ", 0
    prompt_title db "Please enter your title or profession: ", 0

    prompt1 db "We always welcome a %s to our electrical lab.", 10, 10, 0
    prompt_voltage db "Please enter the voltage of the electrical system at your site (volts): ", 0
    prompt_resistance db "Please enter the electrical resistance in the system at your site (ohms): ", 0
    prompt_time db "Please enter the time your system was operating (seconds): ", 0

    prompt2 db 10, "Thank you %s. We at Majestic are pleased to inform you that your system performed %.2lf joules of work.", 10, 10, 0
    prompt3 db "Congratulations %s. Come back any time and make use of our software. Everyone with title %s is welcome to use our programs at a reduced price.", 10, 10, 0

    MAX_INPUT_LEN equ 256

segment .bss
    name resb MAX_INPUT_LEN
    title resb MAX_INPUT_LEN

    voltage resq 1
    resistance resq 1
    time resq 1

segment .text
faraday:
%macro @print 1
    mov rdi, str_f
    mov rsi, %1
    mov rax, 0
    call printf
%endmacro

;Prolog ===== Insurance for any caller of this assembly module ========================================================
;Any future program calling this module that the data in the caller's GPRs will not be modified.
push rbp
mov  rbp,rsp
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags
;===== Code here ======================================================================================================

@print prompt_name
mov rax, 0
mov rdi, name
mov rsi, MAX_INPUT_LEN
mov rdx, [stdin]
call fgets

; rax = strlen(name)
mov rax, 0 
mov rdi, name
call strlen ; gets length of str

sub rax, 1 ; subs one from the rtn, cus it's a \n
mov byte [name + rax], 0 ; sets the last byte of name to \0 (endchar)

@print prompt_title
mov rax, 0
mov rdi, title
mov rsi, MAX_INPUT_LEN
mov rdx, [stdin]
call fgets

; rax = strlen(name)
mov rax, 0 
mov rdi, title
call strlen ; gets length of str

sub rax, 1 ; subs one from the rtn, cus it's a \n
mov byte [title + rax], 0 ; sets the last byte of name to \0 (endchar)

mov rax, 0
mov rdi, prompt1
mov rsi, title
call printf

; prompting for voltage and validating
@print prompt_voltage
mov rax, 1
mov rdi, str_f
mov rsi, voltage
call scanf

; isfloat(voltage)
mov rax, 0
mov rdi, voltage
call isfloat
cmp rax, 0          
je .invalid_input   ; if isfloat(voltage) == false

; prompting for resistance and validating
@print prompt_resistance
mov rax, 1
mov rdi, str_f
mov rsi, resistance
call scanf

mov rax, 0
mov rdi, resistance
call isfloat

cmp rax, 0
je .invalid_input

; prompting for time and validating
@print prompt_time
mov rax, 1
mov rdi, str_f
mov rsi, time
call scanf

mov rax, 0
mov rdi, time
call isfloat

cmp rax, 0
je .invalid_input

; converting all values to float
mov rax, 0
mov rdi, voltage
call atof
movsd xmm15, xmm0

mov rax, 0
mov rdi, resistance
call atof
movsd xmm14, xmm0

mov rax, 0
mov rdi, time
call atof
movsd xmm13, xmm0

mulsd xmm15, xmm15
mulsd xmm15, xmm13
divsd xmm15, xmm14

mov rax, 1
mov rdi, prompt2
mov rsi, title
movsd xmm0, xmm15
call printf

mov rax, 0
mov rdi, prompt3
mov rsi, name
mov rdx, title
call printf

movsd xmm0, xmm15

.return:
;===== Restore original values to integer registers ===================================================================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret

; the program stops accepting inputs as soon as the first invalid input is discovered
.invalid_input:
mov rax, 0
mov rdi, prompt_invalid
mov rsi, title
call printf
xorps xmm0, xmm0 ; zeros out xmm0 register so main gets 0.0
jmp .return      ; ends the program