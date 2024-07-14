THESIS_INPUT = thesis.tex
THESIS_OUTPUT = thesis.pdf
YUDISIUM_INPUT = yudisium.tex
YUDISIUM_OUTPUT = yudisium.pdf
PAPER_INPUT = paper.tex
PAPER_OUTPUT = paper.pdf

.PHONY: all clean thesis yudisium

all: clean thesis yudisium paper

thesis:
	mkdir -p output
	mkdir -p build
	latexmk -pdf -bibtex -outdir=../build -cd src/$(THESIS_INPUT)
	cp build/$(THESIS_OUTPUT) output

yudisium:
	mkdir -p output
	mkdir -p build
	latexmk -pdf -bibtex -outdir=../build -cd src/$(YUDISIUM_INPUT)
	cp build/$(YUDISIUM_OUTPUT) output

paper:
	mkdir -p output
	mkdir -p build
	latexmk -pdf -bibtex -outdir=../build -cd src/$(PAPER_INPUT)
	cp build/$(PAPER_OUTPUT) output

clean:
	rm -rf output/* build/*
	find . -iname "*~" -exec rm '{}' ';'
