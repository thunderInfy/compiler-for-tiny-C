Test_Output.txt: a.out test.c
	./a.out < test.c > Test_Output.txt

a.out: lex.yy.c y.tab.c main.o
	gcc lex.yy.c y.tab.c main.o -lfl

lex.yy.c: lexer.l
	flex lexer.l

y.tab.c: parser.y
	yacc -dtv parser.y

main.o: main.c
	gcc -c main.c

clean:
	rm y.tab.c y.tab.h a.out lex.yy.c y.output main.o Test_Output.txt