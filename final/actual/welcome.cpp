// Name: Ronald Lee
// Email: ronaldvlee@csu.fullerton.edu
// Section: 240-3
// Date: 12-6-2023

#include <stdio.h>

extern "C" int manage();

int main(int argc, char **argv) {
    printf("Welcome to Array Management System\nThis product is maintained by Ronald Lee at ronaldvlee@csu.fullerton.edu\n");
    
    const int x = manage();

    printf("\nThe main function received %d and will keep it for a while.\n", x);

    printf("Please consider buying more software from our suite of commercial program.\nA zero will be returned to the operating system.  Bye\n");
    return 0;
}