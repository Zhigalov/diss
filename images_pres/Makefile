pics= cells dokl_pulsea he3aphd resa_cwnmr_ res_fh_\
      cw_nmr_a dokl_pulse he3phd resa_legg_ res_ft1_\
      cw_nmr dokl_res_osc hpd resa_sig_ res_td_\
      dokl_osc flare_out nmr_hpd_s res_fd_ spectr

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