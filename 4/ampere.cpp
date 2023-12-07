/*
    Author: Ronald Lee
    Email: ronaldvlee@csu.fullerton.edu

; *******************************************************************************************
    ; Driver for program
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

    The main function
*/

#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

extern "C" double faraday();

int main() {
    printf("Welcome to Majestic Power Systems, LLC\n"
        "Project Director, Ronald Lee, Senior Software Engineer.\n\n");

    double x = faraday();

    printf("The main function received this number %.2lf and will keep it for future study.\n"
            "A zero will be returned to the operating system. Bye.\n\n", x);

    return 0;
}