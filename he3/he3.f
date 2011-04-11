CLIBR=NAF: E02AEE, E02CBE, M01AGE.
      PROGRAM HE3
      CHARACTER BUFF*150,PNAM*8,BUFF1*150,BUFF2*4,QUAN*20
      INTEGER IBUFF1(75)
      EQUIVALENCE(IBUFF1,BUFF2),(BUFF2(3:),BUFF1)
      INTEGER IBUF(75)
      EQUIVALENCE (BUFF,IBUF)
      INTEGER K(2),L(2)
      LOGICAL MT
C     LOGICAL RUNST
      COMMON BUFF
      COMMON /OUTB/ OUT(20),NOUT,IOUT(20,2)
      COMMON /DATA/ PCP,TPCP,PA ,ANA,PI,HC,R,AKB,GAM,AM3
      REAL MVF,MV,MC,MCF,MA,MAF,LF2F,LF2,LF
      DATA PNAM/'/HE3:'/
      DATA BUFF2/',,'/
C     LBUFF=LEN*2
C     RUNST=LBUFF.NE.0
C     IF(RUNST) GOTO 2
 1    continue
      REWIND(101)
C     IF(RUNST) THEN
C     CALL EXEC(14,2,OUT,NOUT*2)
C     CALL EXEC(6,0,-1)
C     END IF
      LU=0
      OPEN (101,STATUS='SCRATCH')
      WRITE(LU,'(A,''Command : '',\)') PNAM
      READ(LU,'(A)')BUFF
c     LBUFF=ITLOG()
      LBUFF=80
 2    CONTINUE
      IF(MT) THEN
        REWIND(101)
        WRITE(101,*) QUAN,VAR
        REWIND(101)
        READ(101,'(A)') BUFF
        REWIND(101)
        WRITE(*,*) BUFF
      ENDIF
      NOUT=0
      ITC=INDEX(BUFF,'TC')
      IGH=INDEX(BUFF,'GH')
      IMV=INDEX(BUFF,'MV')
      IMC=INDEX(BUFF,'MC')
      IHI=INDEX(BUFF,'HI')
      ILF=INDEX(BUFF,'LF')
      IVF=INDEX(BUFF,'VF')
      IPF=INDEX(BUFF,'PF')
      IMA=INDEX(BUFF,'MA')
      IF1S=INDEX(BUFF,'F1S')
      ITAB=INDEX(BUFF,'TAB')
      IGAMM=INDEX(BUFF,'GAMM')
      IGMM=INDEX(BUFF,'GMM')
      IGAMM=INDEX(BUFF,'GAMM')
      ISH=INDEX(BUFF,'SH')
      IOS=INDEX(BUFF,'OS')
      ICF=INDEX(BUFF,'CF')
      ICPAR=INDEX(BUFF,'CPAR')
      ICPER=INDEX(BUFF,'CPER')
      ID=INDEX(BUFF,'D')
      ICMB=INDEX(BUFF,'CMB')
      ICM=INDEX(BUFF,'CM')
      IZ0=INDEX(BUFF,'Z0')
      IYO=INDEX(BUFF,'YO')
C--  Gradient to field.
      IF(IGH.GT.0) THEN
      CALL FINDS(IGH,2,IS1,IS2)
C     READ(BUFF(IS1:IS2),*)GRAD
      WRITE(101,'(A)')BUFF(IS1:IS2)
      REWIND (101)
      READ(101,*)GRAD
      FIELD=GRAD/400  *  .2  /370    * 10000
C       mV   Oe/cm      cm    oE/A     mV/A
      CALL OUTS(FIELD)
      PRINT '(A,''H('',F4.1,'' mA)='',F5.3,'' mV'')',PNAM,GRAD,FIELD
      END IF
C--
      IF(ITC.GT.0) THEN
      CALL FINDS(ITC,2,IS1,IS2)

C     READ(BUFF(IS1:IS2),*)P
      WRITE(101,'(A)')BUFF(IS1:IS2)
      REWIND (101)
      READ(101,*)P

      TC=TCF(P)
      CALL OUTS(TC)
      PRINT '(A,''Tc('',F4.1,'' bar)='',F5.3,'' mK'')',PNAM,P,TC
      END IF
