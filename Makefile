parts=01_intro 02_theor 03_num 04_tech 05_res

all: diss.pdf

bib:
	latex diss
	bibtex diss
	latex diss
	latex diss
%.pdf: %.ps
	ps2pdf $<
%.ps: %.dvi
	dvips $<
%.dvi: %.tex
	latex $<
diss.dvi: diss.tex ${parts:=.tex}
	latex $<

clean:
	rm -f *.aux *.log