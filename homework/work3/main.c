#include "../../base.h"
// problem 3
extern void copyarray(int arr1[], int arr2[], int n);

int main(void) {
    int arrOri[5] = {'c', 'D', 'z', 'A', 't'};
    int arrCpy[5] = {};
    int num = 5;

    // 배열 정렬 및 변환 수행
    copyarray(arrOri, arrCpy, num);

    // 결과 출력
    sendstr("Array Original: ");
    printArr(arrOri, num);
    sendstr("Array Copy (Sorted): ");
    printArr(arrCpy, num);

    return 0;
}