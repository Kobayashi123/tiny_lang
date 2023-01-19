TARGET	= tiny

# LINK (*.o)
LD	= clang
LDFLAGS	= -Weverything -Werror

# COMPILE (*.c)
CC	= clang
CCFLAGS	= $(shell \
	XcodeMajorVersion=`xcodebuild -version | head -n 1 | cut -d " " -f 2 | cut -d "." -f 1`; \
	if [ $${XcodeMajorVersion} -lt "12" ] ; \
	then \
		echo '-Weverything -Werror -Wno-reserved-id-macro -Wno-unused-macros -Wno-implicit-int-conversion -Wno-sign-conversion -Wno-comma -Wno-unreachable-code -Wno-padded -Wno-missing-noreturn -Wno-missing-variable-declarations -Wno-cast-align -save-temps -O2' ; \
	else \
		echo '-Weverything -Werror -Wno-reserved-id-macro -Wno-unused-macros -Wno-poison-system-directories -Wno-implicit-int-conversion -Wno-sign-conversion -Wno-comma -Wno-unreachable-code -Wno-padded -Wno-missing-noreturn -Wno-missing-variable-declarations -Wno-cast-align -Wno-sign-compare -save-temps -O2' ; \
	fi)
CCTEMPS	= *.o *.s *.i *.bc

# GENERATOR (*.lex and *.yac)
LEX	= flex
YAC	= yacc

OBJS	= y.tab.o main.o
DEFS	= defs.h
REXP	= rexp.lex
LEXC	= lex.yy.c
SYNS	= syns.yac
YACC	= y.tab.c
SRC	= src.txt
TMP	= tmp.txt
ARC	= Archive
VMN	= TinyVM
VME = tar.gz

all: $(TARGET)

$(TARGET): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $(OBJS)

$(OBJS): $(DEFS)

$(LEXC): $(REXP) $(DEFS)
	$(LEX) $(REXP)

$(YACC): $(SYNS) $(LEXC) $(DEFS)
	$(YAC) $(SYNS)

%.o: %.c
	$(CC) $(CCFLAGS) -c $< -o $@

clean:
	-rm -f $(TARGET)* $(OBJS) $(LEXC) $(YACC) $(TMP) $(CCTEMPS) $(ARC).zip *\~
	-rm -rf ./$(VMN)/ ; rm -f $(VMN).$(VME)
	@rm -rf __MACOSX/

src: all
	./$(TARGET) < $(SRC) > $(TMP) ; if [ ! $$? == 0 ] ; then rm -f $(TMP); touch $(TMP) ; fi
	cat $(TMP)
	@echo

srcLF: all
	./$(TARGET) < srcLF.txt > $(TMP) ; if [ ! $$? == 0 ] ; then rm -f $(TMP); touch $(TMP) ; fi
	cat $(TMP)
	@echo

srcCR: all
	./$(TARGET) < srcCR.txt > $(TMP) ; if [ ! $$? == 0 ] ; then rm -f $(TMP); touch $(TMP) ; fi
	cat $(TMP)
	@echo

srcCRLF: all
	./$(TARGET) < srcCRLF.txt > $(TMP) ; if [ ! $$? == 0 ] ; then rm -f $(TMP); touch $(TMP) ; fi
	cat $(TMP)
	@echo

zip: clean
	mkdir $(ARC)
	cp -p -r ./*.* Makefile $(ARC)/
	zip -r $(ARC).zip $(ARC)/
	rm -rf $(ARC)

vm:
	@if [ ! -e $(TMP) ] ; then make src; fi
	@if [ ! -e ./$(VMN).$(VME) ] ; then curl -O http://www.cc.kyoto-su.ac.jp/~atsushi/deployment/PL/$(VMN).$(VME) ; fi
	@if [ ! -e ./$(VMN)/ ] ; then tar xvfz ./$(VMN).$(VME) > /dev/null 2>&1 ; rm -rf __MACOSX/ > /dev/null 2>&1 ; fi
	@xattr -cr ./$(VMN)/
#	open ./$(VMN)/$(VMN).app
#	open --reveal ./$(VMN)/$(VMN).app
#	open -R ./$(VMN)/$(VMN).app
	(cd ./TinyVM/TinyVM.app/Contents/Resources/Java/ ; java -Dfile.encoding=UTF-8 -Xmx512m -Xss1024k -jar ./tinyvm.jar > /dev/null 2>&1)

#test: vm
#	@:

test: src
	@:
