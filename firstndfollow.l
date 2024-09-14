%{
#include <stdio.h>
#include <string.h>

// Rename the input buffer variable to avoid conflicts
char *input_buffer;

// Declare functions to handle different non-terminals
void process_S();
void process_A();
void process_B();
%}

%%
a       { process_S(); }
b       { printf("Terminal b recognized\n"); }
c       { printf("Terminal c recognized\n"); }
d       { printf("Terminal d recognized\n"); }
\n      { /* Ignore newlines */ }
[ \t]+  { /* Ignore whitespace */ }
.       { printf("Unrecognized character: %s\n", yytext); }

%%

void process_S() {
    // Process the non-terminal S -> aABbc
    printf("Processing S -> aABbc\n");
    input_buffer++;  // Consume 'a'
    
    process_A();  // Process A
    process_B();  // Process B
    
    if (*input_buffer == 'b') {
        printf("Terminal b recognized\n");
        input_buffer++;  // Consume 'b'
    } else {
        printf("Error: expected 'b'\n");
    }

    if (*input_buffer == 'c') {
        printf("Terminal c recognized\n");
        input_buffer++;  // Consume 'c'
    } else {
        printf("Error: expected 'c'\n");
    }
}

void process_A() {
    // Process the non-terminal A -> c | ε
    printf("Processing A -> c | ε\n");
    if (*input_buffer == 'c') {
        printf("Terminal c recognized\n");
        input_buffer++;  // Consume 'c'
    } else {
        printf("A -> ε (epsilon)\n");
    }
}

void process_B() {
    // Process the non-terminal B -> d | ε
    printf("Processing B -> d | ε\n");
    if (*input_buffer == 'd') {
        printf("Terminal d recognized\n");
        input_buffer++;  // Consume 'd'
    } else {
        printf("B -> ε (epsilon)\n");
    }
}

int main(int argc, char **argv) {
    if (argc > 1) {
        input_buffer = argv[1];
        yylex();
    } else {
        printf("Usage: %s <input_string>\n", argv[0]);
    }
    return 0;
}

int yywrap() {
    return 1;
}
