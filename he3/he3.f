CLIBR=NAF: E02AEE, E02CBE, M01AGE.
      program HE3
      character BUFF*150,PNAM*8,BUFF1*150,BUFF2*4,QUAN*20
      integer IBUFF1(75)
      EQUIVALENCE(IBUFF1,BUFF2),(BUFF2(3:),BUFF1)
      integer IBUF(75)
      EQUIVALENCE (BUFF,IBUF)
      integer K(2),L(2)
      logical MT
C     LOGICAL RUNST
      common BUFF
      common /OUTB/ OUT(20),NOUT,IOUT(20,2)
      common /DATA/ PCP,TPCP,PA ,ANA,PI,HC,R,AKB,GAM,AM3
      real MVF,MV,MC,MCF,MA,MAF,LF2F,LF2,LF
      DATA PNAM/'/HE3:'/
      DATA BUFF2/',,'/
C     LBUFF=LEN*2
C     RUNST=LBUFF.NE.0
C     if (RUNST) GOTO 2
 1    continue
      rewind(101)
C     if (RUNST) then
C     call EXEC(14,2,OUT,NOUT*2)
C     call EXEC(6,0,-1)
C     end if
      OPEN (101,STATUS='SCRATCH')
      write(*,'(A,''Command : '')') PNAM
      read(*,'(A)')BUFF
c     LBUFF=ITLOG()
      LBUFF=80
 2    continue

      if (MT) then
        rewind(101)
        write(101,*) QUAN,VAR
        rewind(101)
        read(101,'(A)') BUFF
        rewind(101)
        write(*,*) BUFF
      endif

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
      if1S=INDEX(BUFF,'F1S')
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
      if (IGH.GT.0) then
      call FINDS(IGH,2,IS1,IS2)
C     read(BUFF(IS1:IS2),*)GRAD
      write(101,'(A)')BUFF(IS1:IS2)
      rewind (101)
      read(101,*)GRAD
      FIELD=GRAD/400  *  .2  /370    * 10000
C       mV   Oe/cm      cm    oE/A     mV/A
      call OUTS(FIELD)
      print '(A,''H('',F4.1,'' mA)='',F5.3,'' mV'')',PNAM,GRAD,FIELD
      end if
C--
      if (ITC.GT.0) then
        call FINDS(ITC,2,IS1,IS2)
C       read(BUFF(IS1:IS2),*)P
        write(101,'(A)')BUFF(IS1:IS2)
        rewind (101)
        read(101,*)P
        TC=TCF(P)
        call OUTS(TC)
        print '(A,''Tc('',F4.1,'' bar)='',F5.3,'' mK'')',PNAM,P,TC
      end if

C--  Leggett frequensy.
      if (ILF.GT.0) then
        call FINDS(ILF,2,IS1,IS2)
C       read(BUFF(IS1:IS2),*)P,T
        write(101,'(A)')BUFF(IS1:IS2)
        rewind (101)
        read(101,*)P,T
        if (T.GT.0) T=T*TCF(P)
        T=ABS(T)
        LF2=LF2F(P,T/TCF(P))
        LF=SQRT(LF2)
        call OUTS(LF)
        print '(A,''Leg. fr. LF ('',F4.1,'' bar,'',F5.3,'' mK)='',
     ,    1PG11.5'' Hz'',1x,G11.5,'' rad/sec'')',PNAM,P,T,LF,LF*2*PI
        print '(A,10X,''LF**2='',1PG11.5,'' Hz**2, '',
     ,    G11.5,'' (rad/sec)**2'')',
     ,    PNAM,LF2,LF2*(2*PI)**2
      end if
C--
      if (IHI.GT.0) then
        call FINDS(IHI,2,IS1,IS2)
C       read(BUFF(IS1:IS2),*)P,T
        write(101,'(A)')BUFF(IS1:IS2)
        rewind (101)
        read(101,*)P,T
        if (T.LT.0) T=-T*TCF(P)
        HI=HIF (P,T)
        call OUTS(HI)
        print '(A,''Susceptibility ('',F4.1,'' bar,'',F5.3,'' mK)='',
     ,    1PG11.5'' sgs'')',PNAM,P,T,HI
      end if
