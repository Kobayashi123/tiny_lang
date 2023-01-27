%{
int linecounter = 1;
%}
%option nounput
%%
display                                     { return(DISPLAY); }
string                                      { return(STRING); }
image                                       { return(IMAGE); }
at                                          { return(AT); }
[0-9]+                                      { return(INTEGER); }
"."                                         { return(PERIOD); }
"@"                                         { return(ATMARK);}
"\""([A-Za-z0-9]|":"|"/"|"."|"-"|"~")*"\""  { return(WQUOTED); }
"\n"                                        { linecounter++; }
"\r\n"                                      { linecounter++; }
"\r"                                        { linecounter++; }
" "|"\t"                                    { }
"/*"                                        { comment(); }
.                                           { return(UNKNOWN); }
%%
int yywrap(void) {
	return(1);
}
void comment(void) {
	int boolean, first, second;

	boolean = TRUE;
	first = input();
	while (first != EOF && boolean) {
		second = input();
		if (first == '*' && second == '/') {
			boolean = FALSE;
		} else if (first == '\r' && second == '\n') {
			linecounter++;
			first = input();
		} else {
			if (first == '\r' || first == '\n') {
				linecounter++;
			}
			first = second;
		}
	}
	if (first == EOF) {
		fprintf(stderr, "eof in comment\n");
	}
}
