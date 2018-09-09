%{
#include <stdio.h>
#include <string.h>
extern int yylex();
void yyerror(char *s);
%}

%token AUTO
%token ENUM
%token RESTRICT
%token UNSIGNED
%token BREAK
%token EXTERN
%token RETURN
%token VOID
%token CASE
%token FLOAT
%token SHORT
%token VOLATILE
%token CHAR
%token FOR
%token SIGNED
%token WHILE
%token CONST
%token GOTO
%token SIZEOF
%token BOOL
%token CONTINUE
%token IF
%token STATIC
%token COMPLEX
%token DEFAULT
%token INLINE
%token STRUCT
%token IMAGINARY
%token DO
%token INT
%token SWITCH
%token DOUBLE
%token LONG
%token TYPEDEF
%token ELSE
%token REGISTER
%token UNION
%token ID
%token INTCONST
%token FLOATCONST
%token ENUMCONST
%token CHARCONST
%token STRING
%token MULTICOMM
%token SINGLECOMM
%token BRACKET_OPEN
%token BRACKET_CLOSE
%token PARENTHESIS_OPEN
%token PARENTHESIS_CLOSE
%token BRACES_OPEN
%token BRACES_CLOSE
%token DOT
%token ARROW
%token INCREMENT
%token DECREMENT
%token BITWISE_AND
%token MULTIPLY
%token PLUS
%token MINUS
%token TILDA
%token NEGATION
%token FORWARD_SLASH
%token MODULUS
%token LEFT_SHIFT
%token RIGHT_SHIFT
%token LESS_THAN
%token GREATER_THAN
%token LESS_THAN_EQUAL
%token GREATER_THAN_EQUAL
%token EQUAL
%token NOT_EQUAL
%token BITWISE_XOR
%token BITWISE_OR
%token LOGICAL_AND
%token LOGICAL_OR
%token CONDITIONAL
%token COLON
%token SEMICOLON
%token ELLIPSIS
%token ASSIGN
%token SHORTHAND_MULTIPLY
%token SHORTHAND_DIVIDE
%token SHORTHAND_MODULUS
%token SHORTHAND_PLUS
%token SHORTHAND_MINUS
%token SHORTHAND_LEFT_SHIFT
%token SHORTHAND_RIGHT_SHIFT
%token SHORTHAND_BITWISE_AND
%token SHORTHAND_XOR
%token SHORTHAND_OR
%token COMMA
%token HASH		

%start translation_unit			

%%

primary_expression
	: ID {printf("primary_expression -> ID\n");}
	| constant {printf("primary_expression -> constant\n");}
	| STRING {printf("primary_expression -> STRING\n");}
	| PARENTHESIS_OPEN expression PARENTHESIS_CLOSE
	{printf("primary_expression -> ( expression )\n");}
	;

constant
	:INTCONST {printf("constant -> INTCONST\n");}
	|FLOATCONST {printf("constant -> FLOATCONST\n");}
	|ENUMCONST {printf("constant -> ENUMCONST\n");}
	|CHARCONST {printf("constant -> CHARCONST\n");}
	;

postfix_expression
	:primary_expression {printf("postfix_expression -> primary_expression\n");}
	|postfix_expression BRACKET_OPEN expression BRACKET_CLOSE
	 {printf("postfix_expression -> postfix_expression [ expression ]\n");}
	|postfix_expression PARENTHESIS_OPEN argument_expression_list_opt PARENTHESIS_CLOSE
	 {printf("postfix_expression -> postfix_expression ( argument_expression_list_opt )\n");}
	|postfix_expression DOT ID
	 {printf("postfix_expression -> postfix_expression.ID\n");}
	|postfix_expression ARROW ID
	 {printf("postfix_expression -> postfix_expression -> ID\n");}
	|postfix_expression INCREMENT
	 {printf("postfix_expression -> postfix_expression++\n");}
	|postfix_expression DECREMENT
	 {printf("postfix_expression -> postfix_expression\n");}
	|PARENTHESIS_OPEN type_name PARENTHESIS_CLOSE BRACES_OPEN initializer_list BRACES_CLOSE
	 {printf("postfix_expression -> (type_name) {initializer_list}\n");}
	|PARENTHESIS_OPEN type_name PARENTHESIS_CLOSE BRACES_OPEN initializer_list COMMA BRACES_CLOSE
	{printf("postfix_expression -> (type_name) {initializer_list,}\n");}
	;

