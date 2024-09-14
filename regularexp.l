%{
#include <stdio.h>
%}

%%
a*          { printf("Matched: a*\n"); }
a*b         { printf("Matched: a*b\n"); }
a(a|b)*a    { printf("Matched: a(a|b)*a\n"); }
.|\n        { /* ignore other characters */ }
%%

int main(int argc, char **argv) {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
