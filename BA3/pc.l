%{
#include "pc.tab.h"
%}

%%
\n        {}
[ \t]+	  {}
"P" | "p"	{ return P; }
"C" |"c" 	{ return C; }
"+"     {return ADD;}
"-"     {return SUB;}
[0-9]+	{ yylval.ivalue = atoi(yytext); return( INUMBER ); }
.		{ }
%%