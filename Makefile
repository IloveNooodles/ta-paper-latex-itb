THESIS_INPUT = thesis.tex
THESIS_OUTPUT = thesis.pdf
YUDISIUM_INPUT = yudisium.tex
YUDISIUM_OUTPUT = yudisium.pdf
PAPER_INPUT = paper.tex
PAPER_OUTPUT = paper.pdf

BAKFILES := $(shell find . -iname "*.bak*")
TEXFILES := $(shell find . -iname "*.tex")
STYFILES := $(shell find . -iname "*.sty")
BIBFILES := $(shell find . -iname "*.bib")

.PHONY: all format thesis yudisium paper clean

all: format thesis yudisium paper

thesis:
	@mkdir -p output
	@mkdir -p build
	@latexmk -synctex=1 -interaction=nonstopmode -file-line-error -pdf -bibtex -outdir=../build -cd src/$(THESIS_INPUT)
	@cp build/$(THESIS_OUTPUT) output

yudisium:
	@mkdir -p output
	@mkdir -p build
	@latexmk -synctex=1 -interaction=nonstopmode -file-line-error -pdf -bibtex -outdir=../build -cd src/$(YUDISIUM_INPUT)
	@cp build/$(YUDISIUM_OUTPUT) output

paper:
	@mkdir -p output
	@mkdir -p build
	@latexmk -synctex=1 -interaction=nonstopmode -file-line-error -pdf -bibtex -outdir=../build -cd src/$(PAPER_INPUT)
	@cp build/$(PAPER_OUTPUT) output

format:
	@latexindent -l -s -sl -w $(TEXFILES) $(STYFILES) $(BIBFILES)
	@latexindent -y="indentPreamble:1,defaultIndent:'  '" -m -w $(TEXFILES) $(STYFILES) $(BIBFILES)
	@latexindent -m -l -s -sl -w $(TEXFILES) $(STYFILES) $(BIBFILES)

clean:
	@rm -rf output/* build/*
	@rm -f $(BAKFILES)
	@find . -iname "*~" -exec rm -f '{}' ';'