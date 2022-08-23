
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <assert.h>
int yyerror();
int yylex(void);

struct node{
		char *id;
		char **arg;
		char *val;
		int n_arg;
		struct node * next;
	};

	struct node *head ;
	struct node *current ;

	char* str_replace(char *orig, char *rep, char *with) 
	{   
	    int len_rep;  
	    int len_with; 
	    int len_front; 
	    int count;  
	    char *result; 
	    char *ins;   
	    char *tmp;   

	    if (!orig || !rep)
	        return NULL;
	    len_rep = strlen(rep);
	    if (len_rep == 0)
	        return NULL; 
	    if (!with)
	        with = "";
	    len_with = strlen(with);

	    ins = orig;
	    for (count = 0; tmp = strstr(ins, rep); ++count) {
	        ins = tmp + len_rep;
	    }

	    tmp = result = malloc((strlen(orig) + (len_with - len_rep) * count + 1)*sizeof(char));

	    if (!result)
	        return NULL;

	    while (count--) {
	        ins = strstr(orig, rep);
	        len_front = ins - orig;
	        tmp = strncpy(tmp, orig, len_front) + len_front;
	        tmp = strcpy(tmp, with) + len_with;
	        orig += len_front + len_rep; 
	    }
	    strcpy(tmp, orig);
	    return result;
	}

	void addEntry(char *name, char *args, char *str)
	{	
		struct node * temp = (struct node*)malloc(sizeof(struct node));

		temp->id = (char *) calloc(strlen(name) +1, sizeof(char));
		strcat(temp->id , name);

		temp->arg = malloc(1000*sizeof(char*));

		char *tok;
		tok = strtok(args, ",\n");
		int pos=0;

		while(tok != NULL)
		{
			temp->arg[pos] = tok;
			pos++;
			tok = strtok(NULL, ", \n\t\a\r");
		}

		temp->n_arg = pos; 
		temp->val = (char * )calloc(strlen(str)+1, sizeof(char));

		strcat(temp->val, str);
		temp-> next = NULL;

		if(head == NULL)
		{
			head = temp;
			current = temp;
		}
		else
		{
			current -> next = temp;
			current = current -> next;
		}
	}

	char* searchEntry(char *name, char *argz)
	{
		struct node *t = head;
		char *ans = NULL;

		while(t!=NULL)
		{
			if(strcmp(name, t->id)==0)
			{
				char ** myarg = malloc(1000*sizeof(char*));
				char *tok;
				tok = strtok(argz, ",\n");
				int pos=0;
				while(tok != NULL)
				{
					myarg[pos] = tok;
					pos++;
					tok = strtok(NULL, ", \n\t\a\r");
				}

				if(pos != t->n_arg)
				{
					t = t->next;
					continue;
				}
				else
				{
					ans = (char *) calloc(strlen(t->val) +1, sizeof(char));
					strcat(ans, t->val);
					for(int i=0; i<pos; i++)
					{
						ans = str_replace(ans, t->arg[i], myarg[i]);
					}
					return ans;
				}
			}
			t = t->next;
		}
		return ans;
	}	

 void concat(char* s1, char* s2) 
{
	int i, j;
	i = strlen(s1);
	for (j = 0; s2[j] != '\0'; i++, j++) {
		s1[i] = s2[j];
	}
	s1[i] = '\0';
}

 char* MergeoneString(char *s1)
 {
		char *s0 = (char *) calloc(strlen(s1) + 1, sizeof(char));
		concat(s0, s1);
		return s0;
 }
	char* MergeTwoStrings(char *s1, char *s2)
	{
		char *s0 = (char *) calloc(strlen(s1)+strlen(s2) + 2, sizeof(char));
		concat(s0, s1);
		concat(s0, s2);
		return s0;
	}	
	char* MergeThreeStrings(char *s1, char *s2, char *s3)
	{
		char *s0 = (char *) calloc(strlen(s1)+strlen(s2)+strlen(s3) + 3, sizeof(char));
		concat(s0, s1);
		concat(s0, s2);
		concat(s0, s3);	
		return s0;
	}
	char* MergeFourStrings(char *s1, char *s2, char *s3, char *s4)
	{
		char *s0 = (char *) calloc(strlen(s1)+strlen(s2)+strlen(s3)+strlen(s4) +4, sizeof(char));
		concat(s0, s1);
		concat(s0, s2);
		concat(s0, s3);
		concat(s0, s4);
		return s0;
	}
	char* MergeFiveStrings(char *s1, char *s2, char *s3, char *s4, char *s5)
	{
		char *s0 = (char *) calloc(strlen(s1)+strlen(s2)+strlen(s3)+strlen(s4)+strlen(s5) + 5, sizeof(char));
		concat(s0, s1);
		concat(s0, s2);
		concat(s0, s3);
		concat(s0, s4);
		concat(s0, s5);
		return s0;
	}
	char* MergeSixStrings(char *s1, char *s2, char *s3, char *s4, char *s5, char* s6)
	{
		char *s0 = (char *) calloc(strlen(s1)+strlen(s2)+strlen(s3)+strlen(s4)+strlen(s5)+strlen(s6) + 6, sizeof(char));
		concat(s0, s1);
		concat(s0, s2);
		concat(s0, s3);
		concat(s0, s4);
		concat(s0, s5);
		concat(s0, s6);
		return s0;
	}
	


