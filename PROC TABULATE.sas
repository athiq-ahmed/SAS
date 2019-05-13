DATA TABULATE_DATA;
INFILE 'C:\SAS CLASS\DOCUMENT\TABULATE_DATA.TXT' FIRSTOBS=2;
INPUT subject gender$ blood_type$ age_group$ wbc rbc chol;
RUN;
PROC PRINT ;
RUN;
/*
SYNTAX-
PROC TABULATE DATA=DSN;
CLASS VAR-LIST;
VAR NUMERIC VAR-LIST;
TABLE VAR-COMBINATION;
RUN;
*/

PROC TABULATE DATA=TABULATE_DATA;
CLASS GENDER;
TABLE GENDER*PCTN;
RUN;
/*
TABLE OPERATIONS -
1. CONCATENATION   - VAR1 VAR2
2. TABLE DIMENSION - VAR1,VAR2 (ROW,COLUMN)
3. NESTING         - VAR1*VAR2
*/

PROC TABULATE DATA=TABULATE_DATA;
CLASS GENDER AGE_GROUP;
TABLE GENDER* AGE_GROUP;
RUN;

PROC TABULATE DATA=TABULATE_DATA;
VAR  WBC RBC CHOL;
TABLE WBC RBC CHOL;
RUN;

PROC TABULATE DATA=TABULATE_DATA;
VAR  WBC RBC CHOL;
TABLE WBC*MEAN RBC CHOL*MEAN;
RUN;

PROC TABULATE DATA=TABULATE_DATA;
VAR  WBC RBC CHOL;
TABLE (WBC RBC CHOL) *(MEAN SUM STD);
RUN;

/*CUSTOMIZING YOUR TABLE*/

PROC TABULATE DATA=TABULATE_DATA;
CLASS GENDER;
VAR  WBC RBC CHOL;
TABLE GENDER ALL,WBC RBC CHOL;
RUN;

/*APPLYING FORMAT*/

PROC TABULATE DATA=TABULATE_DATA FORMAT=DOLLAR9.;
CLASS GENDER;
VAR  WBC RBC CHOL;
TABLE GENDER ALL,WBC RBC CHOL;
RUN;

PROC TABULATE DATA=TABULATE_DATA ;
CLASS GENDER;
VAR  WBC RBC CHOL;
TABLE GENDER ALL,WBC*F=DOLLAR12.2 RBC CHOL*F=COMMA5.;
RUN;

/*KEYLABEL - USED TO ASSIGN LABEL FOR KEYWORDS*/
PROC TABULATE DATA=TABULATE_DATA ;
CLASS GENDER AGE_GROUP;
VAR  WBC RBC ;
TABLE GENDER ALL,SUM*(WBC RBC)*AGE_GROUP;
KEYLABEL ALL='TOTAL' SUM='SUM OF';
RUN;

/*MISSTEXT AND BOX*/

PROC TABULATE DATA=TABULATE_DATA ;
CLASS GENDER AGE_GROUP;
VAR  WBC RBC ;
TABLE GENDER ALL,SUM*(WBC RBC)*AGE_GROUP/
	  MISSTEXT='NO DATA' BOX='FINDING SUM OF WBC AND RBC FOR EACH GENDER GROUP GROUPING ON AGE GROUP';
KEYLABEL ALL='TOTAL' SUM='SUM OF';
RUN;

/*REMOVING HEADER OR RENAMING HEADER*/
PROC TABULATE DATA=TABULATE_DATA FORMAT=COMMA12.2 ;
CLASS GENDER AGE_GROUP;
VAR  WBC RBC ;
TABLE GENDER='' ALL,SUM*(WBC='WHITE BLOOD CELL' RBC='RED BLOOD CELL')*AGE_GROUP=''/
	  MISSTEXT='NO DATA' BOX='FINDING SUM OF WBC AND RBC FOR EACH GENDER GROUP GROUPING ON AGE GROUP';
KEYLABEL ALL='TOTAL' SUM='SUM OF';
RUN;


DATA RESULTS;
INFILE 'C:\SAS CLASS\DOCUMENT\CLASS.TXT ' FIRSTOBS=2 DLM= ',' DSD MISSOVER;
INPUT NAME $:10.  Stream $:11. M1 M2 M3  M4  M5;
RUN;
PROC PRINT DATA=RESULTS;
RUN;

data blood;
input Subject Gender$ blood_Type$ age_Group$ WBC RBC Chol;
cards;
1 Female AB Young 7710 7.40 258
2 Male AB Old 6560 4.70 .
3 Male A Young 5690 7.53 184
4 Male B Old 6680 6.85 .
5 Male A Young . 7.72 187
6 Male A Old 6140 3.69 142
7 Female A Young 6550 4.78 290
8 Male O Old 5200 4.96 151
9 Male O Young . 5.66 311
10 Female O Young 7710 5.55 .
run;
proc print;
run;
*Any variable listed in a TABLE statement must be listed in a CLASS statement 
or a VAR statement;
proc tabulate data = blood;
class gender;
tables gender;
run;
/*Describing the Three PROC TABULATE Operators*/

1. concatenation;
*A space between variables in a TABLE statement is used to concatenate table values;
proc tabulate data = blood format = 6.;
class gender blood_type;
tables gender blood_type;
run;

2. table dimensions(page,row, and column);
*If you include a single comma, the specification following the comma generates
columns in the table; the specification before the comma generates rows in the table;
proc tabulate data = blood format = 6.;
class gender blood_type;
tables gender ,blood_type;
run;

3. Nesting;
proc tabulate data = blood format = 6.;
class gender blood_type;
tables gender*blood_type;
run;
/*using the keyword ALL*/
*When you place ALL after a variable name in a table request, PROC TABULATE includes a column
representing all levels of the preceding variable;
proc tabulate data = blood format = 6.;
class gender blood_type;
tables gender all ,blood_type all;
run;
/*descriptive statistics*/
proc tabulate data = blood;
var wbc rbc;
tables wbc rbc;
run;
proc tabulate data = blood;
var rbc wbc;
tables rbc*mean wbc*mean;
run;
proc tabulate data = blood;
var rbc wbc;
tables (rbc wbc)* (sum mean std); 
run;
proc tabulate data = blood;
class gender age_group;
var rbc wbc;
tables gender all ,(rbc wbc)* (sum mean std); 
run;
proc tabulate data = blood;
class gender age_group;
var rbc wbc;
tables (gender all)*(age_group all) ,(rbc wbc)* (sum mean std); 
run;
/*format*/
proc tabulate data = blood;
var rbc wbc;
tables rbc*mean*f=7.2 wbc*mean*f=comma8.2;
run;
/*renaming - keylabel*/
proc tabulate data = blood;
class gender age_group;
var rbc wbc;
tables (gender all)*(age_group all) ,(rbc wbc)* (sum mean std); 
keylabel all='Total' sum='Summation' mean='Average' std='Standard Deviation';
run;
/*Eliminating the N column in a PROC TABULATE table*/
proc tabulate data = blood f=6.;
class gender;
tables gender*n=' ';
/*keylabel n = ' ';*/
run;
*The NOSEPS (no separators) procedure option removes the internal horizontal separator lines 
from the table, shortening the table considerably;
proc tabulate data = blood noseps;
class gender age_group;
var rbc wbc;
tables (gender all)*(age_group all) ,(rbc wbc)* (sum mean std); 
run;
proc tabulate data = blood ;
class gender age_group;
var rbc wbc;
tables (gender=' ' )*(age_group=' ' ) ,(rbc wbc)* (sum mean std); 
run;
/*The statistic PCTN is used with CLASS variables to compute percentages.*/
proc tabulate data = blood;
class blood_type;
tables blood_type*(n pctn);
run;
proc format;
picture pctfmt
	low-high='009.9%';
