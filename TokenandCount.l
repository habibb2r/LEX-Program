%{
#include <stdio.h>
#include <string.h>

int word_count = 0;
char tokens[100][100]; // Array to store tokens
int token_index = 0;   // Index to keep track of tokens

void add_token(const char* token);
void print_tokens();

%}

/* Rules Section */
%%
[a-zA-Z0-9]+ { add_token(yytext); word_count++; }
\n { print_tokens(); printf("Token Size : %d\n", word_count); word_count = 0; token_index = 0; }
. ; /* Ignore other characters */

%%

void add_token(const char* token) {
    strcpy(tokens[token_index++], token);
}

void print_tokens() {
    printf("Tokens : [");
    for (int i = 0; i < token_index; i++) {
        printf("\"%s\"", tokens[i]);
        if (i < token_index - 1) {
            printf(", ");
        }
    }
    printf("]\n");
}

int yywrap(void) {
    return 1;
}

int main() {
    // The function that starts the analysis
    yylex();

    return 0;
}
