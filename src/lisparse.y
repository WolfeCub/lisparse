%{
#include <string>
#include <stdexcept>
#include <stdio.h>
void yyerror(char const *);
extern int yylex(void);
%}

%error-verbose

%union {
    int int_val;
    std::string *str_val;
}

%token EOL
%token <int_val> INTEGER
%token <str_val> STRING ID

%%
program: /*empty */
       | program INTEGER { printf("%d", $2); }
       | program STRING { printf("%s", $2->c_str()); }
       | program ID {  printf("%s", $2->c_str()); }
       | program EOL { printf("\n"); }
;

%%

#include "../obj/lisparse.yy.c"
int main() {
    yyin = stdin;
    yyparse();

    return 0;
}

void yyerror(char const *m) {
  fprintf(stderr, "Parse error on line %d: %s\n", yylineno, m);
  exit(1);
}

