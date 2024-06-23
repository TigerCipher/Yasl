%{
#include "parser.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex();
extern FILE *yyin;
extern int lineno;
%}

/* Regular expressions and tokens */
%option noyywrap

%%

"var"                   { return VAR; }
"final"                 { return FINAL; }
"func"                  { return FUNC; }
"struct"                { return STRUCT; }
"true"                  { return TRUE; }
"false"                 { return FALSE; }
"return"                { return RETURN; }
"@import"               { return IMPORT; }

[a-zA-Z_][a-zA-Z0-9_]*  { yylval.str = strdup(yytext); return IDENTIFIER; }

[0-9]+                  { yylval.num = atoi(yytext); return NUMBER; }
[0-9]+"."[0-9]+         { yylval.fnum = atof(yytext); return FLOAT; }

\"([^\\\n]|(\\.))*?\"   { yylval.str = strdup(yytext); return STRING; }

"//".*                  { /* Ignore comments */ }

"+"                     { return PLUS; }
"-"                     { return MINUS; }
"*"                     { return MULT; }
"/"                     { return DIV; }
"="                     { return ASSIGN; }
"=="                    { return EQ; }
"!="                    { return NEQ; }
"<"                     { return LT; }
">"                     { return GT; }
"<="                    { return LTE; }
">="                    { return GTE; }
"&&"                    { return AND; }
"||"                    { return OR; }
"!"                     { return NOT; }
"{"                     { return LBRACE; }
"}"                     { return RBRACE; }
"("                     { return LPAREN; }
")"                     { return RPAREN; }
"["                     { return LBRACKET; }
"]"                     { return RBRACKET; }
","                     { return COMMA; }
";"                     { return SEMICOLON; }

[ \t\r]+              { /* Ignore whitespace */ }

\n  { lineno++; }

%%

// int yywrap() {
//     return 1;
// }
