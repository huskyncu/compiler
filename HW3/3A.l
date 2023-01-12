%{
#include "3A.tab.h"
%}

%%
\n        {}
[ \t]+	  {}
"load"	{ return LOAD; }
"add" 	{ return ADD; }
"sub"	{ return SUB; }
"mul"	{ return MUL; }
"mod"	{ return MOD; }
"inc"	{ return INC; }
"dec"	{ return DEC; }
[0-9]+	{ yylval.ivalue = atoi(yytext); return( INUMBER ); }
.		{ return( yytext[0] ); }
%%