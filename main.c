#include <stdio.h>
#include "y.tab.h"
extern char* yytext;
extern int yyparse();

int main() {

  yydebug = 1;
  yyparse();

  return 0;
}