C--  Leggett frequensy.
      IF(ILF.GT.0) THEN
      CALL FINDS(ILF,2,IS1,IS2)
C     READ(BUFF(IS1:IS2),*)P,T
      WRITE(101,'(A)')BUFF(IS1:IS2)
      REWIND (101)
      READ(101,*)P,T
      IF(T.GT.0) T=T*TCF(P)
      T=ABS(T)
      LF2=LF2F(P,T/TCF(P))
      LF=SQRT(LF2)
      CALL OUTS(LF)
      PRINT '(A,''Leg. fr. LF ('',F4.1,'' bar,'',F5.3,'' mK)='',
     ,1PG11.5'' Hz'',1x,G11.5,'' rad/sec'')',PNAM,P,T,LF,LF*2*PI
      PRINT '(A,10X,''LF**2='',1PG11.5,'' Hz**2, '',
     ,G11.5,'' (rad/sec)**2'')',
     ,PNAM,LF2,LF2*(2*PI)**2
      END IF
C--
      IF(IHI.GT.0) THEN
      CALL FINDS(IHI,2,IS1,IS2)
C     READ(BUFF(IS1:IS2),*)P,T
      WRITE(101,'(A)')BUFF(IS1:IS2)
      REWIND (101)
      READ(101,*)P,T
      IF(T.LT.0) T=-T*TCF(P)
      HI=HIF(P,T)
      CALL OUTS(HI)
      PRINT '(A,''Susceptibility ('',F4.1,'' bar,'',F5.3,'' mK)='',
     ,1PG11.5'' sgs'')',PNAM,P,T,HI
      END IF
C--
      IF(IGMM.GT.0) THEN
      CALL OUTS(GAM)
      PRINT '(A,''Gyromagnetic ratio = '',F7.1,'' sgs'')',PNAM,GAM
      END IF
C--
      IF(IMV.GT.0) THEN
      CALL FINDS(IMV,2,IS1,IS2)
C     READ(BUFF(IS1:IS2),*)P
      WRITE(101,'(A)')BUFF(IS1:IS2)
      REWIND (101)
      READ(101,*)P
      MV=MVF(P)
      CALL OUTS(MV)
      PRINT '(A,''Molar volume('',F4.1,'' bar)='',F6.3'' cm**3'')',
     ,PNAM,P,MV
      END IF
C--
      IF(IVF.GT.0) THEN
      CALL FINDS(IVF,2,IS1,IS2)
C     READ(BUFF(IS1:IS2),*)P
      WRITE(101,'(A)')BUFF(IS1:IS2)
      REWIND (101)
      READ(101,*)P
      VF=VFF(P)
      CALL OUTS(VF)
      PRINT '(A,''Fermi velosity ('',F5.2,'' bar)='',F7.1,'' cm/sec'')',
     ,PNAM,P,VF
      END IF
C--
      IF(IMC.GT.0) THEN
      CALL FINDS(IMC,2,IS1,IS2)
C     READ(BUFF(IS1:IS2),*)T
      WRITE(101,'(A)')BUFF(IS1:IS2)
      REWIND (101)
      READ(101,*)T
      MC=MCF(T)
      CALL OUTS(MC)
      PRINT '(A,''Melting pressure('',F6.4,'' mK)='',F8.5,'' bar'')',
     ,PNAM,T,MC
      END IF
C--   F1S
      IF(IF1S.GT.0) THEN
      CALL FINDS(IF1S,3,IS1,IS2)
C     READ(BUFF(IS1:IS2),*)P
      WRITE(101,'(A)')BUFF(IS1:IS2)
      REWIND (101)
      READ(101,*)P
      MA=MAF(P)
      F1S=(MA/AM3-1)*3.
      CALL OUTS(F1S)
      PRINT '(A,''F1-S('',F5.2,'' bar)='',F6.3)',PNAM,P,F1S
      END IF