%}

%union{
    char* str;
}

%type <str> INTEGER
%type <str> ID
%type <str> Goal 
%type <str> MacrodefStar
%type <str> Macrodef
%type <str> MacroDefExpr
%type <str> MacroDefStmt
%type <str> TypeDecStar
%type <str> TypeDec
%type <str> Mainclass
%type <str> Expression
%type <str> TypeidStar
%type <str> Typeid
%type <str> MethodDecStar
%type <str> MethodDec
%type <str> Type
%type <str> Parameters
%type <str> StatementStar
%type <str> Statement
%type <str> CommaTypeidStar
%type <str> CommaTypeid
%type <str> CommExpression
%type <str> CommExpr
%type <str> CommExprstar
%type <str> PrimaryExpression
%type <str> CommaIDstar
%type <str> IDIDIDExpr

%token defExpr defExpr0 defExpr1 defExpr2 defStmt defStmt0 defStmt1 defStmt2 
       plus minus semicolon mult DIV le eq coma SqBracketOpen SqBracketClose
	   CurlyBracketOpen CurlyBracketClose BracketOpen BracketClose and or not
	   ne IF ELSE WHILE dotlength dot tru fls System_print intType booleanType
	   RETURN class public STATIC extends VOID MAIN String new this
	  
    
%token <str> Identifier Integer 
       

%start AugmentedG

%%

AugmentedG : Goal
{
    printf("%s\n", $1);
};

Goal : MacrodefStar  Mainclass TypeDecStar
{
    $$ = MergeTwoStrings($2,$3);
};
        
Mainclass : class ID CurlyBracketOpen public STATIC VOID MAIN BracketOpen String  SqBracketOpen SqBracketClose ID BracketClose CurlyBracketOpen System_print BracketOpen Expression BracketClose semicolon CurlyBracketClose CurlyBracketClose
{
    char* text = MergeFiveStrings("class ",$2,"{ \n\tpublic static void main (String[] ",$12,")");
    $$ = MergeFourStrings(text, "{ \n\t\tSystem.out.println(", $17, "); \n\t}\n}\n\n");
};

MacrodefStar : Macrodef MacrodefStar
{
    $$ = MergeTwoStrings($1,$2);   
}
     |
{
    $$ = MergeoneString("");
};

TypeDecStar : TypeDec TypeDecStar
{
      $$ = MergeTwoStrings($1,$2);
}
  |
{
      $$ = MergeoneString("");
};

TypeDec : class ID CurlyBracketOpen TypeidStar MethodDecStar CurlyBracketClose
{
     $$ = MergeSixStrings("class ",$2,"{\n",$4,$5,"}\n");
}
  | class ID extends ID CurlyBracketOpen TypeidStar MethodDecStar CurlyBracketClose
{
    char* temp = MergeFiveStrings("class ",$2," extends ",$4,"{\n");
    $$ = MergeFourStrings(temp,$6,$7,"}\n");
};

TypeidStar :TypeidStar Typeid
{
     $$ = MergeTwoStrings($1,$2);
}
  |
{
     $$ = MergeoneString("");
};

Typeid : Type ID semicolon
{
     $$ = MergeThreeStrings($1,$2,";\n\t\t");
};


