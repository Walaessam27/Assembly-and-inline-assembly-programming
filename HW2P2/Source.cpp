#include<stdio.h>
using namespace std;
int main()
{
    float num;
    int mant[24]; // Array for mantissa
    int exponent;

    printf("Enter a float value: ");
    scanf("%f", &num);

    printf("The value in HEX is %08XH\n", *(unsigned int*)&num);

    _asm {
        mov eax, num

        // exponent in binary
        mov ebx, eax
        shr ebx, 23
        and ebx, 0xFF
        mov exponent, ebx

        // mantissa in binary
        mov ebx, eax
        and ebx, 0x7FFFFF


        mov ecx, 23
        start:
        test ebx, 0x400000
            jz skip
            mov mant[ecx], 1
            jmp cont
            skip :
        mov mant[ecx], 0
            cont :
            shl ebx, 1
            loop start
    }

    // Print
    printf("The biased Exponent: ");
    for (int i = 7; i >= 0; i--) {
        printf("%d", (exponent >> i) & 1);
    }
    printf("\n");


    printf("The mantissa is ");
    for (int i = 23; i >= 0; i--) {
        printf("%d", mant[i]);
    }
    printf("\n");

    return 0;
}
