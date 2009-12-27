# compilers and tools
CC=gcc
CFLAGS=-W -Wall -g -ggdb -std=c99 -I../lib
LDFLAGS=-lm

BIN=gen_heat_sinks gen_radial_can_cap gen_large_can_cap gen_coil gen_ch_conn gen_TO220 gen_DIP gen_wob gen_resistor
OBJ=$(BIN:=.o)

all: $(BIN)

$(BIN): %: %.o
	@echo "LD  $@"
	@$(CC) $(LDFLAGS) $< ../lib/libfootprint.a -o $@

# rulez for compiling c sources
.c.o:
	@echo "CC  $<"
	@$(CC) $(CFLAGS) -c $< -o $@


# clean!
clean:
	rm -rf $(BIN) $(OBJ)
