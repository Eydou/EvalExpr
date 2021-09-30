##
## EPITECH PROJECT, 2019
## Makefile
## File description:
## Makefile for clean.
##

SRC     =       Main.hs

CC      =       stack build

COPY_EXE      =       --copy-bins --local-bin-path .

all:
	@$(CC) $(COPY_EXE)
	@echo -e " -> \e[96mCompilation ok\033[0m"

tests_run:
	@echo -e "\e[94m-------UNIT_TEST-------\033[0m"
	@bats unitTest/unit_test.bats
	@echo -e "\e[94m-----------------------\033[0m"

clean:
	@stack clean --full
	@rm funEvalExpr.cabal
	@echo -e " -> \e[96mIs Clean\033[0m"

fclean: clean
		@rm funEvalExpr

re:     fclean all

.PHONY: all clean fclean
