/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_TOKENIZER_TAB_H_INCLUDED
# define YY_YY_TOKENIZER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    IDENTIFIER_TOKEN = 258,        /* IDENTIFIER_TOKEN  */
    NUMBER_TOKEN = 259,            /* NUMBER_TOKEN  */
    FLOAT_LITERAL_TOKEN = 260,     /* FLOAT_LITERAL_TOKEN  */
    STRING_LITERAL_TOKEN = 261,    /* STRING_LITERAL_TOKEN  */
    BOOL_LITERAL_TOKEN = 262,      /* BOOL_LITERAL_TOKEN  */
    IF_TOKEN = 263,                /* IF_TOKEN  */
    ELSE_TOKEN = 264,              /* ELSE_TOKEN  */
    WHILE_TOKEN = 265,             /* WHILE_TOKEN  */
    FOR_TOKEN = 266,               /* FOR_TOKEN  */
    RETURN_TOKEN = 267,            /* RETURN_TOKEN  */
    INT_TOKEN = 268,               /* INT_TOKEN  */
    FLOAT_TOKEN = 269,             /* FLOAT_TOKEN  */
    BOOL_TOKEN = 270,              /* BOOL_TOKEN  */
    STRING_TOKEN = 271,            /* STRING_TOKEN  */
    VOID_TOKEN = 272,              /* VOID_TOKEN  */
    VAR_TOKEN = 273,               /* VAR_TOKEN  */
    FUNC_TOKEN = 274,              /* FUNC_TOKEN  */
    MAIN_TOKEN = 275,              /* MAIN_TOKEN  */
    PROGRAM_TOKEN = 276,           /* PROGRAM_TOKEN  */
    PRINT_TOKEN = 277,             /* PRINT_TOKEN  */
    TO_TOKEN = 278,                /* TO_TOKEN  */
    READ_TOKEN = 279,              /* READ_TOKEN  */
    ELSEIF_TOKEN = 280,            /* ELSEIF_TOKEN  */
    EQ_TOKEN = 281,                /* EQ_TOKEN  */
    NEQ_TOKEN = 282,               /* NEQ_TOKEN  */
    LE_TOKEN = 283,                /* LE_TOKEN  */
    GE_TOKEN = 284,                /* GE_TOKEN  */
    LT_TOKEN = 285,                /* LT_TOKEN  */
    GT_TOKEN = 286,                /* GT_TOKEN  */
    EQUALS_TOKEN = 287,            /* EQUALS_TOKEN  */
    PLUS_TOKEN = 288,              /* PLUS_TOKEN  */
    MINUS_TOKEN = 289,             /* MINUS_TOKEN  */
    MUL_TOKEN = 290,               /* MUL_TOKEN  */
    DIV_TOKEN = 291,               /* DIV_TOKEN  */
    MOD_TOKEN = 292,               /* MOD_TOKEN  */
    LPAREN_TOKEN = 293,            /* LPAREN_TOKEN  */
    RPAREN_TOKEN = 294,            /* RPAREN_TOKEN  */
    LBRACE_TOKEN = 295,            /* LBRACE_TOKEN  */
    RBRACE_TOKEN = 296,            /* RBRACE_TOKEN  */
    COLON_TOKEN = 297,             /* COLON_TOKEN  */
    SEMICOLON_TOKEN = 298,         /* SEMICOLON_TOKEN  */
    COMMA_TOKEN = 299,             /* COMMA_TOKEN  */
    AND_TOKEN = 300,               /* AND_TOKEN  */
    OR_TOKEN = 301,                /* OR_TOKEN  */
    NOT_TOKEN = 302                /* NOT_TOKEN  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 18 "tokenizer.y"

    int number;
    float fval;
    char str[128]; // Tamaño fijo, como en tu ejemplo

#line 117 "tokenizer.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_TOKENIZER_TAB_H_INCLUDED  */
