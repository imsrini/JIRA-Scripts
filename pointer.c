#include <stdio.h>

int main ()
{
  int age;
  printf("What is your age?");
  scanf("%d", &age);
  int isMinor = 21;
  if(isMinor < age){
    printf ("You can't drink and smoke >,<! at : %d", age);
  }
  // return 0;
}
