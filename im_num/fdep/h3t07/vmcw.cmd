HR 3
LP -0.18

LP_SWEEP_TO 0.2 0.2
WAIT 500

TSTEP 1
TTC_CHANGE -0.001
WAIT 100
TTC_CHANGE 0
TSTEP 0.1


LP_SWEEP_TO 0.180 0.4
WAIT 100
WRITE_M f170t08.dat
LP 0.170
WAIT 100
WRITE_M_STOP

LP_SWEEP_TO 0.190 0.4
WAIT 100
WRITE_M f180t08.dat
LP 0.180
WAIT 100
WRITE_M_STOP

LP_SWEEP_TO 0.235 0.4
WAIT 100
WRITE_M f225t08.dat
LP 0.225
WAIT 100
WRITE_M_STOP

LP_SWEEP_TO 0.280 0.4
WAIT 100
WRITE_M f270t08.dat
LP 0.270
WAIT 100
WRITE_M_STOP

LP_SWEEP_TO 0.370 0.4
WAIT 100
WRITE_M f360t08.dat
LP 0.360
WAIT 100
WRITE_M_STOP

LP_SWEEP_TO 0.550 0.4
WAIT 100
WRITE_M f540t08.dat
LP 0.540
WAIT 100
WRITE_M_STOP

LP_SWEEP_TO 0.730 0.4
WAIT 100
WRITE_M f720t08.dat
LP 0.720
WAIT 100
WRITE_M_STOP

LP_SWEEP_TO 0.910 0.4
WAIT 100
WRITE_M f900t08.dat
LP 0.900
WAIT 100
WRITE_M_STOP



TSTEP 1
TTC_CHANGE -0.001
WAIT 100
TTC_CHANGE 0
TSTEP 0.1


LP_SWEEP_TO 0.180 0.4
WAIT 100
WRITE_M f170t07.dat
LP 0.170
WAIT 100
WRITE_M_STOP

LP_SWEEP_TO 0.190 0.4
WAIT 100
WRITE_M f180t07.dat
LP 0.180
WAIT 100
WRITE_M_STOP

LP_SWEEP_TO 0.235 0.4
WAIT 100
WRITE_M f225t07.dat
LP 0.225
WAIT 100
WRITE_M_STOP

LP_SWEEP_TO 0.280 0.4
WAIT 100
WRITE_M f270t07.dat
LP 0.270
WAIT 100
WRITE_M_STOP

LP_SWEEP_TO 0.370 0.4
WAIT 100
WRITE_M f360t07.dat
LP 0.360
WAIT 100
WRITE_M_STOP

LP_SWEEP_TO 0.550 0.4
WAIT 100
WRITE_M f540t07.dat
LP 0.540
WAIT 100
WRITE_M_STOP

LP_SWEEP_TO 0.730 0.4
WAIT 100
WRITE_M f720t07.dat
LP 0.720
WAIT 100
WRITE_M_STOP

LP_SWEEP_TO 0.910 0.4
WAIT 100
WRITE_M f900t07.dat
LP 0.900
WAIT 100
WRITE_M_STOP


