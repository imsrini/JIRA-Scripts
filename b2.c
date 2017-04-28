# include <stdio.h>
# include <stdlib.h>
# include <ctype.h>

//global definition.
FILE *outFile; /* output file */

/* Function declaration */

void hex(unsigned char *p, int max);

/* Main program */
int main(int argc, char *argv[]){
    FILE *inFile;
    int i, toFile;
    const int SIZE = 16;
    unsigned char lined[SIZE]; //.local buffer

    // validate
    if(argc > 3 || argc < 2){
      fprintf(stderr,"usage: %s filename [filename2] \n",argv[0]);
      return EXIT_FAILURE;
    }
    outFile = stdout; //.set default output stream
    toFile = (argc == 3); //.is there an output file

    //.open I/O files
    if(*inFile = fopen(argv[1], "r") == NULL){
      fprintf(stderr, "Cannot open file %s\n", argv[2]);
      fclose(inFile);
      return EXIT_FAILURE;
    }

    //.main loop : read the SIZE bytes at a time ;
    //.store them in line, can calls hex ();
    while (( i = fread(line , 1 , SIZE , inFile)) > 0){
      hex(line,i);
    }
    //.close I/O
    if(fclose(inFile)==EOF){
      fprintf(stderr,"Can not close file %s\n", argv[1]);
      if(toFile)
	fclose(outFile);
      return EXIT_FAILURE;
    }
    if(toFile && fclose(outFile) == EOF){
      fprintf(stderr, "Can not close file %s\n", argv[2]);
      return EXIT_FAILURE;
    }
    return EXIT_SUCCESS;
}

//. Definition of hex()   
void hex(unsigned char *p, int max){
  int i;
  unsigned char *paux;

  for(i = 0 ,*paux = p ; i < max ; i++ , *paux++)
    fprintf(outFile, "%02x", *paux);
   fputc('\n',outFile);
  
   for (i = 0 , *paux = p ; i < max ; i++ , *paux++)
    fprintf(outFile, "%c ", isprint(*paux) ? *paux : '.');
  fputc('\n', outFile);
}
