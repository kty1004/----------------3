// problem 2
.global _copyarray

// _copyarray 함수 정의
// x0: source 배열의 주소
// x1: destination 배열의 주소
// x2: 배열의 길이
// x3: 인덱스

_copyarray:
    mov x3, #0                  // 인덱스 초기화

copy_loop:
    cmp x3, x2, lsl #2 // x3가 x2와 같은지 비교 (배열 끝 검사)
    bge copy_done               // x3 >= x2이면 루프 종료

    ldr w4, [x0, x3]           // source 배열에서 바이트(문자) 읽기

    // 대문자 ↔ 소문자 변환
    cmp w4, #'a'                // 문자가 'a'보다 크거나 같은지 확인
    blt check_upper             // 'a' 미만이면 대문자 확인으로 이동
    cmp w4, #'z'                // 문자가 'z'보다 작거나 같은지 확인
    bgt check_upper             // 'z' 초과면 대문자 확인으로 이동
    sub w4, w4, #32             // 소문자를 대문자로 변환
    b store_char

check_upper:
    cmp w4, #'A'                // 문자가 'A'보다 크거나 같은지 확인
    blt store_char              // 'A' 미만이면 변환하지 않음
    cmp w4, #'Z'                // 문자가 'Z'보다 작거나 같은지 확인
    bgt store_char              // 'Z' 초과면 변환하지 않음
    add w4, w4, #32             // 대문자를 소문자로 변환

store_char:
    str w4, [x1, x3]           // 변환된 문자를 destination 배열에 저장
    add x3, x3, #4             // 인덱스 증가 integer 4바이트씩 저장하므로 4씩 증가
    b copy_loop                 // 다음 문자로 이동

copy_done:
    ret                         // 함수 종료