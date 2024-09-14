%{
#include <stdio.h>
#include <string.h>
%}

%option noyywrap


%s COMMENT

%%
"#"|"//"    { printf("'%s': Comment\n", yytext); }
"/*"        { BEGIN(COMMENT); }
<COMMENT>.|\n { /* Ignore characters in multi-line comment */ }
<COMMENT>"*/" { BEGIN(INITIAL); printf("'%s': Comment\n", yytext); }
[^#/\n]+    { printf("'%s': Not a comment\n", yytext); }
\n          { printf("'\n': Not a comment\n"); }

%%

int main() {

    char *test_lines[] = {
        "# This is a single-line comment using",
        "#print('Hello, world!')",
        "/* This is a single-line multi-line comment */",
        "print('This is not a comment')"
    };
    int num_tests = sizeof(test_lines) / sizeof(test_lines[0]);

    for (int i = 0; i < num_tests; i++) {
        yy_scan_string(test_lines[i]);
        yylex();
    }

    return 0;
}
