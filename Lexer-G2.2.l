%{
#include <stdio.h>
#include <stdlib.h>
%}

%option noyywrap
%option caseless


html					(<html[\ ]lang=(\"([a-z]{2})\")>)
metanc 					(<meta[\ ](name=(\"[a-zA-Z0-9]*\"))?(content=(\"[a-zA-Z0-9]*\"))?>)
atg 					((class=\"([a-z]{2})\")?(id=\"([a-z]{2})\")?)
atype 					(type=("[a-zA-Z0-9]*")>)
atvalue 				(value=("[0-9]*")>)
athref 	 				(href=((\"(http(s)?|ftp(s)?):\/\/(w{3}.)?([0-9]*[a-zA-Z]*[0-9]*.[a-zA-Z]{2,3})?(\:[0-9]+)?(\/[a-zA-Z0-9]*(.[a-zA-Z]+)?)*(\#[a-zA-Z0-9]+)?\")))
atarget					(target=(\_blank|\_parent|\_self|\_top))
atalt					(alt=("[a-zA-Z0-9]*"))
atwh					((width=[0-9]+(\.[0-9]+)?(\%)?)?(height=[0-9]+(\.[0-9]+)?(\%)?)?)
atb						(border=([0-9]+))
atc						(<caption>)
cierreatc				(<\/caption>)
atsrc 					(src=((\"((http(s)?|ftp(s)?):\/\/)?(w{3}.)?([0-9]*[a-zA-Z]*[0-9]*.[a-zA-Z]{2,3})?(\:[0-9]+)?(\/[a-zA-Z0-9]*(.[a-zA-Z]+)?)*(\#[a-zA-Z0-9]+)?\")))

metacharset				(<meta[\ ]charset=(\"(UTF-8)\")>)
header					(<h[1-6]{1}>)
cheader					(<\/h[1-6]{1}>)

an						[a-zA-Z]+|\=|\"|[\?]|\¿|\!|\¡|\.|\,|\:|\;|[\*]|\/|\(|\)|\[|\]|\{|\}|\+|\_|\-|\^|\#|\%|\&|\-|[\t]*
num 					[0-9]+(\.[0-9]+)?
url						((http(s)?|ftp(s)?):\/\/(w{3}.)?([0-9]*[a-zA-Z]*[0-9]*.[a-zA-Z]{2,3})?(\:[0-9]+)?(\/[a-zA-Z0-9]*(.[a-zA-Z]+)?)*(\#[a-zA-Z0-9]+)?)
spc						[\ ]*


%%
"<!doctype html>"				{printf ("Se encontro etiqueta tipo de html\n");}
{html}							{printf ("Se encontro apertura de html\n");}
"</html>"						{printf ("Se encontro cierre de html\n");}
"<head>"						{printf ("Se encontro apertura de etiqueta head\n");}
"</head>"						{printf ("Se encontro cierre de etiqueta de head\n");}			
"<body>"						{printf ("Se encontro apertura de etiqueta body\n");}
"</body>"						{printf ("Se encontro cierre de etiqueta body\n");}
{metacharset}					{printf ("Se encontro etiqueta meta charset\n");}
{metanc}						{printf ("Se encontro apertura de etiqueta meta\n");}
"<title>"						{printf ("Se encontro apertura de title\n");}
"</title>"						{printf ("Se encontro cierre de title\n");}
"<section>"						{printf ("Se encontro apertura de section\n");}
"</section>"					{printf ("Se encontro cierre de etiqueta section\n");}
"<div>"							{printf ("Se encontro apertura de etiqueta div\n");}
"</div>"						{printf ("Se encontro cierre de div\n");}
"<p>"							{printf ("Se encontro apertura de parrafo\n");}
"</p>"							{printf ("Se encontro cierre de etiqueta parrafo\n");}
{header}						{printf ("Se encontro apertura de header\n");}
{cheader}						{printf ("Se encontro cierre de etiqueta header\n");}
"<br>"	 						{printf ("Se encontro apertura de etiqueta br\n");}
"</br>"							{printf ("Se encontro cierre de br\n");}
"<hr>"				 			{printf ("Se encontro apertura de hr\n");}
"</hr>"							{printf ("Se encontro cierre de hr\n");}
"<strong>" 					 	{printf ("Se encontro apertura de strong\n");}
"</strong>"						{printf ("Se encontro cierre de strong\n");}
"<em>"							{printf ("Se encontro apertura de etiqueta em\n");}
"</em>"							{printf ("Se encontro cierre de etiqueta em\n");}
"<mark>" 						{printf ("Se encontro apertura de mark\n");}
"</mark>" 						{printf ("Se encotro cierre de mark\n");}
"<ol>"							{printf ("Se encontro apertura de etiqueta ol\n");}
"</ol>"							{printf ("Se encontro cierre de etiqueta ol\n");}
"<ul>"							{printf ("Se encontro apertura de etiqueta ul\n");}
"</ul>"							{printf ("Se encontro cierre de etiqueta ul\n");}
"<li>" 							{printf ("Se encontro apertura de etiqueta li\n");}
"</li>"							{printf ("Se encontro apertura de etiqueta li\n");}
"<table>"						{printf ("Se encontro apertura de etiqueta tabla\n");}
"</table>"						{printf ("Se encontro cierre de tabla\n");}
"<thead>" 						{printf ("Se encontro apertura de etiqueta thead\n");}
"</thead>"						{printf ("Se encontro cierre de etiqueta thead\n");}
"<tbody>"						{printf ("Se encontro apertura de etiqueta tbody\n");}
"</tbody>"						{printf ("Se encontro cierre de etiqueta tbody\n");}
"<tfoot>"						{printf ("Se encontro apertura de etiqueta tfoot\n");}
"</tfoot>"						{printf ("Se encontro cierre de etiqueta tfoot\n");}
"<tr>"							{printf ("Se encontro apertura de etiqueta de tr\n");}
"</tr>"							{printf ("Se encontro cierre de tr\n");}
"<td>"							{printf ("Se encontro apertura de etiqueta de td\n");}
"</td>" 						{printf ("Se encontro cierre de etiqueta td\n");}
"<th>"							{printf ("Se encontro apertura de etiqueta th\n");}
"</th>"		 					{printf ("Se encontro cierre de etiqueta th\n");}
"<a>"							{printf ("Se apertura etiqueta a\n");}	
"</a>"							{printf ("Se encontro cierre de etiqueta a\n");}
"<img>" 						{printf ("Se encontro etiqueta img\n");}


{atg} 							{printf ("Se encontro atributo global\n");}
{atype}							{printf ("Se encontro atributo type\n");}
{atvalue}						{printf ("Se encontro atributo value\n");}
{athref}						{printf ("Se encontro atributo href\n");}
{atarget}						{printf ("Se encontro atributo target\n");}
{atalt}							{printf ("Se encontro atributo alt\n");}
{atwh}							{printf ("Se encontro atributo width/height\n");}
{atb} 							{printf ("Se encontro atributo border\n");}
{atc}							{printf ("Se encontro apertura de atributo caption\n");}
{cierreatc}						{printf ("Se encontro cierre de atributo caption\n");}
{atsrc}							{printf ("Se encontro atributo src\n");}

{url}							{}
{an}							{}
{num}							{}
{spc}							{}
.								{printf ("ERROR");}
%%
int main(int argc, char * argv[]) 
{
	if (argc == 2 )
	{
		yyin = fopen(argv[1],"rt");
		if (yyin == NULL) 
	 	{
			printf("ERROR NO SE PUEDE LEER EL ARCHIVO", argv[1]);
			return(0);
	 	}
	}
	yylex();
	fclose(yyin);
	return(0);
}
