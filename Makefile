# disser latex packaged is used:
#   http://www.ctan.org/tex-archive/macros/latex/contrib/disser/
#   http://sourceforge.net/projects/disser/


parts_diss=00_common 00_intro 01_he3 02_theor 03_num 04_tech 05_res 06_vyv
parts_auto=00_common

all: diss.pdf auto.pdf otz_ved.pdf auto_b.pdf

bib:
	latex diss
	bibtex diss
	latex diss
	latex diss

	latex auto
	bibtex auto
	bibtex my
	latex auto
	latex auto

	latex mypub
	bibtex mypub
	bibtex mypub
	latex mypub
	latex mypub

%.pdf: %.ps
	ps2pdf $<

#auto_o.ps: auto.ps
#	psbook $< | psnup -l -pa4 -2 | psselect -r -o > auto_o.ps;
#auto_e.ps: auto.ps
#	psbook $< | psnup -l -pa4 -2 | psselect -r -e > auto_e.ps;
auto_b.ps: auto.ps
	psbook $< | psnup -l -pa4 -2 > auto_b.ps;

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
	ispell -d russian-lebedev ${parts_diss:=.tex} ${parts_auto:=.tex} otz_ved.tex auto.tex
