%{
    #include "HW3_A.tab.h"
    void yyerror(const char*);
%}
%%
[0-9]+     {
                    yylval.ival = atoi(yytext);
                    return INTEGER;
                }
add    {return ADD;}
sub   {return SUB;}
mul   {return MUL;}
mod    {return MOD;}
inc    {return INC;}
dec    {return DEC;}
load    {return LOAD;}
div    {return DIV;}
copy  {return COPY;}
delete {return DELETE;}
switch {return SWITCH;}
\n    {return yytext[0];}
[\t]+    {;}
[ ]+    {;}
.    {yyerror("Invalid input");}
%%
