data assignment;
input name $;
s1 = substr(name,1,1);
s2 = substr(name,2);
up= upcase(s1);
low=lowcase(s2);
con = cats(up,low);
cards;
 Dhoni
 SEHWAG
 sachin
 VIRAT
 raina
 ;
run;
proc print data = assignment;
run;
data one;
infile cards;
input name $ s1 s2 @@; 
cards;
a 12 24 b 24 25
c 14 45
;
run;
proc print data = one;
run;
data cat;
x0 = ' my ';
x1 = ' sas ';
x2 = ' program ';
up1 = upcase(x0);
up2 = upcase(x1);
up3 = upcase(x2);
r1 = cats(up1,'*',up2,'#',up3);
r2 = cat(up1,'*',up2,'#',up3);
run;
proc print data = cat;
run;

/*date function*/

*day() month() year() qtr() week()
today() date() time() datetime()
weekday()
datejul()
intck()
intnx()
yrdif()
;
data date_func;
tod = '22apr22'd;
dd = day(tod);
mm = month(tod);
yy = year(tod);
qq = qtr(tod);
ww = week(tod);
run;
proc print data = date_func;
format tod date7.;
run;
data date_func1;
tod = 18663;
dd = day(tod);
mm = month(tod);
yy = year(tod);
qq = qtr(tod);
ww = week(tod);
run;
proc print data = date_func1;
format tod date7.;
run;

/*today() date() time() datetime()*/
;

data date_func2;
tod = today();
sd = date();
st = time();
sdt = datetime();
run;
proc print data = date_func2;
format tod sd ddmmyy10. st time8. sdt datetime18.;
run;

mdy() -  it is used to create date values from 3 different values.
			3 different values are month , day and year.

syntax - var_name = mdy(month,day,year)
;

data date_func3;
d = 22;
m = 04;
y = 25;
tod = mdy(m,d,y);
/*format tod ddmmyy10.;*/
run;
proc print data = date_func3;
format tod date9.;
run;

weekday () -  it is used to return the weekday in terms of number
				for the given dataset.
syntax - var_name = weekday(date_value);
;
data date_func4;
birthweekday = weekday('27jan2013'd);
run;
proc print data = date_func4;
run;
data date_func5;
independenceweekday = weekday('15aug47'd);
run;
proc print data = date_func5;
run;
/*datejul()*/
datejul() - it is used to convert julian format of date into 
			normal date.
2012001(12001) = 001 - 1st jan
		  2012 - year	
		  12046 - 15feb12
		  00001 - 1st jan
syntax - var_name = datejul(juliandate)
;

data date_func5;
d1 = 12046;
d2 = 1;
dj1 = datejul(d1);
dj2 = datejul(d2);
format dj1 dj2 ddmmyy10.;
run;
proc print data = date_func5;
run;

*intck()
		it is used to calculate no. of interval in terms of 
		day, month and year between two date values.
syntax - var_name = intck(day/month/year/week',date1,date2)
;

data date_func6;
dob = '27jan87'd;
tod = '22apr12'd;
yy = intck ('year',dob,tod);
format dob tod date7.;
run;
proc print data = date_func6;
run;
data neww;
/*WEEK intervals are counted by Sundays*/
Weeks = intck ('week','29 oct 2012'd,'3 nov 2012'd);
/*MONTH intervals are counted by day 1 of each month*/
Months = intck ('month','31 dec 2000'd,'01jan2001'd);
/*YEAR intervals are counted from 01JAN, not in 365-day multiples.*/
Years = intck ('year','31 dec 2000'd,'01jan2001'd);
run;
proc print;
run;

*intnx()
		it is used to find the date values from given date
		values for givne no. of intervals and intervals may
		be day,month,year or week.
syntax - var_name = intnx(day/month/year/week,date1,date2)
;

data date_func7;
tod = '22apr12'd;
fdd = intnx('day',tod,10);
fdm = intnx('month',tod,10);
fdy = intnx('year',tod,10);
format tod fdd fdm fdy ddmmyy10.;
run;
proc print data = date_func7;
format tod fdd fdm fdy date7.;
run;
/*sameday is aplicable in month and year*/
data date_func8;
tod = '22apr12'd;
fdd = intnx('day',tod,10);
fdm12 = intnx('month',tod,10);
fdm = intnx('month',tod,10,'sameday');
fdy = intnx('year',tod,10,'sameday');
/*format tod fdd fdm fdy ddmmyy10.;*/
run;
proc print data = date_func8;
format tod fdd fdm fdm12 fdy date7.;
run;
data new_one;
Month=intnx('month','01jan95'd,5);
MonthX=intnx('month','01jan95'd,5,'b');
MonthX_1=intnx('month','01jan95'd,5,'m');
MonthX_2=intnx('month','01jan95'd,5,'e');
run;
proc print;
format Month MonthX MonthX_1 MonthX_2 date9.; 
run;
data new_one;
Year=intnx('Year','01jan95'd,5,'b');
Year_1=intnx('Year','01jan95'd,5,'m');
Year_2=intnx('Year','01jan95'd,5,'e');
run;
proc print;
format Year Year_1 Year_2 date9.; 
run;

/*yrdif() */
		it is used to compute the exact no. of years b/w two 
		date values.
	syntax - var_name = yrdif(date1,date2,'actual');

data date_func9;
doi = '15aug47'd;
tod = '22apr12'd;
no_of_years = yrdif(doi,tod,'actual');
run;
proc print data = date_func9;
format doi tod date7.;
run;
data one_111;
a1 = yrdif('27jan1987'd,'14oct2012'd ,'actual');
run;
proc print;
run;
data one_112;
a1 = yrdif('27jan1987'd,'14oct2012'd ,'basic');
a2 = yrdif('27jan1987'd,'14oct2012'd ,'Actual');
run;
proc print;
run;
data one_113;
a1 = int(yrdif('27jan1987'd,'14oct2012'd ,'actual'));
a2 = yrdif('27jan1987'd,'14oct2012'd ,'basic');
run;
proc print;
run;
data one_114;
a1 = round(yrdif('27jan1987'd,'14oct2012'd ,'actual'));
run;
proc print;
run;
a1 = '27jan1987'd;
a2 = '27/01/1987'd; - not correct;
question_1;
data dates;
input subject $3. @ 4 dob mmddyy8. @ 12 visitdate date9.;
cards;
0011021195011Nov2006
0020102195525May2005
0031225200525Dec2006
;
run;
proc print;
format dob visitdate date9.;
run;
question_2;
data threedates;
input date1 mmddyy10. @12 date2 mmddyy10. @23 date3 date9.;
year12 = round(yrdif(date1,date2,'actual'));
year23 = round(yrdif(date2,date3,'actual'));
cards;
01/03/1950 01/03/1960 03Jan1970
05/15/2000 05/15/2002 15May2003
10/10/1998 11/12/2000 25Dec2005
run;
proc print;
format date1 date2 date3 mmddyy10.;
run;
question_3;
options yearcutoff = 1920;
data dates1910_2006;
input dates mmddyy8.;
cards;
01/01/11
02/23/05
03/15/15
05/09/06
run;
proc print;
format dates date9.;
run;
question_8;
/*MDY function should be separted by commas*/
data new;
input day month year;
date = mdy(month, day, year);
cards;
25 12 2005
1 1 1960
21 10 1946
;
run;
proc print;
format date mmddyy10.;
run;


