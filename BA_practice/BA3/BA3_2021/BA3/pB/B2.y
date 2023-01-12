%{

  #include <stdio.h>

  void yyerror();
  int yylex();
  int new_pos = 0;

%}

%code requires {
  typedef struct {
  	int[1e6] ent;
    int size;
  } list;
}

%union {
  int val;
	int pos;
  list lst;
}

%token <val> ival
%type <lst> proc
%right 'T'

%%

S			: proc '$'						{
															printf("[");
															for(int i = 0; i < $1.size; i++) {
                                printf("%d", $1.ent[i]);
																if(i != $1.size-1) {
																	printf(", ");
																}
                              }
															printf("]\n");
															return 0;
														}
;

proc	: proc '+' proc				{
															int pos1 = $1.size;
                              for(int i = 0; i < $3.size; i++) {
                                $1.ent[pos1] = $3.ent[i];
                                pos1++;
                              }
                              $1.size += $3.size;
                            }
			| proc '*' ival				{
                              int pos = $1.size;
                              for(int i = 1; i < $3; i++) {
                                for(int j = 0; j < $1.size; j++) {
                                  $1.ent[pos] = $1.ent[j];
                                  pos++;
                                }
                              }
                              $1.size *= $3;
                            }
      | ival '*' proc       {
                              int pos = $3.size;
                              for(int i = 1; i < $1; i++) {
                                for(int j = 0; j < $3.size; j++) {
                                  $3.ent[pos] = $3.ent[j];
                                  pos++;
                                }
                              }
                              $3.size *= $1;
                            }
			| '[' {new_pos = 0;} vals
;

vals  : ival {} vals
      | ']'

%%

void yyerror() {
	printf("Syntax Error\n");
}

int main(void) {
  yyparse();
  return 0;
}
