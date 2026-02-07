CC=gcc
CFLAGS=-Wall -ansi -pedantic
LFLAGS=-lm

LIBRARY_NAME=libimage.a
TESTNAME=test

all:	$(LIBRARY_NAME)

clean:
	rm -f $(LIBRARY_NAME)
	rm -f test
	rm -f *.o
	rm -f *.gcno
	rm -f *.gcda
	rm -f *.html

$(LIBRARY_NAME):	image.o
	ar rcs $(LIBRARY_NAME) image.o

image.o:	image.c
	$(CC) $(CFLAGS) -c -o $@ $^ $(LFLAGS)

image-cov.o:	image.c
	$(CC) $(CFLAGS) -c -fprofile-arcs -ftest-coverage -o $@ $^ $(LFLAGS)

test.o:	test.c
	$(CC) $(CFLAGS) -c -fprofile-arcs -ftest-coverage -o $@ $^ $(LFLAGS)

$(TESTNAME):	test.o image-cov.o
	$(CC) image-cov.o test.o -lgcov -o $(TESTNAME)

coverage.html:	test.gcda
	gcovr --html-details coverage.html -e test.c

test.gcda:	test
	./$(TESTNAME)

coverage.info:
	lcov --capture --directory . --output-file coverage.info

index.html:	coverage.info
	genhtml coverage.info --output-directory .
