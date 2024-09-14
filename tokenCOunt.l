%{
#include <stdio.h>
#include <string.h>

int word_count = 0;

void print_token(const char* token);
%}

/* Rules Section */
%%
[a-zA-Z0-9]+ { print_token(yytext); word_count++; }
\n { printf("Token Size : %d\n", word_count); word_count = 0; }
. ; /* Ignore other characters */

%%

void print_token(const char* token) {
    printf("Token: %s\n", token);
}

int yywrap(void) {
    return 1;
}

int main() {
    // The function that starts the analysis
    yylex();

    return 0;
}
