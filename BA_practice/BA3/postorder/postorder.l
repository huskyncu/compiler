%{
#include "postorder.tab.h"
%}

%%
\n        {}
[ \t]+	  {}
"+" 	{ return ADD; }
"-"	{ return SUB; }
"*"	{ return MUL; }
"/"	{ return MOD; }
[0-9]+("\."[0-9]+)*	{ yylval.ivalue = atof(yytext); return( INUMBER ); }
.		{ printf ( "Wrong Formula\n" ); }
%%