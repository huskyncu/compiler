%{
    #include <stdio.h>
    #include <stdlib.h>
    #define MAX 100

    int yylex(void);
    void yyerror(const char*);
    void push(int);
    void pop();

    int stack[MAX];
    int top = -1;
    int i=0;
%}

%union{
    int ival;
}

%token <ival> INTEGER
%token ADD
%token SUB
%token MUL
%token MOD
%token INC
%token DEC
%token LOAD
%token COPY
%token DELETE
%token SWITCH
%token DIV
%type <ival> expr

%%
program : lines    {
                                if(top != 0)
                                {
                                    printf("Invalid format\n");
                                    exit(0);
                                }
                                else
                                {
                                    printf("%d", stack[top]);
                                    printf("\n");
                                }
                   }
                ;
lines : lines line    {;}
         | line    {;}
         ;
line : expr '\n'    {;}
       | expr    {;}
       | '\n'    {;}
       ;
expr : LOAD INTEGER    {    
                            push($2);
                            /*for(i = 0; i <= top; i++)
                            {
                                                printf("%d ", stack[i]);
                            }
                            printf("\n");*/
                        }
        | ADD    {
                        if(top < 1)
                        {
                            printf("Invalid format\n");
                            exit(0);
                        }

                        int num1 = stack[top];
                        pop();
                        int num2 = stack[top];
                        pop();
                        push(num1 + num2);

                        /*for(int i = 0; i <= top; i++)
                        {
                            printf("%d ", stack[i]);
                        }
                        printf("\n");*/
                     }
        | SUB    {
                         if(top < 1)
                        {
                            printf("Invalid format\n");
                            exit(0);
                        }

                        int num1 = stack[top];
                        pop();
                        int num2 = stack[top];
                        pop();
                        push(num1 - num2);
                        /*for(int i = 0; i <= top; i++)
                        {
                            printf("%d ", stack[i]);
                        }
                        printf("\n");*/
                     }
        | MUL    {
                         if(top < 1)
                        {
                            printf("Invalid format\n");
                            exit(0);
                        }

                        int num1 = stack[top];
                        pop();
                        int num2 = stack[top];
                        pop();
                        push(num1 * num2);
                        /*for(int i = 0; i <= top; i++)
                        {
                            printf("%d ", stack[i]);
                        }
                        printf("\n");*/
                     }
        | MOD    {
                         if(top < 1)
                        {
                            printf("Invalid format\n");
                            exit(0);
                        }

                        int num1 = stack[top];
                        pop();
                        int num2 = stack[top];
                        pop();
                        push(num1 % num2);
                        /*for(int i = 0; i <= top; i++)
                        {
                            printf("%d ", stack[i]);
                        }
                        printf("\n");*/
                     }
        | INC    {
                         if(top < 0)
                        {
                            printf("Invalid format\n");
                            exit(0);
                        }

                        int num = stack[top];
                        pop();
                        num++;
                        push(num);
                        /*for(int i = 0; i <= top; i++)
                        {
                            printf("%d ", stack[i]);
                        }
                        printf("\n");*/
                     }
        | DEC    {
                         if(top < 0)
                        {
                            printf("Invalid format\n");
                            exit(0);
                        }

                        int num = stack[top];
                        pop();
                        num--;
                        push(num);
                       /* for(int i = 0; i <= top; i++)
                        {
                            printf("%d ", stack[i]);
                        }
                        printf("\n");*/
                     }
        | DIV
        {
                    if(top<0)
                    {
                        printf("Invalid format\n");
                        exit(0);
                    }
                    int num1 = stack[top];
                    pop();
                    int num2 = stack[top];
                    pop();
                    if(num2 == 0)
                    {
                        printf("Divide by zero\n");
                        exit(0);
                    }
                    else{
                        push(num1/num2);
                    }

        }
        | COPY  {
                    if(top<0)
                    {
                        printf("Invalid format\n");
                        exit(0);
                    }
                    int num = stack[top];
                    push(num);
        }
        | DELETE 
        {
                    if(top<0)
                    {
                        printf("Invalid format\n");
                        exit(0);
                    }
                    int num1=stack[top];
                    pop();
                    int num2=stack[top];
                    pop();
                    push(num1);
                    //printf("num1 %d\n",num1);
        }
        | SWITCH  
        {
                    if(top<1)
                    {
                        printf("Invalid format\n");
                        exit(0);
                    }
                    int num1=stack[top];
                    pop();
                    int num2=stack[top];
                    pop();
                    push(num1);
                    push(num2);
                    //printf("num1 is %d, num2 is %d\n",num1,num2);
        }
        ;

%%
void yyerror(const char *msg)
{
    printf("Invalid format\n");
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

int main()
{
    yyparse();
    return(0);
}