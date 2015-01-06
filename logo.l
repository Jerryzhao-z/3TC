%{
#include <stdio.h>  
#include "logo.tab.h"
%}

%%
"FORWARD" return FORWARD;
"LEFT" return LEFT;
"RIGHT" return RIGHT;
"REPEAT" return REPEAT;
(-?[1-9][0-9]*)|0 yylval=atoi(yytext); return VALUE;
"[" return ENTREE;
"]" return FIN;
[ \t] 
\n  return RETURN_CHARIOT;
" " return SEPARA;
%%
