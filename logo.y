%{
#include <stdio.h>
#include <string.h>
#include "logo.h"

static int direction;
static Node* tete;
static int verification_branche=0;
static x_position=100;
static y_position=100;

#define forward 1
#define left 2
#define right 3
#define repeat 4

#define north 1
#define east 2 
#define south 3
#define west 0

#define clockwise 1
#define anticlockwise -1
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

%union
{
   Node *NODE_TYPE;
   int VAL;
};

%type <VAL> VALUE FORWARD LEFT RIGHT REPEAT ENTREE FIN
%type <NODE_TYPE> BLOC INSTRUCTION

%%
BLOC: INSTRUCTION
{	
   $$=NewProg(); 
   $$=AddNode($$, $1); 
   if(verification_branche==0)
   {
	tete=$$;
	verification_branche++;
   }

} 
| BLOC INSTRUCTION
{
  $$=AddNode($1, $2);
}
INSTRUCTION: FORWARD VALUE
{
   $$=NewNode(1, $2, NULL); 
}
|LEFT VALUE
{
   $$=NewNode(2, $2, NULL); 
}
|RIGHT VALUE
{
   $$=NewNode(3, $2, NULL); 
}
|REPEAT VALUE ENTREE BLOC FIN
{
   $$=NewNode(4, $2, $4); 
}
%%
int lire_memoire//8.1.15

int which_direction(int direction_of_spin, int original_direction, int times)
{
   int k=(original_direction+direction_of_spin*times)%4;
   if(k<0)
	k=k+4;
   return k;
}

char* cree_la_phrase_svg(int direction, int x_origin, int y_origin, int valeur)
{
   int x_deplace, y_deplace;
   if(direction==1 || directon==3)
   {
	y_deplace=(direction-2)*valeur+y_origin;
	x_deplace=x_origin;
   }
   else
   {
	y_deplace=y_origin;
	x_deplace=(direction-1)*valeur+x_origin;
   }
   if(y_deplace<0)
	y_deplace=0;
   if(x_deplace<0)
	x_deplace=0;
   if(y_deplace>200)
	y_deplace=200;
   if(x_deplace>200)
	x_deplace=200;
   char phrase[]="<line x1=\""+x_origin+".000\" y1=\""+y_origin+".000\" x2=\""+x_deplace+".000\" y2=\""+y_deplace+".000\" stroke=\"red\" />\n";
   return phrase;
}
int main()
{
  FILE* fp;
  fp=fopen("cible.svg","a");
  char headofsvg[] = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
  char annonce[] = "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\"200\" height=\"200\">\n";
  char title[] = "<title>Exemple LOGO</title>";
  char desc[] = "<desc>Du LOGO.</desc>";
  fwrite(headofsvg, 1, sizeof(headofsvg), fp);
  fwrite(annonce, 1, sizeof(annonce), fp);
  fwrite(title, 1, sizeof(title), fp);
  fwrite(desc, 1, sizeof(desc),fp);

  yyparse();
  PrintProgram(tete);  
  return 0;
}


