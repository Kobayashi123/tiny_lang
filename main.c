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

#include "defs.h"

int main(void) {
    linecounter = 1;
    if (yyparse() == 0) {
        fprintf(stderr, "\nparser successfully ended\n\n");
    }
    return (EXIT_SUCCESS);
}

Cell *cons(Cell *car, Cell *cdr) {
    Cell *pointer;

    pointer = (Cell *)malloc(sizeof(Cell));
    pointer->kind = CONS;
    pointer->head = car;
    pointer->tail = cdr;
    return (pointer);
}

Cell *node(char *car, Cell *cdr) {
    Cell *pointer;

    pointer = (Cell *)malloc(sizeof(Cell));
    pointer->kind = NODE;
    pointer->head = (Cell *)strdup(car);
    pointer->tail = cdr;
    return (pointer);
}

Cell *leaf(char *car, char *cdr) {
    Cell *pointer;

    pointer = (Cell *)malloc(sizeof(Cell));
    pointer->kind = LEAF;
    pointer->head = (Cell *)strdup(car);
    pointer->tail = (Cell *)strdup(cdr);
    return (pointer);
}

void tree(Cell *pointer) {
    visit(pointer, 1);
    printf("\n");
}

void visit(Cell *pointer, int level) {
    int count;

    printf("\n");
    for (count = 0; count < level; count++) {
        printf("    ");
    }
    if (pointer->kind == CONS) {
        printf("(");
        visit(pointer->head, level + 1);
        visit(pointer->tail, level + 1);
        printf(")");
    }
    if (pointer->kind == NODE) {
        printf("(");
        printf("%s ", (char *)pointer->head);
        visit(pointer->tail, level + 1);
        printf(")");
    }
    if (pointer->kind == LEAF) {
        printf("(");
        printf("%s ", (char *)pointer->head);
        printf("%s", (char *)pointer->tail);
        printf(")");
    }
    return;
}
