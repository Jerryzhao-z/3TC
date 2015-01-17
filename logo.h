#ifndef LOGO_H_
#define LOGO_H_

#include <stdio.h>
#include <stdlib.h>

/**
 * \struct struct NodeEx
 * \brief élément du langage TClogo
 *
 * struct NodeEx ou Node est l'élément du langage TClogo,
 * qui généralement représente une phrase
 */
 
struct NodeEx
{
  int type;
  int value;
  struct NodeEx* SousProgram; 
  struct NodeEx* suivant;    
};
typedef struct NodeEx Node;
typedef Node* Program; 

Node* NewProg();
Node* NewNode(int command, int entier, Node* SousProgram);
Node* AddNode(Node* Program, Node* Newone);
void PrintProgram(Node* Program);


#endif
