%{
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#define MAX 100
int consequence;
int correct = 1;
int flag = 1;
int yylex();
void push(int);
void pop();
int stack[MAX];
int top = -1;
int i=0;
int tmp;

void yyerror(const char *message);
%}
%union {
	int ivalue;
}
%token START_AND_TAG
%token START_OR_TAG
%token START_NOT_TAG
%token T
%token F
%token END_AND_TAG
%token END_OR_TAG
%token END_NOT_TAG
%type <ivalue> T
%type <ivalue> exp
%type <ivalue> F

%%
input : exp { consequence = stack[top]; pop();}
	; 
exp : START_OR_TAG exp exp END_OR_TAG	{
            flag=0;
            for(i=top;i>=0;i--)
            {
                tmp = stack[top];
                pop();
                if(tmp==1)
                {
                    flag=1;
                    while(top>-1)
                    {
                        stack[top]=0;
                        pop();
                    }
                    break;
                }
            }
            if(flag==1)
            {
                push(1);
                //printf("here or tag and push 1\n");
            }
            else{
                push(0);
                //printf("here or tag and push 0\n");
            }
            
        }
	| START_AND_TAG exp END_AND_TAG { 
           for(i=top;i>=0;i--)
           {
              tmp=stack[top];
              pop();
              if(tmp==0)
              {
                  flag = 0;
                  while(top>-1)
                    {
                        stack[top]=0;
                        pop();
                    }
                    break;
              }
           }
           if(flag==1)
              {
                push(1);
                //printf("here and tag and push 1\n");
              }
              else
              {
                push(0);
                //printf("here and tag and push 0\n");
              }
            
             }
    | START_NOT_TAG exp END_NOT_TAG { tmp=stack[top];  pop();
                if(tmp==1)
                {
                    push(0);
                    //printf("here not tag and push 0\n");
                }
                else{
                    push(1);
                    //printf("here not tag and push 1\n");
                }
                //printf("here not tag and push 1\n");
    }
    | START_OR_TAG END_OR_TAG	{ push(0); //printf("here 107 and push 1\n");
                             }
	| START_AND_TAG END_AND_TAG { push(1); //printf("here 108 and push 1\n");
                            }
    | START_NOT_TAG END_NOT_TAG { }
	| T exp 	{push(1);  //printf("here 110 and push 1\n");
               }
    | F exp     {push(0);  //printf("here 111 and push 0\n");
               }
    | exp T     {push(1);  //printf("here 112 and push 1\n");
                }
    | exp F     {push(0);  //printf("here 113 and push 0\n");
                }
    | exp exp   { 
                    //printf("here 114\n");
                }
    | T         {push(1); //printf("here 115 and push 1\n");
          }
    | F         {push(0); //printf("here 116 and push 0\n");
          }
    |      {}
%%
void yyerror ( const char *message )
{
	correct  = 0;
}
void push(int n)
{
    top++;
    stack[top] = n;
    //printf("%d\n", top);
}

void pop()
{
    top--;
}

int main(int argc, char *argv[]) {
    yyparse();
	if ( correct  == 1 ) {
		printf( "%d\n", consequence);
	}
	else {
		printf ( "Invalid format\n" );
	} 
    return(0);
}