				PROC REPORT

SYNTAX 
 PROC REPORT DATA = DSN NOWINDOWS HEADLINE HEADSKIP;
 COLUMN VAR_LIST;
 DEFINE VAR/<OPTION>;
 RUN;
 LIST OF OPTIONS :
 1.DISPLAY
 2.ANALYSIS
 3.GROUP
 4.ORDER
 5.ACROSS
 6.COMPUTED

NOWINDOWS - IT TELLS SAS NOT TO OPEN INTERACTIVE WINDOW
HEADLINE - IT DRAW ONE LINE AFTER THE VARIABLE NAME
HEADSKIP - IT SKIPS ONE LINE AFTER THE VARIABLE NAME
DEFINE - IT TELLS SAS TO PERFORM A SPECIFIC TASK ON A SPECIFIC VARIABLE
DISPLAY -  IT WILL LIST OUT ALL THE OBSERVATION FOR GIVEN OUTPUT
ANALYSIS - IT IS USED TO COMPUTE ALL STATISTICAL VALUES FOR GIVEN 
			VARIABLE. BY DEFAULT IT GIVES 'SUM'.
GROUP - IT CREATES ONE ROW FOR EACH UNIQUE VALUE OF VARIABLE
ORDER - IT CREATES ONE ROW FOR EACH OBSERVATION WITH ROW ARRANGED
		ACCORDING TO VALUE OF ORDER VARIABLE. BY DEFAULT ARRANGEMENT
		WILL BE IN ASCENDING ORDER
ACROSS - IT CREATES ONE COLUMN FOR EACH UNIQUE VALUE OF GIVEN VARIABLE
COMPUTED - IT IS USED TO CREATE A NEW VARIABLE WHOSE VALUE YOU CALUCULATE
			IN A COMPUTE BLOCK
;

proc report data = sashelp.class nowd headline headskip split = '*' panels = 20 ps = 20;
columns age sex height weight rate;
define age / 'Age *of * hhs' width = 5 spacing = 5 format = comma4.;
define sex /group;
define sex age /group;
define height/analysis mean;
define sex /order descending noprint;
define sex , height weight /across;
define sex,	(heigth weight)/across '-Sex-';
define rate / computed;
compute rate;
rate = height+weight;
endcomp;
define rate/computed;
compute rate /character;
if age < 13 then city = 'AAA';
else city = 'NA';
run;
proc report data = sashelp.class nowd headline headskip;
columns sex height weight;
break after sex /ol ul skip summarize suppress;
rbreak after /ol ul skip summarize;
run;

DATA MEDICAL;
INFILE 'D:\Athiq\Datasets\MEDICAL.TXT' FIRSTOBS = 2 TRUNCOVER;
INPUT Patno $ 3. @ 5 Clinic $  11. @ 18 VisitDate MMDDYY10.
@ 29 Weight 3. @ 36 HR 2.@ 39 DX 3. @ 43 comment $  52.;
RUN;
PROC PRINT;
FORMAT VISITDATE DATE7.;
RUN;

PROC REPORT DATA = MEDICAL NOWINDOWS HEADLINE HEADSKIP;
RUN;

PROC REPORT DATA = MEDICAL NOWINDOWS HEADLINE HEADSKIP;
COLUMN WEIGHT HR DX;
RUN;

PROC REPORT DATA = MEDICAL NOWINDOWS HEADLINE HEADSKIP;
COLUMN PATNO WEIGHT HR DX;
RUN;

PROC REPORT DATA = MEDICAL NOWINDOWS HEADLINE HEADSKIP;
COLUMN WEIGHT HR DX;
DEFINE WEIGHT/DISPLAY;
DEFINE HR/DISPLAY 'HEART RATE';
RUN;

PROC REPORT DATA = MEDICAL NOWINDOWS HEADLINE HEADSKIP;
COLUMN  CLINIC WEIGHT HR ;
DEFINE CLINIC/GROUP WIDTH = 11;
DEFINE WEIGHT/ANALYSIS MEAN 'AVG WEIGHT';
DEFINE HR/ANALYSIS 'SUM OF HEART RATE';
RUN;

