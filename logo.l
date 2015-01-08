%{
#include <stdio.h> 
#include "logo.h" 
#include "logo.tab.h"
%}

%%
"FORWARD" return FORWARD;
"LEFT" return LEFT;
"RIGHT" return RIGHT;
"REPEAT" return REPEAT;
(-?[1-9][0-9]*)|0 {yylval.VAL=atoi(yytext); return VALUE;}
"[" return ENTREE;
"]" return FIN;
%%

/*include logo.h 如果在logo.tab.h后面，那么他将无法识别定义在logo.h里的类型*/
