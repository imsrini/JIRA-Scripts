#include <stdio.h>
int main(){
  int contestants[] = {1,2,3};
  int *choice = contestants;
  //  contestants[0] = 2;
  contestants[1] = 3;
  contestants[2] = *choice;
  printf("i am going to  %i\n", contestants[2]);
  printf("i am going to  %i\n", *choice);
  return 0;
}
