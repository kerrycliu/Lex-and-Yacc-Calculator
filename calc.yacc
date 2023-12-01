%{
/* Type and value, copied directly to c code */
#include <stdio.h>
int yylex(void);		/* resolving the compiler error, must declare yyex(void) */
int yyerror(const char* s);	/* resolving compiler error, must declare yyerror(const char) */
int regs[26];			/* array to store a-z */
int base;			/* octal or decimal numbers */
%}

		/* yacc definitions */
%start list 			/* empty list as start */
%token DIGIT LETTER		/* TYPE = DIGIT LETTER for pattern matching */
				/* Low Prioity */
%left '|'			/* OR */
%left '&'			/* AND */
%left '+' '-'			/* plus minus */
%left '*' '/' '%'		/* mult, divide, mod */
%left UMINUS  			/*supplies precedence for unary minus ie: neg A=-5 */

%%                   		
		/* beginning of rules section */
list:                       	/*empty */
         |			/* OR */
        list stat '\n'		/* expression newline */
         |
        list error '\n'		/* error output newline */
         {
           yyerrok;		/* action for an error */
         }
         ;
stat:    expr			/* if only expression */
         {
           printf("%d\n",$1);   /* print expression with newline */ 
         }
         |
         LETTER '=' expr	/* if assigning a letter to a vaule ie: m = 3 */
         {
           regs[$1] = $3;	/* store the LETTER index with the content of expr */
         }
         ;
expr:    '(' expr ')'		/* expression can have parenthesis */
         {
           $$ = $2;		/* content of the array regs[LETTER] ($$) = expr */
         }
         |
         expr '*' expr		/* multiplication */
         {
           $$ = $1 * $3;	/* store product in the content in regs[LETTER] = $$ */
         }
         |
         expr '/' expr		/* division */
         {
           $$ = $1 / $3;
         }
         |
         expr '%' expr		/* mod */
         {
           $$ = $1 % $3;
         }
         |
         expr '+' expr		/* addition */
         {
           $$ = $1 + $3;
         }
          |
         expr '-' expr		/* subtraction */
         {
           $$ = $1 - $3;
         }
         |
         expr '&' expr		/* bitwise and */
         {
           $$ = $1 & $3;
         }
         |
         expr '|' expr		/* bitwise or */
         {
           $$ = $1 | $3;
         }
         |
        '-' expr %prec UMINUS	/* if '-' before value */
         {
           $$ = -$2;		/* value is negative */
         }
         |
         LETTER			/* if a LETTER */
         {
           $$ = regs[$1];	/* the content in regs[LETTER] = LETTER */
         }
         |
         number			/* DIGIT */
         ;
number:  DIGIT
         {
           $$ = $1;		/* first digit */
           base = ($1==0) ? 8 : 10;	/* check for base ie: if $1=0, then octal; else decimal */
         }       |
         number DIGIT		/* adding digit to number nased on the numeric base */
         {
           $$ = base * $1 + $2;	/* base is global set 8 or 10 */
         }
         ;

%%
main()
{
 return(yyparse());		/* return yyparse */
}
yyerror(s) 			/* declared function yyerror */
char *s;
{
  fprintf(stderr, "%s\n",s);
}
yywrap()
{
  return(1);
}
