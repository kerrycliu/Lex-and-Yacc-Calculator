# calculator_compiler
Lex and Yacc calculator compiler, performing lexical analysis and Yacc compilation
## Installation
Initial files are calc.lex and calc.yacc. 
```
yacc -d calc.yacc
````
This will generate y.tab.h and y.tab.c

Then run
```
lex calc.lex
```
This will produce lex.yy.c

Finally compile:
```
cc y.tab.c lex.yy.c
```
This will produce executable a.out

To run the compiler:
```
./a.out
```
## Usage
./a.out to start the program, CTRL C to quit.
```
$ ./a.out
$ m=5
$ 4+m
$ 9
$ a=8
$ b=2*(a+4)/2
$ b
$ 12
$ 2/0
$ Floating point exception: 8
$ a=(2+3)-(4*7)
$ a
$ -23
$ a=2.0
$ syntax error
$ ^C
```
## Note
This compiler does not support floating point calculations. Every digit value must be integers. 