argument_expression_list
	:assignment_expression
	{printf("argument_expression_list -> assignment_expression\n");}
	|argument_expression_list COMMA assignment_expression
	{printf("argument_expression_list -> argument_expression_list, assignment_expression\n");}
	;

argument_expression_list_opt
	:argument_expression_list
	{printf("argument_expression_list_opt -> argument_expression_list\n");}
	|
	;

unary_expression
	:postfix_expression
	{printf("unary_expression -> postfix_expression\n");}
	|INCREMENT unary_expression
	{printf("unary_expression -> ++unary_expression\n");}
	|DECREMENT unary_expression
	{printf("unary_expression -> --unary_expression\n");}
	|unary_operator cast_expression
	{printf("unary_expression -> unary_operator cast_expression\n");}
	|SIZEOF unary_expression
	{printf("unary_expression -> SIZEOF unary_expression\n");}
	|SIZEOF PARENTHESIS_OPEN type_name PARENTHESIS_CLOSE
	{printf("unary_expression -> SIZEOF(type_name)\n");}
	;

unary_operator
	:BITWISE_AND
	{printf("unary_operator -> &\n");}
	|MULTIPLY
	{printf("unary_operator -> *\n");}
	|PLUS
	{printf("unary_operator -> +\n");}
	|MINUS
	{printf("unary_operator -> -\n");}
	|TILDA
	{printf("unary_operator -> ~\n");}
	|NEGATION
	{printf("unary_operator -> !\n");}
	;

cast_expression
	:unary_expression
	|PARENTHESIS_OPEN type_name PARENTHESIS_CLOSE cast_expression
	{printf("cast_expression\n");}
	;

multiplicative_expression
	:cast_expression
	|multiplicative_expression MULTIPLY cast_expression
	|multiplicative_expression FORWARD_SLASH cast_expression
	|multiplicative_expression MODULUS cast_expression
	{printf("multiplicative_expression\n");}
	;

additive_expression
	:multiplicative_expression
	|additive_expression PLUS multiplicative_expression
	|additive_expression MINUS multiplicative_expression
	{printf("additive_expression\n");}
	;

shift_expression
	:additive_expression
	{printf("shift_expression -> additive_expression\n");}
	|shift_expression LEFT_SHIFT additive_expression
	{printf("shift_expression -> shift_expression << additive_expression\n");}
	|shift_expression RIGHT_SHIFT additive_expression
	{printf("shift_expression -> shift_expression >> additive_expression\n");}
	;

relational_expression
	:shift_expression
	|relational_expression LESS_THAN shift_expression
	{printf("relational_expression -> relational_expression < shift_expression\n");}
	|relational_expression GREATER_THAN shift_expression
	{printf("relational_expression -> relational_expression > shift_expression\n");}
	|relational_expression LESS_THAN_EQUAL shift_expression
	{printf("relational_expression -> relational_expression <= shift_expression\n");}
	|relational_expression GREATER_THAN_EQUAL shift_expression
	{printf("relational_expression -> relational_expression >= shift_expression\n");}
	;

equality_expression
	:relational_expression
	{printf("equality_expression -> relational_expression\n");}
	|equality_expression EQUAL relational_expression
	{printf("equality_expression -> equality_expression == relational_expression\n");}
	|equality_expression NOT_EQUAL relational_expression
	{printf("equality_expression -> equality_expression != relational_expression\n");}
	;

AND_expression
	:equality_expression
	{printf("AND_expression -> equality_expression\n");}
	|AND_expression BITWISE_AND equality_expression
	{printf("AND_expression -> AND_expression & equality_expression\n");}
	;

exclusive_OR_expression
	:AND_expression
	{printf("exclusive_OR_expression -> AND_expression\n");}
	|exclusive_OR_expression BITWISE_XOR AND_expression
	{printf("exclusive_OR_expression -> exclusive_OR_expression ^ AND_expression\n");}
	;

