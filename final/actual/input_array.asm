; Name: Ronald Lee
; Email: ronaldvlee@csu.fullerton.edu
; Section: 240-3
; Date: 12-06-2023

global input_array
extern printf

section .data
        prompt1 db "The array has been filled with random numbers.", 10, 0

section .text

input_array:
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

mov r14, rdi                   ; arg1: array pointer
mov r15, rsi                   ; arg2: array size

mov r13, 0                     ; initialize index

.loop:
; Length check.
        cmp r13, r15
        jge .done

; Generate random number using rdrand.
        mov    rax, 0
        rdrand rax

; Cast to double and store in xmm0.
        movq xmm0, rax

; Assert that it's not NaN, regenerate if it is.
        ucomisd xmm0, xmm0             ; if NaN, then parity flag is set
        jp      .loop                  ; (j)ump if (p)arity

; Check that our exponent is not 0. The exponent is from bit 52 to 62.
        mov rbx, 0x7FF0000000000000    ; mask for exponent
        and rax, rbx                   ; use our float in rax and &mask it
        shr rax, 52                    ; shift right to get exponent
        cmp rax, 0                     ; compare to 0
        je  .loop                      ; if 0, then generate a new number

; Store random float number in array.
        movsd [r14 + (r13 * 8)], xmm0

; Increment index and reloop.
inc r13
jmp .loop

.done:

push qword 0
mov rax, 0
mov rdi, prompt1
call printf
pop rax
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