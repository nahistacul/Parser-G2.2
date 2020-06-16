%{
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern FILE *yyin;
int yylex();
char *yytext;
int yylineno;
%}

%union {
	int ent;
	float real;
}

%token LEER ESCRIBIR 
%token SI ENTONCES SINO FIN_SI 
%token MIENTRAS HACER FIN_MIENTRAS
%token REPETIR HASTA_QUE
%token PARA HASTA FIN_PARA
%token SEGUN FIN_SEGUN
%token ACCION _ES FIN_ACCION
%token PROCESO AMBIENTE
%token INCREMENTO
%token NEG
%token <ent> ENTEROO
%token <real> REALL
%token SALTO

%token ASIGNACION
%token OPARIT
%token OPREL
%token OPLOG
%token DOSPUNTOIDES
%token NUMERAL

%token ID
%token CADENX
%token ABRIR_PATERENSIS CERRAR_PATERENSIS ABRIR_LLAVES CERRAR_LLAVES



%token FIN_LINEA COMA
%token TIPO
%token END 0

%start sigma

%%

sigma: Z;

Z: ACCION ID _ES AMB PROC FIN_ACCION
		|error ID _ES AMB PROC FIN_ACCION
		|ACCION error _ES AMB PROC FIN_ACCION
		|ACCION ID error AMB PROC FIN_ACCION
		|ACCION ID _ES AMB PROC error
;

AMB: AMBIENTE 
	| AMBIENTE  DesAmb
	| error
;

DesAmb:		 ID DOSPUNTOIDES TIPO FIN_LINEA 
			|ID DOSPUNTOIDES TIPO FIN_LINEA  DesAmb
					|ID error TIPO FIN_LINEA 
					|ID error TIPO FIN_LINEA  DesAmb
					|ID DOSPUNTOIDES error FIN_LINEA 
					|ID DOSPUNTOIDES error FIN_LINEA  DesAmb
					|ID DOSPUNTOIDES TIPO error 
					|ID DOSPUNTOIDES TIPO error  DesAmb
					

;

PROC: PROCESO 
	| PROCESO DesProc
	| error
;

