pics=he3phd he3aphd flare_out cw_nmr cw_nmr_a hpd nmr_hpd nmr_hpd_s\
     legg_eq f_roots\
     cells coils spectr wire1 wire2\
     num_hpd num_f_d num_hdep num_kdt\
     res_hpd res_obr res_fh res_fd res_ft res_ft1 res_td\
     resa_sig resa_legg resa_cwnmr\
     dokl_osc dokl_pulse dokl_res_osc

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