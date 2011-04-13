      block data
        common /DATA/ PCP,TPCP,PA,ANA,PI,HC,R,AKB,GAM,AM3
        data PCP/21.22/,TPCP/2.273/,PA/34.358/
C--     Greywall. Phys. Rev.B v.33 #11 p.7520
C       P [bars], Tc [mK]
        data ANA/6.02252E23/,PI/3.141592/,HC/1.05450E-27/,R/8.3143E+7/
C-      HC in SGS., AKB too.
        data AKB/1.38054E-16/,GAM/20378/,AM3/5.0079E-24/
      end

CC    T_c [mK] vs P [bars] -- TCF(P)
C     Greywall. Phys. Rev.B v.33 #11 p.7520
      function TCF(P)
        real TCF,MCF,P
        TCF=   .92938375
     .       + .13867188*P
     .       - .69302185E-2*P**2
     .       + .25685169E-3*P**3
     .       - .57248644E-5*P**4
     .       + .53010918E-7*P**5
        if (P.GT.MCF(TCF)) then
          TCF=0.0
        endif
        return
      end

CC    T_ab [mK] vs P [bars] -- TABF(P)
C     Greywall. Phys. Rev.B v.33 #11 p.7520
      function TABF(P)
        real TABF,MCF,P,PR
        common /DATA/ PCP,TPCP,PA,ANA,PI,HC,R,AKB,GAM,AM3
        PR=P-PCP
        if (PR.LT.0) then
          TABF=TCF(P)
        else
          TABF= TPCP
     .       - .10322623E-1*PR
     .       - .53633181E-2*PR**2
     .       + .83437032E-3*PR**3
     .       - .61709783E-4*PR**4
     .       + .17038992E-5*PR**5
        endif
        if (P.GT.MCF(TABF)) then
          TABF=0.0
        endif
        return
      end

CC    MOLAR VOLUME V[cm**3/mole] vs P [bars] -- MVF(P)
C     Greywall. Phys. Rev.B v.33 #11 p.7520 ref. 27
C     That is Wheatley Rev.Mod.Phys. 47,415(1975).
      function MVF(P)
        real MVF,P
        MVF=   36.837231
     .       - 1.1803474*P
     .       + .0834214*P**2
     .       - .3885962E-2*P**3
     .       + .94759780E-4*P**4
     .       - .91253577E-6*P**5
        return
      end

CC    MELTING PRESSURE P [bars] vs T [mK] -- MCF(T)
C     Greywall. Phys. Rev.B v.33 #11 p.7520
      function MCF(T)
        real MCF,T
        common /DATA/ PCP,TPCP,PA,ANA,PI,HC,R,AKB,GAM,AM3
        MCF=PA-.19652970E-1*T**(-3)-.61880268E-1*T**(-2)-
     .      .78803055E-1*T**(-1)+.13050600-.43519381E-1*T+
     .      .13752791E-3*T**2-.17180436E-6*T**3-
     .      .22093906E-9*T**4+.85450245E-12*T**5
        return
      end

CC    R-Gas constant GAMMA=C/RT [1/(K*mol)] vs P [bar] -- GAMMAF(P)
C     Greywall. Phys. Rev.B v.33 #11 p.7520
      function GAMMAF(P)
        real GAMMAF,P
        GAMMAF =  .27840464E01
     .          + .69575243E-1*P
     .          - .14738303E-2*P**2
     .          + .46153498E-4*P**3
     .          - .53785385E-6*P**4
        return
      end

