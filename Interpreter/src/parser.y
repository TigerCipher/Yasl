%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex();

extern FILE *yyin;
int lineno = 1;

%}

/* Token definitions */
%token VAR FINAL FUNC STRUCT RETURN TRUE FALSE IMPORT IDENTIFIER NUMBER FLOAT STRING

%token PLUS MINUS MULT DIV ASSIGN EQ NEQ LT GT LTE GTE AND OR NOT LBRACE RBRACE LPAREN RPAREN LBRACKET RBRACKET COMMA SEMICOLON

/* Union to hold token values */
%union {
    int num;
    double fnum;
    char *str;
}

/* Associate token types with union */
%type <num> NUMBER
%type <fnum> FLOAT
%type <str> IDENTIFIER STRING

%start program

%%

program:
    statement_list
    ;

statement_list:
    | statement_list statement
    ;

statement:
    variable_declaration
    | function_declaration
    | struct_declaration
    | import_statement
    | return_statement
    | expression_statement
    ;

return_statement
    : RETURN expression SEMICOLON
    ;

variable_declaration:
    VAR IDENTIFIER SEMICOLON
    | VAR IDENTIFIER ASSIGN expression SEMICOLON
    | FINAL VAR IDENTIFIER ASSIGN expression SEMICOLON
    | VAR IDENTIFIER ASSIGN array_literal SEMICOLON
    ;

function_declaration:
    FUNC IDENTIFIER LPAREN parameter_list RPAREN block
    ;

parameter_list:
    | IDENTIFIER
    | parameter_list COMMA IDENTIFIER
    ;

struct_declaration:
    STRUCT IDENTIFIER LBRACE data_member_list RBRACE
    ;

data_member_list:
    IDENTIFIER
    | data_member_list COMMA IDENTIFIER
    ;

import_statement:
    IMPORT STRING SEMICOLON
    ;

block:
    LBRACE statement_list RBRACE
    ;

expression_statement:
    expression SEMICOLON
    ;

expression:
    literal
    | IDENTIFIER
    | function_call
    | struct_access
    | binary_operation
    | unary_operation
    ;

literal:
    NUMBER
    | FLOAT
    | STRING
    | TRUE
    | FALSE
    | array_literal
    ;

function_call:
    IDENTIFIER LPAREN argument_list RPAREN
    ;

argument_list:
    | expression
    | argument_list COMMA expression
    ;

struct_access:
    IDENTIFIER '.' IDENTIFIER
    ;

binary_operation:
    expression PLUS expression
    | expression MINUS expression
    | expression MULT expression
    | expression DIV expression
    | expression EQ expression
    | expression NEQ expression
    | expression LT expression
    | expression GT expression
    | expression LTE expression
    | expression GTE expression
    | expression AND expression
    | expression OR expression
    ;

unary_operation:
    MINUS expression
    | NOT expression
    ;

array_literal:
    LBRACKET RBRACKET
    | LBRACKET expression_list RBRACKET
    ;

expression_list:
    expression
    | expression_list COMMA expression
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s at line %d\n", s, lineno);
}

// int main(int argc, char **argv) {
//     if (argc > 1) {
//         FILE *file = fopen(argv[1], "r");
//         if (!file) {
//             perror(argv[1]);
//             return 1;
//         }
//         yyin = file;
//     }

//     return yyparse();
// }
