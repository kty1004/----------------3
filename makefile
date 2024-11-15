# project directory에서 makefile을 실행하면 각 homework 디렉토리로 이동하여 make를 실행하도록 한다.
.PHONY: all work1 work2 work3 clean

# 최상위에서 각 작업 실행
all: work1 work2 work3

work1:
	@$(MAKE) -C homework/work1 all
	@echo "work1 done"
work2:
	@$(MAKE) -C homework/work2 all
	@echo "work2 done"
work3:
	@$(MAKE) -C homework/work3 all
	@echo "work3 done"

# 각 서브디렉토리에서 실행파일 실행 -> make && make run을 실행하면 각 서브디렉토리의 assem 실행파일을 만들고 이를 실행한다.
run:
	@echo "Running assem in work1:"
	@./homework/work1/assem
	@echo "Running assem in work2:"
	@./homework/work2/assem
	@echo "Running assem in work3:"
	@./homework/work3/assem

clean:
	$(MAKE) -C homework/work1 clean
	$(MAKE) -C homework/work2 clean
	$(MAKE) -C homework/work3 clean
