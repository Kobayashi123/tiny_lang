# tiny_lang

## Description

Design a new language by ourself and create its language processor by yourself using lex(flex) and yacc(bison).

## Requirement

macOS 12.6.2

## Usage

1. Clone this repository

```
$ git clone https://github.com/Kobayashi123/tiny_lang.git
```

2. Change the working directory
```
$ cd tiny_lang
```

3. Run the program

The following command parses src.txt and creates a parse tree named tmp.txt.
```
$ make src
```

After that, download and run tiny_VM by the following command. tiny_VM window opens, select tmp.txt to process src.txt written in tiny_lang and draw in the window.
```
$ make vm
```

## Licence

[Apache License, Version 2.0](https://github.com/Kobayashi123/tiny_lang/blob/main/LICENCE)

## Author

[Kobayashi123](https://github.com/Kobayashi123)

[otty0507](https://github.com/otty0507)

[shuheykoyaba](https://github.com/shuheykoyama)

[KitaokaTsubasa](https://github.com/KitaokaTsubasa)

[TeruyaGoda](https://github.com/Gteruya)
