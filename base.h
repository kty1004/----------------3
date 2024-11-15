// macOS 환경에서는 LPC21xx.h을 사용할 수 없으므로, 대체 함수를 정의
#ifndef BASE_H
#define BASE_H

#include <stdio.h>
#include <stdlib.h>

// 시스템 종료 함수 (macOS 환경에 맞게 수정)
static inline void _sys_exit(int return_code) {
    exit(return_code);
}

// 문자 출력 함수 (UART 대체)
static inline int sendchar(int ch) {
    putchar(ch);
    return ch;
}

// 문자 입력 함수 (UART 대체)
static inline int getkey(void) {
    return getchar();
}

// 16진수 출력 함수
static inline void sendhex(int hex) {
    printf("%X", hex);
}

// 문자열 출력 함수
static inline void sendstr(char *p) {
    printf("%s", p);
}

// 정수 배열 출력 함수
static inline void printArr(int arr[], int n) {
    for (int i = 0; i < n; i++) {
        printf("%c", arr[i]);
    }
    printf("\n");
}

// 정수 출력 함수
static inline void printDecimal(int num) {
    printf("%d\n", num);
}

#endif // BASE_H