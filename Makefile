parts=01_intro 06_hpd_osc 07_num 08_exp 09_res

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