PROC REPORT DATA = MEDICAL NOWINDOWS HEADLINE HEADSKIP ;
COLUMN  CLINIC WEIGHT HR ;
DEFINE CLINIC/GROUP WIDTH = 11;
DEFINE WEIGHT/ANALYSIS MEAN 'AVG WEIGHT' FORMAT=6.2;
DEFINE HR/ANALYSIS 'SUM OF HEART RATE'F=6.2;
RUN;

PROC REPORT DATA = MEDICAL NOWINDOWS HEADLINE HEADSKIP ;
COLUMN VISITDATE PATNO CLINIC;
DEFINE VISITDATE/ORDER 'VISITDATE' F = DATE9.;
DEFINE PATNO/DISPLAY 'PATIENT NUMBER' WIDTH = 7;
RUN;


PROC REPORT DATA = MEDICAL NOWINDOWS HEADLINE HEADSKIP ;
COLUMN VISITDATE PATNO CLINIC;
DEFINE VISITDATE/ORDER 'VISITDATE' F = MMDDYY10.;
DEFINE PATNO/DISPLAY 'PATIENT NUMBER' WIDTH = 7;
RUN;

PROC REPORT DATA = MEDICAL NOWINDOWS HEADLINE HEADSKIP ;
COLUMN PATNO CLINIC ,(WEIGHT HR);
DEFINE PATNO/DISPLAY 'PATIENT NUMBER' WIDTH = 7;
DEFINE CLINIC/ACROSS;
RUN;

PROC REPORT DATA = MEDICAL NOWINDOWS HEADLINE HEADSKIP ;
COLUMN PATNO CLINIC ,(WEIGHT HR);
DEFINE PATNO/ORDER 'PATIENT NUMBER' WIDTH = 7;
DEFINE CLINIC/ACROSS;
RUN;

PROC REPORT DATA = MEDICAL NOWINDOWS HEADLINE HEADSKIP ;
COLUMN CLINIC PATNO WEIGHT HR RATE;
DEFINE PATNO/DISPLAY 'PATIENT NUMBER' WIDTH = 7;
DEFINE CLINIC/GROUP;
DEFINE HR/DISPLAY;
DEFINE RATE/COMPUTED;
COMPUTE RATE/CHARACTER LENGTH = 6; 
IF HR > 75 THEN RATE = ' FAST';
ELSE IF HR >55 THEN RATE = 'NORMAL';
ELSE IF NOT MISSING (HR) THEN RATE = 'SLOW';
ENDCOMP;
RUN;

PROC REPORT DATA = MEDICAL NOWINDOWS HEADLINE HEADSKIP ;
COLUMN CLINIC PATNO WEIGHT HR WTKG;
DEFINE PATNO/DISPLAY 'PATIENT NUMBER' WIDTH = 7;
DEFINE CLINIC/GROUP;
DEFINE WEIGHT /DISPLAY NOPRINT;
DEFINE WTKG/COMPUTED 'WT IN KG';
COMPUTE WTKG;
WTKG = ROUND (WEIGHT/2.2);
ENDCOMP;
RUN;

BREAK <LOCATION> VAR/<OPTION>;
RBREAK <LOCATION> /<OPTION>;

BREAK:
THE VARIABLE USED UNDER BREAK STT SHOULD BE DEFINED AS GROUP OR ORDER.
IT WILL BE APPLIED ON EACH UNIQUE VALUE OF THE VARIABLE.

RBREAK :
IT WILL BE APPLIED ON ALL OBSERVATIONS.

LOCATION VALUES HAS 2 VALUES = BEFORE / AFTER;

OPTIONS :
1.OL - DRAW A LINE OVER THE BREAK. 
2.UL - YOU WILL DRAW A LINE UNDER THE BREAK
3.DOL - DRAW DOUBLE LINE OVER THE BREAK.
4.DUL - DRAW DOUBLE LINE UNDER THE BREAK
5.SKIP - WILL INSERT THE BLANK LINE.
6.SUMMARIZE -  IT INSERT A SUM FOR THE NUMERIC VARIABLES.
;

