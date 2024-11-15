# Makefile for compiling with clang on Apple Silicon
# Variables
compiler=clang
target=arm64-apple-macos11
source=assem.s
output=assem
source_c=main.c


clean:
	@rm -rf $(output) $(output).dSYM
	@echo "Cleaned up the directory"