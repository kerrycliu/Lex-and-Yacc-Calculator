%{
 
#include <stdio.h>
#include "y.tab.h"
int c;
extern int yylval;
%}
%%
" "       ;			/* if epsilon */
[a-z]     {
            c = yytext[0];	/* predefined pointer for pattern matching */
            yylval = c - 'a';  	/* if c matches letter then sets yylval to the offset from a */
            return(LETTER);	/* return LETTER -> TYPE in yacc */
          }
[0-9]     {
            c = yytext[0];	/* matches single digit */
            yylval = c - '0';	/* sets yylval from c offset from 0 */
            return(DIGIT);	/* return DIGIT -> TYPE in yacc */
          }
[^a-z0-9\b]    {
                 c = yytext[0];	/* match anything not a letter or digit */
                 return(c);	/* return c */
               }
%%
