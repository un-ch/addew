#!/bin/bash

if [ "$1" = "" ]; then
	echo "error: no project name";
	exit 1;
fi

PROJECT_DIR=$1
PROJECT_NAME=$1
PROJ_MAIN_BIN=$1
SRC_DIR=src

#### generating directories: ####
mkdir -p	$PROJECT_DIR \
		$PROJECT_DIR/$SRC_DIR
# ---------------------------------- #

cd $PROJECT_DIR

#### general Makefile generating: ####
cat > Makefile << EOF
#

default:
	@cd src && \$(MAKE) --no-print-directory

all:	default

clean:
	@cd src && \$(MAKE) clean --no-print-directory

run:	all
	@./src/$PROJ_MAIN_BIN

.PHONY: default all clean run
EOF
# ---------------------------------- #

#### .gitignore file generating: ####
cat > .gitignore << EOF
# ignore everything:
*

# except:
!.gitignore
!Makefile
!*.c
!*.h
!*/
EOF
# ---------------------------------- #

cd $SRC_DIR

#### Makefile generating: ####
cat > Makefile << EOF
#
#

CC	= gcc
CFLAGS	= -Wall -ggdb -ansi -O0 -MMD -MP -fdiagnostics-color=never -fno-diagnostics-show-caret
LIBS	= -lncurses
MAIN_BIN= $PROJ_MAIN_BIN

MODULES	= main.o
DEPS	= \$(MODULES:.o=.d)

all: \$(MAIN_BIN) tags

%.o:	%.c
	@\$(CC) \$(CFLAGS) -c $< -o \$@

\$(MAIN_BIN): \$(MODULES)
	@\$(CC) \$(CFLAGS) \$(MODULES) \$(LIBS) -o \$@

.PHONY: run clean

run:	\$(MAIN_BIN)
	@./\$(MAIN_BIN)

tags:
	@ctags -R -n --c-kinds=+p --fields=+iaS --extras=+q

valg:
	valgrind -s --tool=memcheck --leak-check=full --track-origins=yes --log-file=VALG_LOG ./\$(MAIN_BIN)

clean:
	@rm -f *.o *.i *.d *.s \$(MAIN_BIN)

# dependency files:
-include \$(DEPS)
EOF
# ---------------------------------- #

cat > main.c << EOF
int main(void)
{
	return 0;
}
EOF
