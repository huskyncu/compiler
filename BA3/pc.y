%{
#include <stdio.h>
#include <string.h>
#include <math.h>

int consequence;
int correct = 1;
int yylex();
void yyerror(const char *message);
int sum1 = 1;
int sum2 = 1;
int sum3 = 1;
int i=1, j=1,k=1;
%}
%union {
	int ivalue;
}
%token ADD
%token SUB
%token P
%token C
%token <ivalue> INUMBER
%type <ivalue> exp

%%
input : exp { consequence = $1; /*printf("555\n");*/}
	; 
exp : exp ADD exp	{ $$ = $1 + $3; /*printf("3333\n");*/}
	| exp SUB exp	{ $$ = $1 - $3; /*printf("4444\n");*/}
	| P INUMBER INUMBER	{   sum1=1;sum2=1;
                            for(i=1;i<=$2;i++)
							{
								sum1*=i;
							}
						  for(j=1;j<=$2-$3;j++)
						  {
							  sum2*=j;
						  }
						  $$ = sum1/sum2; 
                          //printf("total is %d\n",$$); 
                          //printf("1111\n");
					}
	| C INUMBER INUMBER	{    sum1=1;sum2=1;sum3=1;
                            for(i=1;i<=$2;i++)
							{
								sum1*=i;
							}
						  for(j=1;j<=$3;j++)
						  {
							  sum2*=j;
						  }
						  for(k=1;k<=$2-$3;k++)
						  {
							sum3*=k;
						  }  
						  $$ = sum1/(sum2*sum3); 
                          //printf("total is %d\n",$$);  
                          //printf("2222\n");
					    }
   ; 
%%
void yyerror ( const char *message )
{
	correct  = 0;
}
int main(int argc, char *argv[]) {
    yyparse();
	if ( correct  == 1 ) {
		printf( "%d\n", consequence);
	}
	else {
		printf ( "Wrong Formula\n" );
	} 
    return(0);
}