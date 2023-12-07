// Name: Ronald Lee
// Email: ronaldvlee@csu.fullerton.edu
// Section: 240-3

#include <stdio.h>

extern "C" double manage();

int main(int argc, char **argv) {
    printf("Welcome to my array by Ronald Lee\n");
    
    const double x = manage();

    printf("\nThe main function received this number: %g and will study it.\n", x);

    printf("0 will be returned to the operating system.\n");
    return 0;
}