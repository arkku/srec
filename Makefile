CC=clang
CFLAGS=-Wall -std=c99 -pedantic -Wextra -Weverything -Wno-padded -Wno-unused-parameter -Os #-emit-llvm
LDFLAGS=-Os
AR=ar
ARFLAGS=rcs

OBJS = kk_srec.o
BINPATH = ./
LIBPATH = ./
BINS = srec2bin
LIB = $(LIBPATH)libkk_srec.a

.PHONY: all clean distclean test

all: $(BINS) $(LIB)

$(OBJS): kk_srec.h
$(BINS): | $(BINPATH)
$(LIB): | $(LIBPATH)

$(LIB): $(OBJS)
	$(AR) $(ARFLAGS) $@ $+

$(BINPATH)srec2bin: srec2bin.o $(LIB)
	$(CC) $(LDFLAGS) -o $@ $+

$(sort $(BINPATH) $(LIBPATH)):
	@mkdir -p $@

clean:
	rm -f $(OBJS)

distclean: | clean
	rm -f $(BINS) $(LIB)
	@rmdir $(BINPATH) $(LIBPATH) >/dev/null 2>/dev/null || true