CC    LEGGETT FREQ^2, Lf^2 [Hz^2] vs P [bar], T/Tc -- LF2F(P,T)
C     Ahonen (18.7,21.1,25.4,29.0,32 bars), Osheroff(MP).
C     Ahonen et.al.  JLTP. v.25 p.421(1976)
C     Osheroff       PRL v.34. p.190
C     From 0 to 18.7 bar data are not reliable.
C     See file YOM3.
C     Least squares 2-D fitting. From fil:: YOM3
C     F= vs. T= & P=
C     Polinmms of the orders : 4,  1
      function LF2F(P,T)
        real LF2F,P,T,TABF,TCF
        real WORK(5),A(10)
        DATA XMIN/   .2660000    /,XMAX/   1.000000    /
        DATA YMIN/   0.000000    /,YMAX/   34.36000    /
        DATA K/ 4/,L/ 1/,NA/ 10/,NWORK/5/
        DATA A/  1.3169660E+11,  5.0310062E+10,
     .          -6.6371420E+10, -2.0536020E+10,
     .          -5.2457041E+09, -5.1179683E+09,
     .           5.8596372E+09,  3.1320310E+08,
     .          -6.9788020E+07,  2.0270360E+08/
        if (T.LT.TABF(P)/TCF(P)) THEN
          IFAIL=1
          call E02CBE(1,1,K,L,T,XMIN,XMAX,P,YMIN,YMAX,F,
     ,                A,NA,WORK,NWORK,IFAIL)
          LF2F=F
          if (IFAIL.EQ.2) THEN
            print *,'P out of range:',YMIN,YMAX
            LF2F=0
          elseif (IFAIL.EQ.3) THEN
            print *,'T out of range:',XMIN,XMAX
            LF2F=0
          elseif (IFAIL.NE.0) THEN
            print *,'Error:',IFAIL
            LF2F=0
          endif
          if (P.LT.18.7) print *,'Data not reliable.'
        else
          print *,'No data for A-phase.'
          LF2F=0
        endif
        return
      end

C--   Attention density of state must be multiplyied by ANA later.
      function DNDEF(P)
        real DNDEF,P
        common /DATA/ PCP,TPCP,PA,ANA,PI,HC,R,AKB,GAM,AM3
        DNDEF=3.*GAMMAF(P)/AKB/PI**2
        return
      end

CC    EFFECTIVE MASS [g] vs P [bar] -- MAF(P)
      function MAF(P)
        real MAF,P,MVF
        common /DATA/ PCP,TPCP,PA,ANA,PI,HC,R,AKB,GAM,AM3
        PF=PFF(P)
C       MAF=GAMMAF(P)*R*HC*MVF(P)*(HC/PF)*3
C       print *,GAMMAF(P),GAMMAF(P)*R*HC,R
        MAF=DNDEF(P)*PF/3.*PF
C       MAF=DNDEF(P)*PF/3./MVF(P)*PF
        return
      end

CC    FERMI MOMENTUM [sgs] vs P [bar] -- PFF(P)
      real function PFF(P)
        common /DATA/ PCP,TPCP,PA,ANA,PI,HC,R,AKB,GAM,AM3
        real PFF,P,MVF
        PFF=HC*(3*PI**2*ANA/MVF(P))**.3333333
        return
      end

CC    FERMI VELOSITY [cm/s] vs P [bar] -- VFF(P)
      real function VFF(P)
        real VFF,P,MAF
        VFF=PFF(P)/MAF(P)
        return
      end

CC    Osheroff's spin wave velocity. S [cm/s] vs P [bar], T [mK] -- SF(P,T)
C     Osheroff's spin wave velocity if recalculated to arbitrary pressure
C     by taking value of Osheroff for melting pressure (1100 cm/sek)
C     and assuming S is proportional to Fermi velocity.
      function SF(P,T)
        real SF,P,T,VFF,TCF
        SF=1100/VFF(34.3)*VFF(P)*SQRT(1-T/TCF(P))
      end

CC    Parallel Fomin spin wave velocity. Cpar [cm/c] vs P [bar], T [mK] -- CPARF(P,T)
      function CPARF(P,T)
        real CPARF,P,T,SF
        CPARF=SF(P,T)*SQRT(2.0)
      end
CC    Perp Fomin spin wave velocity. Cper [cm/c] vs P [bar], T [mK] -- CPERF(P,T)
      function CPERF(P,T)
        real CPERF,P,T,SF
        CPERF=SF(P,T)*SQRT(1.5)
      end