inclusive_OR_expression
	:exclusive_OR_expression
	{printf("inclusive_OR_expression -> exclusive_OR_expression\n");}
	|inclusive_OR_expression BITWISE_OR exclusive_OR_expression
	{printf("inclusive_OR_expression -> inclusive_OR_expression | exclusive_OR_expression\n");}
	;

logical_AND_expression
	:inclusive_OR_expression
	{printf("logical_and_expression -> inclusive_OR_expression\n");}
	|logical_AND_expression LOGICAL_AND inclusive_OR_expression
	{printf("logical_and_expression -> logical_AND_expression && inclusive_OR_expression\n");}
	;

logical_OR_expression
	:logical_AND_expression
	{printf("logical_OR_expression -> logical_AND_expression\n");}
	|logical_OR_expression LOGICAL_OR logical_AND_expression
	{printf("logical_OR_expression -> logical_OR_expression || logical_AND_expression\n");}
	;

conditional_expression
	:logical_OR_expression
	{printf("conditional_expression -> logical_OR_expression\n");}
	|logical_OR_expression CONDITIONAL expression COLON conditional_expression
	{printf("conditional_expression -> logical_OR_expression ? expression : conditional_expression\n");}
	;

assignment_expression
	:conditional_expression
	{printf("assignment_expression -> conditional_expression\n");}
	|unary_expression assignment_operator assignment_expression
	{printf("assignment_expression -> unary_expression assignment_operator assignment_expression\n");}
	;

assignment_operator 
	:ASSIGN
	{printf("assignment_operator -> =\n");}
	|SHORTHAND_MULTIPLY
	{printf("assignment_operator -> *=\n");}
	|SHORTHAND_DIVIDE
	{printf("assignment_operator -> /=\n");}
	|SHORTHAND_MODULUS
	{printf("assignment_operator -> %=\n");}
	|SHORTHAND_PLUS
	{printf("assignment_operator -> +=\n");}
	|SHORTHAND_MINUS
	{printf("assignment_operator -> -=\n");}
	|SHORTHAND_LEFT_SHIFT
	{printf("assignment_operator -> <<=\n");}
	|SHORTHAND_RIGHT_SHIFT
	{printf("assignment_operator -> >>=\n");}
	|SHORTHAND_BITWISE_AND
	{printf("assignment_operator -> &=\n");}
	|SHORTHAND_XOR
	{printf("assignment_operator -> ^=\n");}
	|SHORTHAND_OR
	{printf("assignment_operator -> |=\n");}
	;

expression
	:assignment_expression
	{printf("expression -> assignment_expression\n");}
	|expression COMMA assignment_expression
	{printf("expression -> expression, assignment_expression\n");}
	;

constant_expression
	:conditional_expression
	{printf("constant_expression -> conditional_expression\n");}
	;

declaration
	:declaration_specifiers init_declarator_list_opt SEMICOLON
	{printf("declaration -> declaration_specifiers init_declarator_list_opt;\n");}
	;

declaration_specifiers
	:storage_class_specifier declaration_specifiers_opt
	{printf("declaration_specifiers -> storage_class_specifier declaration_specifiers_opt\n");}
	|type_specifier declaration_specifiers_opt
	{printf("declaration_specifiers -> type_specifier declaration_specifiers_opt\n");}
	|type_qualifier declaration_specifiers_opt
	{printf("declaration_specifiers -> type_qualifier declaration_specifiers_opt\n");}
	|function_specifier declaration_specifiers_opt
	{printf("declaration_specifiers -> function_specifier declaration_specifiers_opt\n");}
	;

declaration_specifiers_opt
	:declaration_specifiers
	{printf("declaration_specifiers_opt -> declaration_specifiers\n");}
	|
	;


init_declarator_list
	:init_declarator
	{printf("init_declarator_list -> init_declarator\n");}
	|init_declarator_list COMMA init_declarator
	{printf("init_declarator_list -> init_declarator_list, init_declarator\n");}
	;

init_declarator_list_opt
	:init_declarator_list
	{printf("init_declarator_list_opt -> init_declarator_list\n");}
	|;

