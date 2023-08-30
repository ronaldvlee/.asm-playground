#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

extern "C" double compute_trip();

int main() {
    printf("Welcome to Trip Advisor by Ronald Lee.\n"
           "We help you plan your trip.\n\n");
    

    double x = compute_trip();

    printf("The main module received this number %.2lf and will keep it for a while.\n"
           "A zero will be sent to your operating system.\nGood-bye. Have a great trip.\n\n", x);

    return 0;
}