CC    SPIN DIFFUSION COEFF, SUPERFLUID D [cm**2/sec] vs P [bar], T[mk] -- DSUPF(P,T)
C--   Our data. Was measured at pressures .6,11,14.8,20,29 bar
C     at T .45-.67,  .45-.8  .45-.81  .45-.94  .45-.67 Tc respectivly.
C     Least squares 2-D fitting. From fil:: MUHLR1
C     D/C= vs. T= & P=
C     Polinoms of the orders : 4,  4
      function DSUPF(P,T)
        real DSUPF,P,T
        real WORK( 5),A( 25)
        DATA XMIN/   .4400000    /,XMAX/   .9400001    /
        DATA YMIN/   0.000000    /,YMAX/   29.00000    /
        DATA K/ 4/,L/ 4/,                          NA/ 25/,NWORK/5/
        DATA A/  6.6012963E-03, -2.2342042E-03,  4.2030680E-04
     ,  ,  1.6044091E-04, -8.2734930E-04,  1.7867290E-03, -6.6435340E-04
     ,  , -1.8627312E-04,  4.3953900E-04, -6.3450170E-04, -4.1724560E-04
     ,  ,  3.9544643E-04, -3.2521144E-04,  1.7599921E-04, -1.9650970E-04
     ,  ,  1.2244173E-04,  3.2786340E-05,  6.5047061E-08, -3.2710520E-05
     ,  , -6.1170401E-05,  3.7204154E-05,  9.9630890E-06,  1.2296370E-08
     ,  , -9.9427400E-06, -1.8589210E-05/
        TR=T/TCF(P)
        IFAIL=1
        call E02CBE(1,1,K,L,TR,XMIN,XMAX,P,YMIN,YMAX,F,
     ,              A,NA,WORK,NWORK,IFAIL)
        if (IFAIL.EQ.2) THEN
          print *,'Y out of range.'
        else if (IFAIL.EQ.3) THEN
          print *,'X out of range.'
        else if (IFAIL.NE.0) THEN
          print *,'Error:',IFAIL
        end if
        DSUPF=F*CPARF(P,T)**(.6666666666666)
      end
C--

CC    SPIN DIFFUSION COEFF, NORMAL D [cm**2/sec] vs P [bar], T[mk] -- DNORF(P,T)
C--   Brewer data for D*T**2
C--   JLTP v.56 #5/6 p.617
C     Least squares fitting. From file: YDIFD
C     DT2=                  vs.  P=
C     Polinom of the order : 4
C     Residual: 0.000
      function DNORF(P,T)
        real DNORF, P,T, XCAP, DT2F
        real A(4)
        DATA M1/4/
        DATA XMIN/0.000000/,XMAX/27.75999/
        DATA A/1.0603673E-06, -5.4074212E-07,
     .         2.2418920E-07, -6.4375400E-08/
        IFAIL=1
        XCAP=((P-XMIN)-(XMAX-P))/(XMAX-XMIN)
        call E02AEE(M1,A,XCAP,F,IFAIL)
        if (IFAIL.NE.0) print *,'Error in E02AEE :',IFAIL
C       .89 accounts fo Grewall scale.
        DT2F=(F*.89**2)
        DNORF=DT2F/(T*1E-3)**2
        return
      end

CC    SPIN DIFFUSION COEFF D [cm**2/sec] vs P [bar], T[mk] -- DF(P,T)
      function DF(P,T)
        real DF, P,T, DNORF,DSUPF
        if (T.GT.TCF(P)) THEN
          DF=DNORF(P,T)
        else
          DF=DSUPF(P,T)
C          print *,'Superflow region. Check if data out range.'
        end if
        return
      end

      include 'E02AEE.FOR'
      include 'E02CBE.FOR'
      include 'M01AGE.FOR'
      include 'P01AAE.FOR'
      include 'X02AAE.FOR'
      include 'X04AAE.FOR'
