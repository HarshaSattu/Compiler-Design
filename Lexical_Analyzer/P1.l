%{
   #include<stdio.h>
   #include<stdlib.h>
   #include<stdbool.h>
   #include<string.h>
   #include "P1.tab.h" 
   void yyerror(char*); 
   int yyparse(void);
    
%}





%%
"//".*  {;}
"/*"(.|\n)*"*/" {;}
[ \t\n\r\f]+ {;}
"#defineExpr" { return defExpr;}
"#defineExpr0" { return defExpr0;}
"#defineExpr1" { return defExpr1; }
"#defineExpr2" { return defExpr2; }
"#defineStmt" { return defStmt;}
"#defineStmt0" { return defStmt0; }
"#defineStmt1" { return defStmt1; }
"#defineStmt2" { return defStmt2; }
"+" {return plus;}
"-" {return minus;}
";" {return semicolon;}
"*" {return mult;}
"/" {return DIV;}
"<=" {return le;}
"=" {return eq;}

"," {return coma;}
"[" {return SqBracketOpen;}
"]" {return SqBracketClose;}
"{" {return CurlyBracketOpen;}
"}" {return CurlyBracketClose;}
"(" {return BracketOpen;}
")" {return BracketClose;}
"&&" {return and;}
"||" {return or;}
"!" {return not;}
"!=" {return ne;}
"if" {return IF;}
"else" {return ELSE;}
"while" {return WHILE;}
".length" {return dotlength;}
"." {return dot;}
"true" {return tru;}
"false" {return fls;}
"System.out.println" {return System_print;}
"int" {return intType;}
"boolean" {return booleanType;}
"return" {return RETURN;}
"class" {return class;}
"public" {return public;}
"static" {return STATIC;}
"extends" {return extends;}
"void" {return VOID;}
"main" {return MAIN;}

"String" {return String;}

"new" {return new;}
"this" {return this;}
[0-9]+ {	yylval.str = (char*)malloc(strlen(yytext)+1);strcpy(yylval.str,yytext); return Integer ;}
[_a-zA-Z]([_a-zA-Z]|[0-9])* {yylval.str = (char*)malloc(strlen(yytext)+1);strcpy(yylval.str,yytext); return Identifier;}


%%