PROC REPORT DATA = MEDICAL NOWINDOWS HEADLINE HEADSKIP ;
COLUMN CLINIC PATNO WEIGHT HR ;
DEFINE PATNO/DISPLAY 'PATIENT NUMBER' WIDTH = 7;
DEFINE CLINIC/GROUP;
BREAK AFTER CLINIC/DOL DUL SKIP SUMARIZE;
RBREAK AFTER /DOL DUL SKIP SUMMARIZE;
RUN;
/*inclusion of both character and numeric variables results in list reprot*/
proc report data =  sashelp.class nowd;
columns sex height weight;
run;
/*consists only numeric variables which results in summary report and default sum statement*/
proc report data = sashelp.class nowd;
columns height weight;
run;
/*define stt - use to make list report even for numeric variables*/
/*note - without display option define stt doesnt work*/
proc report data = sashelp.class nowd;
columns height weight;
define height /display "HT";
define weight /display "WT";
run;
proc report data = sashelp.class nowd;
columns height weight;
define height / analysis mean "avg height";
run;
proc report data = sashelp.class nowd;
columns sex height weight;
define sex / group width = 3;
define height /analysis mean 'AVG HT.';
define weight /analysis mean 'AVG WT.';
run;
data one;
input name$ description$ 5-90;
cards;
AAA this is my first sas class and im here to do the class 29/12/2012 in a improvised role
BBB this is not a good teacher since he doesnt the practical examples to us
;
run;
proc print;
run;
/*flow option -  to break the statement as per the width specified*/
/*split option is used to break the comment by using the blank*/
/*check out without split option(observe the date value)*/
/*The default alignment for character variables is LEFT.*/
proc report data = one nowd;
define description / width = 40 flow;
run;
proc report data = one nowd split = ' ';
define description / width = 40 flow;
run;
/*no observations are present in proc report data*/
data new_one;
input country$ model$ price year;
cards;
India AAA 45000 2012
India AAA 55000 2013
India AAA 66000 2014
India AA+ 45000 2012
Italy AAA 68000 2012
Italy AA+ 68000 2013
USA AAA 33000 2012
USA CC+ 33000 2014
;
run;
proc print ;
run;
/*comment and uncomment year and chk out the result*/
title 'Multiple grouping';
proc report data = new_one nowd;
columns country model year price;
define country / group 'New_Country' width = 10;
define model /group 'New_Model' width = 9;
define year/display;
run;
proc report data = sashelp.class nowd;
columns age sex height weight;
define sex / group width = 3;
run;
/*order statement*/
proc report data = sashelp.class nowd;
columns sex name age height weight;
define sex / order width = 3;
/*define height / descending order ;*/
run;
/*linesize should be between 64 and 256*/
/*pagesize should be between 15 and 32767*/
options pagesize = 200;
proc print data = sashelp.class;
run;
*panels - displays the data into group wise horizontally, use pagesize(ps)
to get more clarrity;
proc report data = sashelp.class nowd panels = 12 ps = 20;
columns name sex age;
define age / display;
run;
/*rbreak - applicable for all variables*/
proc report data = sashelp.class nowd;
columns name age sex;
rbreak after /dol dul summarize;
run;
/*break <group/order variable> */
/*suppress - to remove summary lines*/
proc report data = sashelp.class nowd;
columns name sex height weight;
define sex / group width = 3;
break after sex/dol dul summarize skip suppress;
run;
data new_12;
input name$ 1-12;
cards;
athiq ahmed 
sonia sharma
raj malhotra
;
run;
proc print;
run;
/*chk out last_new*/
data new_13;
set new_12;
last_name = scan(name,-1,' ');
last_new = scan(name,-1);
run;
proc print;
run;
data one;
a = "This notes is too good";
a1 = scan(a,1);
a2 = scan(a,1,' ');
a3 = scan(a,-1);
a4 = scan(a,-1,' ');
run;
proc print;
run;