MethodDecStar : MethodDec MethodDecStar
{
     $$ = MergeTwoStrings($1,$2);
}
  |
{
    $$ = MergeoneString("");
};
            
MethodDec : public Type ID BracketOpen Parameters BracketClose CurlyBracketOpen TypeidStar StatementStar RETURN Expression semicolon CurlyBracketClose
{
    char* temp = MergeSixStrings("\tpublic ",$2,$3,"(",$5,")");
    char* text = MergeSixStrings(temp,"{\n\t\t",$8,$9,"\t\treturn ",$11);
	$$ = MergeTwoStrings(text,";\n\t}\n");
};

Parameters : Type ID CommaTypeidStar 
{
    $$ = MergeThreeStrings($1,$2,$3);
}
  |
{
    $$ = MergeoneString("");
};


CommaTypeidStar : CommaTypeid CommaTypeidStar
{
    $$ = MergeTwoStrings($1,$2);
}
  |
{
    $$ = MergeoneString("");
};

CommaTypeid : coma Type ID 
{
    $$ = MergeFourStrings(",",$2," ",$3);
};

Type : intType SqBracketOpen SqBracketClose
{
    $$ = MergeoneString("int[] ");
}
  | booleanType
{
    $$ = MergeoneString("boolean ");
}
  | intType
{
	  $$ = MergeoneString("int ");
}
  | ID
{
    $$ = MergeTwoStrings($1," ");
};


StatementStar : Statement StatementStar
{
    $$ = MergeTwoStrings($1,$2);
}
  |
{
    $$ = MergeoneString("");
};

Statement : CurlyBracketOpen StatementStar CurlyBracketClose
{
    $$ = MergeThreeStrings("{\n",$2,"} \n");
}
  | System_print BracketOpen Expression BracketClose semicolon
{
    $$ = MergeThreeStrings("System.out.println(",$3,"); \n");
}
  | ID eq Expression semicolon
{
    $$ = MergeFourStrings($1," = ",$3,";\n");
}
  | ID SqBracketOpen Expression SqBracketClose eq Expression semicolon
{
    char* text = MergeSixStrings($1,"[",$3,"]"," = ",$6);
	$$ = MergeTwoStrings(text,"; \n");
}
  | IF BracketOpen Expression BracketClose Statement
{
    $$ = MergeFourStrings("if (",$3,")\n\t\t\t",$5);
}
  | IF BracketOpen Expression BracketClose Statement ELSE Statement
{
    $$ = MergeSixStrings( "if (", $3, ")\n\t\t\t", $5, "\t\telse \n\t\t\t", $7);
}
  | WHILE BracketOpen Expression BracketClose Statement
{
    $$ = MergeFourStrings("while (", $3, ")", $5);
}
  | ID BracketOpen CommExpression BracketClose  semicolon
{
   char * ans = searchEntry($1, $3);
  
	if(ans == NULL)
	{	yyerror();
		exit(0);
	}	
	else
	{
		$$ = MergeTwoStrings(ans, " \n");
	} 
 
};



CommExpression : Expression CommExprstar 
{
    $$ = MergeTwoStrings($1,$2);
}
  |
{
    $$ = MergeoneString("");
};

CommExprstar : CommExpr CommExprstar
{
    $$ = MergeTwoStrings($1,$2);
}
  |
{
    $$ = MergeoneString("");
};

CommExpr : coma Expression
{
    $$ = MergeTwoStrings(",",$2);
};




