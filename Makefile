############################################################
# Will's Custom Makefile for C/C++ Projects
#
# File Hierarchy
# 	assets			Assets Files (.png, .ico, etc)
#	bin 			Binary Files (.out, .exe, etc)
#	build			Build Files (.obj, etc)
#	doc				Documentation
#	include 		External Library Headers
#	lib 			External Library Files
#	src 			Source Files (.c, .cpp, .h, etc)
#	test			Test code
############################################################


################### MODIFIABLE VARIABLES ###################
# PROJECT TYPE
SRCEXT := c
PRJTYPE := sys_util
## Example Project Types:
### sys_util: 	system utility (deploys to ${HOME}/dev/bin; added to system PATH)

# FILE HIERARCHY
SRCDIR := src
BUILDDIR := build
TARGET_NAME := python-refresh

# PROJECT BUILDING
CFLAGS := -g -Wall
LIB :=
INC := -I include
############################################################


################## AUTOASSIGNED VARIABLES ##################
##----- MODIFY AT OWN RISK - MAY BREAK FUNCTIONALITY -----##
# GRAB ALL SOURCE FILES
SOURCES := $(wildcard $(SRCDIR)/*.$(SRCEXT))

# GET OBJECT FILE NAME PATTERN
OBJECTS := $(patsubst $(SRCDIR)/%.$(SRCEXT),$(BUILDDIR)/%.o,$(SOURCES))

# SET OUTPUT TARGET BASED ON PROJECT TYPE
ifdef PRJTYPE
	ifeq ($(PRJTYPE),sys_util)
		TARGET := ${HOME}/dev/bin/$(TARGET_NAME)
	else
		TARGET := bin/$(TARGET_NAME)
	endif
else
	TARGET := bin/$(TARGET_NAME)
endif

# SET COMPILER BASED ON $(SRCEXT)
ifeq ($(SRCEXT),c)
CC=gcc
else ifeq ($(SRCEXT),cpp)
CC=g++
endif
############################################################


########### CHECK IF NECESSARY VARIABLES ARE SET ###########
# Logic to check if everything needed is defined
ifndef SRCEXT
$(error Source extension not defined)
endif
ifndef TARGET_NAME
$(error Target name not set)
endif
############################################################


############## MAIN COMPILE AND BUILD TARGETS ##############
$(TARGET): $(OBJECTS)
	@echo "Linking..."
	$(CC) $^ -o $(TARGET) $(INC)

$(BUILDDIR)/%.o: $(SRCDIR)/%.$(SRCEXT)
	@echo "Building..."
	$(CC) $(CFLAGS) $(INC) -c -o $@ $<
############################################################


##################### CLEAN EVERYTHING #####################
.PHONY: clean
clean:
	@echo "Cleaning..."
	rm -f $(BUILDDIR)/* $(TARGET)
############################################################