C--
      if (IGMM.GT.0) then
        call OUTS(GAM)
        print '(A,''Gyromagnetic ratio = '',F7.1,'' sgs'')',PNAM,GAM
      end if
C--
      if (IMV.GT.0) then
        call FINDS(IMV,2,IS1,IS2)
C       read(BUFF(IS1:IS2),*)P
        write(101,'(A)')BUFF(IS1:IS2)
        rewind (101)
        read(101,*)P
        MV=MVF(P)
        call OUTS(MV)
        print '(A,''Molar volume('',F4.1,'' bar)='',F6.3'' cm**3'')',
     ,    PNAM,P,MV
      end if
C--
      if (IVF.GT.0) then
        call FINDS(IVF,2,IS1,IS2)
C       read(BUFF(IS1:IS2),*)P
        write(101,'(A)')BUFF(IS1:IS2)
        rewind (101)
        read(101,*)P
        VF=VFF(P)
        call OUTS(VF)
        print
     ,  '(A,''Fermi velosity ('',F5.2,'' bar)='',F7.1,'' cm/sec'')',
     ,  PNAM,P,VF
      end if
C--
      if (IMC.GT.0) then
        call FINDS(IMC,2,IS1,IS2)
C       read(BUFF(IS1:IS2),*)T
        write(101,'(A)')BUFF(IS1:IS2)
        rewind (101)
        read(101,*)T
        MC=MCF(T)
        call OUTS(MC)
        print
     ,  '(A,''Melting pressure('',F6.4,'' mK)='',F8.5,'' bar'')',
     ,  PNAM,T,MC
      end if

C--   F1S
      if (IF1S.GT.0) then
        call FINDS(IF1S,3,IS1,IS2)
C       read(BUFF(IS1:IS2),*)P
        write(101,'(A)')BUFF(IS1:IS2)
        rewind (101)
        read(101,*)P
        MA=MAF(P)
        F1S=(MA/AM3-1)*3.
        call OUTS(F1S)
        print '(A,''F1-S('',F5.2,'' bar)='',F6.3)',PNAM,P,F1S
      end if

C--   Z0
      if (IZ0.GT.0) then
      call FINDS(IZ0,2,IS1,IS2)
      write(101,'(A)')BUFF(IS1:IS2)
      rewind (101)
      read(101,*)P
      Z0=Z0F(P)
      call OUTS(Z0)
      print '(A,''Z0('',F5.2,'' bar)='',F7.4)',PNAM,P,Z0
      end if

C--   Yosida
      if (IYO.GT.0) then
      call FINDS(IYO,2,IS1,IS2)
      write(101,'(A)')BUFF(IS1:IS2)
      rewind (101)
      read(101,*)TTC
      Y=YOSHIDF(TTC)
      call OUTS(Y)
      print '(A,''Y('',F5.2,'' bar)='',F7.5)',PNAM,P,Y
      end if
C--
      if (IMA.GT.0) then
        call FINDS(IMA,2,IS1,IS2)
C       read(BUFF(IS1:IS2),*)P
        write(101,'(A)')BUFF(IS1:IS2)
        rewind (101)
        read(101,*)P
        MA=MAF(P)
        call OUTS(MA)
        call OUTS(MA)
        print
     ,    '(A,''Effective mass('',F5.2,'' bar)='',1PG13.7,'' g = '',
     ,    0PF5.5)',PNAM,P,MA,MA/AM3
      end if
C--
      if (IPF.GT.0) then
        call FINDS(IPF,2,IS1,IS2)
C       read(BUFF(IS1:IS2),*)P
        write(101,'(A)')BUFF(IS1:IS2)
        rewind (101)
        read(101,*)P
        PF=PFF(P)
        call OUTS(PF)
        print
     ,    '(A,''Fermi momentum ('',F5.2,'' bar)='',1PG13.7,'' sgs'')',
     ,    PNAM,P,PF
      end if