DesProc:
		 ID ASIGNACION ID_Asig
				|ID error ID_Asig
		|ID ASIGNACION ID_Asig DesProc
				|ID error ID_Asig DesProc
		|ESCRIBIR ABRIR_PATERENSIS CADENX Esc_Fac
		|ESCRIBIR ABRIR_PATERENSIS CADENX Esc_Fac DesProc
				|ESCRIBIR ABRIR_PATERENSIS error Esc_Fac
				|ESCRIBIR ABRIR_PATERENSIS error Esc_Fac DesProc
				|ESCRIBIR error CADENX Esc_Fac
				|ESCRIBIR error CADENX Esc_Fac DesProc
		|LEER ABRIR_PATERENSIS ID CERRAR_PATERENSIS FIN_LINEA
		|LEER ABRIR_PATERENSIS ID CERRAR_PATERENSIS FIN_LINEA DesProc
				|LEER error ID CERRAR_PATERENSIS FIN_LINEA
				|LEER error ID CERRAR_PATERENSIS FIN_LINEA DesProc
				|LEER ABRIR_PATERENSIS error CERRAR_PATERENSIS FIN_LINEA
				|LEER ABRIR_PATERENSIS error CERRAR_PATERENSIS FIN_LINEA DesProc
				|LEER ABRIR_PATERENSIS ID error FIN_LINEA
				|LEER ABRIR_PATERENSIS ID error FIN_LINEA DesProc
				|LEER ABRIR_PATERENSIS ID CERRAR_PATERENSIS error
				|LEER ABRIR_PATERENSIS ID CERRAR_PATERENSIS error DesProc
		|SI CONDICION ENTONCES DesProc FIN_SI
		|SI CONDICION ENTONCES DesProc FIN_SI DesProc
		|SI CONDICION ENTONCES DesProc SINO DesProc FIN_SI DesProc
		|SI CONDICION ENTONCES DesProc SINO DesProc FIN_SI
				|SI error ENTONCES DesProc FIN_SI
				|SI error ENTONCES DesProc FIN_SI DesProc
				|SI error ENTONCES DesProc SINO DesProc FIN_SI DesProc
				|SI error ENTONCES DesProc SINO DesProc FIN_SI
				|SI CONDICION error DesProc FIN_SI
				|SI CONDICION error DesProc FIN_SI DesProc
				|SI CONDICION error DesProc SINO DesProc FIN_SI DesProc
				|SI CONDICION error DesProc SINO DesProc FIN_SI
				|SI CONDICION ENTONCES DesProc error
				|SI CONDICION ENTONCES DesProc error DesProc FIN_SI DesProc
				|SI CONDICION ENTONCES DesProc error DesProc FIN_SI
				|SI CONDICION ENTONCES DesProc SINO DesProc error DesProc
				|SI CONDICION ENTONCES DesProc SINO DesProc error
		|MIENTRAS CONDICION HACER DesProc FIN_MIENTRAS
		|MIENTRAS CONDICION HACER DesProc FIN_MIENTRAS DesProc
				|MIENTRAS error HACER DesProc FIN_MIENTRAS
				|MIENTRAS error HACER DesProc FIN_MIENTRAS DesProc
				|MIENTRAS CONDICION error DesProc FIN_MIENTRAS
				|MIENTRAS CONDICION error DesProc FIN_MIENTRAS DesProc
				|MIENTRAS CONDICION HACER DesProc error
				|MIENTRAS CONDICION HACER DesProc error DesProc
		|REPETIR DesProc HASTA_QUE CONDICION
		|REPETIR DesProc HASTA_QUE CONDICION DesProc
				|REPETIR DesProc error CONDICION
				|REPETIR DesProc error CONDICION DesProc
				|REPETIR DesProc HASTA_QUE error
				|REPETIR DesProc HASTA_QUE error DesProc
		|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac COMA ENTEROO HACER DesProc FIN_PARA
		|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac COMA ENTEROO HACER DesProc FIN_PARA DesProc
				|PARA error ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac COMA ENTEROO HACER DesProc FIN_PARA
				|PARA error ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac COMA ENTEROO HACER DesProc FIN_PARA DesProc
				|PARA ABRIR_PATERENSIS error ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac COMA ENTEROO HACER DesProc FIN_PARA
				|PARA ABRIR_PATERENSIS error ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac COMA ENTEROO HACER DesProc FIN_PARA DesProc
				|PARA ABRIR_PATERENSIS ID error para_fac CERRAR_PATERENSIS HASTA para_fac COMA ENTEROO HACER DesProc FIN_PARA
				|PARA ABRIR_PATERENSIS ID error para_fac CERRAR_PATERENSIS HASTA para_fac COMA ENTEROO HACER DesProc FIN_PARA DesProc
				|PARA ABRIR_PATERENSIS ID ASIGNACION error CERRAR_PATERENSIS HASTA para_fac COMA ENTEROO HACER DesProc FIN_PARA
				|PARA ABRIR_PATERENSIS ID ASIGNACION error CERRAR_PATERENSIS HASTA para_fac COMA ENTEROO HACER DesProc FIN_PARA DesProc
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac error HASTA para_fac COMA ENTEROO HACER DesProc FIN_PARA
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac error HASTA para_fac COMA ENTEROO HACER DesProc FIN_PARA DesProc
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS error para_fac COMA ENTEROO HACER DesProc FIN_PARA
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS error para_fac COMA ENTEROO HACER DesProc FIN_PARA DesProc
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA error COMA ENTEROO HACER DesProc FIN_PARA
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA error COMA ENTEROO HACER DesProc FIN_PARA DesProc
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac error ENTEROO HACER DesProc FIN_PARA
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac error ENTEROO HACER DesProc FIN_PARA DesProc
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac COMA error HACER DesProc FIN_PARA
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac COMA error HACER DesProc FIN_PARA DesProc
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac COMA ENTEROO error DesProc FIN_PARA
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac COMA ENTEROO error DesProc FIN_PARA DesProc
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac COMA ENTEROO HACER DesProc error
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac COMA ENTEROO HACER DesProc error DesProc
		|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac COMA NEG ENTEROO HACER DesProc FIN_PARA
		|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac COMA NEG ENTEROO HACER DesProc FIN_PARA DesProc
				|PARA error ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac COMA NEG ENTEROO HACER DesProc FIN_PARA
				|PARA error ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac COMA NEG ENTEROO HACER DesProc FIN_PARA DesProc
				|PARA ABRIR_PATERENSIS error ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac COMA NEG ENTEROO HACER DesProc FIN_PARA
				|PARA ABRIR_PATERENSIS error ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac COMA NEG ENTEROO HACER DesProc FIN_PARA DesProc
				|PARA ABRIR_PATERENSIS ID error para_fac CERRAR_PATERENSIS HASTA para_fac COMA NEG ENTEROO HACER DesProc FIN_PARA
				|PARA ABRIR_PATERENSIS ID error para_fac CERRAR_PATERENSIS HASTA para_fac COMA NEG ENTEROO HACER DesProc FIN_PARA DesProc
				|PARA ABRIR_PATERENSIS ID ASIGNACION error CERRAR_PATERENSIS HASTA para_fac COMA NEG ENTEROO HACER DesProc FIN_PARA
				|PARA ABRIR_PATERENSIS ID ASIGNACION error CERRAR_PATERENSIS HASTA para_fac COMA NEG ENTEROO HACER DesProc FIN_PARA DesProc
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac error HASTA para_fac COMA NEG ENTEROO HACER DesProc FIN_PARA
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac error HASTA para_fac COMA NEG ENTEROO HACER DesProc FIN_PARA DesProc
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS error para_fac COMA NEG ENTEROO HACER DesProc FIN_PARA
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS error para_fac COMA NEG ENTEROO HACER DesProc FIN_PARA DesProc
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA error COMA NEG ENTEROO HACER DesProc FIN_PARA
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA error COMA NEG ENTEROO HACER DesProc FIN_PARA DesProc
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac error NEG ENTEROO HACER DesProc FIN_PARA
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac error NEG ENTEROO HACER DesProc FIN_PARA DesProc
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac COMA error ENTEROO HACER DesProc FIN_PARA
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac COMA error ENTEROO HACER DesProc FIN_PARA DesProc
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac COMA NEG ENTEROO error DesProc FIN_PARA
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac COMA NEG ENTEROO error DesProc FIN_PARA DesProc
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac COMA NEG ENTEROO HACER DesProc error
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac COMA NEG ENTEROO HACER DesProc error DesProc
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac COMA NEG error HACER DesProc FIN_PARA
				|PARA ABRIR_PATERENSIS ID ASIGNACION para_fac CERRAR_PATERENSIS HASTA para_fac COMA NEG error HACER DesProc FIN_PARA DesProc
		|SEGUN ABRIR_PATERENSIS ID CERRAR_PATERENSIS HACER DesSegun FIN_SEGUN
		|SEGUN ABRIR_PATERENSIS ID CERRAR_PATERENSIS HACER DesSegun FIN_SEGUN DesProc
				|SEGUN error ID CERRAR_PATERENSIS HACER DesSegun FIN_SEGUN
				|SEGUN error ID CERRAR_PATERENSIS HACER DesSegun FIN_SEGUN DesProc
				|SEGUN ABRIR_PATERENSIS error CERRAR_PATERENSIS HACER DesSegun FIN_SEGUN
				|SEGUN ABRIR_PATERENSIS error CERRAR_PATERENSIS HACER DesSegun FIN_SEGUN DesProc
				|SEGUN ABRIR_PATERENSIS ID error HACER DesSegun FIN_SEGUN
				|SEGUN ABRIR_PATERENSIS ID error HACER DesSegun FIN_SEGUN DesProc
				|SEGUN ABRIR_PATERENSIS ID CERRAR_PATERENSIS error DesSegun FIN_SEGUN
				|SEGUN ABRIR_PATERENSIS ID CERRAR_PATERENSIS error DesSegun FIN_SEGUN DesProc
				|SEGUN ABRIR_PATERENSIS ID CERRAR_PATERENSIS HACER DesSegun error
				|SEGUN ABRIR_PATERENSIS ID CERRAR_PATERENSIS HACER DesSegun error DesProc
		|SEGUN ABRIR_PATERENSIS ID CERRAR_PATERENSIS HACER DesSegun SINO DesSegun FIN_SEGUN
		|SEGUN ABRIR_PATERENSIS ID CERRAR_PATERENSIS HACER DesSegun SINO DesSegun FIN_SEGUN DesProc
				|SEGUN error ID CERRAR_PATERENSIS HACER DesSegun SINO DesSegun FIN_SEGUN
				|SEGUN error ID CERRAR_PATERENSIS HACER DesSegun SINO DesSegun FIN_SEGUN DesProc
				|SEGUN ABRIR_PATERENSIS error CERRAR_PATERENSIS HACER DesSegun SINO DesSegun FIN_SEGUN
				|SEGUN ABRIR_PATERENSIS error CERRAR_PATERENSIS HACER DesSegun SINO DesSegun FIN_SEGUN DesProc
				|SEGUN ABRIR_PATERENSIS ID error HACER DesSegun SINO DesSegun FIN_SEGUN
				|SEGUN ABRIR_PATERENSIS ID error HACER DesSegun SINO DesSegun FIN_SEGUN DesProc
				|SEGUN ABRIR_PATERENSIS ID CERRAR_PATERENSIS error DesSegun SINO DesSegun FIN_SEGUN
				|SEGUN ABRIR_PATERENSIS ID CERRAR_PATERENSIS error DesSegun SINO DesSegun FIN_SEGUN DesProc
				|SEGUN ABRIR_PATERENSIS ID CERRAR_PATERENSIS HACER DesSegun error DesSegun FIN_SEGUN
				|SEGUN ABRIR_PATERENSIS ID CERRAR_PATERENSIS HACER DesSegun error DesSegun FIN_SEGUN DesProc
				|SEGUN ABRIR_PATERENSIS ID CERRAR_PATERENSIS HACER DesSegun SINO DesSegun error
				|SEGUN ABRIR_PATERENSIS ID CERRAR_PATERENSIS HACER DesSegun SINO DesSegun error DesProc