C--   Z0
      IF(IZ0.GT.0) THEN
      CALL FINDS(IZ0,2,IS1,IS2)
      WRITE(101,'(A)')BUFF(IS1:IS2)
      REWIND (101)
      READ(101,*)P
      Z0=Z0F(P)
      CALL OUTS(Z0)
      PRINT '(A,''Z0('',F5.2,'' bar)='',F7.4)',PNAM,P,Z0
      END IF
C--   Yosida
      IF(IYO.GT.0) THEN
      CALL FINDS(IYO,2,IS1,IS2)
      WRITE(101,'(A)')BUFF(IS1:IS2)
      REWIND (101)
      READ(101,*)TTC
      Y=YOSHIDF(TTC)
      CALL OUTS(Y)
      PRINT '(A,''Y('',F5.2,'' bar)='',F7.5)',PNAM,P,Y
      END IF
C--
      IF(IMA.GT.0) THEN
      CALL FINDS(IMA,2,IS1,IS2)
C     READ(BUFF(IS1:IS2),*)P
      WRITE(101,'(A)')BUFF(IS1:IS2)
      REWIND (101)
      READ(101,*)P
      MA=MAF(P)
      CALL OUTS(MA)
      CALL OUTS(MA)
      PRINT '(A,''Effective mass('',F5.2,'' bar)='',1PG13.7,'' g = '',
     ,0PF5.5)',PNAM,P,MA,MA/AM3
      END IF
C--
      IF(IPF.GT.0) THEN
      CALL FINDS(IPF,2,IS1,IS2)
C     READ(BUFF(IS1:IS2),*)P
      WRITE(101,'(A)')BUFF(IS1:IS2)
      REWIND (101)
      READ(101,*)P
      PF=PFF(P)
      CALL OUTS(PF)
      PRINT'(A,''Fermi momentum ('',F5.2,'' bar)='',1PG13.7,'' sgs'')',
     ,PNAM,P,PF
      END IF
C--
      IF(ITAB.GT.0) THEN
      CALL FINDS(ITAB,3,IS1,IS2)
C     READ(BUFF(IS1:IS2),*)P
      WRITE(101,'(A)')BUFF(IS1:IS2)
      REWIND (101)
      READ(101,*)P
      TAB=TABF(P)
      CALL OUTS(TAB)
      PRINT '(A,''T A-B('',F4.1,'' bar)='',F5.3'' mK'')',PNAM,P,TAB
      END IF
C--
      IF(IGAMM.GT.0) THEN
      CALL FINDS(IGAMM,4,IS1,IS2)
C     READ(BUFF(IS1:IS2),*)P
      WRITE(101,'(A)')BUFF(IS1:IS2)
      REWIND (101)
      READ(101,*)P

      GAMMA=GAMMAF(P)
      CALL OUTS(GAMMA)
      PRINT '(A,''C/RT ('',F4.1,'' bar)='',F5.3,'' 1/(K*mol)'')',
     ,PNAM,P,GAMMA
      END IF
C--  Osheroff's spin wave velocity.
      IF(IOS.GT.0) THEN
      CALL FINDS(IOS,2,IS1,IS2)

C     READ(BUFF(IS1:IS2),*)P,T
      WRITE(101,'(A)')BUFF(IS1:IS2)
      REWIND (101)
      READ(101,*)P,T

      T=TF(T,P)
      S=SF(P,T)
      CALL OUTS(S)
      PRINT'(A,''S('',F4.1,'' bar, '',F5.3,'' mK)='',
     ,1PG13.6,'' cm/sek'')',PNAM,P,T,S
      END IF
C--  Parallel Fomin spin wave velocity.
      IF(ICPAR.GT.0) THEN
      CALL FINDS(ICPAR,4,IS1,IS2)

C     READ(BUFF(IS1:IS2),*)P,T
      WRITE(101,'(A)')BUFF(IS1:IS2)
      REWIND (101)
      READ(101,*)P,T

      T=TF(T,P)
      CPAR=CPARF(P,T)
      CALL OUTS(CPAR)
      PRINT'(A,''Cpar('',F4.1,'' bar, '',F5.3,'' mK)='',
     ,1PG13.6,'' cm/sek'')',PNAM,P,T,CPAR
      END IF