C--
      if (ITAB.GT.0) then
        call FINDS(ITAB,3,IS1,IS2)
C       read(BUFF(IS1:IS2),*)P
        write(101,'(A)')BUFF(IS1:IS2)
        rewind (101)
        read(101,*)P
        TAB=TABF(P)
        call OUTS(TAB)
        print '(A,''T A-B('',F4.1,'' bar)='',F5.3'' mK'')',PNAM,P,TAB
      end if
C--
      if (IGAMM.GT.0) then
        call FINDS(IGAMM,4,IS1,IS2)
C       read(BUFF(IS1:IS2),*)P
        write(101,'(A)')BUFF(IS1:IS2)
        rewind (101)
        read(101,*)P

        GAMMA=GAMMAF(P)
        call OUTS(GAMMA)
        print '(A,''C/RT ('',F4.1,'' bar)='',F5.3,'' 1/(K*mol)'')',
     ,    PNAM,P,GAMMA
      end if

C--  Osheroff's spin wave velocity.
      if (IOS.GT.0) then
        call FINDS(IOS,2,IS1,IS2)
C       read(BUFF(IS1:IS2),*)P,T
        write(101,'(A)')BUFF(IS1:IS2)
        rewind (101)
        read(101,*)P,T

        T=TF(T,P)
        S=SF(P,T)
        call OUTS(S)
        print'(A,''S('',F4.1,'' bar, '',F5.3,'' mK)='',
     ,    1PG13.6,'' cm/sek'')',PNAM,P,T,S
      end if

C--  Parallel Fomin spin wave velocity.
      if (ICPAR.GT.0) then
        call FINDS(ICPAR,4,IS1,IS2)

C       read(BUFF(IS1:IS2),*)P,T
        write(101,'(A)')BUFF(IS1:IS2)
        rewind (101)
        read(101,*)P,T

        T=TF(T,P)
        CPAR=CPARF(P,T)
        call OUTS(CPAR)
        print'(A,''Cpar('',F4.1,'' bar, '',F5.3,'' mK)='',
     ,    1PG13.6,'' cm/sek'')',PNAM,P,T,CPAR
      end if

C--  Perpendicular Fomin spin wave velocity.
      if (ICPER.GT.0) then
        call FINDS(ICPER,4,IS1,IS2)

C       read(BUFF(IS1:IS2),*)P,T
        write(101,'(A)')BUFF(IS1:IS2)
        rewind (101)
        read(101,*)P,T

        T=TF(T,P)
        CPER=CPERF(P,T)
        call OUTS(CPER)
        print'(A,''Cperp('',F4.1,'' bar, '',F5.3,'' mK)='',
     ,    1PG13.6,'' cm/sek'')',PNAM,P,T,CPER
      end if

C--  Fomin combination of spin wave velocities.
      if (ICF.GT.0) then
        call FINDS(ICF,2,IS1,IS2)

C       read(BUFF(IS1:IS2),*)P,T
        write(101,'(A)')BUFF(IS1:IS2)
        rewind (101)
        read(101,*)P,T

        T=TF(T,P)
        CF=SF(P,T)*SQRT(11./8.)
        call OUTS(C)
        print'(A,''C('',F4.1,'' bar, '',F5.3,'' mK)='',
     ,    1PG13.6,'' cm/sek'')'  ,PNAM,P,T,CF
      end if

C--  Heat capacity.
      if (ISH.GT.0) then
        call FINDS(ISH,2,IS1,IS2)

C       read(BUFF(IS1:IS2),*)P,T
        write(101,'(A)')BUFF(IS1:IS2)
        rewind (101)
        read(101,*)P,T

        SH=GAMMAF(P)*R*T*1E-3
        call OUTS(SH)
        print'(A,''C('',F4.1,'' bar, '',F5.3,'' mK)='',
     ,    1PG13.6,'' erg/(K*mol)'')',PNAM,P,T,SH
      end if
