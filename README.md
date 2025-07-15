# Parser_ProductoUnidad

Como ejecutar:
bison -d tokenizer.y
flex tokenv2.l
gcc tokenizer.tab.c lex.yy.c -o a

Importante tener Flex y Bison instalados.