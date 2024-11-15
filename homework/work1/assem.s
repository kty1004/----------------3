//problem 1
// Apple Silicon (AArch64)용 어셈블리 코드
.text
.align 4
.global _copyarray
.global _source_array
.global _dest_array

// 데이터 섹션: 배열 정의
.data
.align 8
_source_array: .word 1, 2, 3, 4, 5      // 원본 배열
_dest_array:   .space 20                // 복사될 배열 (5개의 4바이트 정수 공간)

.text
_copyarray:
    // x0: _source_array 주소
    // x1: _dest_array 주소
    // x2: 배열 크기 (정수 개수)

    mov x2, #5                         // 배열 크기 설정

    // 원본 배열 주소 가져오기
    adrp x0, _source_array@PAGE         // 페이지 기준으로 원본 배열 주소 로드
    add  x0, x0, _source_array@PAGEOFF  // 페이지 오프셋 추가

    // 복사될 배열 주소 가져오기
    adrp x1, _dest_array@PAGE           // 페이지 기준으로 복사될 배열 주소 로드
    add  x1, x1, _dest_array@PAGEOFF    // 페이지 오프셋 추가

copy_loop:
    cbz x2, copy_done                  // x2가 0이면 종료
    ldr w3, [x0], #4                   // 원본 배열에서 값 읽기 후 x0를 4바이트 증가
    str w3, [x1], #4                   // 복사된 배열에 값 저장 후 x1를 4바이트 증가
    sub x2, x2, #1                     // 카운터 감소
    b copy_loop                        // 반복

copy_done:
    ret

