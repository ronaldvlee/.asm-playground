; Author: Ronald Lee
; Email: ronaldvlee@csu.fullerton.edu

; *******************************************************************************************
; Director, (main) assembly function
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

;
; The main director of my project, runs everything


global director

extern input_array
extern output_array
extern sortpointers
extern printf

segment .data
    str_f db "%s", 0
    float_f db "%lf", 0

    prompt1 db "This program will sort all of your doubles", 10
            db "Please enter floating point numbers separated by white space. After the last numeric input enter at least one more white space and press cntl+d.", 10, 0

    prompt2 db "Thank you. You entered these numbers", 10, 0

    prompt3 db "End of output of array.", 10
            db "The array is now being sorted without moving any numbers.", 10
            db "The data in the array are now ordered as follows", 10, 0

    ARRAY_LENGTH equ 50

segment .bss
    array resq ARRAY_LENGTH

segment .text

director:

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
mov rsi, ARRAY_LENGTH
call input_array
mov r15, rax

@print prompt2

mov rax, 0
mov rdi, array
mov rsi, r15
call output_array

@print prompt3

mov rax, 0
mov rdi, array
mov rsi, r15
call sortpointers

mov rax, 0
mov rdi, array
mov rsi, r15
call output_array

mov rax, array
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