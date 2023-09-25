#include <stdio.h>

extern double* manage();

int main(int argc, char **argv) {
    printf("Welcome to Array Management System\n"
           "This product is maintained by Ronald Lee at ronaldvlee@csu.fullerton.edu\n\n");
    
    const double* x = manage();

    printf("The main function has recieved this array:\n");
    for (int i = 0; i < 8; i++) {
       if (!x[i]){
       } else {
           printf("%.10lf\n", x[i]);
       }
    }

    printf("Please consider buying more software from our suite of commercial program.\n"
           "A zero will be returned to the operating system. Bye\n");
    return 0;
}