#include "../../base.h"
// problem 2

extern void copyarray (int arr1[], int arr2[], int n);

int main (void)
{
    int arrOri[5] = {'c', 'D', 'z', 'A', 't'};
    int arrCpy[5] = {0, 0, 0, 0, 0};
    int num = 5;

    // 배열 복사 및 변환
    copyarray(arrOri, arrCpy, num);

    // 결과 출력
    sendstr("Array Original : ");
    printArr(arrOri, num);
    sendstr("Array Copy : ");
    for (int i = 0; i < num; i++) {
        sendchar(arrCpy[i]);
    }
    sendstr("\n");

    _sys_exit(0);
}