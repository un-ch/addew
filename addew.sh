#!/bin/bash

if [ "$1" = "" ]; then
	echo "error: no project name";
	exit 1;
fi

# directories definitions:
PROJECT_DIR=$1	
PROJECT_NAME=$1
BUILD_DIR=build
INCLUDE_DIR=include
SRC_DIR=src

# generating directories:
mkdir -p	$PROJECT_DIR \
			$PROJECT_DIR/$BUILD_DIR \
			$PROJECT_DIR/$INCLUDE_DIR \
			$PROJECT_DIR/$SRC_DIR

# generating the "main" file:
touch $PROJECT_DIR/$SRC_DIR/$PROJECT_NAME

# generating the Makefile:
touch $PROJECT_DIR/Makefile

cat > $PROJECT_DIR/Makefile << EOF
CC	=	gcc
CFLAGS	=	-Wall -g -I
LIBS	=

SRC_FILE_EXTENSION = .c
HEADER_FILE_EXTERNSION = .h

# directories definitions:
BUILD_DIR	=	build
INCLUDE_DIR	=	include
SRC_DIR		=	src

# modules enumeration:
SRC_FILES	=	\$(SRC_DIR)/\$(SRC_FILE_EXTENSION)

# set object files to the build directory:
OBJECT_FILES=	\$(subst \$(SRC_DIR),\$(BUILD_DIR),\$(SRC_FILES:\$(SRC_FILE_EXTENSION)=.o))

HEADER_FILES=	\$(wildcard \$(INCLUDE_DIR)/*\$(HEADER_FILE_EXTERNSION)

\$(BUILD_DIR)/%.o: \$(SRC_DIR)/%\$(SRC_FILE_EXTENSION) \$(INCLUDE_DIR)/%\$(HEADER_FILE_EXTERNSION)
	@\$(CC) \$(CFLAGS)\$(INCLUDE_DIR) -c \$< -o \$@

# targets:
$PROJECT_NAME: \$(SRC_DIR)/$PROJECT_NAME\$(SRC_FILE_EXTENSION) \$(OBJECT_FILES) \$(LIBS)
	@\$(CC) \$(CFLAGS) \$(INCLUDE_DIR) \$^ -o \$(BUILD_DIR)/\$@

.PHONY: run
run: $PROJECT_NAME
	@./\$(BUILD_DIR)/$PROJECT_NAME

.PHONY: clean
clean:
	@rm -f	\$(BUILD_DIR)/*.o \$(BUILD_DIR)/$PROJECT_NAME

.PHONY: delete_files
delete_files:
	@rm -f	\$(BUILD_DIR)/* \$(SRC_DIR)/* \$(INCLUDE_DIR)/*
EOF

# generating the .gitignore file:
	touch $PROJECT_DIR/.gitignore
	cat > $PROJECT_DIR/.gitignore << EOF
# The gitignore file specifies intentionally untracked files that Git should ignore.
#
EOF

# generating another .gitignore file:
	touch $PROJECT_DIR/$BUILD_DIR/.gitignore
	cat > $PROJECT_DIR/$BUILD_DIR/.gitignore << EOF
# The gitignore file specifies intentionally untracked files that Git should ignore.
#
# ignore everything in this directory
*
# except this file:
!.gitignore
EOF
