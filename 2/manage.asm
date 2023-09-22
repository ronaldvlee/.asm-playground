global manage

extern printf
extern input_array
extern output_array
extern sum_array

segment .data
    str_f db "%s", 0
    float_f db "%lf", 0

    prompt1 db "We will take care of all your array needs.", 10
            db "Please input float numbers separated by ws. After the last number press ws followed by control-d.", 10, 0
    
    prompt2 db "Thank you.  The numbers in the array are:", 10, 0

    prompt3 db "The sum of numbers in the array is %.10lf", 10
            db "Thank you for using Array Management System.", 10, 0

    ARRAY_LENGTH equ 8


segment .bss
    array resq ARRAY_LENGTH

segment .text

%macro @print 1
        mov rdi, str_f
        mov rsi, %1
        mov rax, 0
        call printf
%endmacro

manage:
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
mov rsi, ARRAY_LENGTH
call input_array
mov r15, rax            ; r15 will store the number of elements in the array, not the length

mov rax, 0
mov rdi, array
mov rsi, r15
call sum_array
movsd xmm15, xmm0

@print prompt2

mov rax, 0
mov rdi, array
mov rsi, r15
call output_array

mov rax, 1
mov rdi, prompt3
movsd xmm0, xmm15
call printf

movsd xmm0, xmm15

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