run;
proc tabulate data = blood;
class blood_type;
tables (blood_type all)*(n pctn*f=pctfmt8.1);
keylabel n='count' pctn='percent';
run;
*rts - increases the row title space (the space for the width of the row title, 
including the vertical lines);
proc tabulate data = blood;
class gender blood_type ;
tables (gender all),(blood_type all)*(n pctn*f=pctfmt7.1)/rts=25;
keylabel n ='count' pctn='percent' all='total';
run;
/*colpctn and label*/
proc tabulate data = blood;
class gender blood_type ;
tables (gender all='total_all'),(blood_type all)*(n colpctn*f=pctfmt7.1)/rts=25;
keylabel n ='count' pctn='percent' all='total';
run;
/*rowpctn*/
proc tabulate data = blood;
class gender blood_type ;
tables (gender all='total_all'),(blood_type all)*(n rowpctn*f=pctfmt7.1)/rts=25;
keylabel n ='count' pctn='percent' all='total';
run;
question_1;
proc tabulate data = blood;
class gender blood_type age_group;
tables gender blood_type all,age_group;
run;
question_2;
proc tabulate data = blood;
class gender blood_type age_group;
tables age_group all,gender blood_type all;
keylabel all ='Total';
run;
question_3;
proc tabulate data = blood;
class gender blood_type age_group;
tables (gender all*blood_type all),age_group all;
keylabel all= 'Total';
run;
question_4(doubt);
proc tabulate data = blood;
class gender blood_type age_group;
tables blood_type all ,(age_group*gender all);
keylabel all= 'Total';
run;
question_5;
proc tabulate data = blood;
class gender;
var wbc;
tables wbc*(n mean min max),gender all;
keylabel all='Total' n= 'Number' mean = 'Average' min = 'Minimum' max = 'Maximum';
run;
question_6;
proc tabulate data = blood;
class gender;
var wbc rbc;
tables wbc*(n mean) rbc*(n mean),gender all;
keylabel all='Total' n= 'Number' mean = 'Average' ;
run;
question_7;
proc tabulate data = blood noseps;
class blood_type;
var wbc rbc;
tables blood_type,wbc*(median min max) rbc*(median min max);
keylabel min='minimum' max='maximum';
run;
question_8;
proc format;
picture pctfmt 
	low-high = '009.9%';
run;
proc tabulate data = blood noseps;
class gender age_group;
tables gender,(age_group all)*(rowpctn*f=pctfmt7.1);
keylabel rowpctn='Percent' all = 'Total';
run;
question_9;
proc sort data = blood out =new;
by descending age_group;
run;
proc print data = new;
run;
proc tabulate data = new noseps order=data;
class gender age_group;
tables 	gender all,(age_group all)*(colpctn*f=pctfmt7.1);
keylabel colpctn='Percent' all = 'Total';
run;
question_10;
proc tabulate data = blood noseps;
class gender ;
var wbc;
tables gender all,(wbc)*(pctsum*f=pctfmt7.1);
keylabel pctsum='Percent' all = 'Total';
run;

proc tabulate data = sashelp.class;
class sex;
tables sex;
run;
proc tabulate data = sashelp.class;
class sex;
tables sex*n = ' ';
run;
proc tabulate data = sashelp.class;
var height;
tables height*(mean sum skewness);
run;
proc tabulate data = sashelp.class;
class sex;
var height;
tables sex height;
run;
proc tabulate data = sashelp.class;
class sex;
var height;
tables sex,height*(sum mean max min);
run;
proc tabulate data = sashelp.class;
class sex;
var height;
tables sex*height;
run;
proc tabulate data = sashelp.class noseps ;
class sex;
var height;
tables sex = 'New_Sex' all,height*(sum*f = dollar8.2 mean max min)all / box = 'Gender';
keylabel all = 'Total';
run;
