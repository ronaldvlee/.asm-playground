#include <stdio.h>

extern double manage();

int main(int argc, char **argv) {
    printf("Welcome to Array Management System\n"
           "This product is maintained by Ronald Lee at ronaldvlee@csu.fullerton.edu\n\n");
    
    const double x = manage();

    printf("\n\nThe main function received %.10lf and will keep it for a while.\n"
           "Please consider buying more software from our suite of commercial program.\n"
           "A zero will be returned to the operating system. Bye\n", x);
    return 0;
}