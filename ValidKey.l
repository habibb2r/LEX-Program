%{
#include <stdio.h>
#include <string.h>

// List of valid Python keywords
const char* keywords[] = {
    "False", "None", "True", "and", "as", "assert", "async", "await", "break", "class", 
    "continue", "def", "del", "elif", "else", "except", "finally", "for", "from", "global", 
    "if", "import", "in", "is", "lambda", "nonlocal", "not", "or", "pass", "raise", 
    "return", "try", "while", "with", "yield"
};

int is_valid_keyword(const char* word) {
    int num_keywords = sizeof(keywords) / sizeof(keywords[0]);
    for (int i = 0; i < num_keywords; i++) {
        if (strcmp(word, keywords[i]) == 0) {
            return 1;
        }
    }
    return 0;
}

void check_keyword(const char* word);

%}

%%

[a-zA-Z_][a-zA-Z0-9_]* { check_keyword(yytext); }
.|\n { /* Ignore other characters and newline */ }

%%

void check_keyword(const char* word) {
    printf("'%s': %s\n", word, is_valid_keyword(word) ? "Valid keyword" : "Invalid keyword");
}

int main() {
    // Test cases
    char *test_keywords[] = {"if", "else", "fi", "elsefi"};
    int num_tests = sizeof(test_keywords) / sizeof(test_keywords[0]);

    for (int i = 0; i < num_tests; i++) {
        YY_BUFFER_STATE buffer = yy_scan_string(test_keywords[i]);
        yylex();
        yy_delete_buffer(buffer);
    }

    return 0;
}

int yywrap(void) {
    return 1;
}
