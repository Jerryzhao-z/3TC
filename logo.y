%{
#include <stdio.h>
#include <string.h>
#include <logo.h>

void yyerror(const char* str)
{
  fprintf(stderr,"error: %s\n",str);
}
int yywrap()
{
  return 1;  
}

%}

%token  FORWARD 
%token  LEFT
%token  RIGHT
%token  REPEAT
%token  VALUE
%token  ENTREE
%token  FIN
%token  SEPARA;
%token  RETURN_CHARIOT;
%%
BLOC: INSTRUCTION 
| BLOC RETURN_CHARIOT INSTRUCTION
INSTRUCTION: MOT_CLEF SEPARA VALUE
| REPEAT SEPARA VALUE SEPARA ENTREE BLOC FIN
MOT_CLEF: FORWARD
| LEFT
| RIGHT
%%
main()
{
  yyparse();  
}
