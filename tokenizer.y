%{
#include <stdio.h>
#include <string.h>
void yyerror(const char *s);
int yylex(void);
extern FILE *yyin; 
extern void write_tokens_and_variables();
extern void add_variable(char*, char*, char*, int);
extern int line_number;
%}

%union {
    char str[128];	
    int number;
    double fval;
}

%token IF_TOKEN
%token ELSE_TOKEN
%token WHILE_TOKEN
%token FOR_TOKEN
%token RETURN_TOKEN
%token INT_TOKEN
%token FLOAT_TOKEN
%token BOOL_TOKEN
%token <str> BOOL_LITERAL_TOKEN
%token VOID_TOKEN
%token VAR_TOKEN

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
%token LPAREN_TOKEN
%token RPAREN_TOKEN
%token LBRACE_TOKEN
%token RBRACE_TOKEN
%token COLON_TOKEN
%token SEMICOLON_TOKEN
%token COMMA_TOKEN

%token <number> NUMBER_TOKEN
%token <fval> FLOAT_LITERAL_TOKEN
%token <str> IDENTIFIER_TOKEN
%token UNKNOWN_TOKEN

%type <str> type
%type <str> value


%%
prog:
      /* empty */
    | prog statement
    ;

statement:
    VAR_TOKEN IDENTIFIER_TOKEN COLON_TOKEN type EQUALS_TOKEN value SEMICOLON_TOKEN
    {
        printf("Declaration: %s : %s = %s;\n", $2, $4, $6);
        add_variable($2, $6, $4, line_number);
    }
    | error SEMICOLON_TOKEN
        { yyerrok; }
    ;

type:
    INT_TOKEN    { strcpy($$, "int"); }
    | FLOAT_TOKEN { strcpy($$, "float"); }
    | BOOL_TOKEN  { strcpy($$, "bool"); }
    ;

value:
    NUMBER_TOKEN         { sprintf($$, "%d", $1); }
    | FLOAT_LITERAL_TOKEN { sprintf($$, "%f", $1); }
    | BOOL_LITERAL_TOKEN  { strcpy($$, $1); }
    ;


%%

void yyerror(const char *s) {
    
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