init_declarator
	:declarator
	{printf("init_declarator -> declarator\n");}
	|declarator ASSIGN initializer
	{printf("init_declarator -> declarator = initializer\n");}
	;


storage_class_specifier
	: EXTERN
	{printf("storage_class_specifier -> EXTERN\n");}
	| STATIC
	{printf("storage_class_specifier -> STATIC\n");}
	| AUTO
	{printf("storage_class_specifier -> AUTO\n");}
	| REGISTER
	{printf("storage_class_specifier -> REGISTER\n");}
	;

type_specifier
	: VOID
	{printf("type_specifier -> VOID\n");}
	| CHAR
	{printf("type_specifier -> CHAR\n");}
	| SHORT
	{printf("type_specifier -> SHORT\n");}
	| INT
	{printf("type_specifier -> INT\n");}
	| LONG
	{printf("type_specifier -> LONG\n");}
	| FLOAT
	{printf("type_specifier -> FLOAT\n");}
	| DOUBLE
	{printf("type_specifier -> DOUBLE\n");}
	| SIGNED
	{printf("type_specifier -> SIGNED\n");}
	| UNSIGNED
	{printf("type_specifier -> UNSIGNED\n");}
	| BOOL
	{printf("type_specifier -> BOOL\n");}
	| COMPLEX
	{printf("type_specifier -> COMPLEX\n");}
	| IMAGINARY
	{printf("type_specifier -> IMAGINARY\n");}
	| enum_specifier
	{printf("type_specifier -> enum_specifier\n");}
	;

specifier_qualifier_list
	: type_specifier specifier_qualifier_list_opt
	{printf("specifier_qualifier_list -> type_specifier specifier_qualifier_list_opt\n");}
	| type_qualifier specifier_qualifier_list_opt
	{printf("specifier_qualifier_list -> type_qualifier specifier_qualifier_list_opt\n");}
	;

specifier_qualifier_list_opt
	:specifier_qualifier_list
	{printf("specifier_qualifier_list_opt -> specifier_qualifier_list\n");}
	|
	;

enum_specifier
	:ENUM identifier_opt BRACES_OPEN enumerator_list BRACES_CLOSE
	{printf("enum_specifier -> ENUM identifier_opt { enumerator_list }\n");}
	|ENUM identifier_opt BRACES_OPEN enumerator_list COMMA BRACES_CLOSE
	{printf("enum_specifier -> ENUM identifier_opt { enumerator_list, }\n");}
	|ENUM ID
	{printf("enum_specifier -> ENUM ID\n");}
	;

identifier_opt
	:ID
	{printf("identifier_opt -> ID\n");}
	|
	;

enumerator_list
	:enumerator
	{printf("enumerator_list -> enumerator\n");}
	|enumerator_list COMMA enumerator
	{printf("enumerator_list -> enumerator_list, enumerator\n");}
	;

enumerator
	:ID
	{printf("enumerator -> ID\n");}
	|ID ASSIGN constant_expression
	{printf("enumerator -> ID = constant_expression\n");}
	;

type_qualifier
	:CONST
	{printf("type_qualifier -> CONST\n");}
	|RESTRICT
	{printf("type_qualifier -> RESTRICT\n");}
	|VOLATILE
	{printf("type_qualifier -> VOLATILE\n");}
	;

function_specifier
	:INLINE
	{printf("function_specifier -> INLINE\n");}
	;

declarator
	:pointer_opt direct_declarator
	{printf("declarator -> pointer_opt direct_declarator\n");}
	;

pointer_opt 
	:pointer
	{printf("pointer_opt -> pointer\n");}
	|
	;

