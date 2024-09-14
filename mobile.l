%{
#include <stdio.h>
#include <string.h>
%}

%option noyywrap

%%
"019"[0-9]{8}    { printf("%s: Banglalink mobile number\n", yytext); }
"017"[0-9]{8}    { printf("%s: Grameenphone mobile number\n", yytext); }
"018"[0-9]{8}    { printf("%s: Robi mobile number\n", yytext); }
"018"[0-9]{9}    { printf("%s: Invalid mobile number\n", yytext); }
.|\n             { printf("%s: Not a valid mobile number\n", yytext); }

%%

int main() {
   
    char *test_numbers[] = {
        "01912345678",
        "01787654321",
        "018987654322",
    };
    int num_tests = sizeof(test_numbers) / sizeof(test_numbers[0]);

    for (int i = 0; i < num_tests; i++) {
        yy_scan_string(test_numbers[i]);
        yylex();
    }

    return 0;
}