C--
        if (ID.GT.0) then
          call FINDS(ID,1,IS1,IS2)

C         read(BUFF(IS1:IS2),*)P,T
          write(101,'(A)')BUFF(IS1:IS2)
          rewind (101)
          read(101,*)P,T

          T=TF(T,P)
          if (T.LE.TCF(P)) then
            print *,'Superflow region. Check if data out range.'
          endif

          D=DF(P,T)
          call OUTS(D)
          print'(A,''D('',F4.1,'' bar, '',F5.3,'' mK)='',
     ,      1PG13.6,'' cm**2/sec'')',PNAM,P,T,D
        end if

C       Output of a table
        if (MT) then
          write(102,*)VAR,OUT(1)
          VAR = VAR+STEP
          if (VAR.GT.FLAST) then
            MT=.FALSE.
            close(102)
            GOTO 1
          end if
          goto 2
        end if
C--
        if (BUFF.EQ.'H'.OR.BUFF.EQ.'?') then
          open (49,FILE='HE3.HLP',STATUS='OLD')
          do 1201 J=1,10000
            read(49,'(A)',end=55)BUFF
c           LENB=ITLOG()
            LENB=80
            if (BUFF(:4).EQ.'****') goto 55
            write(*,'(A)')BUFF(:LENB)
 1201     continue
 55       close(49)
          BUFF=' '
        else if (BUFF.EQ.'E'.OR.BUFF.EQ.'A'.OR.
     .      BUFF.EQ.'EX') then
          print *,pnam,'End.'
          close (101)
          stop
        else if (BUFF.EQ.'MT') then
          MT=.TRUE.
          write(*,'('' Quantity: '')')
          read(*,'(A)') QUAN
          write(*,'('' First,last,step: '')')
          read(*,*) FIRST,FLAST,STEP
          VAR=FIRST
          OPEN(102,FILE='HE3.DAT')
          write(102,*)'Table of ',quan
	  GOTO 2
        end if
C--
        if (INDEX(BUFF,'/').GT.0.OR.INDEX(BUFF,'+').GT.0.OR.
     .      INDEX(BUFF,'*').GT.0.OR.INDEX(BUFF,'^').GT.0) then
          do 1202 J=NOUT+1,20
c           IOUT(J,1)=#0efff
            IOUT(J,1)=-1
 1202     continue
C--       Sorting.
          IFAIL=111
          call M01AGE(IOUT,20,2,1,K,L,IFAIL)
C--
C         print *,'BUFF',BUFF
          I=1
          IB1=1
          do 1203 J=1,NOUT
C           print *,'I1,I2,NOUT',IOUT(J,1),IOUT(J,2),NOUT,J,IB1,I
            I1=IOUT(J,1)
            if (I1-I.GE.0) then
              BUFF1(IB1:)=BUFF(I:I1)
C             print *,'I,I1,BUFF(I:I1)',I,I1,BUFF(I:I1),IB1
              IB1=IB1+(I1-I)+1
C             print *,IB1
            end if
            I=IOUT(J,2)
            write(BUFF1(IB1:),'(G15.7)')OUT(J)
C           print *,BUFF1(:IB1)
            IB1=IB1+15
 1203     continue
          if (LBUFF-I.GE.0) then
            BUFF1(IB1:)=BUFF(I:LBUFF)
            IB1=IB1+(LBUFF-I)
          else
            IB1=IB1-1
          end if
C         print *,BUFF1(:IB1)
C         call EXEC(100011B,6HC      ,0,0,0,0,0,IBUFF1,-IB1)
C         I=I+1
        end if
        goto 1
      end
C--
      subroutine FINDS(I,IL,IS1,IS2)
        CHARACTER BUFF*150
        common BUFF
        common /OUTB/ OUT(20),NOUT,IOUT(20,2)
        IE=I+IL
        IS1=INDEX(BUFF(IE:),'(')+IE
        IS2=INDEX(BUFF(IE:),')')
        if (IS2.GT.0) then
          IS2=IS2-2+IE
        else
          IS2=150
        end if
        NOUT=NOUT+1
        if (NOUT.GT.20) stop 'Too many functions.'
        IOUT(NOUT,1)=I-1
        IOUT(NOUT,2)=IS2+2
