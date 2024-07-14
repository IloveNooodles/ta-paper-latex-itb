@echo off
setlocal

set THESIS_INPUT=thesis.tex
set THESIS_OUTPUT=thesis.pdf
set YUDISIUM_INPUT=yudisium.tex
set YUDISIUM_OUTPUT=yudisium.pdf
set PAPER_INPUT=paper.tex
set PAPER_OUTPUT=paper.pdf

if not exist output mkdir output
if not exist build mkdir build

:format
for /r %%i in (*.tex *.sty *.bib) do (
  latexindent -l -s -sl -w "%%i"
  latexindent -y="indentPreamble:1,defaultIndent:'  '" -m -w "%%i"
  latexindent -m -l -s -sl -w "%%i"
)
goto :eof

:thesis
latexmk -synctex=1 -interaction=nonstopmode -file-line-error -pdf -bibtex -outdir=../build -cd src/%THESIS_INPUT%
copy build\%THESIS_OUTPUT% output\
goto :eof

:yudisium
latexmk -synctex=1 -interaction=nonstopmode -file-line-error -pdf -bibtex -outdir=../build -cd src/%YUDISIUM_INPUT%
copy build\%YUDISIUM_OUTPUT% output\
goto :eof

:paper
latexmk -synctex=1 -interaction=nonstopmode -file-line-error -pdf -bibtex -outdir=../build -cd src/%PAPER_INPUT%
copy build\%PAPER_OUTPUT% output\
goto :eof

:clean
del /s /q output\*
del /s /q build\*
for /r %%i in (*.bak* *~) do del /q "%%i"
goto :eof

:all
call :format
call :thesis
call :yudisium
call :paper
goto :eof

:end
endlocal