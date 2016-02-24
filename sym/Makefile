SYMS=$(wildcard */*.sym)
PNGS=$(SYMS:.sym=.png)

all: $(PNGS) README.md

$(PNGS): %.png: %.sym
	gschem -p -o $$(basename $@) -s $$PWD/image.scm $<

README.md: $(SYMS)
	./gen_readme.sh

clean:
	rm $(PNGS) README.md
