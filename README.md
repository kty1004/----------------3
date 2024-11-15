# 컴퓨터 구조 과제3
> 물리학과 김태영

## 개요
이 프로젝트는 Apple Silicon (AArch64) 아키텍처를 기반으로 하는 어셈블리 언어와 C 언어를 사용하여 컴퓨터구조 과제3을 해결 합니다. 각 homework 디렉토리에는 다음과 같은 파일이 포함되어 있습니다. 각 homework는 개별 디렉토리로 구성되어 있으며, 이 디렉토리 내에서 어셈블리 및 C 코드를 컴파일하고 실행할 수 있습니다.
## 디렉토리 구조
```
project_root/
├── makefile                # 최상위 Makefile
├── README.md               # 프로젝트 설명 파일 (현재 파일)
└── homework/
    ├── work1/
    │   ├── assem.s        # 어셈블리 코드 파일
    │   ├── main.c         # C 코드 파일
    │   ├── makefile       # work1 전용 Makefile
    │   └── assem          # 컴파일된 실행 파일 (생성됨)
    ├── work2/
    │   ├── assem.s        # 어셈블리 코드 파일
    │   ├── main.c         # C 코드 파일
    │   ├── makefile       # work2 전용 Makefile
    │   └── assem          # 컴파일된 실행 파일 (생성됨)
    └── work3/
        ├── assem.s        # 어셈블리 코드 파일
        ├── main.c         # C 코드 파일
        ├── makefile       # work3 전용 Makefile
        └── assem          # 컴파일된 실행 파일 (생성됨)
```

> assem은 컴파일된 실행 파일을 나타냅니다.

## Makefile 사용 방법
프로젝트를 쉽게 빌드하고 실행하기 위해 Makefile을 사용합니다. Makefile은 각각 서브 디렉토리에 있는 코드를 빌드하고 실행하는 데 사용할수도 있고, 전체 프로젝트를 한번에 빌드하고 실행할 수도 있습니다.
### 프로젝트 최상위 디렉토리에서 실행
homework 내에 여러 subdirectory가 있기에 이들을 한번에 빌드하고 실행하기 위해 최상위 Makefile을 사용합니다.
1. **전체 빌드 및 실행**
   ```zsh
   make
   make run
   ```
   - `make`: `homework/work1`, `homework/work2`, `homework/work3` 디렉토리의 코드를 각각 빌드합니다.
   - `make run`: 빌드된 실행 파일을 각각 실행합니다.

2. **개별 작업 빌드 및 실행**
   ```zsh
   make work1
   make work2
   make work3
   ```
   - `make work1`: `homework/work1` 디렉토리의 코드를 빌드합니다.
   - `make work2`: `homework/work2` 디렉토리의 코드를 빌드합니다.
   - `make work3`: `homework/work3` 디렉토리의 코드를 빌드합니다.

3. **정리 (Clean)**
   ```zsh
   make clean
   ```
   - 각 homework 디렉토리의 빌드된 파일을 삭제합니다.

### 개별 `homework` 디렉토리에서 직접 빌드 및 실행
각 `work1`, `work2`, `work3` 디렉토리 내에서도 독립적으로 컴파일이 가능합니다.

```zsh
# 예시 (homework/work1 디렉토리에서)
cd homework/work1
make
./assem
```

## 실행 예시
1. 전체 빌드 및 실행
```zsh
make && make run # 전체 빌드 및 실행을 동시에 진행합니다.
```
2. 결과 확인
terminal에 다음과 같은 결과가 출력되면 성공적으로 실행된 것입니다.
```
work1 done
work2 done
work3 done
Running assem in work1:
Source Array: 1 2 3 4 5 
Destination Array: 1 2 3 4 5 
Test Passed!
Running assem in work2:
Array Original : cDzAt
Array Copy : CdZaT
Running assem in work3:
Array Original: cDzAt
Array Copy (Sorted): AcDtz
```

## 추가 참고 사항
- 이 프로젝트는 Apple Silicon 기반의 AArch64 아키텍처에서 동작하도록 설계되었습니다. Intel 기반 시스템 및 Window에서는 동작하지 않을 수 있습니다.
- `Clang`이 설치된 macOS 환경에서 테스트되었습니다.
- Apple silicon에서 동작하도록 설계되었기에, `base.h` 파일은 주어진 파일이 아닌, Apple silicon에 맞는 코드를 작성하여 재구현하였습니다.