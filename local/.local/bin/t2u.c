#include <stdio.h>
#include <stdlib.h>
/* WRONG */

int main(int argc, char **argv)
{
        int i;
        
        if (argc <= 1) {
                printf("Usage: %s signed_num ...\n", argv[0]);
                exit(1);
        }

        for (i = 1; i < argc; i++) {
                printf("signed = %d, unsigned = %u\n", (short int)argv[i], (unsigned short)argv[i]);
	}

    	return 0;
}