C--  Perpendicular Fomin spin wave velocity.
      IF(ICPER.GT.0) THEN
      CALL FINDS(ICPER,4,IS1,IS2)

C     READ(BUFF(IS1:IS2),*)P,T
      WRITE(101,'(A)')BUFF(IS1:IS2)
      REWIND (101)
      READ(101,*)P,T

      T=TF(T,P)
      CPER=SF(P,T)*SQRT(1.5)
      CALL OUTS(CPER)
      PRINT'(A,''Cperp('',F4.1,'' bar, '',F5.3,'' mK)='',
     ,1PG13.6,'' cm/sek'')',PNAM,P,T,CPER
      END IF
C--  Fomin combination of spin wave velocities.
      IF(ICF.GT.0) THEN
      CALL FINDS(ICF,2,IS1,IS2)

C     READ(BUFF(IS1:IS2),*)P,T
      WRITE(101,'(A)')BUFF(IS1:IS2)
      REWIND (101)
      READ(101,*)P,T

      T=TF(T,P)
      CF=SF(P,T)*SQRT(11./8.)
      CALL OUTS(C)
      PRINT'(A,''C('',F4.1,'' bar, '',F5.3,'' mK)='',
     ,1PG13.6,'' cm/sek'')'  ,PNAM,P,T,CF
      END IF
C--  Heat capacity.
      IF(ISH.GT.0) THEN
      CALL FINDS(ISH,2,IS1,IS2)

C     READ(BUFF(IS1:IS2),*)P,T
      WRITE(101,'(A)')BUFF(IS1:IS2)
      REWIND (101)
      READ(101,*)P,T

      SH=GAMMAF(P)*R*T*1E-3
      CALL OUTS(SH)
      PRINT'(A,''C('',F4.1,'' bar, '',F5.3,'' mK)='',
     ,1PG13.6,'' erg/(K*mol)'')',PNAM,P,T,SH
      END IF
C--
      IF(ID.GT.0) THEN
      CALL FINDS(ID,1,IS1,IS2)

C     READ(BUFF(IS1:IS2),*)P,T
      WRITE(101,'(A)')BUFF(IS1:IS2)
      REWIND (101)
      READ(101,*)P,T

      T=TF(T,P)
      IF(T.GT.TCF(P)) THEN
      D=DF(P,T)
      ELSE
      D=DSUPF(P,T)
      PRINT *,'Superflow region. Check if data out range.'
      END IF
      CALL OUTS(D)
      PRINT'(A,''D('',F4.1,'' bar, '',F5.3,'' mK)='',
     ,1PG13.6,'' cm**2/sec'')',PNAM,P,T,D
      END IF
C    Output of a table
      IF (MT) THEN
        WRITE(102,*)VAR,OUT(1)
        VAR = VAR+STEP
        IF (VAR.GT.FLAST) THEN
          MT=.FALSE.
          CLOSE(102)
          GOTO 1
        END IF
	GOTO 2
      END IF
C--
      IF(BUFF.EQ.'H'.OR.BUFF.EQ.'?') THEN
        OPEN(49,FILE='HE3.HLP',STATUS='OLD')
        DO 1201 J=1,10000
          READ(49,'(A)',END=55)BUFF
c         LENB=ITLOG()
          LENB=80
          IF(BUFF(:4).EQ.'****') GOTO 55
          WRITE(LU,'(A)')BUFF(:LENB)
 1201   continue
 55     CLOSE(49)
        BUFF=' '
      ELSE IF(BUFF.EQ.'E'.OR.BUFF.EQ.'A'.OR.
     .BUFF.EQ.'EX') THEN
        PRINT *,pnam,'End.'
        CLOSE (101)
        STOP
      ELSE IF(BUFF.EQ.'MT') THEN
        MT=.TRUE.
        WRITE(*,'('' Quantity: '',\)')
        read(*,'(A)') QUAN
        WRITE(*,'('' First,last,step: '',\)')
        read(*,*) FIRST,FLAST,STEP
        VAR=FIRST
        OPEN(102,FILE='HE3.DAT')
        WRITE(102,*)'Table of ',quan
	GOTO 2
      END IF