direct_declarator
	:ID
	{printf("direct_declarator -> ID\n");}
	|PARENTHESIS_OPEN declarator PARENTHESIS_CLOSE
	{printf("direct_declarator -> ( declarator )\n");}
	|direct_declarator BRACKET_OPEN type_qualifier_list_opt assignment_expression_opt BRACKET_CLOSE
	{printf("direct_declarator -> [ type_qualifier_list_opt assignment_expression_opt ]\n");}
	| direct_declarator BRACKET_OPEN STATIC type_qualifier_list_opt assignment_expression BRACKET_CLOSE
	{printf("direct_declarator -> [ STATIC type_qualifier_list_opt assignment_expression ]\n");}
	| direct_declarator BRACKET_OPEN type_qualifier_list STATIC assignment_expression BRACKET_CLOSE
	{printf("direct_declarator -> [ type_qualifier_list STATIC assignment_expression ]\n");}
	| direct_declarator BRACKET_OPEN type_qualifier_list_opt MULTIPLY BRACKET_CLOSE
	{printf("direct_declarator -> [ type_qualifier_list_opt * ]\n");}
	| direct_declarator PARENTHESIS_OPEN parameter_type_list PARENTHESIS_CLOSE
	{printf("direct_declarator -> ( parameter_list_opt )\n");}
	| direct_declarator PARENTHESIS_OPEN identifier_list_opt PARENTHESIS_CLOSE
	{printf("direct_declarator -> ( identifier_list_opt )\n");}
	;

type_qualifier_list_opt
	:type_qualifier_list
	{printf("type_qualifier_list_opt -> type_qualifier_list\n");}
	|
	;

assignment_expression_opt
	:assignment_expression
	{printf("assignment_expression_opt -> assignment_expression\n");}
	|
	;

pointer
	:MULTIPLY type_qualifier_list_opt
	{printf("pointer -> * type_qualifier_list_opt\n");}
	|MULTIPLY type_qualifier_list_opt pointer
	{printf("pointer -> * type_qualifier_list_opt pointer\n");}
	;

type_qualifier_list
	:type_qualifier
	{printf("type_qualifier_list -> type_qualifier\n");}
	|type_qualifier_list type_qualifier
	{printf("type_qualifier_list -> type_qualifier_list type_qualifier\n");}
	;

parameter_type_list
	:parameter_list
	{printf("parameter_type_list -> parameter_list\n");}
	|parameter_list COMMA ELLIPSIS
	{printf("parameter_type_list -> parameter_list, ...\n");}
	;

parameter_list
	:parameter_declaration
	{printf("parameter_list -> parameter_declaration\n");}
	|parameter_list COMMA parameter_declaration
	{printf("parameter_list -> parameter_list, parameter_declaration\n");}
	;

parameter_declaration
	:declaration_specifiers declarator
	{printf("parameter_declaration -> declaration_specifiers declarator\n");}
	|declaration_specifiers
	{printf("parameter_declaration -> declaration_specifiers\n");}
	;

identifier_list
	:ID
	{printf("identifier_list -> ID\n");}
	|identifier_list COMMA ID
	{printf("identifier_list -> identifier_list, ID\n");}
	;

identifier_list_opt
	:identifier_list
	{printf("identifier_list_opt -> identifier_list\n");}
	|
	;

type_name
	:specifier_qualifier_list
	{printf("type_name -> specifier_qualifier_list\n");}
	;

initializer
	:assignment_expression
	{printf("initializer -> assignment_expression\n");}
	|BRACES_OPEN initializer_list BRACES_CLOSE
	{printf("initializer -> { initializer_list }\n");}
	|BRACES_OPEN initializer_list COMMA BRACES_CLOSE
	{printf("initializer -> { initializer_list, }\n");}
	;

initializer_list
	:designation_opt initializer
	{printf("initializer_list -> designation_opt initializer\n");}
	|initializer_list COMMA designation_opt initializer
	{printf("initializer_list -> initializer_list, designation_opt initializer\n");}
	;

designation_opt
	:designation
	{printf("designation_opt -> designation\n");}
	|
	;

designation
	:designator_list ASSIGN
	{printf("designation -> designator_list =\n");}
	;

designator_list
	:designator
	{printf("designator_list -> designator\n");}
	|designator_list designator
	{printf("designator_list -> designator_list designator\n");}
	;

designator
	:BRACKET_OPEN constant_expression BRACKET_CLOSE
	{printf("designator -> [ constant_expression ]\n");}
	|DOT ID
	{printf("designator -> .ID\n");}
	;

statement
	:labeled_statement
	{printf("statement -> labeled_statement\n");}
	|compound_statement
	{printf("statement -> compound_statement\n");}
	|expression_statement
	{printf("statement -> expression_statement\n");}
	|selection_statement
	{printf("statement -> selection_statement\n");}
	|iteration_statement
	{printf("statement -> iteration_statement\n");}
	|jump_statement
	{printf("statement -> jump_statement\n");}
	;

