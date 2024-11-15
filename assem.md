# AArch64 어셈블리 문법 정리

## 파일 구조
- `.text`: 코드 섹션을 정의함. 실행 가능한 명령어들이 위치함.
- `.data`: 데이터 섹션을 정의함. 프로그램에서 사용할 정적 데이터를 저장함.
- `.align N`: 메모리 정렬을 위해 사용함. `N`은 정렬할 바이트 수를 나타냄.
- `.global`: 전역 심볼을 선언하여 외부에서 접근 가능하게 만듦.

## 코드 설명

### 데이터 섹션
```assembly
.data
.align 8
source_array: .word 1, 2, 3, 4, 5      // 원본 배열 정의
dest_array:   .space 20                // 복사될 배열 공간 할당 (5개의 4바이트 정수)
```
- `source_array`: 1, 2, 3, 4, 5의 값을 가지는 배열임.
- `dest_array`: 20바이트(5개의 4바이트 정수)를 위한 공간을 할당함.

### 코드 섹션
```assembly
.text
.align 4
.global copyarray
.global main
```
- `copyarray`와 `main` 함수는 외부에서 접근 가능하도록 선언함.

## 어셈블리 명령어 설명

### `adrp`와 `add`
```assembly
adrp x0, source_array@PAGE         // 페이지 기준으로 source_array 주소 로드
add  x0, x0, source_array@PAGEOFF  // 페이지 오프셋 추가
```
- `adrp`: 페이지 기준 주소를 로드함. 페이지 단위로 정렬된 주소를 가져옴.
- `add`: 오프셋을 더하여 실제 주소를 계산함.

### 레지스터 설명
- `x0`, `x1`, `x2`: 64비트 범용 레지스터.
- `w3`: 32비트 레지스터.
- `sp`: 스택 포인터 레지스터.
- `cbz`: 조건부 분기 명령어로, 레지스터 값이 0이면 분기함.

### `copyarray` 함수
```assembly
copyarray:
    mov x2, #5                         // 배열 크기 설정
    adrp x0, source_array@PAGE         // 원본 배열 주소 가져오기
    add  x0, x0, source_array@PAGEOFF  // 오프셋 추가
    adrp x1, dest_array@PAGE           // 복사될 배열 주소 가져오기
    add  x1, x1, dest_array@PAGEOFF    // 오프셋 추가

copy_loop:
    cbz x2, copy_done                  // x2가 0이면 종료
    ldr w3, [x0], #4                   // 원본 배열에서 값 읽고 x0를 4바이트 증가
    str w3, [x1], #4                   // 복사된 배열에 값 저장 후 x1를 4바이트 증가
    sub x2, x2, #1                     // 카운터 감소
    b copy_loop                        // 반복

copy_done:
    ret                                // 함수 종료
```
- `mov`: 레지스터에 값을 할당함.
- `ldr`: 메모리에서 값을 로드함.
- `str`: 레지스터 값을 메모리에 저장함.
- `cbz`: 값이 0인지 확인하고 조건부 분기함.
- `ret`: 함수 종료 후 호출 지점으로 복귀함.

### `main` 함수
```assembly
main:
    bl copyarray                       // copyarray 함수 호출
    ret                                // 프로그램 종료
```
- `bl`: 서브루틴 호출 (branch with link).
- `ret`: 호출한 위치로 복귀.

## 어셈블리 코드 흐름
1. `main`에서 `copyarray` 함수 호출함.
2. `copyarray` 함수에서 `source_array` 값을 `dest_array`로 복사함.
3. 복사가 완료되면 `main`으로 복귀하여 종료함.

## 참고 사항
- Apple Silicon (AArch64) 환경에서 동작하도록 작성된 코드임.
- `adrp`와 `add`를 사용하여 Position-Independent Code(PIC)를 구현함.
- Mach-O 포맷에서 데이터 접근을 위해 페이지 접근 방식을 사용함.


# 페이지 접근 방식 (Page Access Method)

## 페이지 접근 방식이란?
- **페이지 접근 방식**은 프로세서에서 **대용량 메모리를 효율적으로 관리**하기 위해 사용하는 방법임.
- 특히 **Apple Silicon (AArch64)** 환경에서는 메모리 접근 시 **페이지 단위**로 접근하는 것이 일반적임.
- 이 방식은 **Position-Independent Code (PIC)**를 구현하는 데도 중요한 역할을 함.

## 페이지 접근 방식의 필요성
- 현대 컴퓨터 시스템에서는 메모리가 **페이지**라는 단위로 관리됨. 일반적으로 **4KB** 크기를 가짐.
- **페이지 접근 방식**을 사용하면, 코드가 **동적으로 로드**되거나 **재배치**되더라도 올바른 메모리 주소를 계산할 수 있음.
- 특히, **Mach-O 포맷**에서는 코드와 데이터가 서로 독립적으로 위치할 수 있기 때문에, 페이지 접근 방식이 필수적임.

## `ADRP`와 `ADD` 명령어를 활용한 페이지 접근 방식
- `ADRP` (Address of Page): 현재 **프로그램 카운터(PC)**를 기준으로 **4KB 페이지 기준 주소**를 가져옴.
- `ADD`: `ADRP`로 가져온 페이지 주소에 **오프셋을 추가**하여 **실제 메모리 주소**를 계산함.

### 예제 코드
```assembly
adrp x0, source_array@PAGE         // 페이지 기준으로 source_array의 페이지 주소 로드
add  x0, x0, source_array@PAGEOFF  // 페이지 오프셋 추가하여 실제 주소 계산
```
- `ADRP x0, source_array@PAGE`: `source_array`가 위치한 페이지의 시작 주소를 가져옴.
- `ADD x0, x0, source_array@PAGEOFF`: 페이지 시작 주소에 오프셋을 더해 실제 주소를 계산함.

## `ADRP` 명령어의 동작 방식
- `ADRP`는 **현재 PC**를 기준으로 **4KB 페이지 단위**로 주소를 계산함.
- 예를 들어, `source_array`가 0x10001000 주소에 위치해 있을 경우:
  - `ADRP`는 **0x10001000**을 페이지 단위로 올림하여 **0x10000000**을 로드함.
  - 이후 `ADD` 명령어를 통해 필요한 오프셋을 더하여 실제 주소를 계산함.

## 페이지 접근 방식의 장점
1. **Position-Independent Code (PIC)** 구현에 유리함.
   - 프로그램이 메모리 내 어디에 로드되더라도 **올바른 주소**를 계산할 수 있음.
2. **메모리 효율성 향상**:
   - 페이지 접근 방식은 큰 메모리 블록을 효율적으로 관리할 수 있도록 도와줌.

## 페이지 접근 방식의 한계
- **4KB 페이지 경계를 넘는 데이터 접근**에는 추가적인 연산이 필요할 수 있음.
- `ADRP`와 `ADD`의 조합이 **Mach-O 포맷**에서 제한적일 수 있으며, 일부 경우 **리터럴 풀(literal pool)**을 사용해야 할 수도 있음.

## 정리
- 페이지 접근 방식은 **AArch64 환경**에서 메모리를 효율적으로 관리하고 **Position-Independent Code**를 구현하는 데 필수적임.
- `ADRP`와 `ADD` 명령어를 활용하여 **동적 메모리 주소 계산**을 수행함.