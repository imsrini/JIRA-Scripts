#include <stdio.h>
void fortune_cookie(char msg[]){
  printf("Message reads: %s\n", msg);
  printf("msg occupies: %d bytes\n", (int) sizeof(msg));
}
void main(){
  char quote[] = "Cookie makes you fat";
  fortune_cookie(quote);
  printf("print sizeof s %d \n", sizeof(&quote));
// printf("print sizeof s;
}