;

DesSegun:	
		 ID DOSPUNTOIDES ABRIR_LLAVES DesProc CERRAR_LLAVES 
		|CADENX DOSPUNTOIDES ABRIR_LLAVES DesProc CERRAR_LLAVES
				|ID error ABRIR_LLAVES DesProc CERRAR_LLAVES 
				|CADENX error ABRIR_LLAVES DesProc CERRAR_LLAVES
				|ID DOSPUNTOIDES error DesProc CERRAR_LLAVES 
				|CADENX DOSPUNTOIDES error DesProc CERRAR_LLAVES
				|ID DOSPUNTOIDES ABRIR_LLAVES DesProc error 
				|CADENX DOSPUNTOIDES ABRIR_LLAVES DesProc error
		|ID DOSPUNTOIDES ABRIR_LLAVES DesProc CERRAR_LLAVES DesSegun
		|CADENX DOSPUNTOIDES ABRIR_LLAVES DesProc CERRAR_LLAVES DesSegun
				|ID error ABRIR_LLAVES DesProc CERRAR_LLAVES DesSegun
				|CADENX error ABRIR_LLAVES DesProc CERRAR_LLAVES DesSegun
				|ID DOSPUNTOIDES error DesProc CERRAR_LLAVES DesSegun
				|CADENX DOSPUNTOIDES error DesProc CERRAR_LLAVES DesSegun
				|ID DOSPUNTOIDES ABRIR_LLAVES DesProc error DesSegun
				|CADENX DOSPUNTOIDES ABRIR_LLAVES DesProc error DesSegun

