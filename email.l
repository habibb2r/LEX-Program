%{
#include <stdio.h>
#include <string.h>

void validate_email(const char *email) {
    const char *at = strchr(email, '@');
    if (at == NULL) {
        printf("Invalid email: missing '@'\n");
        return;
    }

    const char *dot = strchr(at, '.');
    if (dot == NULL) {
        printf("Invalid email: missing domain extension\n");
        return;
    }

    printf("Your given mail is Valid : %s\n", email);
}

int yywrap(void) {
    return 1;
}
%}

%%
[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}   { validate_email(yytext); }
\n                                                { /* Ignore newline characters */ }
.                                                 { printf("Invalid character: %s\n", yytext); }
%%

int main(void) {
    yylex();
    return 0;
}
