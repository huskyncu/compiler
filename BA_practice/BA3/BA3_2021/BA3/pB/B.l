%{
#include "B.tab.h"
#include <string.h>
%}
digits -?[0-9]+
eol \n
nul ("\t"|" ")
%%
"[" return LBR;
"]" return RBR;
"," return COM;
"*" return MUL;
"+" return ADD;
{digits} {
  yylval.word = yytext;
  return DIG;
}
{eol} {
	return '$';
}
{nul} {}
.
%%

/*
flex -o B.yy.c B.l
clang -c -g -I.. B.yy.c
clang -o B B.tab.o B.yy.o -ll
*/