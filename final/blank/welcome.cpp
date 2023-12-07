#include <stdio.h>

extern "C" double manage();

int main(int argc, char **argv) {
    printf("Welcome to my array by Ronald Lee");
    
    const double x = manage();

    printf("The main function received this number: %lf and will study it.\n", x);

    printf("0 will be returned to the operating system.\n");
    return 0;
}