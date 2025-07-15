%{
#include <stdio.h>
#include <string.h>
void yyerror(const char *s);
int yylex(void);
extern FILE *yyin;
extern int line_number;
extern void write_tokens_and_variables();
extern void add_variable(char*, char*, char*, int);
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
%token <str>STRING_LITERAL_TOKEN

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

%type <str> type
%type <str> expression

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
      PROGRAM_TOKEN fun_declarations fun_main
    | fun_declarations fun_main
    ;

fun_declarations:
      /* vacío */
    | fun_declarations fun_declaration
    ;

fun_declaration:
      FUNC_TOKEN IDENTIFIER_TOKEN LPAREN_TOKEN parameters_optional RPAREN_TOKEN block
    | FUNC_TOKEN IDENTIFIER_TOKEN LPAREN_TOKEN parameters_optional RPAREN_TOKEN COLON_TOKEN return_type block
    | IDENTIFIER_TOKEN LPAREN_TOKEN parameters_optional RPAREN_TOKEN block
;

parameters_optional:
      /* vacío */
    | parameters_list
    ;

return_type:
    VOID_TOKEN
    | type
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
      VAR_TOKEN IDENTIFIER_TOKEN COLON_TOKEN type EQUALS_TOKEN expression SEMICOLON_TOKEN
        {
            add_variable($2, $6, $4, line_number);
        }
    | VAR_TOKEN IDENTIFIER_TOKEN COLON_TOKEN type SEMICOLON_TOKEN
        {
            add_variable($2, "", $4, line_number);
        }
    | type COLON_TOKEN IDENTIFIER_TOKEN EQUALS_TOKEN expression SEMICOLON_TOKEN
        {
            add_variable($3, $5, $1, line_number);
        }
    | type COLON_TOKEN IDENTIFIER_TOKEN SEMICOLON_TOKEN
        {
            add_variable($3, "", $1, line_number);
        }
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
    FOR_TOKEN LPAREN_TOKEN IDENTIFIER_TOKEN EQUALS_TOKEN expression TO_TOKEN expression RPAREN_TOKEN block
    | FOR_TOKEN LPAREN_TOKEN IDENTIFIER_TOKEN RPAREN_TOKEN block
    ;

while_loop:
    WHILE_TOKEN LPAREN_TOKEN expression RPAREN_TOKEN block
    ;

type:
    INT_TOKEN     { strcpy($$, "int"); }
  | FLOAT_TOKEN   { strcpy($$, "float"); }
  | BOOL_TOKEN    { strcpy($$, "bool"); }
  | STRING_TOKEN  { strcpy($$, "string"); }
;

expression:
      expression OR_TOKEN expression      { sprintf($$, "%s || %s", $1, $3); }
    | expression AND_TOKEN expression     { sprintf($$, "%s && %s", $1, $3); }
    | NOT_TOKEN expression                { sprintf($$, "!%s", $2); }
    | expression EQ_TOKEN expression      { sprintf($$, "%s == %s", $1, $3); }
    | expression NEQ_TOKEN expression     { sprintf($$, "%s != %s", $1, $3); }
    | expression LT_TOKEN expression      { sprintf($$, "%s < %s", $1, $3); }
    | expression GT_TOKEN expression      { sprintf($$, "%s > %s", $1, $3); }
    | expression LE_TOKEN expression      { sprintf($$, "%s <= %s", $1, $3); }
    | expression GE_TOKEN expression      { sprintf($$, "%s >= %s", $1, $3); }
    | expression PLUS_TOKEN expression    { sprintf($$, "%s + %s", $1, $3); }
    | expression MINUS_TOKEN expression   { sprintf($$, "%s - %s", $1, $3); }
    | expression MUL_TOKEN expression     { sprintf($$, "%s * %s", $1, $3); }
    | expression DIV_TOKEN expression     { sprintf($$, "%s / %s", $1, $3); }
    | expression MOD_TOKEN expression     { sprintf($$, "%s %% %s", $1, $3); }
    | LPAREN_TOKEN expression RPAREN_TOKEN{ sprintf($$, "(%s)", $2); }
    | IDENTIFIER_TOKEN                    { strcpy($$, $1); }
    | NUMBER_TOKEN                        { sprintf($$, "%d", $1); }
    | FLOAT_LITERAL_TOKEN                 { sprintf($$, "%f", $1); }
    | BOOL_LITERAL_TOKEN                  { strcpy($$, $1); }
    | STRING_LITERAL_TOKEN                { strcpy($$, $1); }
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

    write_tokens_and_variables(); 
    return 0;
}
