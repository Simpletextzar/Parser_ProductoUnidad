%{
/* === INCLUDES Y DEFINICIONES === */
#include <stdio.h>
#include "tokenizer.tab.h"  // Header generado por Bison, define tokens y tipos

/* Archivo de salida para tokens */
FILE *out_file;

/* Contador de líneas */
int line_number = 1;

/* === DEFINICIÓN DE CONSTANTES === */
#define MAX_TOKENS 2048
#define MAX_VALUE_LEN 128

/* === ESTRUCTURAS PARA GUARDAR TOKENS === */
/* Estructura para un Token */
typedef struct {
    char type[32];                 // Tipo de token (ej. IF, IDENTIFIER, etc.)
    char value[MAX_VALUE_LEN];     // Valor literal del token (ej. nombre variable)
    int line;                      // Línea donde se encontró
} Token;

/* Arreglo para almacenar tokens */
Token tokens[MAX_TOKENS];
int token_count = 0;

/* === ESTRUCTURA PARA VARIABLES === */
/* Estructura para guardar variables declaradas */
typedef struct {
    char name[MAX_VALUE_LEN];      // Nombre de la variable
    char value[MAX_VALUE_LEN];     // Valor asignado
    char type[32];                 // Tipo (int, float, bool, etc.)
    int line;                      // Línea de declaración
} Variable;

/* Arreglo para variables */
Variable variables[MAX_TOKENS];
int variable_count = 0;

/* === FUNCIÓN PARA GUARDAR UN TOKEN === */
void add_token(const char* type, const char* value, int line) {
    if (token_count < MAX_TOKENS) {
        strncpy(tokens[token_count].type, type, sizeof(tokens[token_count].type)-1);
        strncpy(tokens[token_count].value, value, sizeof(tokens[token_count].value)-1);
        tokens[token_count].line = line;
        token_count++;
    }
}

/* === FUNCIÓN PARA GUARDAR UNA VARIABLE === */
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

/* === FUNCIÓN PARA ESCRIBIR TOKENS Y VARIABLES A ARCHIVOS === */
void write_tokens_and_variables() {
    FILE *tokfile = fopen("tokens_output.txt", "w");
    FILE *varfile = fopen("variables.txt", "w");
    if (!tokfile || !varfile) return;

    // Encabezados para tokens
    fprintf(tokfile, "%-15s %-20s %-12s\n", "Token", "Value", "Line Number");
    fprintf(tokfile, "-----------------------------------------------\n");
    for (int i = 0; i < token_count; ++i) {
        fprintf(tokfile, "%-15s %-20s %-12d\n",
            tokens[i].type, tokens[i].value, tokens[i].line);
    }

    // Encabezados para variables
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
/* === REGLAS LÉXICAS === */

/* Ignorar espacios en blanco y tabulaciones */
[ \t]+              ;

/* Contar saltos de línea */
\n                  {line_number++;}

/* Ignorar comentarios de una línea */
\/\/.*              ;

/* === PALABRAS CLAVE === */
"if"                { add_token("IF", yytext, line_number); return IF_TOKEN; }
"elseif"            { add_token("ELSEIF", yytext, line_number); return ELSEIF_TOKEN; }
"else"              { add_token("ELSE", yytext, line_number); return ELSE_TOKEN; }
"while"             { add_token("WHILE", yytext, line_number); return WHILE_TOKEN; }
"for"               { add_token("FOR", yytext, line_number); return FOR_TOKEN; }
"return"            { add_token("RETURN", yytext, line_number); return RETURN_TOKEN; }
"int"               { add_token("INT", yytext, line_number); return INT_TOKEN; }
"float"             { add_token("FLOAT", yytext, line_number); return FLOAT_TOKEN; }
"bool"              { add_token("BOOL", yytext, line_number); return BOOL_TOKEN; }
"string"            { add_token("STRING", yytext, line_number); return STRING_TOKEN; }
"void"              { add_token("VOID", yytext, line_number); }
"var"               { add_token("VAR", yytext, line_number); sscanf(yytext, "%s", yylval.str); return VAR_TOKEN; }
"func"              { add_token("FUNC", yytext, line_number); return FUNC_TOKEN; }
"main"              { add_token("MAIN", yytext, line_number); return MAIN_TOKEN; }
"program"           { add_token("PROGRAM", yytext, line_number); return PROGRAM_TOKEN; }
"print"             { add_token("PRINT", yytext, line_number); return PRINT_TOKEN; }
"read"              { add_token("READ", yytext, line_number); return READ_TOKEN; }
"to"                { add_token("TO", yytext, line_number); return TO_TOKEN; }

/* === OPERADORES RELACIONALES Y ARITMÉTICOS === */
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

/* === SÍMBOLOS DE AGRUPACIÓN === */
"("                 { add_token("LPAREN", yytext, line_number); return LPAREN_TOKEN; }
")"                 { add_token("RPAREN", yytext, line_number); return RPAREN_TOKEN; }
"{"                 { add_token("LBRACE", yytext, line_number); return LBRACE_TOKEN; }
"}"                 { add_token("RBRACE", yytext, line_number); return RBRACE_TOKEN; }
":"                 { add_token("COLON", yytext, line_number); return COLON_TOKEN; }
";"                 { add_token("SEMICOLON", yytext, line_number); return SEMICOLON_TOKEN; }
","                 { add_token("COMMA", yytext, line_number); return COMMA_TOKEN; }

/* === OPERADORES LÓGICOS === */
"&&"                { add_token("AND", yytext, line_number); return AND_TOKEN; }
"\\|\\|"            { add_token("OR", yytext, line_number); return OR_TOKEN; }
"!"                 { add_token("NOT", yytext, line_number); return NOT_TOKEN; }

/* === LITERALES === */
(true|false)        { add_token("BOOL_LITERAL", yytext, line_number);
                      strncpy(yylval.str, yytext, sizeof(yylval.str)-1);
                      yylval.str[sizeof(yylval.str)-1] = '\0';
                      return BOOL_LITERAL_TOKEN; }

[0-9]+              { add_token("NUMBER", yytext, line_number); 
                      yylval.number = atoi(yytext); return NUMBER_TOKEN; }

[0-9]+\.[0-9]+      { add_token("FLOAT_LITERAL", yytext, line_number); 
                      yylval.fval = atof(yytext); return FLOAT_LITERAL_TOKEN; }

\"[^\"]*\"          { add_token("STRING_LITERAL", yytext, line_number);
                      strncpy(yylval.str, yytext, sizeof(yylval.str)-1);
                      yylval.str[sizeof(yylval.str)-1] = '\0';
                      return STRING_LITERAL_TOKEN; }

/* === IDENTIFICADORES === */
[a-zA-Z_][a-zA-Z0-9_]* { add_token("IDENTIFIER", yytext, line_number);
                         strncpy(yylval.str, yytext, sizeof(yylval.str)-1);
                         yylval.str[sizeof(yylval.str)-1] = '\0';
                         return IDENTIFIER_TOKEN;}

/* === CUALQUIER OTRO CARÁCTER === */
.                   { add_token("UNKNOWN", yytext, line_number); }

%%

/* === FIN DEL ARCHIVO === */
/* Indica a Flex que terminó el archivo de entrada */
yywrap(){return 1;}