C--
      IF(INDEX(BUFF,'/').GT.0.OR.INDEX(BUFF,'+').GT.0.OR.
     .INDEX(BUFF,'*').GT.0.OR.INDEX(BUFF,'^').GT.0)THEN
      DO 1202 J=NOUT+1,20
c     IOUT(J,1)=#0efff
      IOUT(J,1)=-1
 1202 continue
C-- Sorting.
      IFAIL=111
      CALL M01AGE(IOUT,20,2,1,K,L,IFAIL)
C--
C     PRINT *,'BUFF',BUFF
      I=1
      IB1=1
      DO 1203 J=1,NOUT
C     PRINT *,'I1,I2,NOUT',IOUT(J,1),IOUT(J,2),NOUT,J,IB1,I
      I1=IOUT(J,1)
      IF(I1-I.GE.0) THEN
      BUFF1(IB1:)=BUFF(I:I1)
C     PRINT *,'I,I1,BUFF(I:I1)',I,I1,BUFF(I:I1),IB1
      IB1=IB1+(I1-I)+1
C     PRINT *,IB1
      END IF
      I=IOUT(J,2)
      WRITE(BUFF1(IB1:),'(G15.7)')OUT(J)
C     PRINT *,BUFF1(:IB1)
      IB1=IB1+15
 1203 continue
      IF(LBUFF-I.GE.0) THEN
      BUFF1(IB1:)=BUFF(I:LBUFF)
      IB1=IB1+(LBUFF-I)
      ELSE
      IB1=IB1-1
      END IF
C     PRINT *,BUFF1(:IB1)
C     CALL EXEC(100011B,6HC      ,0,0,0,0,0,IBUFF1,-IB1)
C     I=I+1
      END IF
      GO TO1
      END
C--
      SUBROUTINE FINDS(I,IL,IS1,IS2)
      CHARACTER BUFF*150
      COMMON BUFF
      COMMON /OUTB/ OUT(20),NOUT,IOUT(20,2)
      IE=I+IL
      IS1=INDEX(BUFF(IE:),'(')+IE
      IS2=INDEX(BUFF(IE:),')')
      IF(IS2.GT.0) THEN
      IS2=IS2-2+IE
      ELSE
      IS2=150
      END IF
      NOUT=NOUT+1
      IF(NOUT.GT.20) STOP'Too many functions.'
      IOUT(NOUT,1)=I-1
      IOUT(NOUT,2)=IS2+2
C     PRINT *,'I,IS1,IS2,IL,IE,NOUT',I,IS1,IS2,IL,IE,NOUT
      END
      FUNCTION TCF(P)
C--  Greywall. Phys. Rev.B v.33 #11 p.7520
C    P [bars], Tc [mK]
      TCF=.92938375+.13867188*P-.69302185E-2*P**2+.25685169E-3*P**3-
     -.57248644E-5*P**4+.53010918E-7*P**5
      RETURN
      END
      REAL FUNCTION MVF(P)
C--  Greywall. Phys. Rev.B v.33 #11 p.7520 ref. 27
C-- That is Wheatley Rev.Mod.Phys. 47,415(1975).
C    P [bars], V[cm**3/mole].
      MVF=36.837231-1.1803474*P+.0834214*P**2-.3885962E-2*P**3+
     +.94759780E-4*P**4-.91253577E-6*P**5
      RETURN
      END
C---
      REAL FUNCTION MCF(T)
C--  Greywall. Phys. Rev.B v.33 #11 p.7520
C    P [bars], Tc [mK]
      COMMON /DATA/ PCP,TPCP,PA ,ANA,PI,HC,R,AKB,GAM,AM3
      MCF=PA-.19652970E-1*T**(-3)-.61880268E-1*T**(-2)-
     -.78803055E-1*T**(-1)+.13050600-.43519381E-1*T+.13752791E-3*T**2-
     -.17180436E-6*T**3-.22093906E-9*T**4+.85450245E-12*T**5
      END
C--
      FUNCTION TABF(P)
