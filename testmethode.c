#include <stdio.h>
#include <stdlib.h>

int which_direction(int direction_of_spin, int original_direction, int times)
{
   int k=(original_direction+direction_of_spin*times)%4;
   if(k<0)
	k=k+4;
   return k;
}

int main()
{
	printf("%d",which_direction(1,1,3));
	printf("%d",which_direction(-1,1,7));
	printf("%d",which_direction(1,2,3));
	printf("%d",which_direction(-1,2,7));
	printf("%d",which_direction(1,3,3));
	printf("%d",which_direction(-1,3,7));
	printf("%d",which_direction(1,0,3));
	printf("%d",which_direction(-1,0,7));
}
