%skeleton "lalr1.cc" // -*- C++ -*-
%require "3.6.4"
%defines

%define api.token.raw

%define api.token.constructor
%define api.value.type variant
%define parse.assert

%code requires {
  # include <string>
  #include <cmath>
  class driver;
}

// The parsing context.
%param { driver& drv }

%locations

%define parse.trace
%define parse.error detailed
%define parse.lac full

%code {
# include "driver.hh"
}

%define api.token.prefix {TOK_}
%token
  ASSIGN  ":="
  MINUS   "-"
  PLUS    "+"
  STAR    "*"
  SLASH   "/"
  LPAREN  "("
  RPAREN  ")"
  POWER   "^"
  SIN     "SIN"
  COS     "COS"
  TAN     "TAN"
  LOG     "LOG"
  LOG10   "LOG10"
  LOG2    "LOG2"
  SQUAREROOT    "SQUAREROOT"
  PERCENTAGE    "%"
;

%token <std::string> IDENTIFIER "identifier"
%token <double> NUMBER "number"
%nterm <double> exp

%printer { yyo << $$; } <*>;

%%
%start unit;
unit: assignments exp  { drv.result = $2; };

assignments:
  %empty                 {}
| assignments assignment {};

assignment:
  "identifier" ":=" exp { drv.variables[$1] = $3; };

%left "+" "-";
%left "*" "/";
exp:
  "number"
| "identifier"  { $$ = drv.variables[$1]; }
| exp "+" exp   { $$ = $1 + $3; }
| exp "-" exp   { $$ = $1 - $3; }
| exp exp       { $$ = $1 + $2; }
| exp "*" exp   { $$ = $1 * $3; }
| exp "/" exp   { $$ = $1 / $3; }
| "(" exp ")"   { $$ = $2; }
| exp "^" exp   { $$ = pow($1, $3); }
| "SIN" "(" exp     { $$ = sin($3); }
| "SIN" "(" exp ")" { $$ = sin($3); }
| "COS" "(" exp     { $$ = cos($3); }
| "COS" "(" exp ")" { $$ = cos($3); }
| "TAN" "(" exp     { $$ = tan($3); }
| "TAN" "(" exp ")" { $$ = tan($3); }
| "LOG" "(" exp     { $$ = log($3); }
| "LOG" "(" exp ")" { $$ = log($3); }
| "LOG10" "(" exp   { $$ = log10($3); }
| "LOG10" "(" exp ")" { $$ = log10($3); }
| "LOG2" "(" exp    { $$ = log2($3); }
| "LOG2" "(" exp ")" { $$ = log2($3); }
| "SQUAREROOT" "(" exp   { $$ = sqrt($3); }
| "SQUAREROOT" "(" exp ")"  { $$ = sqrt($3); }
| exp "%" { $$ = $1 / 100; }
%%

void
yy::parser::error (const location_type& l, const std::string& m)
{
  std::cerr << l << ": " << m << '\n';
}
