find the sum of age ht wt for female n male employees
separtely and also find grand total.in the o/p name 
should nt be displayed.
;
proc sort data = sashelp.class;
by sex;
run;
proc print data = sashelp.class(drop =name)noobs;
by sex;
sum _numeric_ ;
run;

proc format;
invalue marks 'A+' = 100
			  'A' = 96
			  'A-' = 92
			  'B+' = 88
			  'B' = 84
			  'B-' = 80
			  'C' = 76
			  'D' = 72;
run;

data informats_use;
input @1 sno 3. @4 grade marks2.;
cards;
101A+
102B
103C
104F
105B+
106A
;
run;
proc print;
run;

					/*CONVERSION*/

1. Character to Numeric
	var_name = INPUT(char_value,informat);

data conversion1;
input name$ age$ doj$;
cards;
david 28 14nov11
amelia 29 15nov11
alan 30 16nov11
;
run;
proc print;
run;

data char_to_numeirc;
set conversion1;
age = age + 10;
run;
proc print;
run;
			/*SWAP AND DROP METHOD*/;

data char_to_numeric1;
set conversion1 (rename=(age=char_age doj=char_doj));
age = input(char_age,8.);
doj = input(char_doj,date7.);
drop char_age char_doj;
run;
proc print;
format doj date7.;
run;
/*dlm = '09'x = tab*/

2. Numeric to Character
	Var_name = put(char_variable,format);

data conversion2;
input name$ age sex;
cards;
david 28 1 
amelia 29 2
alan 30 1
;
run;
proc print;
run;

proc format;
value sexfmt 1 = 'M'
			  2 = 'F';
			  run;

data num_to_character;
set conversion2 (rename = (sex=num_sex));
sex = put(num_sex,sexfmt.);
drop num_sex;
run;
proc print;
run;
data one;
input name$ age$ sex$;
cards;
aaa 22 m
bbb 33 f
ccc 44 m
;
run;
proc print;
sum _numeric_;
run;
data character_to_numeric;
set one (rename = (age= new_age));
age = input(new_age,2.);
drop new_age;
run;
proc print;
sum _numeric_;
run;
data two;
input name$ age sex;
cards;
aaa 22 1
bbb 33 2
;
run;
proc print;
run;
proc format;
value sex
	1 = 'Female'
	2 = 'Male';
	run;
data numeric_to_character;
set two(rename = (sex = new_sex));
sex = put(new_sex,sex.);
drop new_sex;
run;
proc print;
run;
/*ssn11. - is a format which adds dashes...*/
data division1;
input SS @11 DOB mmddyy10. Gender $;
cards;
111223333 11/14/1956 M
123456789 05/17/1946 F
987654321 04/01/1977 F
;
run;
proc print;
format dob date9.;
run;
data division2;
input SS $ :11.  JobCode $ Salary;
/*input ss comma11.*/ 
cards;
111-22-3333 A10 45123
123-45-6789 B5 35400
987-65-4321 A20 87900
run;
proc print;
run;
/*numeric to character*/
data division3(drop = ss_new);
set division1 (rename = (ss = ss_new));
ss = put(ss_new,ssn11.);
run;
proc print;
run;
data new;
merge division3 division2;
by ss;
run;
proc print;
format dob date9.;
run;
/*character to numeric*/
data division4(drop = num_ss);
set division2 (rename = (ss = num_ss));
ss = input(num_ss,comma11.);
run;
proc print;
run;
data new;
merge division4 division1;
by ss;
run;
proc print;
format dob date9.;
run;


					proc means
 syntax
 		proc means data = dsn <options> - n nmiss mean median stddev
										  range sum noprint max min;
		var var_list;
		by pre_sorted var_list;
		class var_list;
		output out = new dsn;
		run;

n = no of non missing values
nmiss = no of missing values
;

proc means data = sashelp.class maxdec =3 noprint nway chartype;
var height weight;
by sex;
class sex;
output out = new
	mean = avght avgwt;
output out = new
	mean(height) = avght
	max(weight) = maxiwt;
