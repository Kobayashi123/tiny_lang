/*
   Copyright 2023 Ochiai Daisuke, Kitaoka Tsubasa, Kobayashi Shun,
   KoyamaShuhey, Goda Teruya

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

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TRUE 1
#define FALSE 0

enum { CONS, NODE, LEAF };

typedef struct cell {
    int kind;
    struct cell *head;
    struct cell *tail;
} Cell;

extern char *yytext;
extern int linecounter;

int main(void);
int yylex(void);
void comment(void);
int yyparse(void);
void yyerror(char *);
Cell *cons(Cell *, Cell *);
Cell *node(char *, Cell *);
Cell *leaf(char *, char *);
void tree(Cell *);
void visit(Cell *, int);
