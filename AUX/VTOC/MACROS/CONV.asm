         MACRO
&LABEL   CONV  &TO,&FROM,&LEN,&EDMASK,&SCOMP
         LCLC  &L,&FIRSTFR,&EDM,&COMP
         LCLA  &COUNT
&L       SETC  'L'''
         AIF   ('&LABEL' EQ '').NOLABEL  SKIP LABEL IF NOT PRESENT
&LABEL   DS    0H             SET THE LABEL
.NOLABEL ANOP
&EDM     SETC  'EDMASK'      DEFAULT EDIT MASK
         AIF   ('&EDMASK' EQ '').DEFMASK  IF NOT ENTERED USE DEFAULT
&EDM     SETC  '&EDMASK'     USE THE ENTERED VALUE
.DEFMASK ANOP
&COMP    SETC  'BLANKS'      DEFAULT COMPARISON CHARS
         AIF   ('&SCOMP' EQ '').DEFCOMP  NOT ENTERED, USE THE DEFAULT
&COMP    SETC  '&SCOMP'      GET WHAT THE GUY WANTS
.DEFCOMP ANOP
&FIRSTFR SETC  '&FROM'(1,1)   GET FIRST CHAR OF &FROM
         AIF   ('&FIRSTFR' EQ '(').REGISTR
         L     R1,&FROM       GET THE DATA TO CONVERT
         CVD   R1,DOUBLE      CONVERT TO PACKED DECIMAL
         AGO   .INDEC
.REGISTR ANOP
&COUNT   SETA  K'&FROM-2
&FIRSTFR SETC  '&FROM'(2,&COUNT)  STRIP THE PERRONS
         CVD   &FIRSTFR,DOUBLE   CONVERT TO PACKED DECIMAL
.INDEC   ANOP
         MVC   CHARS,&EDM     PUT IN THE EDIT MASK
         ED    CHARS,DOUBLE   CONVERT TO CHARACTERS
         AIF   ('&LEN' NE '').LENSET
         MVC   &TO,CHARS+16-&L&TO  MOVE IN THE NUMBER
         CLC   CHARS(16-&L&TO),&COMP   WAS THERE AN OVERFLOW?
         BE    *+10           NO, EVERYTHING WAS OK
         MVC   &TO,STARS      BAD NEWS, NOTE IT
         MEXIT
.LENSET  ANOP
         MVC   &TO.(&LEN),CHARS+16-&LEN MOVE IN THE NUMBER
         CLC   CHARS(16-&LEN),&COMP   WAS THERE AN OVERFLOW?
         BE    *+10           NO, EVERYTHING WAS OK
         MVC   &TO.(&LEN),STARS   BAD NEWS, NOTE IT
         MEND