output out = new (drop = _:)
	mean =
	max = /autoname;
run;
proc print data = new;
run;


proc means data = sashelp.class;
run;

proc means data = sashelp.class n nmiss mean median maxdec=2;
run;

proc means data = sashelp.class ;
var height weight;
run;

proc sort data = sashelp.class ;
by age;
run;
proc means data = sashelp.class;
by age;
run;

proc means data = sashelp.class;
class sex;
run;

proc means data = sashelp.class noprint;
class age sex;
output out = mclass;
run;
proc print data = mclass;
run;
/* _type_ indicates no of variables present in the class stt.*/

age		sex		_type_
0		0		0
0		1		1
1		0		2
1		1		3
;
proc means data = sashelp.class maxdec=0;
run;
/*The variables must be listed in the same order as in the VAR statement.*/
proc means data= sashelp.class ;
var age height weight;
output out = new max(age)=maximum_age
				mean(height) = avg_ht
				mean(weight) = avg_wt;
run;
proc print;
run;
proc means data = sashelp.class noprint;
var age ;
output out = mclass 
			max(age) = max_age;
run;
proc print data = mclass;
run;

data blood;
input Subject Chol;
cards;
1 258
2 .
3 184
4 .
5 187
run;
proc print;
run;
proc means data = blood ;
var chol;
output out = means 
	mean = avechol;
run;
proc print data = means;
run;
data new_blood;
set blood;
if _n_ =1 then set means;
perchol= chol/avechol;
format perchol percent8.;
run;
proc print;
run;
proc means data = sashelp.class;
run;
data new;
set sashelp.class;
label age = 'gender' height = 'HH';
run;
proc print data = new label;
run;
/*by default proc means shows the 5 statistical vaules along with the labels name if any*/
proc means data = new;
run;
/*chk out for clm option - it gives 2 outputs*/
proc means data = sashelp.class n nmiss std max min q1 q3 range median clm maxdec =1;
var height weight;
run;
proc sort data = new;
by sex;
run;
proc means data = new;
by sex;
run;
proc means data = sashelp.class;
class sex;
run;
proc format;
value $ sex
	'F' = 'Female'
	'M' = 'Male';
run;
/*class statement - the class variables are used as formatted values */
proc means data = sashelp.class;
class sex;
format sex $sex.;
run;
/*view the output by adding the variables to the class statement*/
proc means data = sashelp.class;
class  sex age height;
run;
proc means data = sashelp.class noprint;
var height weight;
output out = new_data 
				mean = Avg_height Avg_weight
				median = Med_height Med_weight
				std = sd_Height sd_weight
				n = n_ht n_wt
				nmiss = nmiss_ht nmiss_wt;
run;
proc print data = new_data;
run;
/*Autoname option - to name the output variables name*/
proc means data = sashelp.class noprint;
var height weight;
output out = new_data 
				mean = 
				nmiss =/autoname;
run;
proc print data = new_data;
run;
/*outputting a summary data set - including a by statement*/
proc means data = new noprint;
var height weight;
by 	sex;
output out = new_data 
				mean = 
				nmiss =/autoname;
run;
proc print data = new_data;
run;
/*outputting a summary data set - including a class statement*/
/*note that by using the class statement and outputting the dataset results in 3 observations*/
/*the addition value ie the '0' represents the grandmean - the mean of all non-missing values*/
proc means data = new noprint;
var height weight;
class sex;
output out = new_data 
				mean = 
				nmiss =/autoname;
run;
proc print data = new_data;
run;
/*nway option is used to remove the grandmean*/
proc means data = new noprint nway;
var height weight;
class sex;
output out = new_data 
				mean = 
				nmiss =/autoname;
run;
proc print data = new_data;
run;
/*chartype option is used to make the _Type_ variable to be a  character string of 1's and 0's */
/*see the table for clear understanding(page no - 370)*/
proc means data = new noprint chartype;
var height weight;
class sex age;
output out = new_data 
				mean = 
				nmiss =/autoname;
