#include <stdio.h>
#include <stdbool.h>

// 어셈블리 함수 선언
extern void copyarray();

// 배열 선언
extern int source_array[5];
extern int dest_array[5];

int main() {
    // 배열 복사 함수 호출
    copyarray();

    // 결과 출력
    printf("Source Array: ");
    for (int i = 0; i < 5; ++i) {
        printf("%d ", source_array[i]);
    }
    printf("\n");

    printf("Destination Array: ");
    for (int i = 0; i < 5; ++i) {
        printf("%d ", dest_array[i]);
    }
    printf("\n");

    // 유닛 테스트
    bool test_passed = true;
    for (int i = 0; i < 5; ++i) {
        if (source_array[i] != dest_array[i]) {
            test_passed = false;
            break;
        }
    }

    if (test_passed) {
        printf("Test Passed!\n");
    } else {
        printf("Test Failed!\n");
    }

    return 0;
}