C--  Greywall. Phys. Rev.B v.33 #11 p.7520
C    P [bars], Tc [mK]
      COMMON /DATA/ PCP,TPCP,PA ,ANA,PI,HC,R,AKB,GAM,AM3
      PR=P-PCP
      TABF=TPCP-.10322623E-1*PR-.53633181E-2*PR**2+.83437032E-3*PR**3-
     -.61709783E-4*PR**4+.17038992E-5*PR**5
      IF(PR.LT.0) TABF=TCF(P)
      END
C--
      FUNCTION GAMMAF(P)
C--  Greywall. Phys. Rev.B v.33 #11 p.7520
C    P [bars], Tc [mK]
C--  GAMMA=C/(R*T)  R-Gas constant.
      GAMMAF=.27840464E01+.69575243E-1*P-.14738303E-2*P**2+
     +.46153498E-4*P**3-.53785385E-6*P**4
      END
C---
      REAL FUNCTION PFF(P)
      COMMON /DATA/ PCP,TPCP,PA ,ANA,PI,HC,R,AKB,GAM,AM3
      REAL MVF
      PFF=HC*(3*PI**2*ANA/MVF(P))**.3333333
      END
C--
      REAL FUNCTION VFF(P)
      REAL MAF
      VFF=PFF(P)/MAF(P)
      END
C--
      FUNCTION DNDEF(P)
C-- Attention density of state must be multiplyied by ANA later.
      COMMON /DATA/ PCP,TPCP,PA ,ANA,PI,HC,R,AKB,GAM,AM3
      DNDEF=3.*GAMMAF(P)/AKB/PI**2
      END
C--
      REAL FUNCTION MAF(P)
      REAL MVF
      COMMON /DATA/ PCP,TPCP,PA ,ANA,PI,HC,R,AKB,GAM,AM3
      PF=PFF(P)
C     MAF=GAMMAF(P)*R*HC*MVF(P)*(HC/PF)*3
C     PRINT *,GAMMAF(P),GAMMAF(P)*R*HC,R
      MAF=DNDEF(P)*PF/3.*PF
C     MAF=DNDEF(P)*PF/3./MVF(P)*PF
      END
C--
      FUNCTION HIF(P,T)
      REAL MVF
      COMMON /DATA/ PCP,TPCP,PA ,ANA,PI,HC,R,AKB,GAM,AM3
      HIF=.25*GAM**2*HC*DNDEF(P)*HC*ANA/(1+Z0F(P)/4)/MVF(P)
      TTC=T/TCF(P)
      IF(TTC.LT.1) THEN
      Z0=Z0F(P)
      Y=YOSHIDF(TTC)
C     PRINT *,Z,Y,((1.+Z0/4.)*(2.+Y)/3.)/(1.+Z0/4.*(2.+Y)/3.)
      HIF=HIF*((1.+Z0/4.)*(2.+Y)/3.)/(1.+Z0/4.*(2.+Y)/3.)
      END IF
      END
C--
      FUNCTION Z0F(P)
C-- Sourse B-phase notebook.
C Least squares fitting. From file: YZ0
C  Z0=                   vs.  P=
C Polinom of the order : 5
C Residual: 0.000
      REAL A(5)
      DATA M1/ 5/
      DATA XMIN/   0.000000    /,XMAX/   34.36000    /
     0 DATA A/-5.762472,-.1136529,5.5511940E-02,
     1 -1.7914600E-02,4.0055060E-03/
      IFAIL=1
      XCAP=((P-XMIN)-(XMAX-P))/(XMAX-XMIN)
      CALL E02AEE(M1,A,XCAP,Z0F,IFAIL)
      IF(IFAIL.NE.0)PRINT *,'Error in E02AEE :',IFAIL
      END
C--
      BLOCK DATA
      COMMON /DATA/ PCP,TPCP,PA ,ANA,PI,HC,R,AKB,GAM,AM3
      DATA PCP/21.22/,TPCP/2.273/,PA/34.358/
C--  Greywall. Phys. Rev.B v.33 #11 p.7520
C    P [bars], Tc [mK]
      DATA ANA/6.02252E23/,PI/3.141592/,HC/1.05450E-27/,R/8.3143E+7/