title "listing ordered by last name";
/*noprint - it uses to sort the dataset and also hides the variable from appearing in the dataset*/
proc report data = sashelp.class nowd;
columns sex height weight;
define sex /order width =3 noprint;
run;
title "Creating a New Variable in a COMPUTE Block";
proc report data = sashelp.class nowd;
columns name age height weight rate;
define height / display "HT of hhs";
define weight / display "WT of hhs";
define rate/computed;
compute rate;
rate = height + weight;
endcomp;
run;
title "Creating a Character Variable in a COMPUTE Block";
proc report data = sashelp.class nowd;
columns name age height weight rate;
define age/ display 'age of hhs';
define rate/computed;
compute rate /character;
if age < 12 then rate = 'AAAAAAAA';
else if age < 13 then rate = 'BBBBBBBB';
else rate = 'CCCCCCCC';
endcomp;
run;
title 'age,<variables>';
proc report data = sashelp.class nowd;
columns sex,height weight;
define sex/across;
run;
title 'age,(<variables>)';
proc report data = sashelp.class nowd;
columns sex,(height weight);
define sex/across;
run;
title 'Demonstrating an ACROSS Usage Changing the Column Heading';
proc report data = sashelp.class nowd;
columns sex,height weight;
define sex/across " -Sex-";
run;
proc report data = sashelp.class nowd;
columns name age sex,(height weight) ;
define age/group;
define sex / across "-sex-" width =3;
define height/analysis mean "AVG of hh";
define weight/analysis mean "AVG of wh";
run;
question_1;
proc report data = sashelp.class (obs=5) nowd headline;
columns name height weight;
define height/display "Ht of HHs" format = comma6.0;
define weight/display "Wt of HHs" format = 4.2;
run;
question_2;
proc report data = sashelp.class nowd headline headskip;
columns sex height weight;
define sex/group width=3;
define height/analysis mean "Avg of height" format = 4.2;
define weight/analysis mean "Avg of weight" format = 4.2;
rbreak after/dol summarize;
run;
question_3;
data one;
input subject admission_date mmddyy10. +1 dob mmddyy10.;
cards;
1 03/28/2003 09/15/1926
2 03/28/2003 07/08/1950
3 03/28/2003 12/30/1981
4 03/28/2003 06/11/1942
5 08/03/2003 06/28/1928
run;
proc print;
format admission_date mmddyy10. dob mmddyy10.;
run;
proc report data = one headline headskip nowd;
columns subject admission_date dob age_at_admission;
define admission_date/display format = mmddyy10.;
define dob/display format = mmddyy10.;
define age_at_admission/computed;
compute age_at_admission;
	age_at_admission = round(yrdif(dob,admission_date,'actual'));
endcomp;
run;
question_4;
proc report data = sashelp.class nowd;
columns name sex height weight status;
define sex/group width =3;
define name/display "Names of hhs";
define height/display "Ht of hhs";
define weight/display "Wt of hhs";
define status/computed;
compute status/character;
if sex = 'F' and height < 60 or weight < 80 then status = "Yes";
/*else status = "No";*/
else if sex = 'M' and height < 60 or weight < 100 then status = "Yes";
else status = "No";
endcomp;
run;
question_5;
data bloodpressure;
input gender$ age;
cards;
M 23 
F 68 
M 55 
F 28 
M 35 
M 45 
F 48 
F 78 
run;
proc print;
run;
proc report data = bloodpressure nowd;
columns gender age agegroup;
define agegroup/computed "age/group";
compute agegroup/character;
if age < 50 then agegroup = "<=50";
else agegroup = "<50";
endcomp;
run;
question_6;
proc report data = sashelp.class nowd;
columns name sex age height weight;
define sex /order 'Gender' width = 6;
define age/order 'age of hhs';
run;
question_7;
proc report data = sashelp.class nowd headline;
columns sex age height;
define sex/group 'Gender' width = 6;
define age/display 'Age of hhs';
define height/analysis mean 'Avg of height';
run;
question_8;
proc report data = sashelp.class nowd headline;
columns name age sex ,height sex,weight;
define sex /across '-sex-' width =6;
define height/analysis mean 'Avg height';
define weight/analysis mean 'Avg weight';
run;


			ODS - OUTPUT DELIVERY SYSTEM

PURPOSE : DESTINATION        AND 		TEMPLATE(LOOK OF OUTPUT)
		  		|			 					  |
			LISTING     TABLE TEMP(STRUCTURE)		STYLE TEMP (LOOK OF THE OUTPUT)
			(HTML PDF
			RTF CSV..)
;
PROC TEMPLATE;
LIST STYLES;
RUN;

PROCEDURE + TABLE TEMPLATE = OUTPUT OBJECT
OUTPUT OBJECT + (FONT SIZE,COLOR,BOLD,ITALIC..) = ODS

INFORMATION ABT THE OUTPUT OBJECT WILL BE DISPLAYED IN THE LOG WINDOW
WITH THE HELP OF ODS TRACE ON.
;
/*IT IS DISPLAYING THE INFO ABT THE OUTPUT OBJECT FOR ALL AGE BREAKS*/
ODS TRACE ON;
PROC MEANS DATA = SASHELP.CLASS;
CLASS AGE;
BY AGE;
RUN;
ODS TRACE OFF;