labeled_statement
	:ID COLON statement
	{printf("labeled_statement -> ID : statement\n");}
	|CASE constant_expression COLON statement
	{printf("labeled_statement -> CASE constant_expression : statement\n");}
	|DEFAULT COLON statement
	{printf("labeled_statement -> DEFAULT: statement\n");}
	;

compound_statement
	:BRACES_OPEN block_item_list_opt BRACES_CLOSE
	{printf("compound_statement -> { block_item_list_opt }\n");}
	;

block_item_list_opt
	:block_item_list
	{printf("block_item_list_opt -> block_item_list\n");}
	|
	;

block_item_list
	:block_item
	{printf("block_item_list -> block_item\n");}
	|block_item_list block_item
	{printf("block_item_list -> block_item_list block_item\n");}
	;

block_item
	:declaration
	{printf("block_item -> declaration\n");}
	|statement
	{printf("block_item -> statement\n");}
	;

expression_statement
	:expression_opt SEMICOLON
	{printf("expression_statement -> expression_opt;\n");}
	;

expression_opt
	:expression
	{printf("expression_opt -> expression;\n");}
	|
	;

selection_statement
	:IF PARENTHESIS_OPEN expression PARENTHESIS_CLOSE statement
	{printf("selection_statement -> IF ( expression ) statement\n");}
	|IF PARENTHESIS_OPEN expression PARENTHESIS_CLOSE statement ELSE statement
	{printf("selection_statement -> IF ( expression ) statement ELSE statement\n");}
	|SWITCH PARENTHESIS_OPEN expression PARENTHESIS_CLOSE statement
	{printf("selection_statement -> SWITCH ( expression ) statement\n");}
	;

iteration_statement
	:WHILE PARENTHESIS_OPEN expression PARENTHESIS_CLOSE statement
	{printf("iteration_statement -> WHILE ( expression ) statement\n");}
	|DO statement WHILE PARENTHESIS_OPEN expression PARENTHESIS_CLOSE SEMICOLON
	{printf("iteration_statement -> DO statement WHILE ( expression );\n");}
	|FOR PARENTHESIS_OPEN expression_opt SEMICOLON expression_opt SEMICOLON expression_opt PARENTHESIS_CLOSE statement
	{printf("iteration_statement -> FOR ( expression_opt; expression_opt; expression_opt ) statement\n");}
	|FOR PARENTHESIS_OPEN declaration expression_opt SEMICOLON expression_opt PARENTHESIS_CLOSE statement
	{printf("iteration_statement -> FOR ( declaration expression_opt; expression_opt ) statement\n");}
	;

jump_statement
	:GOTO ID SEMICOLON
	{printf("jump_statement -> GOTO ID;\n");}
	|CONTINUE SEMICOLON
	{printf("jump_statement -> CONTINUE;\n");}
	|BREAK SEMICOLON
	{printf("jump_statement -> BREAK;\n");}
	|RETURN expression_opt SEMICOLON
	{printf("jump_statement -> RETURN expression_opt;\n");}
	;

translation_unit
	:external_declaration
	{printf("translation_unit -> external_declaration\n");}
	|translation_unit external_declaration
	{printf("translation_unit -> translation_unit external_declaration\n");}
	;

external_declaration
	:function_definition
	{printf("external_declaration -> function_definition\n");}
	|declaration
	{printf("external_declaration -> declaration\n");}
	;

function_definition
	:declaration_specifiers declarator declaration_list_opt compound_statement
	{printf("function_definition -> declaration_specifiers declarator declaration_list_opt compound_statement\n");}
	;

declaration_list_opt
	:declaration_list
	{printf("declaration_list_opt -> declaration_list\n");}
	|
	;

declaration_list
	:declaration
	{printf("declaration_list -> declaration\n");}
	|declaration_list declaration
	{printf("declaration_list -> declaration_list declaration\n");}
	;

%%

void yyerror(char *s) {
    printf("ERROR: %s\n",s);
}