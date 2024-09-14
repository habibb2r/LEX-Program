%{
#include <stdio.h>
#include <string.h>

char *input_string;
int matched = 0;
%}

%%
^a(a|b)*a$   { printf("Matched with Given String: a(a|b)*a\n"); matched = 1; }
^a*b$        { printf("Matched with Given String: a*b\n"); matched = 1; }
^a*$         { printf("Matched with Given String: a*\n"); matched = 1; }
.|\n         { /* Ignore other characters */ }
%%

int main(int argc, char **argv) {
    // Read input from standard input
    size_t len = 0;
    getline(&input_string, &len, stdin);

    // Remove newline character if present
    input_string[strcspn(input_string, "\n")] = 0;

    // Match the entire input string
    yy_scan_string(input_string);
    yylex();

    // If no pattern matched, print "Not matched"
    if (!matched) {
        printf("Not matched, Try ANother string\n");
    }

    return 0;
}

int yywrap() {
    return 1;
}
