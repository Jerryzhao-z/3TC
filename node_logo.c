#include <stdio.h>
#include <stdlib.h>
#include "logo.h"

Node* NewProg()
{
  return (Node*)malloc(sizeof(Node));  
}

Node* NewNode(int command, int entier, Node* SubProgram)
{
  Node* nodeCree;
  nodeCree=(Node*)malloc(sizeof(Node));

  nodeCree->type=command;
  nodeCree->value=entier;
  nodeCree->SousProgram=SubProgram;
 
  return nodeCree;
}

Node* AddNode(Node* Program, Node* Newone)
{
  Node* curseur=Program;
  if(Program->type==0 && Program->value==0 && Program->SousProgram==NULL)
    curseur=Newone;
  else
  { 
    while(curseur->suivant!=NULL)
      curseur=curseur->suivant;
    curseur->suivant=Newone;
    return Program;
  }
}

void PrintProgram(Node* Program)  // la recursion sera mieux
{
  while(Program->suivant!=NULL)
   {
     printf("%d, %d", Program->type, Program->value);
     if(Program->SousProgram!=NULL)
     {
      printf("\n[\n");
      PrintProgram(Program->SousProgram);
      printf("]\n"); 
      Program=Program->suivant;  	
     }else
     {		
     printf("\n");
     Program=Program->suivant;     
     }
   }
 
     printf("%d, %d\n", Program->type, Program->value);


     if(Program->SousProgram!=NULL)
     {
       printf("[\n");
       PrintProgram(Program->SousProgram);
       printf("]\n");      
     }
}

