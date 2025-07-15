
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     IF_TOKEN = 258,
     ELSE_TOKEN = 259,
     ELSEIF_TOKEN = 260,
     WHILE_TOKEN = 261,
     FOR_TOKEN = 262,
     RETURN_TOKEN = 263,
     INT_TOKEN = 264,
     FLOAT_TOKEN = 265,
     BOOL_TOKEN = 266,
     STRING_TOKEN = 267,
     VOID_TOKEN = 268,
     PRINT_TOKEN = 269,
     READ_TOKEN = 270,
     MAIN_TOKEN = 271,
     BOOL_LITERAL_TOKEN = 272,
     NUMBER_TOKEN = 273,
     FLOAT_LITERAL_TOKEN = 274,
     IDENTIFIER_TOKEN = 275,
     VAR_TOKEN = 276,
     FUNC_TOKEN = 277,
     PROGRAM_TOKEN = 278,
     TO_TOKEN = 279,
     MOD_TOKEN = 280,
     STRING_LITERAL_TOKEN = 281,
     EQ_TOKEN = 282,
     NEQ_TOKEN = 283,
     LE_TOKEN = 284,
     GE_TOKEN = 285,
     LT_TOKEN = 286,
     GT_TOKEN = 287,
     EQUALS_TOKEN = 288,
     PLUS_TOKEN = 289,
     MINUS_TOKEN = 290,
     MUL_TOKEN = 291,
     DIV_TOKEN = 292,
     NOT_TOKEN = 293,
     AND_TOKEN = 294,
     OR_TOKEN = 295,
     LPAREN_TOKEN = 296,
     RPAREN_TOKEN = 297,
     LBRACE_TOKEN = 298,
     RBRACE_TOKEN = 299,
     COLON_TOKEN = 300,
     SEMICOLON_TOKEN = 301,
     COMMA_TOKEN = 302,
     LOWER_THAN_ELSE = 303
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 12 "tokeni2.y"

    char str[128];
    int number;
    float fval;



/* Line 1676 of yacc.c  */
#line 108 "tokeni2.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