Expression : PrimaryExpression and PrimaryExpression
{
   $$ = MergeThreeStrings($1, "&&", $3);
}
  | PrimaryExpression or PrimaryExpression
{
   $$ = MergeThreeStrings($1, "||", $3);
}
  | PrimaryExpression ne PrimaryExpression
{
   $$ = MergeThreeStrings($1, "!=", $3);
}
  | PrimaryExpression le PrimaryExpression
{
   $$ = MergeThreeStrings($1, "<=", $3);
}
  | PrimaryExpression plus PrimaryExpression
{
   $$ = MergeThreeStrings($1, "+", $3);
}
  | PrimaryExpression minus PrimaryExpression
{
   $$ = MergeThreeStrings($1, "-", $3);
}
  | PrimaryExpression mult PrimaryExpression
{
   $$ = MergeThreeStrings($1, "*", $3);
}
  | PrimaryExpression DIV PrimaryExpression
{
   $$ = MergeThreeStrings($1, "/", $3);
}
  | PrimaryExpression SqBracketOpen PrimaryExpression SqBracketClose
{
   $$ = MergeFourStrings($1,"[", $3, "]");
}
  | PrimaryExpression dotlength
{
   $$ = MergeTwoStrings($1, ".length");
}
  | PrimaryExpression
{
   $$ = MergeoneString($1);
}
  | PrimaryExpression dot ID BracketOpen CommExpression BracketClose
{
   $$ = MergeSixStrings($1, "." , $3, "(", $5, ")");
}
  | ID BracketOpen CommExpression BracketClose
{  
   char * ans = searchEntry($1, $3);
   
	if(ans==NULL)
	{
		yyerror();
		exit(0);
	}	
	else{
		$$ = MergeThreeStrings("(", ans, ")");
  } 
  
};



PrimaryExpression : INTEGER
{
   $$ = MergeoneString($1);
}
  | tru
{
   $$ = MergeoneString("true");
}
  | fls
{ 
   $$ = MergeoneString("false");
}
  | ID
{
   $$ = MergeoneString($1);
}
  | this
{
   $$ = MergeoneString("this");
}
  | new intType SqBracketOpen Expression SqBracketClose
{
   $$ = MergeThreeStrings("new int[", $4, "] ");
}
  | new ID BracketOpen BracketClose
{
   $$ = MergeThreeStrings("new ", $2, "()");
}
  | not Expression
{
   $$ = MergeTwoStrings("!" ,$2);
}
  | BracketOpen Expression BracketClose
{
   $$ = MergeThreeStrings("(", $2, ")");
};

Macrodef : MacroDefExpr
{
   $$ = MergeoneString($1);
}
  | MacroDefStmt
{
   $$ = MergeoneString($1);
};


CommaIDstar : coma ID CommaIDstar
{
   $$ = MergeThreeStrings(",",$2,$3);
}
  |
{
   $$ = MergeoneString("");
}


IDIDIDExpr : ID CommaIDstar
{ 
  $$ = MergeTwoStrings($1,$2);
 
}
  |
{  
  $$ = MergeoneString("");
 
};


MacroDefStmt : defStmt ID BracketOpen IDIDIDExpr BracketClose CurlyBracketOpen StatementStar CurlyBracketClose
{
  $$ = "";
  addEntry($2,$4,$7); 

}
  | defStmt0 ID BracketOpen IDIDIDExpr BracketClose CurlyBracketOpen StatementStar CurlyBracketClose
{ 
  $$ = "";
  addEntry($2,$4,$7); 
 
}
  | defStmt1 ID BracketOpen IDIDIDExpr BracketClose CurlyBracketOpen StatementStar CurlyBracketClose
{ 
  $$ = "";
  addEntry($2,$4,$7); 
 
}
  | defStmt2 ID BracketOpen IDIDIDExpr BracketClose CurlyBracketOpen StatementStar CurlyBracketClose
{ 
  $$ = "";
  addEntry($2,$4,$7);
 
};




MacroDefExpr :  defExpr ID BracketOpen IDIDIDExpr BracketClose BracketOpen Expression BracketClose
{ 
  $$ = "";
  addEntry($2,$4,$7); 

}
  | defExpr0 ID BracketOpen IDIDIDExpr BracketClose BracketOpen Expression BracketClose
{ 
  $$ = "";
  addEntry($2,$4,$7); 
 
}
  | defExpr1 ID BracketOpen IDIDIDExpr BracketClose BracketOpen Expression BracketClose
{ 
  $$ = "";
  addEntry($2,$4,$7); 
  
}
  | defExpr2 ID BracketOpen IDIDIDExpr BracketClose BracketOpen Expression BracketClose
{ 
  $$ = "";
  addEntry($2,$4,$7); 
 
};

ID : Identifier
{
   $$ = MergeoneString($1);
};

INTEGER : Integer
{
  $$ = MergeoneString($1);
};
%%

int yyerror(){
    printf("//Failed to parse input code");
}

int main(int argc,char** argv){

	yyparse();	

	return 0;
}