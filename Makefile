parts=01_intro 06_hpd_osc 07_num 08_exp 09_res

all: diss.pdf


%.pdf: %.ps
	ps2pdf $<
%.ps: %.dvi
	dvips $<
diss.dvi: diss.tex ${parts:=.tex}
	latex $<

clean:
	rm -f *.aux *.log