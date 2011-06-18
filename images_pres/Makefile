pics= cells dokl_pulsea he3aphd resa_cwnmr res_fh\
      cw_nmr_a dokl_pulse he3phd resa_legg res_ft1\
      cw_nmr dokl_res_osc hpd hpd1 resa_sig res_td\
      dokl_osc flare_out nmr_hpd res_fd spectr

#all: ${pics:=.png} ${pics:=.tex} ${pics:=.eps}
all: ${pics:=.tex} ${pics:=.eps}

%.png: %.fig
	fig2dev -Lpng -j -m3.75 $< $@

%.eps: %.fig
	fig2dev -Lpstex -j $< $@
%.tex: %.fig
	fig2dev -Lpstex_t -p ${@:.tex=.eps} -j $< $@

clean:
	rm -f *.tex *.png *.eps