#include <stdio.h>
/* WRONG */

int print_char_to_binary(char ch)
{

        int inint = (int)ch;
        int tmp1, tmp2, sum = 0;
        
        tmp1 = 1;
        while(inint/tmp1 > 1) {
                tmp1 <<= 1;
        }
        
        do {
                tmp2 = inint/tmp1;
                sum += sum * 10 + tmp2;
                inint -= tmp1*tmp2;
        } while((tmp1 >>= 1) > 0);

        printf("%d\n", sum);
        return sum;
}

int main(int argc, char **argv)
{
	unsigned int u;
        int bin = 00;

        bin = print_char_to_binary(**argv);
        u = (unsigned int) **argv;

        int tu = (int)u;

        printf("%u = %d = 0x%u = 0b%d\n ", u, tu, u, bin);
        
    	return 0;
}
