%{
#include <stdio.h>
#include <string.h>

void check_variable_name(const char* name, int is_valid);

%}

%%
[a-zA-Z_][a-zA-Z0-9_]* { check_variable_name(yytext, 1); }
[^ \t\n]+ { check_variable_name(yytext, 0); }
[ \t\n]+ { /* Ignore whitespace and newline */ }
%%

void check_variable_name(const char* name, int is_valid) {
    printf("%s: %s\n", name, is_valid ? "Valid" : "Invalid");
}

int main() {
    // Test cases
    char *test_names[] = {"variable1", "1variable", "vari##$$", "Vari+-", "_variable", "Variable"};
    int num_tests = sizeof(test_names) / sizeof(test_names[0]);

    for (int i = 0; i < num_tests; i++) {
        YY_BUFFER_STATE buffer = yy_scan_string(test_names[i]);
        yylex();
        yy_delete_buffer(buffer);
    }

    return 0;
}

int yywrap(void) {
    return 1;
}
