/*
   Copyright 2023 Ochiai Daisuke, Kitaoka Tsubasa, Kobayashi Shun,
   Koyama Shuhey, Goda Teruya

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

%{
int linecounter = 1;
%}
%option nounput
%%
display                                     { return(DISPLAY); }
string                                      { return(STRING); }
image                                       { return(IMAGE); }
line                                        {return(LINE); }
rectangle                                   { return(RECTANGLE);}
arc                                         { return(ARC); }
angle                                       { return(ANGLE); }
sweep                                       { return(SWEEP); }
fill                                        { return(FILL); }
stroke                                      { return(STROKE); }
start                                       { return(START); }
pass                                        { return(PASS); }
end                                         { return(END); }
color                                       { return(COLOR); }
green                                       { return(GREEN); }
red                                         { return(RED); }
blue                                        { return(BLUE); }
cyan                                        { return(CYAN); }
magenta                                     { return(MAGENTA); }
yellow                                      { return(YELLOW); }
gray                                        { return(GRAY); }
black                                       { return(BLACK); }
white                                       { return(WHITE); }
width                                       { return(WIDTH);}
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
