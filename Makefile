CC = g++
OPTS = -std=gnu++11 -g

BIN_DIR = bin
SRC_DIR = src
OBJ_DIR = obj

BINARY = $(BIN_DIR)/lisparse

default: builddir main

main:
	flex -o $(OBJ_DIR)/lisparse.yy.c $(SRC_DIR)/lisparse.l
	bison -o $(OBJ_DIR)/lisparse.tab.c $(SRC_DIR)/lisparse.y
	$(CC) $(OPTS) $(OBJ_DIR)/lisparse.tab.c -o bin/lisparse

clean:
	rm -rf $(BIN_DIR) $(OBJ_DIR)

builddir:
	mkdir -p $(OBJ_DIR)
	mkdir -p $(BIN_DIR)
