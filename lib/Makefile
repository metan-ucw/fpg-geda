# compilers and tools
CC=gcc
CFLAGS=-W -Wall -g -ggdb -std=c99
SOURCES=pcb_backend.c fpg_primitives.c fpg_symbol_coil.c fpg_symbol_cap.c fpg_symbol_resistor.c fpg_symbol_diode.c fpg_symbol.c fpg_metadata.c fpg_utils.c
OBJECTS=$(SOURCES:.c=.o)

all: test libfootprint.a .dep

# create static library 
libfootprint.a: $(SOURCES) $(OBJECTS)
	@ar rcs libfootprint.a $(OBJECTS)
	@echo "AR  libfootprint.a"

# generate file dependencies
.dep: $(SOURCES) $(HEADERS)
	@echo DEP $(SOURCES)
	@gcc -MM $(SOURCES) > .dep

include .dep

test: $(SOURCES) $(HEADERS) libfootprint.a test.o
	@echo "LN  test"
	@gcc -lm test.o libfootprint.a -o test
	@echo "GEN test.fp"
	@./test > test.fp

# rulez for compiling c sources
.c.o:
	@$(CC) $(CFLAGS) -c $< -o $@
	@echo "CC  $<"

# clean!
clean:
	rm -rf libfootprint.a $(OBJECTS) test.o test test.fp test.fp- .dep
