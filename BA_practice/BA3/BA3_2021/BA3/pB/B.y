%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *);
int yylex(void);

typedef struct List {
    int size;
    char** items;
    int maxSize;
}my_list;

my_list* create_list() {
    const int maxSize = 10000;
    my_list* list = malloc(sizeof(my_list));
    list->items = malloc(sizeof(char*)*maxSize);
    list->size = 0;
    list->maxSize = maxSize;
    return list;
}

int append_last(my_list* list, char* c) {
    list->items[list->size] = malloc((strlen(c)+1) * sizeof(char));
    strcpy(list->items[list->size], c);
    list->size+=1;
    return list->size;
}

int append_head(my_list* list, char* c) {
    int i;
    for (i = list->size-1; i > -1 ; i--) {
        list->items[i+1] = list->items[i];
    }
    list->items[0] = malloc((strlen(c)+1) * sizeof(char));
    strcpy(list->items[0], c);
    list->size+=1;
    return list->size;
}

// +
my_list* concat_list(my_list* first_list , my_list* second_list) {
    my_list* new_list = create_list();
    int i;
    for(i = 0; i < first_list->size; i++) {
        append_last(new_list, first_list->items[i]);
    }
    for(i = 0; i < second_list->size; i++) {
        append_last(new_list, second_list->items[i]);
    }
    return new_list;
}

my_list* repeat_list(my_list* list , int repeat_num) {
    my_list* new_list = create_list();
    // if repeat num <= 0, list would be empty
    int ori_size = list->size;
    if (repeat_num <= 0) {
        return new_list;
    }
    int r; 
    int i;
    for (r = 0 ; r < repeat_num ; r++) {
        for(i =0; i < ori_size; i++) {
            append_last(new_list, list->items[i]);
        }
    }
    return new_list;
}

void print_list(my_list* list) {
    printf("[");
    int i;
    for (i = 0 ; i < list->size ; i++ ) {
        printf("%s", list->items[i]);
        if (i != list->size - 1) {
            printf(", ");
        }
    }
    printf("]\n");
}

my_list* list;

%}

%union {
  int ival;
  char* word;
  struct List* list;
}

%start S
%token<word> DIG
%token LBR RBR COM MUL ADD

%type<list> ListItem List Term Sum
%type<ival> MulDigit

%%
S 
    : Sum '$' {printf("end\n");}

Sum 
    : Term ADD Sum { 
        printf("sum1\n"); 
    }
    | Term { 
        printf("sum2\n");
    }

Term 
    : List MUL MulDigit {
        printf("Term1\n");
    }
    | MulDigit MUL List {
        printf("Term2\n");
    }
    | MulDigit MUL List MUL MulDigit {
        printf("Term3\n"); 
    }
    | List {
        printf("Term4\n");
    }

MulDigit 
    : MulDigit MUL  DIG {
        printf("MulDigit1\n");
    }
    | DIG {
        printf("MulDigit2\n"); 
    }

List 
    : LBR ListItem RBR {
        printf("list1\n"); 
    }

ListItem 
    : DIG {my_list list } COM ListItem {
        printf("ListItem1\n");
    }
    | DIG {
        printf("ListItem2\n");
    }
%%

void yyerror (const char *s) {
   printf ("%s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}

/*
bison -d -o B.tab.c B.y
clang -c -g -I.. B.tab.c
*/