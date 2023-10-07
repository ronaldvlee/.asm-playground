; Author: Ronald Lee
; Email: ronaldvlee@csu.fullerton.edu

; *******************************************************************************************
; Input Array Function in ASM
; Copyright (C) 2023 Ronald Lee

; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.

; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.

; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <https://www.gnu.org/licenses/>.
; *******************************************************************************************

; int input_array(double* arr, int size)
; ====================================================================================
; This function takes an array and it's size and inputs double into the
; array until the user hits CTRL + D.
; Parameters:
;   - rdi: array pointer, double*
;   - rsi: size of the array, int
; Returns:
;   - rax: # of elems in array, int

global input_array

extern printf
extern scanf
extern clearerr
extern stdin

section .data
    single_float_format db "%lf", 0

section .bss
    ; temp_float resq 1

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

push qword 0 ;staying on the boundary

; Taking information from parameters
mov r15, rdi  ; This holds the first parameter (the array)
mov r14, rsi  ; This holds the second parameter (the size of array)

; let user enter numbers until cntrl + d is entered
; this for loop will go to 6, the chosen array size, or end once cntrl d is pressed.
mov r13, 0 ; for loop counter
beginLoop:
    cmp r14, r13 ; we want to exit loop when we hit the size of array
    je outOfLoop
    mov rax, 0
    mov rdi, single_float_format
    push qword 0
    mov rsi, rsp
    call scanf
    cdqe
    cmp rax, -1  ; loop termination condition: user enters cntrl + d.
    pop r12
    je outOfLoop
    
    lea r10, [r12]  ;at array[counter], place the input number
    mov [r15 + 8*r13], r10
    
    inc r13  ;increment loop counter
    jmp beginLoop

outOfLoop:
pop rax ; counter push at the beginning
mov rax, r13  ; store the number of things in the aray from the counter of for loop

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