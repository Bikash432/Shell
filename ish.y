%{
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <pwd.h>

%}

%union
{
    char	*string;
    int		integer;
}

%token 	<string>	WORD
%token 	<string>	COMMAND
%token 	<string>	FILENAME
%token	<int>		BACKGROUND
%token	<int>		PIPE
%token	<int>		PIPE_ERROR
%token	<int>		SEMICOLON
%token	<int>		REDIRECT_IN
%token	<int>		REDIRECT_OUT
%token	<int>		REDIRECT_ERROR
%token	<int>		APPEND
%token	<int>		APPEND_ERROR
%token	<string>	OPTION
%token	<string>	STRING
%token	<int>		LOGICAL_AND
%token	<int>		LOGICAL_OR

%%

cmd_line 	: cmd_line separator COMMAND parameters 
                | COMMAND parameters
{
  printf("example: COMMAND is %s\n", $<string>1);
}
		| cmd_line BACKGROUND
		| cmd_line SEMICOLON
		|  
		| error 
		;

separator 	: BACKGROUND 
		| PIPE
{
  printf("example: got a pipe\n");
}
		| 
		{
			handlePipe();
		}
		| SEMICOLON
		;

parameters	: parameters OPTION
		| parameters STRING
		| parameters WORD
		| parameters REDIRECT_IN FILENAME
                | parameters REDIRECT_OUT FILENAME
		| parameters REDIRECT_ERROR FILENAME
		| parameters APPEND FILENAME
		| parameters APPEND_ERROR FILENAME
		|
		;

%%

int yyerror(char *s)
{
    fprintf(stderr, "syntax error\n");
    return 0;
}

int main(){
  while(1){
    if (!yyparse()){
      //something perhaps
    }
  }
  return 0;
}
void handlePipe(){

}