;

CONDICION: 
		 ABRIR_PATERENSIS Cond_Fac OPREL Cond_Fac CERRAR_PATERENSIS
				|ABRIR_PATERENSIS Cond_Fac error Cond_Fac CERRAR_PATERENSIS
				|ABRIR_PATERENSIS Cond_Fac OPREL Cond_Fac error
		|ABRIR_PATERENSIS Cond_Fac OPREL Cond_Fac CERRAR_PATERENSIS OPLOG CONDICION
				|ABRIR_PATERENSIS Cond_Fac error Cond_Fac CERRAR_PATERENSIS OPLOG CONDICION
				|ABRIR_PATERENSIS Cond_Fac OPREL Cond_Fac error OPLOG CONDICION
				|ABRIR_PATERENSIS Cond_Fac OPREL Cond_Fac CERRAR_PATERENSIS OPLOG error
		|ABRIR_PATERENSIS CONDICION CERRAR_PATERENSIS			/* Permite (((((CONDICION))))) */
				|ABRIR_PATERENSIS error CERRAR_PATERENSIS
				|ABRIR_PATERENSIS CONDICION error
;

Cond_Fac: NUM
		 |ID
		 |oper_mat
		 |error
		 |CADENX
;

Esc_Fac:								/*Factorizacion por izquierda de escribir*/
			 CERRAR_PATERENSIS FIN_LINEA					
			|MORE CERRAR_PATERENSIS FIN_LINEA
					|error FIN_LINEA
					|error CERRAR_PATERENSIS FIN_LINEA
					|MORE error FIN_LINEA
					|CERRAR_PATERENSIS error					
					|MORE CERRAR_PATERENSIS error
