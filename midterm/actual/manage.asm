; Name: Ronald Lee
; Email: ronaldvlee@csu.fullerton.edu
; Section: 240-3

global manage

extern input_array
extern output_array
extern sum_array
extern rot_left
extern printf

segment .data
    str_f db "%s", 0
    float_f db "%lf", 0

    prompt1 db "Please enter floating point numbers separated by ws.  After the last valid input enter one more ws followed by control+d.", 10, 0
    prompt2 db 10, "Function rot_left was called 1 time.", 10, 0
    rotcalled db 10, "Function rot_left was called %d times consecutively.", 10, 0
    here_arr db "Here is the array: ", 0
    this_arr db "This is the array: ", 0

    MAX_ARRAY_SIZE equ 10

segment .bss
    array resq MAX_ARRAY_SIZE

segment .text

manage:

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
@print prompt1

mov rax, 0
mov rdi, array
mov rsi, MAX_ARRAY_SIZE
call input_array

mov r15, rax ; r15 will store the length of the array

@print this_arr
mov rax, 0
mov rdi, array
mov rsi, r15
call output_array

; --- rotate 1 time ---
@print prompt2

mov rax, 0
mov rdi, array
mov rsi, r15
mov rdx, 1
call rot_left

@print here_arr
mov rax, 0
mov rdi, array
mov rsi, r15
call output_array
; ---

; --- rotate 3 times ---
mov rax, 0
mov rdi, rotcalled
mov rsi, 3
call printf

mov rax, 0
mov rdi, array
mov rsi, r15
mov rdx, 3
call rot_left

@print here_arr
mov rax, 0
mov rdi, array
mov rsi, r15
call output_array
; ---

; --- rotate 2 times ---
mov rax, 0
mov rdi, rotcalled
mov rsi, 2
call printf

mov rax, 0
mov rdi, array
mov rsi, r15
mov rdx, 2
call rot_left

@print here_arr
mov rax, 0
mov rdi, array
mov rsi, r15
call output_array
; ---


mov rax, 0
mov rdi, array
mov rsi, r15
call sum_array
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