ODS TRACE ON;
PROC MEANS DATA = SASHELP.CLASS;
CLASS AGE;
BY AGE;
ODS SELECT Means.ByGroup3.Summary;
RUN;
ODS TRACE OFF;

ODS TRACE ON;
PROC MEANS DATA = SASHELP.CLASS;
CLASS AGE;
BY AGE;
ODS EXCLUDE Means.ByGroup3.Summary;
RUN;
ODS TRACE OFF;

ODS TRACE ON;
PROC MEANS DATA = SASHELP.CLASS;
CLASS AGE;
BY AGE;
ODS OUPUT Means.ByGroup3.Summary = AGE_13;
RUN;
ODS TRACE OFF;
PROC PRINT DATA = AGE_13;
RUN;
chapter_19;
proc univariate data = sashelp.class;
run;
ods trace on;
proc univariate data = sashelp.class;
run;
ods trace off;
ods select quantiles;
proc univariate data = sashelp.class;
run;
ods exclude quantiles;
proc univariate data = sashelp.class;
run;
ods listing close;
ods output ttests = new_one;


*/		DESTINATION
SYNTAX 
ODS DESTINATION FILE/BODY = 'LOCATION/FILE.EXT;
SAS CODE;
ODS DESTINATION CLOSE;

ODS HTML BODY = 'D:\Athiq\Datasets\RESULT.HTML';
PROC PRINT DATA = SASHELP.CLASS;
RUN;
PROC MEANS DATA = SASHELP.CLASS;
RUN;
PROC REPORT DATA = SASHELP.CLASS NOWINDOWS;
RUN;
ODS HTML CLOSE;

ODS HTML PATH = 'D:\Athiq\Datasets\'
			BODY = 'ODS_BODY_CONTENT.HTML'
			CONTENTS = 'ODS_HTML_CONTENT.HTML'
			PAGE = 'ODS_HTML_PAGE.HTML'
			FRAME = 'ODS_HTML_FRAME.HTML'
			STYLE = D3D;
ODS NOPROC TITLE;
PROC REPORT DATA = SASHELP.CLASS NOWINDOWS;
RUN;
PROC PRINT DATA = SASHELP.CLASS;
RUN;
PROC MEANS DATA = SASHELP.CLASS;
RUN;
ODS HTML CLOSE;

ODS PDF BODY = 'D:\Athiq\Datasets\RESULT.PDF'
				COLUMNS = 3
				STYLE = ANALYSIS;
PROC MEANS DATA = SASHELP.CLASS;
CLASS AGE;
RUN;
PROC REPORT DATA = SASHELP.CLASS NOWINDOWS;
RUN;
ODS PDF CLOSE;


ODS RTF BODY = 'C:\Documents and Settings\Athik\Desktop\Athiq\SAS\RESULT.RTF'
				COLUMNS = 5
				STYLE = ANALYSIS;
PROC MEANS DATA = SASHELP.CLASS;
CLASS AGE;
RUN;
PROC REPORT DATA = SASHELP.CLASS NOWINDOWS;
RUN;
proc print data = sashelp.class;
run;
proc freq data = sashelp.class;
run;
ODS RTF CLOSE;

/*STARTPAGE = NO = TO GIVE ALL THE INFO IN A SINGLE PAGE*/

ODS RTF BODY = 'C:\Documents and Settings\Athik\Desktop\Athiq\SAS\RESULT.RTF'
				BODYTITLE STARTPAGE = NO
				STYLE = ANALYSIS;
PROC MEANS DATA = SASHELP.CLASS;
CLASS AGE;
RUN;
PROC REPORT DATA = SASHELP.CLASS NOWINDOWS;
RUN;
proc print data = sashelp.class;
run;
proc freq data = sashelp.class;
run;
ODS RTF CLOSE;

ods listing close;
ods html file = 'C:\Documents and Settings\Athik\Desktop\SAS Certification Prep Guide\result.html';
ods pdf file = 'C:\Documents and Settings\Athik\Desktop\SAS Certification Prep Guide\result.pdf';
proc print data = sashelp.class;
run;
proc means data = sashelp.class;
run;
ods _all_ close;
ods listing;

