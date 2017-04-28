#include <stdio.h>
void main(){
  char s[] = "How are you ";
  char *t = s;
  printf("print sizeof s %i \n"), (int)sizeof(s);
  printf("print sizeof t %i \n"), (int)sizeof(t);
}
