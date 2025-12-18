#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

void print_usage() {
    printf("usage: paint [-h hours] [-m minutes] [-s seconds] [-color color]\n");
    printf("watch paint dry. defaults to 30 seconds.\n");
}

int main(int argc, char *argv[]) {
    int hours = 0, minutes = 0, seconds = 30;
    char color[32] = "white";
    
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-h") == 0 && i + 1 < argc) {
            hours = atoi(argv[++i]);
        } else if (strcmp(argv[i], "-m") == 0 && i + 1 < argc) {
            minutes = atoi(argv[++i]);
        } else if (strcmp(argv[i], "-s") == 0 && i + 1 < argc) {
            seconds = atoi(argv[++i]);
        } else if (strcmp(argv[i], "-color") == 0 && i + 1 < argc) {
            strncpy(color, argv[++i], sizeof(color) - 1);
        } else if (strcmp(argv[i], "--help") == 0) {
            print_usage();
            return 0;
        }
    }
    
    int total_seconds = hours * 3600 + minutes * 60 + seconds;
    
    printf("watching %s paint dry for ", color);
    if (hours > 0) printf("%dh ", hours);
    if (minutes > 0) printf("%dm ", minutes);
    printf("%ds...\n", seconds);
    
    for (int i = 0; i < total_seconds; i++) {
        printf(".");
        fflush(stdout);
        sleep(1);
    }
    
    printf("\npaint is dry!\n");
    return 0;
}