;

MORE:						/*Posibilidad de Escribir("asdasda",id,id2,id3,idn,"asdsadasds");      */
	 COMA ID
	|COMA ID MORE
	|COMA ID COMA MOREE

;
MOREE: CADENX
	  |CADENX MORE
			  |error
			  |error MORE
;

ID_Asig:								/*Factorizacion por izquierda de "id:=" */
		 ID FIN_LINEA
		| CADENX FIN_LINEA
		|NUM FIN_LINEA
		|oper_mat FIN_LINEA
		|ID error
		| CADENX error
		|NUM error
		|oper_mat error
		| error FIN_LINEA
;

oper_mat: 
		 oper_fac OPARIT oper_fac
		|oper_fac OPARIT oper_mat
		|oper_fac NEG oper_fac
		|oper_fac NEG oper_mat
		|NEG oper_fac
		|ABRIR_PATERENSIS oper_mat CERRAR_PATERENSIS
;

NUM: ENTEROO | REALL;

para_fac:NUM | ID;

oper_fac:
		 NUM
		|ID
		|error
;

%%
int yyerror(char *s) {
	s = "\t\t\t\t\t\t\t\t\tError en la linea: ";
	printf("\n%s%d\n",s,yylineno);
}
int main(int argc, char *argv[]) {
	int control;
	printf("Prueba 1\n");
	if (argc == 2){
		yyin = fopen (argv[1],"r");
		control = yyparse();
	}else{
		printf("Se inicio el modo interactivo.\n");
		printf("Para finalizar precione Ctrl+Z, una vez introducido fin_accion\n");
		yyin = stdin;
		yyparse();
	}
	if (control == 0){
		printf("\nTodo bien, todo correcto.\n");
	}
	return 0;
}