run;
proc print data = new_data;
run;
data new_grand new_sex new_age detail;
set new_data;
if _type_ = '00' then output new_grand;
else if _type_ = '10' then output new_sex;
else if _type_ = '01' then output new_age;
else output detail;
run;
proc print data = new_grand;
run;
proc print data = new_sex;
run;
proc print data = new_age;
run;
proc print data = detail;
run;
/*selecting different statistics for different variable*/
/*This DROP= option uses the colon wildcard notation. All variables beginning with an underscore */
/*character will be dropped.*/
proc means data = new noprint;
var height weight ;
class sex age;
output out = new_data  (drop = _:)
				mean(height) = 
				nmiss(height weight) =/autoname;
run;
proc print data = new_data;
run;
question_1;
proc means data = sashelp.class maxdec = 2 mean median min max n nmiss;
var height weight;
run;
question_2;
proc sort data =new;
by sex;
run;
proc means data = new;
by sex;
run;
proc format;
value $sex
		'F' = 'Female'
		'M' = 'Male';
value age
		low - 13 = 'AAA'
		14 <= 15 = 'BBB'
		15 - high = 'CCC';
run;
proc means data = new;
class sex;
format sex $sex. age age.;
run;
question_3;
proc means data = new;
by sex;
run;
proc means data = new;
class sex;
run;
question_4 and question_5;
similar to question_2;
question_6;
proc means data = sashelp.class noprint;
class sex;
var height weight;
output out = class_summary (drop = _:)
			n=
			mean =
			median= /autoname;
run;
proc print data = class_summary;
run;


					/*proc summary*/

proc summary data = sashelp.class print;
run;
proc summary gives the output if print options is der n 
by default gives the nobs only whereas proc means gives the 
output and by defalut it gives 5 statistical numbers;

proc summary data = sashelp.class print;
var age;
run;

							/*proc freq*/
syntax
proc freq data = dsn;
tables var_combination/<options>;
run;
list of options are LIST MISSING NOROW NOCOL NOPERCENT OUT=NEWDSN;

proc freq data = sashelp.class;
tables height weight;
tables height*weight/list crosslist norow nocol nopercent nofreq out = new;
tables height*weight/missing;
run;
proc freq data = sashelp.class order = formatted;
proc freq data = sashelp.class order = data;
proc freq data = sashelp.class order = freq;
tables height*weight;
run;
Proc freq is used to find the frequency distribution in the table.
;
/*frequency,percent,cumulative frequency and cumulative percent*/
proc freq data = sashelp.class;
tables sex age;
run;
/*frequency,percent,row pct and col pct*/
proc freq data = sashelp.class;
tables sex*age;
run;
proc freq data = sashelp.class;
tables sex*age*weight/crosslist;
run;
proc freq data = sashelp.class;
run;
proc freq data = sashelp.class;
tables age /nocum;
run;
proc freq data = sashelp.class;
tables age * sex /norow nocol nopercent;
run;
proc freq data = sashelp.class;
tables age * sex /list nocum;
run;
proc freq data = sashelp.class;
tables age * sex /list nocum missing;
run;
proc freq data = sashelp.class;
tables age * sex /list nocum out = fclass;
run;
proc print data = fclass;
run;
proc freq data = sashelp.class;
tables height weight /nocum nopercent;
run;
proc format;
value $sex
		'F' = 'Females'
		'M' = 'Males';
value age
		low-<12 = 'AAA'
		13-<14 = 'BBB'
		15-high = 'CCC';
run;
proc freq data = sashelp.class;
tables sex age/nocum;
format sex $sex. age age.;
run;
data one;
input x;
cards;
1
2
3
.
4
5
6
missing
7
8
run;
proc print;
run;
proc format;
value x
	low-3 = 'AAA'
	4-7='BBB'
	. = 'Missing'
	other='CCC';
