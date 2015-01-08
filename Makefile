
all: logofile

logofile: logo.tab.o lex.yy.o logo.h node_logo.c
	gcc logo.tab.o lex.yy.o node_logo.c -o TClogo
	./TClogo <test.TClogo	

logo.tab.c: logo.y logo.h
	bison -d logo.y 

lex.yy.c: logo.l logo.h
	flex logo.l

clean:
	\rm -rf *~ logo.tab.* lex.yy.c a.out *.o TClogo
  
