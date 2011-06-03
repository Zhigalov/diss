parts_diss=000_tit 001_intro 01_intro 02_theor 03_num 04_tech 05_res
parts_auto=000_tit 001_auto

all: diss.pdf auto.pdf

bib:
	latex diss
	bibtex diss
	latex diss
	latex diss

	latex auto
	bibtex auto
	latex auto
	latex auto
%.pdf: %.ps
	ps2pdf $<
%.ps: %.dvi
	dvips $<
%.dvi: %.tex
	latex $<
diss.dvi: diss.tex ${parts_diss:=.tex}
	make -C images
	latex $<
auto.dvi: auto.tex ${parts_auto:=.tex}
	make -C images
	latex $<

clean:
	rm -f *.aux *.log

spell:
	ispell -d russian-lebedev ${parts_diss:=.tex} ${parts_auto:=.tex}
