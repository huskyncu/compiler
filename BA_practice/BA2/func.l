%option noyywrap

name [A-Za-z_][A-Za-z0-9_]*
sn    ^{name}[\(]((({name}[\,][ ])*({name}))|(({name})?))[\)][\n]?

%%

{sn} {ECHO;}
.
\n

%%

int main(void)
{
    //function call
    yylex();
    return 0;
}