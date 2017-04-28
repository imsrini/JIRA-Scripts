//. Practice
//-------------------------------------
#include <stdio.h>
void go_to_south(int *lat, int *lon){
  *lat = *lat - 1;
  *lon = *lon + 1;
}
int main(){
  int latitude = 33;
  int longlat = 63;
  go_to_south (&latitude,&longlat);
  printf("Avast! [%i,%i]\n",latitude,longlat);
  return 0;
}