ods listing close;
ods html path = 'C:\Documents and Settings\Athik\Desktop\SAS Certification Prep Guide'
			body = 'body.html'(url = 'body.html')
			contents = 'contents.html'(url = 'contents.html')
			frame = 'frame.html';
proc print data = sashelp.class;
run;
proc means data = sashelp.class;
run;
ods html close;
ods listing;

data soccer;
input Team : $20. Wins Losses;
datalines;
Readington 20 3
Raritan 10 10
Branchburg 3 18
Somerville 5 18
;
options nodate nonumber;
title;
ods listing close;
ods csv file='C:\Documents and Settings\Athik\Desktop\SAS Certification Prep Guide\soccer.csv';
proc print data=soccer noobs;
run;
ods csv close;
ods listing;
question_3;
libname athiq12 'C:\Documents and Settings\Athik\Desktop\SAS Certification Prep Guide\soccer.xls';
proc means data = athiq12.'soccer$'n mean ;
run;


/*CUSTOMIZING YOUR TITLE AND FOOTNOTE*/

/*CUTOMIZING YOUR TITLE AND FOOTNOTE

TITLE <OPTION> 'TEXT';
FOOTNOTE <OPTION>  'TEXT';

LIST OPTIONS - COLOR BCOLOR FONT BOLD ITALIC HEIGHT JUSTIFY=L/R/C 

*/

ODS HTML FILE='E:\Palka\document\HTML_RESULT.HTML';
TITLE COLOR=RED BCOLOR=GREEN FONT='TIMES NEW ROMAN'
      ITALIC HEIGHT=1CM JUSTIFY=C 'MY TITLE';
FOOTNOTE COLOR=RED BCOLOR=GREEN FONT='TIMES NEW ROMAN'
      ITALIC HEIGHT=1CM JUSTIFY=L 'MY FOOTNOTE';
PROC PRINT DATA=SASHELP.CLASS;
RUN;
ODS HTML CLOSE;

question_1;
ods listing close;
ods html file= 'C:\Documents and Settings\Athik\Desktop\SAS Certification Prep Guide\new'
proc print data = sashelp.class;
run;
proc means data = sashelp.class;
run;
ods html close;
ods listing;

/*PROC PRINT WITH STYLE= OPTION
PROC PRINT DATA=DSN STYLE(LOCATION-LIST)={STYLE-ATTRIBUTE=VALUE};
VAR
BY 
ID
SUM 
RUN;

LIST OF LOCATION-	TABLE REGION AFFECTED-
DATA 			-	WHOLE DATA CELLS
HEADER			-   COLUMN HEADER OR VARIABLE NAME
OBS 			-   OBS VALUE OR ID STMT VARIABLE VALUE
OBSHEADER		-   OBS HEADER OR ID STMT VARIABLE
TOTAL			-   TOTAL THAT WE GET USING SUM STMT
GRANDTOTAL		-  GRANDTOTAL VALUE IF WE USE SUM STMT

*/

ODS HTML FILE='C:\Documents and Settings\Athik\Desktop\Athiq\SAS\PRINT_RESULT.HTML';
TITLE;
FOOTNOTE;
PROC SORT DATA=SASHELP.CLASS OUT=SCLASS;
BY SEX;
RUN;
PROC PRINT DATA=SCLASS
	STYLE(DATA)={BACKGROUND=WHITE}
	STYLE(HEADER)={BACKGROUND=GREEN}
	STYLE(OBS)={BACKGROUND=RED}
	STYLE(OBSHEADER)={BACKGROUND=RED}
	STYLE(TOTAL)={BACKGROUND=YELLOW}
	STYLE(GRANDTOTAL)={BACKGROUND=YELLOW};
VAR AGE HEIGHT WEIGHT;
BY SEX;
ID SEX;
SUM AGE HEIGHT WEIGHT;
RUN;
ODS HTML CLOSE;

/*
WHEN U R USING STYLE IN VAR STMT; ONLY TWO LOCATION LIST ARE 
ALLOWED DATA AND HEADER
*/

ODS HTML FILE='E:\Palka\document\PRINT_RESULT1.HTML';
TITLE;
FOOTNOTE;
PROC PRINT DATA=SCLASS
	
	STYLE(HEADER)={BACKGROUND=GREEN}
	STYLE(OBS)={BACKGROUND=RED}
	STYLE(OBSHEADER)={BACKGROUND=RED}
	STYLE(TOTAL)={BACKGROUND=YELLOW}
	STYLE(GRANDTOTAL)={BACKGROUND=YELLOW};

