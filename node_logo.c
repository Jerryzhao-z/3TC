/**
 * \file node_logo.c
 * \brief gestion de Node de Programme
 * \author JerryZhao.z
 * \version 1.0
 * \date 16.1.2015
 *
 * Programme qui genère et gestionne un programme en TClogo
 *
 */
#include <stdio.h>
#include <stdlib.h>
#include "logo.h"


/**
 * \fn Node* NewProg()
 * \brief fonction de constuire un tete de programme
 *
 * \param 
 * \return Un pointeur NULL dirige vers type Node.
 */
Node* NewProg()
{
  return NULL; 

}

/**
 * \fn Node* NewNode(int command, int entier, Node* SubProgram)
 * \brief fonction de générer un Node, c'est à dire une phrase dans la command
 *
 * \param command: FORWARD, LEFT, RIGHT or REPEAT
 * \param entier: valeur of command
 * \param SubProgram of command 
 * \return le pointeur dirige vers la node crée.
 */
Node* NewNode(int command, int entier, Node* SubProgram)
{
  Node* nodeCree;
  nodeCree=(Node*)malloc(sizeof(Node));

  nodeCree->type=command;
  nodeCree->value=entier;
  nodeCree->SousProgram=SubProgram;

  return nodeCree;
}

/**
 * \fn Node* AddNode(Node* Program, Node* Newone)
 * \brief Ajouter une node à la fin du programme existé
 *
 * \param Programme le programme cible
 * \param Newone la node à ajouter
 * \return le pointeur dirige vers le nouveau programme.
 */
Node* AddNode(Node* Programme, Node* Newone)
{
  Node* curseur=Programme;
  if(Programme->type==0 && Programme->value==0 && Programme->SousProgram==NULL)
    curseur=Newone;
  else
  { 
    while(curseur->suivant!=NULL)
      curseur=curseur->suivant;
    curseur->suivant=Newone;
  }
  return Programme;
}

/**
 * \fn void PrintProgram(Node* Program) 
 * \brief afficher le programme total sur la session
 *
 * \param Programme: le programme cible à sortir
 * \return rien.
 */
void PrintProgram(Node* Programme)  // la recursion sera mieux
{
  while(Programme->suivant!=NULL)
   {
     printf("%d, %d", Programme->type, Programme->value);
     if(Programme->SousProgram!=NULL)
     {
      printf("\n[\n");
      PrintProgram(Programme->SousProgram);
      printf("]\n"); 
      Programme=Programme->suivant;  	
     }else
     {		
     printf("\n");
     Programme=Programme->suivant;     
     }
   }
 
     printf("%d, %d\n", Programme->type, Programme->value);


     if(Programme->SousProgram!=NULL)
     {
       printf("[\n");
       PrintProgram(Programme->SousProgram);
       printf("]\n");      
     }
}