C       print *,'I,IS1,IS2,IL,IE,NOUT',I,IS1,IS2,IL,IE,NOUT
      end

      subroutine OUTS(OUTV)
        common /OUTB/ OUT(20),NOUT,IOUT(20,2)
        if (NOUT.LE.20)OUT(NOUT)=OUTV
      end

      function TF(T,P)
        if (T.LT.0) T=T*TCF(P)
        TF=ABS(T)
      end

C--
      function HIF (P,T)
      real MVF
      common /DATA/ PCP,TPCP,PA ,ANA,PI,HC,R,AKB,GAM,AM3
      HIF=.25*GAM**2*HC*DNDEF(P)*HC*ANA/(1+Z0F(P)/4)/MVF(P)
      TTC=T/TCF(P)
      if (TTC.LT.1) then
      Z0=Z0F(P)
      Y=YOSHIDF(TTC)
C     print *,Z,Y,((1.+Z0/4.)*(2.+Y)/3.)/(1.+Z0/4.*(2.+Y)/3.)
      HIF=HIF*((1.+Z0/4.)*(2.+Y)/3.)/(1.+Z0/4.*(2.+Y)/3.)
      end if
      end
C--
      function Z0F(P)
C-- Sourse B-phase notebook.
C Least squares fitting. From file: YZ0
C  Z0=                   vs.  P=
C Polinom of the order : 5
C Residual: 0.000
      real A(5)
      DATA M1/ 5/
      DATA XMIN/   0.000000    /,XMAX/   34.36000    /
     0 DATA A/-5.762472,-.1136529,5.5511940E-02,
     1 -1.7914600E-02,4.0055060E-03/
      IFAIL=1
      XCAP=((P-XMIN)-(XMAX-P))/(XMAX-XMIN)
      call E02AEE(M1,A,XCAP,Z0F,IFAIL)
      if (IFAIL.NE.0)print *,'Error in E02AEE :',IFAIL
      end
C--
      function YOSHIDF(TTC)
C-- Sourse B-phase notebook.
C Least squares fitting. From file: YOSHID
C  Y=                    vs.  T=
C Polinom of the order : 5
C Residual: 0.000
        real A(  5)
        DATA M1/ 5/
        DATA XMIN/  9.9999994E-02/,XMAX/   1.000000    /
        DATA A/   .7349111    ,   .5123515    ,   .1371038
     ,  , -1.4855450E-02, -4.5979050E-03/
        if (TTC.GE..1) then
          IFAIL=1
          XCAP=((TTC-XMIN)-(XMAX-TTC))/(XMAX-XMIN)
          call E02AEE(M1,A,XCAP,YOSHIDF,IFAIL)
          if (IFAIL.NE.0)print *,'Error in E02AEE :',IFAIL
        else
          YOSHIDF=0
        end if
        return
      end
C--
      function F0AF(P)
C-      Sourse - Greywall, Phys.Rev.  v.27  5  (1983)
C       Least squares fitting. From file: YF0A
C       F0A=                  vs.  P=
C       Polinom of the order : 7
C       Residual: 0.000
        real A(  7)
        DATA M1/ 7/
        DATA XMIN/   0.000000    /,XMAX/   34.36000    /
        DATA A/-1.489332, -2.3159460E-02,  1.3571171E-02,
     ,    -4.2908173E-03,  1.4413130E-03, -1.1601811E-03,
     .    9.9658221E-04/
        IFAIL=1
        XCAP=((P-XMIN)-(XMAX-P))/(XMAX-XMIN)
        call E02AEE(M1,A,XCAP,F0AF,IFAIL)
        if (IFAIL.NE.0)print *,'Error in E02AEE :',IFAIL
      end
C---
      include 'he3_funcs.f'
