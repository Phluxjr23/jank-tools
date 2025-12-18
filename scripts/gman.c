#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

const char *quotes[] = {
    "rise... and... shine... mister... freeman... rise and... shine...",
    "not that i... wish to imply you have been sleeping on the job...",
    "no one is more deserving of a rest... and all the effort in the world would have gone to waste until...",
    "well... let's just say your hour has... come again...",
    "the right man in the wrong place can make all the... difference... in the world...",
    "so... wake up... mister freeman... wake up and... smell the ashes...",
    "time... doctor freeman? is it really that... time again?",
    "it seems as if you only just arrived...",
    "you've done a great deal in a small time... span...",
    "you've done so... well, in fact, that i've received some interesting offers for your services...",
    "ordinarily, i wouldn't contemplate them... but these are extraordinary times...",
    "rather than offer you the illusion of free choice, i will take the liberty of choosing for you...",
    "if and when your time comes round again...",
    "i do apologize for what must seem to you an arbitrary imposition, doctor freeman...",
    "i trust it will all make sense to you in the course of... well... i'm really not at liberty to say...",
    "in the meantime... this is where i get off...",
    "we'll see... about that...",
    "prepare for unforeseen consequences...",
    "wisely done, mister freeman... i will see you up ahead...",
    "no regrets, mister freeman...",
    "time to choose...",
    "do you have regrets?",
    "well... it looks like we won't be working together...",
    "no, i don't think so...",
    "i'm afraid you've misunderstood my assignment...",
};

void print_quote(const char *quote) {
    for (int i = 0; quote[i] != '\0'; i++) {
        putchar(quote[i]);
        fflush(stdout);
        
        if (quote[i] == '.' && quote[i+1] == '.' && quote[i+2] == '.') {
            usleep(300000);
        } else if (quote[i] == ' ') {
            usleep(50000);
        } else {
            usleep(30000);
        }
    }
    printf("\n");
}

void print_random_quote() {
    srand(time(NULL));
    int idx = rand() % (sizeof(quotes) / sizeof(quotes[0]));
    print_quote(quotes[idx]);
}

void print_hire() {
    printf("the right man in the wrong place can make all the... difference... in the world...\n\n");
    usleep(500000);
    printf("you've done so... well, in fact, that i've received some interesting offers for your services...\n\n");
    usleep(500000);
    printf("rather than offer you the illusion of free choice, i will take the liberty of choosing for you...\n\n");
    usleep(500000);
    printf("welcome... to the employment roster...\n");
}

void print_time() {
    printf("time... doctor freeman? is it really that... time again?\n");
    usleep(500000);
    printf("it seems as if you only just arrived...\n");
}

void print_freeman() {
    printf("mister... freeman...\n");
    usleep(500000);
    printf("the right man in the wrong place...\n");
    usleep(500000);
    printf("wisely done...\n");
}

void print_alyx() {
    printf("miss... vance...\n");
    usleep(500000);
    printf("i'm afraid you've misunderstood my assignment...\n");
}

void print_consequences() {
    printf("prepare for unforeseen... ");
    fflush(stdout);
    usleep(1000000);
    printf("CONSEQUENCES\n");
    usleep(300000);
    for (int i = 0; i < 5; i++) {
        printf(".");
        fflush(stdout);
        usleep(200000);
    }
    printf("\n");
}

void print_briefcase() {
    printf("the borderworld... xen...\n");
    usleep(500000);
    printf("is in our control... for the time being...\n");
    usleep(500000);
    printf("thanks to you...\n");
    usleep(500000);
    printf("quite a nasty piece of work you managed over there...\n");
    usleep(500000);
    printf("*adjusts briefcase*\n");
}

void print_choice() {
    printf("rather than offer you the illusion of free choice...\n");
    usleep(500000);
    printf("i will take the liberty of choosing for you...\n");
    usleep(500000);
    printf("if and when your time comes round again...\n");
}

void print_regrets() {
    printf("do you have... regrets?\n");
    usleep(500000);
    printf("no regrets, mister freeman...\n");
    usleep(500000);
    printf("or perhaps... too many...\n");
}

void print_vortigaunt() {
    printf("the freeman... we have seen you...\n");
    usleep(500000);
    printf("in the vortessence...\n");
    usleep(500000);
    printf("though we cannot say your name...\n");
}

void print_barney() {
    printf("about that beer i owed ya...\n");
    usleep(500000);
    printf("*stares mysteriously*\n");
    usleep(500000);
    printf("...\n");
}

void print_breen() {
    printf("doctor... breen...\n");
    usleep(500000);
    printf("i have recommended your services...\n");
    usleep(500000);
    printf("what you've done will have... consequences...\n");
}

void print_lambda() {
    printf("the lambda symbol...\n");
    usleep(500000);
    printf("such a simple... icon...\n");
    usleep(500000);
    printf("yet it represents... so much...\n");
}

void print_wake() {
    printf("rise... and... shine...\n");
    usleep(800000);
    printf("not that i wish to imply you have been sleeping on the job...\n");
    usleep(500000);
    printf("wake up... and smell the ashes...\n");
}

int main(int argc, char *argv[]) {
    if (argc == 1) {
        print_random_quote();
        return 0;
    }
    
    if (strcmp(argv[1], "--hire") == 0) {
        print_hire();
    } else if (strcmp(argv[1], "--time") == 0) {
        print_time();
    } else if (strcmp(argv[1], "--freeman") == 0) {
        print_freeman();
    } else if (strcmp(argv[1], "--alyx") == 0) {
        print_alyx();
    } else if (strcmp(argv[1], "--consequences") == 0) {
        print_consequences();
    } else if (strcmp(argv[1], "--briefcase") == 0) {
        print_briefcase();
    } else if (strcmp(argv[1], "--choice") == 0) {
        print_choice();
    } else if (strcmp(argv[1], "--regrets") == 0) {
        print_regrets();
    } else if (strcmp(argv[1], "--vortigaunt") == 0) {
        print_vortigaunt();
    } else if (strcmp(argv[1], "--barney") == 0) {
        print_barney();
    } else if (strcmp(argv[1], "--breen") == 0) {
        print_breen();
    } else if (strcmp(argv[1], "--lambda") == 0) {
        print_lambda();
    } else if (strcmp(argv[1], "--wake") == 0) {
        print_wake();
    } else if (strcmp(argv[1], "--help") == 0 || strcmp(argv[1], "-h") == 0) {
        printf("usage: gman [option]\n\n");
        printf("options:\n");
        printf("  --hire          receive employment offer\n");
        printf("  --time          check the time\n");
        printf("  --freeman       address doctor freeman\n");
        printf("  --alyx          address miss vance\n");
        printf("  --consequences  unforeseen consequences\n");
        printf("  --briefcase     briefcase adjustment\n");
        printf("  --choice        illusion of free choice\n");
        printf("  --regrets       contemplation of regrets\n");
        printf("  --vortigaunt    vortessence communication\n");
        printf("  --barney        about that beer he owes ya\n");
        printf("  --breen         regarding doctor breen\n");
        printf("  --lambda        the symbol\n");
        printf("  --wake          rise and shine\n");
        printf("  -h, --help      show this help\n\n");
        printf("no option: random quote\n");
    } else {
        printf("the illusion of free choice...\n");
        printf("try: gman --help\n");
    }
    
    return 0;
}
