; Name: Ronald Lee
; Email: ronaldvlee@csu.fullerton.edu
; Section: 240-3

global rot_left

segment .data

segment .bss

segment .text
rot_left:
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

; void rot_left(array, length, n)
; rdi holds the array
; rsi holds the length of the array
; rdx holds the amount of times the array will be rotated to the left

; This code was used to reference: https://www.javatpoint.com/java-program-to-left-rotate-the-elements-of-an-array
;
; for(int i = 0; i < n; i++){  
;     int j, first;  
;     first = arr[0];  
;     for(j = 0; j < arr.length-1; j++){  
;         arr[j] = arr[j+1];  
;     }  
;     //First element of array will be added to the end  
;     arr[j] = first;  
; }  

mov r15, rdi ; array
mov r14, rsi ; len
mov r13, rdx ; n

.loop:

xor r11, r11 ; index
movsd xmm15, [r15] ; saving first elem of array

.rotation:
movsd xmm14, [r15 + (r11 + 1) * 8]
movsd [r15 + r11 * 8], xmm14        ; arr[j] = arr[j+1]
inc r11
cmp r11, r14 - 1
jl .rotation

movsd [r15 + (r14 - 1) * 8], xmm15  ; moves the first elem of the array to the back

dec r13
cmp r13, 0
jg .loop

.done:
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