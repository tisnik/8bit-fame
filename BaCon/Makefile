SOURCES := $(wildcard *.bas)

all:	$(SOURCES:.bas=.bac)

clean:
	rm *.bac

%.bac:	%.bas
	cp $< $@
