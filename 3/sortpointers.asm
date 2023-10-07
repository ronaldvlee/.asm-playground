; Author: Ronald Lee
; Email: ronaldvlee@csu.fullerton.edu

; *******************************************************************************************
; sortpointers Function in ASM
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

; void sortpointers(double*, int)
; ============================================
; This is a bubble sort.
;
; Parameters:
;   - rdi: array pointer, double*
;   - rsi: size, int

global sortpointers

section .text
sortpointers:
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

%define array_pointer r15
mov array_pointer, rdi  ; array pointer

%define array_size r14
mov array_size, rsi     ; array size

%define swapped r13
mov swapped, 0          ; swapped flag

%define iterator r12
mov iterator, 0         ; first iterator, i

%define jterator r11
mov jterator, 0         ; second iterator, j

dec array_size          ; subtracting the array size by one, bc we are already checking the next index

outerloop:
mov jterator, 0         ; j = 0
mov r9, array_size      ; r9 = size - 1
sub r9, iterator        ; r9 = size - 1 - i

innerloop:
movsd xmm1, [array_pointer + jterator * 8]      ; load arr[i]
movsd xmm2, [array_pointer + jterator * 8 + 8]  ; load arr[i+1]

ucomisd xmm1, xmm2  ; arr[i] (compare) arr[i+1]
jbe noswap          ; jump if below or equal

; swapping the two indexes
movsd [array_pointer + jterator * 8], xmm2     
movsd [array_pointer + jterator * 8 + 8], xmm1

mov swapped, 1      ; set swapped flag to true

noswap:
inc jterator        ; j++
cmp jterator, r9    ; check if j < size - i - 1
jl innerloop        ; go back to looping

inc iterator                ; i++
cmp iterator, array_size    ; check if i >= size - 1
jge done                    ; go to finish

; if i < size - 1
cmp swapped, 0              ; now we check the swapped flag is 0
jne outerloop               ; if swapped flag != 0 then go back to looping


done:
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