%option noyywrap
%{
#include "calc.tab.h"
#include <stdlib.h>
#include <stdio.h>
%}
%%
"+" { return ADD;}
"-" { return SUB; }
"*" { return MUL; }
"/" { return DIV; }
"|" { return ABS; }
[0-9]+|[0-9]+\.[0-9]+ { yylval = strtod(yytext, NULL); return NUMBER; }
\n {return EOL;}
"(" { return OP; }
")" { return CP; }
[ \t] {}
. {printf("????");}
%%

