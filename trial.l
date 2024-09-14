%{


%}


%%
"Hello World" {printf("Matched\n");}
"Hello Compiler" {printf("Agunnnn.......\n");}



%%
int yywrap(){
    
}

int main(){
    yylex();
    return 0;
}