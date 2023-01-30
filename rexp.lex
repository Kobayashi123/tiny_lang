%{
int linecounter = 1;
%}
%option nounput
%%
display                                     { return(DISPLAY); }
string                                      { return(STRING); }
image                                       { return(IMAGE); }
line										{return(LINE); }
rectangle									{ return(RECTANGLE);}
arc											{ return(ARC);}
angle										{ return(ANGLE);}
sweep										{ return(SWEEP);}
fill										{ return(FILL);}
stroke										{ return(STROKE);}
start										{ return(START);}
pass										{ return(PASS);}
end											{ return(END);}
color										{ return(COLOR);}

green										{ return(GREEN); }
red								  			{ return(RED); }
blue										{ return(BLUE); }
cyan										{ return(CYAN); }
magenta										{ return(MAGENTA); }
yellow										{ return(YELLOW); }
gray										{ return(GRAY); }
black										{ return(BLACK); }
white										{ return(WHITE); }

width										{ return(WIDTH);}

at                                          { return(AT);}
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
