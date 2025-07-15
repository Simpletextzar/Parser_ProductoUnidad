%{
#include <stdio.h>
#include <string.h>
void yyerror(const char *s);
int yylex(void);
extern FILE *yyin;
extern int line_number;
%}

%union {
    char str[128];
    int number;
    float fval;
}

%token IF_TOKEN
%token ELSE_TOKEN
%token ELSEIF_TOKEN
%token WHILE_TOKEN
%token FOR_TOKEN
%token RETURN_TOKEN
%token INT_TOKEN
%token FLOAT_TOKEN
%token BOOL_TOKEN
%token STRING_TOKEN
%token VOID_TOKEN
%token PRINT_TOKEN
%token READ_TOKEN
%token MAIN_TOKEN
%token <str> BOOL_LITERAL_TOKEN
%token <number> NUMBER_TOKEN
%token <fval> FLOAT_LITERAL_TOKEN
%token <str> IDENTIFIER_TOKEN
%token VAR_TOKEN
%token FUNC_TOKEN
%token PROGRAM_TOKEN
%token TO_TOKEN
%token MOD_TOKEN
%token STRING_LITERAL_TOKEN


%token EQ_TOKEN
%token NEQ_TOKEN
%token LE_TOKEN
%token GE_TOKEN
%token LT_TOKEN
%token GT_TOKEN
%token EQUALS_TOKEN
%token PLUS_TOKEN
%token MINUS_TOKEN
%token MUL_TOKEN
%token DIV_TOKEN
%token NOT_TOKEN
%token AND_TOKEN
%token OR_TOKEN
%token LPAREN_TOKEN
%token RPAREN_TOKEN
%token LBRACE_TOKEN
%token RBRACE_TOKEN
%token COLON_TOKEN
%token SEMICOLON_TOKEN
%token COMMA_TOKEN

%left OR_TOKEN
%left AND_TOKEN
%right NOT_TOKEN
%nonassoc EQ_TOKEN
%nonassoc NEQ_TOKEN
%nonassoc LT_TOKEN
%nonassoc LE_TOKEN
%nonassoc GT_TOKEN
%nonassoc GE_TOKEN
%left PLUS_TOKEN
%left MINUS_TOKEN
%left MUL_TOKEN
%left DIV_TOKEN

%start prog
%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE_TOKEN

%%

prog:
      fun_declarations fun_main
    ;

fun_declarations:
      /* vacío */
    | fun_declarations fun_declaration
    ;

fun_declaration:
    IDENTIFIER_TOKEN LPAREN_TOKEN parameters_optional RPAREN_TOKEN block
    ;

parameters_optional:
      /* vacío */
    | parameters_list
    ;

parameters_list:
    IDENTIFIER_TOKEN
    | IDENTIFIER_TOKEN COMMA_TOKEN parameters_list
    ;

fun_main:
    MAIN_TOKEN LPAREN_TOKEN RPAREN_TOKEN block
    ;

block:
    LBRACE_TOKEN statement_list RBRACE_TOKEN
    ;

statement_list:
      /* vacío */
    | statement_list statement
    ;

statement:
      declaration
    | assignment
    | if_statement
    | for_loop
    | while_loop
    | print_statement
    | read_statement
    | return_statement
    ;

declaration:
    type COLON_TOKEN IDENTIFIER_TOKEN EQUALS_TOKEN expression SEMICOLON_TOKEN
    | type COLON_TOKEN IDENTIFIER_TOKEN SEMICOLON_TOKEN
    ;

assignment:
    IDENTIFIER_TOKEN EQUALS_TOKEN expression SEMICOLON_TOKEN
    ;

print_statement:
    PRINT_TOKEN LPAREN_TOKEN expression RPAREN_TOKEN SEMICOLON_TOKEN
    ;

read_statement:
    READ_TOKEN LPAREN_TOKEN IDENTIFIER_TOKEN RPAREN_TOKEN SEMICOLON_TOKEN
    ;

return_statement:
    RETURN_TOKEN expression SEMICOLON_TOKEN
    | RETURN_TOKEN SEMICOLON_TOKEN
    ;

if_statement:
    IF_TOKEN LPAREN_TOKEN expression RPAREN_TOKEN block %prec LOWER_THAN_ELSE
    | IF_TOKEN LPAREN_TOKEN expression RPAREN_TOKEN block else_part
    ;

else_part:
    ELSE_TOKEN block
    | ELSEIF_TOKEN LPAREN_TOKEN expression RPAREN_TOKEN block else_part
    ;

for_loop:
    FOR_TOKEN LPAREN_TOKEN IDENTIFIER_TOKEN RPAREN_TOKEN block
    ;

while_loop:
    WHILE_TOKEN LPAREN_TOKEN expression RPAREN_TOKEN block
    ;

type:
    INT_TOKEN | FLOAT_TOKEN | BOOL_TOKEN | STRING_TOKEN
    ;

expression:
      expression OR_TOKEN expression
    | expression AND_TOKEN expression
    | NOT_TOKEN expression
    | expression EQ_TOKEN expression
    | expression NEQ_TOKEN expression
    | expression LT_TOKEN expression
    | expression GT_TOKEN expression
    | expression LE_TOKEN expression
    | expression GE_TOKEN expression
    | expression PLUS_TOKEN expression
    | expression MINUS_TOKEN expression
    | expression MUL_TOKEN expression
    | expression DIV_TOKEN expression
    | LPAREN_TOKEN expression RPAREN_TOKEN
    | IDENTIFIER_TOKEN
    | NUMBER_TOKEN
    | FLOAT_LITERAL_TOKEN
    | BOOL_LITERAL_TOKEN
    ;

%%

void yyerror(const char *s) {
    printf("Error: %s en la linea %d\n", s, line_number);
}

int main() {
    FILE *file = fopen("read_file.txt", "r");
    if (file) {
        yyin = file;
    }
    yyparse();
    if (file) {
        fclose(file);
    }
    return 0;
}