VAR AGE /STYLE(HEADER)={BACKGROUND=WHITE};
VAR HEIGHT/STYLE(DATA)={BACKGROUND=ORANGE};
VAR WEIGHT/STYLE(DATA)={BACKGROUND=CYAN};

BY SEX;
ID SEX;
SUM AGE HEIGHT WEIGHT;
RUN;
ODS HTML CLOSE;


/* PROC REPORT WITH STYLE= OPTION 
PROC REPORT DATA=DSN NOWINDOWS HEADLINE HEADSKIP
	STYLE(LOCATION)={STYLE-ATTRIBUTE=VALUE};
COLUMN VAR-LIST;
DEFINE VAR/<OPTION>;
RUN;

LOCATION - 	TABLE REGION AFFECTED
COLUMN	 -	WHOLE DATA VALUES
HEADER	 -  COLUMN HEADER
SUMMARY  -  ROW GENERATED BY USING BREAK AND RBREAK OPTION
*/

ODS HTML FILE='E:\Palka\document\REPORT_RESULT.HTML';
PROC REPORT DATA=SASHELP.CLASS NOWINDOWS HEADLINE HEADSKIP
	STYLE(COLUMN)={BACKGROUND=WHITE}
	STYLE(HEADER)={BACKGROUND=GREEN}
	STYLE(SUMMARY)={BACKGROUND=YELLOW};

COLUMN SEX NAME AGE HEIGHT WEIGHT;
DEFINE SEX/GROUP;

BREAK AFTER SEX/SKIP SUMMARIZE;
RBREAK AFTER /SKIP SUMMARIZE;
RUN;
ODS HTML CLOSE;

/*PROC TABULATE WITH STYLE= OPTION 

PROC TABULATE DATA=DSN STYLE={STYLE ATTRIBUTE=VALUE}; /* AFFECT ONLY DATA VALUE 
CLASS VAR-LIST /STYLE={STYLE_ATTRIBUTE=VALUE}; /* AFFECT ONLY VARIABLE USED IN CLASS STMT 
VAR NUMERIC VAR-LIST/STYLE={STYLE-ATTRIBUTE=VALUE}; /* AFFECT ONLY VARIABLE USED IN VAR STMT 
TABLE TABLE-APPEARANCE/STYLE={STYLE-ATTRIBUTE=VALUE}; /* AFFECT ONLY TABLE PARTS 
RUN;
*/


ODS HTML FILE='E:\Palka\document\TABULATE_RESULT.HTML';
PROC TABULATE DATA=SASHELP.CLASS STYLE={BACKGROUND=RED};
CLASS SEX AGE / STYLE={BACKGROUND=GREEN};
VAR HEIGHT WEIGHT/ STYLE={BACKGROUND=CYAN};
TABLE AGE ALL,SUM*(HEIGHT WEIGHT)*SEX /STYLE={BACKGROUND=YELLOW}
	  BOX='SUM OF HEIGHT AND WEIGHT';
KEYLABEL SUM= 'SUM OF';
RUN;
ODS HTML CLOSE;


/*ASSIGNMENT*/
ODS HTML FILE='C:\SAS CLASS 1-4\document\TABULATE_RESULT.HTML';
ODS PDF FILE='C:\SAS CLASS 1-4\document\TABULATE_RESULT.PDF'
STYLE=DEFAULT;
PROC TABULATE DATA=SASHELP.CLASS FORMAT=DOLLAR8. STYLE={BACKGROUND=RED};
CLASS SEX AGE / STYLE={BACKGROUND=GREEN};
VAR HEIGHT WEIGHT/ STYLE={BACKGROUND=CYAN};
TABLE AGE ALL,SUM*(HEIGHT WEIGHT)*SEX /STYLE={BACKGROUND=YELLOW}
								   BOX='SUM OF HEIGHT AND WEIGHT';
KEYLABEL SUM= 'SUM OF';
RUN;
ODS PDF CLOSE;
ODS HTML CLOSE;

/* TELL ME THE NO. OF OUTPUT GENERATED BY THIS CODE
1. 1
2. 2
3. 3
4. 4

GIVE REASON ALSO.
*/





