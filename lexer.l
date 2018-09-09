%{
#include "y.tab.h"
%}


AUTO		"auto"
ENUM		"enum"
RESTRICT	"restrict"
UNSIGNED	"unsigned"
BREAK		"break"
EXTERN		"extern"
RETURN		"return"
VOID		"void"
CASE		"case"
FLOAT		"float"
SHORT		"short"
VOLATILE	"volatile"
CHAR		"char"
FOR			"for"
SIGNED		"signed"
WHILE		"while"
CONST		"const"
GOTO		"goto"
SIZEOF		"sizeof"
BOOL		"_Bool"
CONTINUE	"continue"
IF			"if"
STATIC		"static"
COMPLEX		"_Complex"
DEFAULT		"default"
INLINE		"inline"
STRUCT		"struct"
IMAGINARY	"_Imaginary"
DO			"do"
INT			"int"
SWITCH		"switch"
DOUBLE		"double"
LONG		"long"
TYPEDEF		"typedef"
ELSE		"else"
REGISTER	"register"
UNION		"union"
ID			[a-zA-Z_][a-zA-Z_0-9]*
INTCONST	0|[1-9][0-9]*
FLOATCONST	((([0-9]+\.)|(([0-9]+)?\.[0-9]+))([eE][\+\-]?[0-9]+)?)|([0-9]+[eE][\+\-]?[0-9]+)
ENUMCONST	[a-zA-Z_][a-zA-Z_0-9]*
ESCSEQ					[\\][']|[\\]["]|[\\][?]|[\\][\\]|[\\][a]|[\\][b]|[\\][f]|[\\][n]|[\\][r]|[\\][t]|[\\][v]
CCHAR					[^'\n\\]|{ESCSEQ}
CCHARSEQ				{CCHAR}+
CHARCONST				[']{CCHARSEQ}[']
SCHAR					[^"\n\\]|{ESCSEQ}
SCHARSEQ				{SCHAR}*
STRING 			["]{SCHARSEQ}["]
MULTICOMM	\/\*[^\*]*[\*]+([^\*\/][^\*]*[\*]+)*\/
SINGLECOMM	\/\/[^\n]*\n

%%
{AUTO}			{return AUTO;}
{ENUM}			{return ENUM;}
{RESTRICT}			{return RESTRICT;}
{UNSIGNED}			{return UNSIGNED;}
{BREAK}			{return BREAK;}
{EXTERN}			{return EXTERN;}
{RETURN}			{return RETURN;}
{VOID}			{return VOID;}
{CASE}			{return CASE;}
{FLOAT}			{return FLOAT;}
{SHORT}			{return SHORT;}
{VOLATILE}			{return VOLATILE;}
{CHAR}			{return CHAR;}
{FOR}			{return FOR;}
{SIGNED}			{return SIGNED;}
{WHILE}			{return WHILE;}
{CONST}			{return CONST;}
{GOTO}			{return GOTO;}
{SIZEOF}			{return SIZEOF;}
{BOOL}			{return BOOL;}
{CONTINUE}			{return CONTINUE;}
{IF}			{return IF;}
{STATIC}			{return STATIC;}
{COMPLEX}			{return COMPLEX;}
{DEFAULT}			{return DEFAULT;}
{INLINE}			{return INLINE;}
{STRUCT}			{return STRUCT;}
{IMAGINARY}			{return IMAGINARY;}
{DO}			{return DO;}
{INT}			{return INT;}
{SWITCH}			{return SWITCH;}
{DOUBLE}			{return DOUBLE;}
{LONG}			{return LONG;}
{TYPEDEF}			{return TYPEDEF;}
{ELSE}			{return ELSE;}
{REGISTER}			{return REGISTER;}
{UNION}			{return UNION;}
{ID}			{return ID;}
{INTCONST}			{return INTCONST;}
{FLOATCONST}			{return FLOATCONST;}
{ENUMCONST}			{return ENUMCONST;}
{CHARCONST}			{return CHARCONST;}
{STRING}			{return STRING;}
{MULTICOMM}			{}
{SINGLECOMM}			{}
"["			{return BRACKET_OPEN;}
"]"			{return BRACKET_CLOSE;}
"("			{return PARENTHESIS_OPEN;}
")"			{return PARENTHESIS_CLOSE;}
"{"			{return BRACES_OPEN;}
"}"			{return BRACES_CLOSE;}
"."			{return DOT;}
"->"			{return ARROW;}
"++"			{return INCREMENT;}
"--"			{return DECREMENT;}
"&"			{return BITWISE_AND;}
"*"			{return MULTIPLY;}
"+"			{return PLUS;}
"-"			{return MINUS;}
"~"			{return TILDA;}
"!"			{return NEGATION;}
"/"			{return FORWARD_SLASH;}
"%"			{return MODULUS;}
"<<"			{return LEFT_SHIFT;}
">>"			{return RIGHT_SHIFT;}
"<"			{return LESS_THAN;}
">"			{return GREATER_THAN;}
"<="			{return LESS_THAN_EQUAL;}
">="			{return GREATER_THAN_EQUAL;}
"=="			{return EQUAL;}
"!="			{return NOT_EQUAL;}
"^"			{return BITWISE_XOR;}
"|"			{return BITWISE_OR;}
"&&"			{return LOGICAL_AND;}
"||"			{return LOGICAL_OR;}
"?"			{return CONDITIONAL;}
":"			{return COLON;}
";"			{return SEMICOLON;}
"..."			{return ELLIPSIS;}
"="			{return ASSIGN;}
"*="			{return SHORTHAND_MULTIPLY;}
"/="			{return SHORTHAND_DIVIDE;}
"%="			{return SHORTHAND_MODULUS;}
"+="			{return SHORTHAND_PLUS;}
"-="			{return SHORTHAND_MINUS;}
"<<="			{return SHORTHAND_LEFT_SHIFT;}
">>="			{return SHORTHAND_RIGHT_SHIFT;}
"&="			{return SHORTHAND_BITWISE_AND;}
"^="			{return SHORTHAND_XOR;}
"|="			{return SHORTHAND_OR;}
","			{return COMMA;}
"#"			{return HASH;}
[ \t\n]		{}
%%
