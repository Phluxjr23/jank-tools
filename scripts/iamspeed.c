#include <stdio.h>
#include <unistd.h>

int main() {
    int spaces = 0;
    int direction = 1;
    
    while (1) {
        for (int i = 0; i < spaces; i++) {
            printf(" ");
        }
        printf("i am speed!!!!!!\n");
        fflush(stdout);
        
        usleep(100000);
        
        spaces += direction;
        
        if (spaces >= 13) direction = -1;
        if (spaces <= 0) direction = 1;
    }
    
    return 0;
}
