%{
    /* Lisparser */
%}

%option noyywrap

%{
    /* REGEX Variable Initialization */
%}
Newline     [\n]|[\r\n]|[\r]
Comment     ;{1,2}.*$
BlankLines  ^([" "|"\t"]*(#.*)?{Newline})+
Integer     [0-9]+
String      \"(\\.|[^\"])*\"
Whitespace  [ \t]+
Symbol      [a-zA-Z/?-]+

%%

{BlankLines}
{Newline}    { yylineno++; return EOL; }
{Integer}    { yylval.int_val = atoi(yytext); return INTEGER; }
{String}     { char *temp = (yytext + 1); temp[strlen(temp) -1] = '\0'; yylval.str_val = new std::string(temp); return STRING; }
{Symbol}     { yylval.str_val = new std::string(yytext); return ID; }
{Whitespace} { printf("ws"); }

"("          return '(';
")"          return ')';

%{
    /* Comments have lower precedece than other tokens */
%}
{Comment} { printf("comment\n"); }

. {
    fprintf(stderr, "Invalid token: '%s' on line %d\n", yytext, yylineno);
    yyterminate();
}
