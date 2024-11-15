// problem 3
.global _copyarray

// 매개변수:
// arr1: x0 -> 원본 배열 주소
// arr2: x1 -> 정렬된 결과를 저장할 배열 주소
// n: x2 -> 배열의 크기 (항상 5로 가정)

_copyarray:
    mov x4, #0                  // 외부 루프 인덱스 초기화 (요소 단위)

copy_loop:
    cmp x4, x2                  // 배열 길이와 비교
    bge sort_start              // 복사 완료 시 정렬 단계로 이동
    ldr w5, [x0, x4, lsl #2]    // arr1[x4]의 int 읽기 (4바이트 접근)
    str w5, [x1, x4, lsl #2]    // arrCpy[x4]에 복사
    add x4, x4, #1              // 인덱스 증가 (요소 단위)
    b copy_loop

// 정렬 시작
sort_start:
    mov x4, #0                  // 외부 루프 인덱스 초기화

outer_loop:
    cmp x4, x2                  // 외부 루프 종료 조건
    bge sort_done               
    mov x3, #0                  // 내부 루프 인덱스 초기화

inner_loop:
    sub x6, x2, #1              // 배열 끝 인덱스 설정
    cmp x3, x6                  // 내부 루프 종료 조건 (요소 단위 비교)
    bge outer_continue

    // arrCpy[x3]와 arrCpy[x3+1] 비교
    ldr w7, [x1, x3, lsl #2]    // arrCpy[x3]의 int 읽기 (4바이트 접근)
    add x5, x3, #1              // x5 = x3 + 1
    ldr w8, [x1, x5, lsl #2] // arrCpy[x3+1]의 int 읽기 (다음 4바이트 접근)

    // 대소문자 구분 없이 비교하기 위해 소문자로 변환
    orr w9, w7, #0x20           // 소문자로 변환
    orr w10, w8, #0x20          // 소문자로 변환

    cmp w9, w10                 // arrCpy[x3]와 arrCpy[x3+1] 비교
    ble no_swap

    // arrCpy[x3]와 arrCpy[x3+1]를 교환
    str w8, [x1, x3, lsl #2]    // arrCpy[x3] = arrCpy[x3+1]
    add x5, x3, #1              // x5 = x3 + 1
    str w7, [x1, x5, lsl #2] // arrCpy[x3+1] = arrCpy[x3]

no_swap:
    add x3, x3, #1              // 내부 루프 인덱스 증가 (요소 단위)
    b inner_loop

outer_continue:
    add x4, x4, #1              // 외부 루프 인덱스 증가 (요소 단위)
    b outer_loop

sort_done:
    ret                         // 정렬 완료 후 리턴