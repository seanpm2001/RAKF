         MACRO
&LAB     VTCALL &RTN,&TEST
&LAB     LA    R1,VTOCOM      POINT TO THE COMMON AREA
         L     R15,VAD&RTN    POINT TO THE ROUTINE
         AIF ('&TEST' NE 'TEST').NOTEST
         LTR   R15,R15       SEE IF THE ROUTINE IS PRESENT
         BZ    *+6           DON'T CALL IT IF IT'S NOT THERE
.NOTEST  ANOP
         BALR  R14,R15        THEN CALL IT
         MEND