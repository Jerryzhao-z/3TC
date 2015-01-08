#include <stdio.h>
#include <stdlib.h>
#include "logo.h"

int main()
{
  Node* tete=NewProg();
  tete=(Node*)malloc(sizeof(Node));
  tete=AddNode(tete, NewNode( 1, 10, NULL));    
  tete=AddNode(tete, NewNode( 2, 15, NULL));    
  tete=AddNode(tete, NewNode( 10, 100, NULL));    
  tete=AddNode(tete, NewNode( 1, 10, NULL));
  Node* sub=NewProg();
  Node* suq=NewProg();
  sub=AddNode(sub, NewNode( 0, 100, NULL));
  sub=AddNode(sub, NewNode( 1, 10, NULL));
  sub=AddNode(sub, NewNode( 100, 0, NULL));
  suq=AddNode(suq, NewNode( 0, 100, NULL));
  suq=AddNode(suq, NewNode( 1, 10, NULL));
  suq=AddNode(suq, NewNode( 100, 0, NULL));
  tete=AddNode(tete, NewNode( 1, 11, sub));
  tete=AddNode(tete, NewNode( 10, 100, NULL));    
  tete=AddNode(tete, NewNode( 1, 10, NULL));
  sub=AddNode(sub, NewNode( 1, 12, suq));
  tete=AddNode(tete, NewNode( 10, 100, NULL));    
  tete=AddNode(tete, NewNode( 1, 12, NULL));

  PrintProgram(tete);  
  
}
