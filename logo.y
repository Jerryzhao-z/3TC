%{
#include <stdio.h>
#include <string.h>
#include <math.h>
#include "logo.h"



static int direction=270;
static Node* tete;
static int verification_branche=0;
static x_position=100;
static y_position=100;
#define PI 3.14159265358979323846

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


int which_direction(int direction_of_spin, int original_direction, int times)
{
	direction=(original_direction+(direction_of_spin*times))%360;
	if(direction<0)
		direction+360;
	return direction;
}

void cree_la_phrase_svg(int direction, int x_deplace, int y_deplace, FILE* fp)
{
   if(y_deplace<0)
	y_deplace=0;
   if(x_deplace<0)
	x_deplace=0;
   if(y_deplace>200)
	y_deplace=200;
   if(x_deplace>200)
	x_deplace=200;
   fprintf(fp, "<line x1=\"%d.000\" y1=\"%d.000\" x2=\"%d.000\" y2=\"%d.000\" stroke=\"red\" />\n", x_position, y_position, x_deplace, y_deplace);
   x_position=x_deplace;
   y_position=y_deplace;
}

int prochaine_x(int valeur)
{
	return (int)(sin((double)direction/360*2*PI)*valeur)+x_position;
}
int prochaine_y(int valeur)
{
	return (int)(-cos((double)direction/360*2*PI)*valeur)+y_position;
}

int lecture_Noeud(Node* noeud, FILE* fp)
{
	int i=0;
	switch(noeud->type)
	{
		case 1:
			cree_la_phrase_svg(direction, prochaine_x(noeud->value), prochaine_y(noeud->value), fp);
			break;
		case 2:		
			direction=which_direction(anticlockwise, direction, noeud->value);
			break;
		case 3:
			direction=which_direction(clockwise, direction, noeud->value);
			break;
		case 4:
			for(i ; i < noeud->value ; i++)
			{
				lecture_Noeud(noeud->SousProgram, fp);
			}
			break;
	}
	if(noeud->suivant != NULL)
		lecture_Noeud(noeud->suivant, fp);
	return 1;	
}

int main()
{
  FILE* fp;
  fp=fopen("cible.svg","a");
  char headofsvg[] = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
  char annonce[] = "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\"200\" height=\"200\">\n";
  char title[] = "<title>Exemple LOGO</title>\n";
  char desc[] = "<desc>Du LOGO.</desc>\n";
  char fin[] = "</svg>\n";
  fprintf(fp, "%s", headofsvg);
  fprintf(fp, "%s", annonce);
  fprintf(fp, "%s", title);
  fprintf(fp, "%s", desc);

  yyparse();
  PrintProgram(tete);
  lecture_Noeud(tete, fp);
  fprintf(fp, "%s", fin);

  return 0;
}



