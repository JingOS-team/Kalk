%{
#include <stdio.h>
double parse(char*s);
%}

%define api.value.type {double}
%parse-param {double* result}
%token NUMBER
%token ADD SUB MUL DIV ABS
%token OP CP
%token EOL
 
%%
calclist:
  | calclist exp EOL { *result = $2; }
  ;
exp: factor
 | exp ADD factor { $$ = $1 + $3; }
 | exp SUB factor { $$ = $1 - $3; }
 ;
factor: term
 | factor MUL term { $$ = $1 * $3; }
 | factor DIV term {$$ = $1 / $3; }
 ;
term: NUMBER
 | ABS term { $$ = $2 >= 0? $2 : - $2; }
 | OP exp CP { $$ = $2; }
 ;
%%