C- HC in SGS., AKB too.
      DATA AKB/1.38054E-16/,GAM/20378/,AM3/5.0079E-24/
      END
C--
      REAL FUNCTION LF2F(P,T)
C-- Ahonen (18.7,21.1,25.4,29.0,32 bars), Osheroff(MP).
C-- Ahonen et.al.  JLTP. v.25 p.421(1976)
C-- Osheroff       PRL v.34. p.190
C-- From 0 to 18.7 bar data are not reliable.
C-- See file YOM3.
C Least squares 2-D fitting. From fil:: YOM3
C  F= vs. T= & P=
C Polinmms of the orders : 4,  1
      REAL WORK( 5),A( 10)
      DATA XMIN/   .2660000    /,XMAX/   1.000000    /
      DATA YMIN/   0.000000    /,YMAX/   34.36000    /
      DATA K/ 4/,L/ 1/,NA/ 10/,NWORK/5/
      DATA A/  1.3169660E+11,  5.0310062E+10, -6.6371420E+10
     ,, -2.0536020E+10, -5.2457041E+09, -5.1179683E+09,  5.8596372E+09
     ,,  3.1320310E+08, -6.9788020E+07,  2.0270360E+08/
      IF(T.LT.TABF(P)/TCF(P)) THEN
      IFAIL=1
      CALL E02CBE(1,1,K,L,T,XMIN,XMAX,P,YMIN,YMAX,F,
     ,A,NA,WORK,NWORK,IFAIL)
      LF2F=F
      IF(IFAIL.EQ.2) THEN
      PRINT *,'P out of range:',YMIN,YMAX
      LF2F=0
      ELSE IF(IFAIL.EQ.3) THEN
      PRINT *,'T out of range:',XMIN,XMAX
      LF2F=0
      ELSE IF(IFAIL.NE.0) THEN
      PRINT *,'Error:',IFAIL
      LF2F=0
      END IF
      IF(P.LT.18.7) PRINT *,'Data not reliable.'
      ELSE
      PRINT *,'No data for A-phase.'
      LF2F=0
      END IF
      END
C--
      SUBROUTINE OUTS(OUTV)
      COMMON /OUTB/ OUT(20),NOUT,IOUT(20,2)
      IF(NOUT.LE.20)OUT(NOUT)=OUTV
      END
C--
      FUNCTION DF(P,T)
C-- Brewer data for D*T**2
C--  JLTP v.56 #5/6 p.617
C Least squares fitting. From file: YDIFD
C  DT2=                  vs.  P=
C Polinom of the order : 4
C Residual: 0.000
      REAL A(  4)
      DATA M1/ 4/
      DATA XMIN/   0.000000    /,XMAX/   27.75999    /
      DATA A/  1.0603673E-06, -5.4074212E-07,  2.2418920E-07
     ,, -6.4375400E-08/
C--
      IFAIL=1
      XCAP=((P-XMIN)-(XMAX-P))/(XMAX-XMIN)
      CALL E02AEE(M1,A,XCAP,F,IFAIL)
      IF(IFAIL.NE.0)PRINT *,'Error in E02AEE :',IFAIL
C .89 accounts fo Grewall scale.
      DT2F=(F*.89**2)
      DF=DT2F/(T*1E-3)**2
      END
C--
      FUNCTION YOSHIDF(TTC)
C-- Sourse B-phase notebook.
C Least squares fitting. From file: YOSHID
C  Y=                    vs.  T=
C Polinom of the order : 5
C Residual: 0.000
      REAL A(  5)
      DATA M1/ 5/
      DATA XMIN/  9.9999994E-02/,XMAX/   1.000000    /
      DATA A/   .7349111    ,   .5123515    ,   .1371038
     ,, -1.4855450E-02, -4.5979050E-03/
      IF(TTC.GE..1) THEN
      IFAIL=1
      XCAP=((TTC-XMIN)-(XMAX-TTC))/(XMAX-XMIN)
      CALL E02AEE(M1,A,XCAP,YOSHIDF,IFAIL)
      IF(IFAIL.NE.0)PRINT *,'Error in E02AEE :',IFAIL
      ELSE
      YOSHIDF=0
      END IF
      RETURN
      END