run;
proc freq data = one;
tables x;
format x x.;
run;
/*missing statement*/
/*Without the MISSING option, percentages are computed as the frequency of each
category divided by the number of non-missing values; with the MISSING option, 
SAS computes frequencies by dividing the frequencies by the number of missing
and non-missing observations.*/
proc freq data = one;
tables x/missing;
format x x.;
run;
proc format;
value darwin
1 = 'Yellow'
2 = 'Blue'
3 = 'Red'
4 = 'Green'
. = 'Missing';
run;
data test;
input Color @@;
datalines;
3 4 1 2 3 3 3 1 2 2
;
proc print;
format color darwin.;
run;
title "Default Order (Internal)";
proc freq data=test;
tables Color / nocum nopercent missing;
format Color darwin.;
run;
/*ORDER=formatted alphabetizes the list based on the formatted values.*/
title "ORDER = formatted";
proc freq data=test order=formatted;
tables Color / nocum nopercent;
format Color darwin.;
run;
*In order to understand the ORDER=data option, notice that the first four observations 
in the data set Test are 3, 4, 1, and 2. This order controls the order of the frequencies 
in the table;
title "ORDER = data";
proc freq data=test order=data;
tables Color / nocum nopercent;
format Color darwin.;
run;
*the ORDER=freq option lists the values from the most frequent to the least frequent. 
This last option is especially useful when you have a large number of categories and 
you want to see which values are most frequent;
title "ORDER = freq";
proc freq data=test order=freq;
tables Color / nocum nopercent;
format Color darwin.;
run;
/*frequency,percent,cumualative frequency and cumualative percent*/
proc freq data = sashelp.class;
run;
/*two - way table*/
/*frequency,percent,row pct and col pct*/
proc freq data = sashelp.class;
tables age*weight;
run;
proc freq data = sashelp.class;
tables age * (height weight);
run;
/*three way table*/
proc freq data = sashelp.class;
tables sex*height*weight /norow nocol nopercent;
run;
question_1;
proc freq data = sashelp.class;
tables age height weight/nopercent nocum;
run;
question_2;
proc format;
value age
	low-12 = 'AAA'
	13-<14 = 'BBB'
	15-high = 'CCC';
	run;
proc freq data = sashelp.class;
tables name sex age;
format age age.;
run;
question_3;
/*without missing option*/
data blood;
input chol;
cards;
187
200
225
.
246
missing
250
run;
proc print;
run;
proc format;
value chol
	low-200 = 'AAA'
	201-high = 'BBB'
	. = 'Missing'
	other = 'CCC';
	run;
proc freq data = blood;
tables chol;
format chol chol.;
run;
/*with missing option*/
proc freq data = blood;
tables chol /missing;
format chol chol.;
run;
question_4;
proc freq data = sashelp.class;
tables sex*height;
run;


					/*PROC TRANSPOSE*/
syntax
		proc transpose data = dsn out = newdsn;
		var var_list;
		by pre_sorted var_list;
		id unique value var_list;
		run;
proc transpose data = sashelp.class out = new;
var height weight;
by sex;
run;

proc transpose data = sashelp.class out = tclass;
var name sex age;
run;
proc print data = tclass;
run;

proc sort data = sashelp.class out =myclass;
by sex;
run;
proc transpose data = myclass out = tclass;
by sex;
run;
proc print data = tclass;
run;

proc transpose data = sashelp.class out = tclass;
id name;
run;
proc print data = tclass;
run;

proc transpose data = myclass out = tclass;
var height weight;
by sex;
id name;
run;
proc print data = tclass;
run;

proc transpose data = myclass out = tclass;
var height weight;
by sex;
id name;
copy age;
run;
proc print data = tclass;
run;
				/*GENERATING CUSTOM REPORT*/
(.txt , .doc)

Raw data ---> (infile , input) ---> SAS
SAS ---> (file,put) ---> Raw data
;
data _null_;
set sashelp.class;
/*file 'location \filename.ext'print;*/
file 'D:\Athiq\Notes\report.doc' print;
put @1 name @ 10 age @ 15 sex;
title;
run;
/*chk out - without print option*/
data _null_;
set sashelp.class;
/*file 'location \filename.ext'print;*/
file 'D:\Athiq\Notes\report.txt' print;
put @1 name @ 10 age @ 15 sex;
title;
run;

