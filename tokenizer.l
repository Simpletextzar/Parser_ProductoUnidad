/*Tokenizer using flex for a simple language for college, must read " var x = 5; "*/
%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(const char *s);
int line_number = 1;
FILE *out_file;
%}

%option noyywrap

%%
[ \t]+          ; /* Ignore whitespace */
\n             { line_number++; }
"var"         { return VAR_TOKEN; }
"="            { return ASSIGN_TOKEN; }
";"            { return SEMICOLON_TOKEN; }
[0-9]+         { yylval = atoi(yytext); return NUMBER_TOKEN; }
%%
int main(int argc, char **argv) {
    FILE *file = fopen("read_file.txt", "r");
    out_file = fopen("tokens_output.txt", "w");
    yyin = file;
    yylex();
    fclose(file);
    fclose(out_file);
    return 0;
}
