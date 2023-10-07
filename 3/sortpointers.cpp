#include <vector>
#include <iostream>
#include <stddef.h>
#include <stdio.h>

extern "C" void sortpointers(double* arr, int size) {
    // Find the maximum value in the array to determine the range of counts
    double max_value = arr[0];
    for (int i = 1; i < size; ++i) {
        if (arr[i] > max_value) {
            max_value = arr[i];
        }
    }

    // Create a count arra  y to store the counts of each value
    int range = static_cast<int>(max_value) + 1;
    std::vector<int> count(range, 0);

    // Count the occurrences of each value in the input array
    for (int i = 0; i < size; ++i) {
        int index = static_cast<int>(arr[i]);
        count[index]++;
    }

    // Update the count array to store the cumulative counts
    for (int i = 1; i < range; ++i) {
        count[i] += count[i - 1];
    }

    // Create a temporary array to store the sorted values
    double* temp = new double[size];

    // Place the elements in their correct positions in the temp array
    for (int i = size - 1; i >= 0; --i) {
        int index = static_cast<int>(arr[i]);
        temp[count[index] - 1] = arr[i];
        count[index]--;
    }

    // Copy the sorted elements back to the original array
    for (int i = 0; i < size; ++i) {
        arr[i] = temp[i];
    }

    // Free the memory allocated for the temporary array
    delete[] temp;
}
