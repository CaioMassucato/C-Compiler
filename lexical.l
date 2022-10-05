/*
Compilador de C--
Universidade de Brasília
Departamento de Ciência da Computação
Compiladores - CIC000 - 2022/1 A
Prof. Dr. Germana
Desenvolvido por
	Bruno Sanguinetti Regadas de Barros - 18/0046063
	Caio Bernardon N. K. Massucato - 16/0115001
    Caroline Ferreira Pinto - 16/0067766
*/

/* Declarações */
%{
#include <stdio.h>
extern FILE *yyin;
extern FILE *yyout;
%}
%x C_COMMENT

/* Definicoes e Regex 
   comment está zoado
*/
digit       [0-9]
number      {digit}+
letter      [a-zA-Z]
identifier  {letter}+
newline     [\n]
whitespace  [ ]
whitespaces {whitespace}+
keyword     if|else|while|int|void|return
/* 
    Dúvida whitespace, como contabilizar? 
    É pra ser assim mesmo?
*/
%%
{keyword}         {fprintf(yyout,"[Keyword, %s]\n",yytext);}
"="               {fprintf(yyout,"[Assign, %s]\n",yytext);}
"<"               {fprintf(yyout,"[Less, %s]\n",yytext);}
">"               {fprintf(yyout,"[Greater, %s]\n",yytext);}
"<="              {fprintf(yyout,"[Leq, %s]\n",yytext);}
">="              {fprintf(yyout,"[Geq, %s]\n",yytext);}
"+"               {fprintf(yyout,"[Sum, %s]\n",yytext);}
"-"               {fprintf(yyout,"[Sub, %s]\n",yytext);}
"/^*$/"           {fprintf(yyout,"[Mul, %s]\n",yytext);}
"/^/$/"           {fprintf(yyout,"[Div, %s]\n",yytext);}
"("               {fprintf(yyout,"[LParnt, %s]\n",yytext);}
")"               {fprintf(yyout,"[RParnt, %s]\n",yytext);}
"{"               {fprintf(yyout,"[LBrack, %s]\n",yytext);}
"}"               {fprintf(yyout,"[RBrack, %s]\n",yytext);}
";"               {fprintf(yyout,"[End, %s]\n",yytext);}
{number}          {fprintf(yyout,"[Number, %s]\n",yytext);}
{identifier}      {fprintf(yyout,"[ID, %s]\n",yytext);}
{whitespace}      {fprintf(yyout,"[Space, %s]\n",yytext);}
{whitespaces}     {fprintf(yyout,"[Spaces, %s]\n",yytext);}
{newline}         {fprintf(yyout,"[New Line]\n");}
"/*"              { BEGIN(C_COMMENT); }
<C_COMMENT>"*/"   { BEGIN(INITIAL); }
<C_COMMENT>.      { }
%%

/* recomendavel declarar sempre funcao yywrap() */
int yywrap ();

/* programa principal */
int main(argc, argv)
 int argc;
 char **argv;
    {
	++argv; --argc; 	    /* abre arquivo de entrada se houver */
	if(argc > 0)
		yyin = fopen(argv[0],"rt");
	else
		yyin = stdin;    /* cria arquivo de saida se especificado */
	if(argc > 1)
		yyout = fopen(argv[1],"wt");
	else
		yyout = stdout;
	yylex(); /* scanner gerado por Flex */
	fclose(yyin);
	fclose(yyout);
    }

int yywrap() {
	return 1;
}