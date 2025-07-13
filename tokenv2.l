%{
#include <stdio.h>
#include "tokenizer.tab.h"
FILE *out_file;
int line_number = 1;

#define MAX_TOKENS 2048
#define MAX_VALUE_LEN 128

typedef struct {
    char type[32];
    char value[MAX_VALUE_LEN];
    int line;
} Token;

Token tokens[MAX_TOKENS];
int token_count = 0;

typedef struct {
    char name[MAX_VALUE_LEN];
    char value[MAX_VALUE_LEN];
    char type[32];
    int line;
} Variable;

Variable variables[MAX_TOKENS];
int variable_count = 0;

void add_token(const char* type, const char* value, int line) {
    if (token_count < MAX_TOKENS) {
        strncpy(tokens[token_count].type, type, sizeof(tokens[token_count].type)-1);
        strncpy(tokens[token_count].value, value, sizeof(tokens[token_count].value)-1);
        tokens[token_count].line = line;
        token_count++;
    }
}
void add_variable(const char* name, const char* value, const char* type, int line) {
    if (variable_count < MAX_TOKENS) {
        strncpy(variables[variable_count].name, name, sizeof(variables[variable_count].name)-1);
        variables[variable_count].name[sizeof(variables[variable_count].name)-1] = '\0';
        strncpy(variables[variable_count].value, value, sizeof(variables[variable_count].value)-1);
        variables[variable_count].value[sizeof(variables[variable_count].value)-1] = '\0';
        strncpy(variables[variable_count].type, type, sizeof(variables[variable_count].type)-1);
        variables[variable_count].type[sizeof(variables[variable_count].type)-1] = '\0';
        variables[variable_count].line = line;
        variable_count++;
    }
}

void write_tokens_and_variables() {
    FILE *tokfile = fopen("tokens_output.txt", "w");
    FILE *varfile = fopen("variables.txt", "w");
    if (!tokfile || !varfile) return;

    fprintf(tokfile, "%-15s %-20s %-12s\n", "Token", "Value", "Line Number");
    fprintf(tokfile, "-----------------------------------------------\n");
    for (int i = 0; i < token_count; ++i) {
        fprintf(tokfile, "%-15s %-20s %-12d\n",
            tokens[i].type, tokens[i].value, tokens[i].line);
    }

    // Write all variables with name, value, type, and line
    fprintf(varfile, "%-15s %-15s %-10s %-10s\n", "Name", "Value", "Type", "Line");
    fprintf(varfile, "-----------------------------------------------\n");
    for (int i = 0; i < variable_count; ++i) {
        fprintf(varfile, "%-15s %-15s %-10s %-10d\n",
           variables[i].name, variables[i].value, variables[i].type, variables[i].line);
    }

    fclose(tokfile);
    fclose(varfile);
}


%}

%%

[ \t]+              ; /* Ignore whitespace */
\n                  {line_number++;}/* Ignore newlines */
\/\/.*              ; /* Ignore single-line comments */

"if"                { add_token("IF", yytext, line_number); return IF_TOKEN; }
"else"              { add_token("ELSE", yytext, line_number); return ELSE_TOKEN; }
"while"             { add_token("WHILE", yytext, line_number); return WHILE_TOKEN; }
"for"               { add_token("FOR", yytext, line_number); return FOR_TOKEN; }
"return"            { add_token("RETURN", yytext, line_number); return RETURN_TOKEN; }
"int"               { add_token("INT", yytext, line_number); return INT_TOKEN; }
"float"             { add_token("FLOAT", yytext, line_number); return FLOAT_TOKEN; }
"bool"              { add_token("BOOL", yytext, line_number); return BOOL_TOKEN; }
"string" { add_token("STRING", yytext, line_number); return STRING_TOKEN; }
"void"              { add_token("VOID", yytext, line_number); }
"var"               { add_token("VAR", yytext, line_number); sscanf(yytext, "%s", yylval.str); return VAR_TOKEN; }
"func"              { add_token("FUNC", yytext, line_number); return FUNC_TOKEN; }
"main"              { add_token("MAIN", yytext, line_number); return MAIN_TOKEN; }
"program"           { add_token("PROGRAM", yytext, line_number); return PROGRAM_TOKEN; }
"print"             { add_token("PRINT", yytext, line_number); return PRINT_TOKEN; }
"to"                { add_token("TO", yytext, line_number); return TO_TOKEN; }


"=="                { add_token("EQ", yytext, line_number); return EQ_TOKEN; }
"!="                { add_token("NEQ", yytext, line_number); return NEQ_TOKEN; }
"<="                { add_token("LE", yytext, line_number); return LE_TOKEN; }
">="                { add_token("GE", yytext, line_number); return GE_TOKEN; }
"<"                 { add_token("LT", yytext, line_number); return LT_TOKEN; }
">"                 { add_token("GT", yytext, line_number); return GT_TOKEN; }
"="                 { add_token("EQUALS", yytext, line_number); return EQUALS_TOKEN; }
"+"                 { add_token("PLUS", yytext, line_number); return PLUS_TOKEN; }
"-"                 { add_token("MINUS", yytext, line_number); return MINUS_TOKEN; }
"*"                 { add_token("MUL", yytext, line_number); return MUL_TOKEN; }
"/"                 { add_token("DIV", yytext, line_number); return DIV_TOKEN; }
"%"                 { add_token("MOD", yytext, line_number); return MOD_TOKEN; }
"("                 { add_token("LPAREN", yytext, line_number); return LPAREN_TOKEN; }
")"                 { add_token("RPAREN", yytext, line_number); return RPAREN_TOKEN; }
"{"                 { add_token("LBRACE", yytext, line_number); return LBRACE_TOKEN; }
"}"                 { add_token("RBRACE", yytext, line_number); return RBRACE_TOKEN; }
":"                 { add_token("COLON", yytext, line_number); return COLON_TOKEN; }
";"                 { add_token("SEMICOLON", yytext, line_number); return SEMICOLON_TOKEN; }
","                 { add_token("COMMA", yytext, line_number); return COMMA_TOKEN; }

"&&"                { add_token("AND", yytext, line_number); return AND_TOKEN; }
"\\|\\|"            { add_token("OR", yytext, line_number); return OR_TOKEN; }
"!"                 { add_token("NOT", yytext, line_number); return NOT_TOKEN; }

(true|false)        { add_token("BOOL_LITERAL", yytext, line_number);
                        strncpy(yylval.str, yytext, sizeof(yylval.str)-1);
                        yylval.str[sizeof(yylval.str)-1] = '\0';
                        return BOOL_LITERAL_TOKEN; }
[0-9]+              { add_token("NUMBER", yytext, line_number); 
                        yylval.number = atoi(yytext); return NUMBER_TOKEN; }
[0-9]+\.[0-9]+      { add_token("FLOAT_LITERAL", yytext, line_number); 
                        yylval.fval = atof(yytext); return FLOAT_LITERAL_TOKEN; }
\"[^\"]*\"          {add_token("STRING_LITERAL", yytext, line_number);
                        strncpy(yylval.str, yytext, sizeof(yylval.str)-1);
                        yylval.str[sizeof(yylval.str)-1] = '\0';
                        return STRING_LITERAL_TOKEN;}
[a-zA-Z_][a-zA-Z0-9_]* {add_token("IDENTIFIER", yytext, line_number);
                            strncpy(yylval.str, yytext, sizeof(yylval.str)-1);
                            yylval.str[sizeof(yylval.str)-1] = '\0';
                            return IDENTIFIER_TOKEN;}

.                   { add_token("UNKNOWN", yytext, line_number); }

%%

yywrap(){return 1;}