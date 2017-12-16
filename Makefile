ARCH := $(shell uname -m)

DEBUG_OPTS := -Wall -Wextra -Wfloat-equal -Winline -Wundef -Werror -fverbose-asm -Wint-to-pointer-cast -Wshadow -Wpointer-arith -Wcast-align  -Wcast-qual -Wunreachable-code -Wstrict-overflow=5 -Wwrite-strings -Wconversion --pedantic-errors -ggdb -Wredundant-decls -Werror=maybe-uninitialized

MEM_OPTS := -fstack-protector -fsanitize=address -fsanitize=undefined -fno-omit-frame-pointer

OPTS := -lm deps/fnv-hash/libfnv.a

CMD_ARGS ?=

all: bin/interpreter

bin/libconcat.a: bin/compile.o bin/lex.o bin/lib.o bin/object.o bin/stack.o
	ar rcsv $@ $^

bin/interpreter: deps/fnv-hash/libfnv.a bin/libconcat.a
	$(CC) -static src/main.c $(DEBUG_OPTS) $(OPTS) deps/fnv-hash/libfnv.a bin/libconcat.a -o $@

bin/compile.o:
	$(CC) src/compile/compilecommon.h $(DEBUG_OPTS) $(OPTS) -c -o $@
bin/lex.o:
	$(CC) src/lex/lexcommon.h $(DEBUG_OPTS) $(OPTS) -c -o $@
bin/lib.o:
	$(CC) src/lib/libcommon.h $(DEBUG_OPTS) $(OPTS) -c -o $@
bin/object.o:
	$(CC) src/object/objectcommon.h $(DEBUG_OPTS) $(OPTS) -c -o $@
bin/stack.o:
	$(CC) src/stack/stackcommon.h $(DEBUG_OPTS) $(OPTS) -c -o $@

deps/fnv-hash/libfnv.a:
	$(MAKE) -C deps/fnv-hash

clean:
	rm bin/*