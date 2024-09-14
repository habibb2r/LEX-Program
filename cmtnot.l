%{
#include <stdio.h>

void print_comment(const char* comment);
void print_not_comment(const char* text);
%}


%%
"/*"([^*]|\*+[^*/])*\*+"/" { print_comment(yytext); }
"//".*                   { print_comment(yytext); }
"#".*                   { print_comment(yytext); }
[^\n]+                  { print_not_comment(yytext); }
\n                      { /* Ignore new lines */ }

%%

void print_comment(const char* comment) {
    printf("This line is a Comment: %s\n", comment);
}

void print_not_comment(const char* text) {
    printf("This Line Not a comment: %s\n", text);
}

int yywrap(void) {
    return 1;
}

int main() {
    yylex();

    return 0;
}