C--
      FUNCTION F0AF(P)
C-  Sourse - Greywall, Phys.Rev.  v.27  5  (1983)
C Least squares fitting. From file: YF0A
C  F0A=                  vs.  P=
C Polinom of the order : 7
C Residual: 0.000
      REAL A(  7)
      DATA M1/ 7/
      DATA XMIN/   0.000000    /,XMAX/   34.36000    /
      DATA A/  -1.489332    , -2.3159460E-02,  1.3571171E-02
     ,, -4.2908173E-03,  1.4413130E-03, -1.1601811E-03,  9.9658221E-04/
      IFAIL=1
      XCAP=((P-XMIN)-(XMAX-P))/(XMAX-XMIN)
      CALL E02AEE(M1,A,XCAP,F0AF,IFAIL)
      IF(IFAIL.NE.0)PRINT *,'Error in E02AEE :',IFAIL
      END
C---
      FUNCTION DSUPF(P,T)
C-- Our data. Was measured at pressures .6,11,14.8,20,29 bar
C   at T .45-.67,  .45-.8  .45-.81  .45-.94  .45-.67 Tc respectivly.
C Least squares 2-D fitting. From fil:: MUHLR1
C  D/C= vs. T= & P=
C Polinoms of the orders : 4,  4
      REAL WORK( 5),A( 25)
      DATA XMIN/   .4400000    /,XMAX/   .9400001    /
      DATA YMIN/   0.000000    /,YMAX/   29.00000    /
      DATA K/ 4/,L/ 4/,                          NA/ 25/,NWORK/5/
      DATA A/  6.6012963E-03, -2.2342042E-03,  4.2030680E-04
     ,,  1.6044091E-04, -8.2734930E-04,  1.7867290E-03, -6.6435340E-04
     ,, -1.8627312E-04,  4.3953900E-04, -6.3450170E-04, -4.1724560E-04
     ,,  3.9544643E-04, -3.2521144E-04,  1.7599921E-04, -1.9650970E-04
     ,,  1.2244173E-04,  3.2786340E-05,  6.5047061E-08, -3.2710520E-05
     ,, -6.1170401E-05,  3.7204154E-05,  9.9630890E-06,  1.2296370E-08
     ,, -9.9427400E-06, -1.8589210E-05/
      TR=T/TCF(P)
      IFAIL=1
      CALL E02CBE(1,1,K,L,TR,XMIN,XMAX,P,YMIN,YMAX,F,
     ,A,NA,WORK,NWORK,IFAIL)
      IF(IFAIL.EQ.2) THEN
      PRINT *,'Y out of range.'
      ELSE IF(IFAIL.EQ.3) THEN
      PRINT *,'X out of range.'
      ELSE IF(IFAIL.NE.0) THEN
      PRINT *,'Error:',IFAIL
      END IF
      DSUPF=F*CPARF(P,T)**(.6666666666666)
      END
C--
      FUNCTION SF(P,T)
C  Osheroff's spin vawe velocity if recalculated to arbitrary pressure
C  by taking value of Osheroff for melting pressure (1100 cm/sek)
C  and assuming S is proportional to Fermi velocity.
      REAL MCF
      SF=1100/VFF(34.3)*VFF(P)*SQRT(1-T/TCF(P))
C     PRINT *,T,VFF(34.3),P,VFF(P),TCF(P)
      END
C--
      FUNCTION TF(T,P)
      IF(T.LT.0) T=T*TCF(P)
      TF=ABS(T)
      END
C--
      FUNCTION CPARF(P,T)
      CPARF=SF(P,T)*SQRT(2.)
      END

$INCLUDE: 'E02AEE.FOR'
$INCLUDE: 'E02CBE.FOR'
$INCLUDE: 'M01AGE.FOR'
$INCLUDE: 'P01AAE.FOR'
$INCLUDE: 'X02AAE.FOR'
$INCLUDE: 'X04AAE.FOR'
