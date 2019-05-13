data assignment;
length des32.;
infile "D:\Athiq\Datasets\batting.txt"firstobs = 2;
input batting$ &15. @10 des $ &49. @25 r  @27 b
@29 _4s @32 _6s @35s/r;
run;
proc print;
run;

data one;
a= 5;
do while (a le 1000);
n+1;
a = a*2;
output;
end;
run;
proc print;
run;

data one1;
a= 5;
do until (a ge 1000);
a = a*2;
output;
end;
run;
proc print;
run;

data two;
a = 0;
do while (a le 5000);
a = a+400;
n+1;
output;
end;
run;
proc print;
run;

data rent;
input r1 r2 r3 r4 r5;
amount = 1000;
cards;
100 110 120 130 140 150
;
run;
proc print;
run;

data profit_cal;
set rent;
revenue = 1500;
array rent(5) r1 - r5;
do son = 1 to 5;
profit = revenue - (amount+rent(son));
output;
end;
run;
proc print;
run;

									/*PROCEDURE*/
proc sort data = sashelp.class out = new nodup(whole line) nodupkey dupout = new_1;
by sex descending age;
run;
proc print data = new;
run;
proc print data = sashelp.class double N = 'No of observations = ' 
(firstobs =2 obs =10) heading = v /h label/split = '*';
id sex;
var height weight;
label sex = 'Gender'
	  age = 'New_age';
by sex;
sum _numeric_;
pageby sex;
run;
libname athiq 'C:\Documents and Settings\Athik\Desktop\Athiq\SAS' ;
proc format lib = athiq;
value $sex 
	'M' = 'Male'
	'F' = 'Female';
	run;
options fmtsearch = (athiq work);
proc print data = sashelp.class;
format sex $sex.;
run;
proc format lib = athiq fmtlib;
run;


proc sort - it is used to arrange the dataset in ascending or 
	descending order according to "BY" statement variable value.
	syn = proc sort data = dsn out = newdsn(dsn = data set name);
			by var_list;
			run;
where ever by stt is used proc sort is used - mandatory;
by default it sorts in ascending order;

proc sort data = sashelp.class out = sclass;
by age;
run;
proc print;
run;

proc sort data = sashelp.class out = sclass_des;
by descending age;
run;
proc print;
run;

proc sort data = sashelp.class out = sclass1;
by sex age descending name ;
run;
proc print;
run;

proc sort data = sashelp.class out = sclass2;
by age height ;
run;
proc print;
run;

data rsort;
input name$ age marks;
cards;
ravi 28 75
raja 29 80
mona 30 85
roja 31 90
ravi 25 75
raja 29 80
mona 32 90
roja 33 95
;
run;
proc print;
run;
nodup - it is used to remove duplicate records.
nodupkey - it is used to remove records acc to by stt variables 
		value,duplicate values records will be removed.
dupout -  it is used to store removed records
;

proc sort data= rsort out =sort1 nodup;
by name;
run;
proc print;
run;
/*nodupkey = specific column;*/
proc sort data= rsort out =sort1 nodupkey;
by age;
run;
proc print;
run;

proc sort data= rsort out =sort1 nodupkey dupout = drecords;
by name;
run;
proc print;
run;

proc print data = dsn noobs;
syntax 
proc print data = dsn;
var_list; - specific variables as well as
				specific orders will be displayed.
By pre_sorted var_list;- it gives specific blocks.
Id var_list;- it is used to supress observations.
	it will nt display obs and the mentioned var vll b first.
Sum numeric var_list;- it displays the sum value of variables;
	run;

proc print data = sashelp.class;
var sex name age;
run;

proc sort data = sashelp.class out = myclass;
by sex;
run;
proc print data = myclass;
by sex ;
run;

proc print data = sashelp.class;
id height;
run;
proc print data = sashelp.class;
var name age sex;
id name age sex;
run;

proc print data = sashelp.class noobs;
var name age sex;
run;

proc print data = sashelp.class noobs;
sum age ;
run;

proc print data = sashelp.class noobs;
sum _numeric_;
run;
proc sort data = sashelp.class out = new;
by age;
run;
proc print data= new;
sum _numeric_;
by age;
pageby age;
run;
/*using the same variable in both id and by statement*/
proc print data =new;
id age;
by age;
run;
/*usage of "N" option in proc print statement*/
title "N observation";
proc print data =new n = "Total no of observations = ";
run;
/*double spacing*/
proc print data =new double;
run;
/*firstobs and obs and heading*/
proc print data = sashelp.class (obs = 5);
run;
proc print data = sashelp.class (firstobs = 2 obs = 5) heading = v;
run;
proc print data = sashelp.class (firstobs = 2 obs = 5) heading = h;
run;

question_2;
title "sales figure from the sales data set";
/*note : the dataset new is sorted by age;*/
proc print data = new;
id age;
by age;
sum _numeric_;
run;
question_3;
title 'Selected Patients from HOSP Data Set';
title2 'Admitted in September of 2004';
title3 'Older than 83 years of age';
title4 '-------------------------';
proc print data = new double n = 'Number of observation = ';
label height = "New_ht" age = "New age" weight = "New and old weight";
run;
question_4;
title;
proc print data = new (firstobs = 1 obs = 5);
id name;
var age height weight;
run;


find the sum of age ht wt for female n male employees
separtely and also find grand total.in the o/p name 
should nt be displayed.

datasets = contents + property 
			proc contents + proc print
proc contents is used to display the discriptive 
portion of the data set.
;
proc contents data = sashelp.class;
run;

proc format
syntax
	proc format;
	value name range1 = 'text1'
				rangen = 'textn';
	value $name 'text1' = value1
				'textn' = valuen;
	run;
proc format lib = athiq;
value age_group low - 12 = 'KID'
				13 - 14 = 'CHILD'
				15 - 16 = 'TEEN'
				17 - High = 'ADULT';
value $gender 'F' = 1
			  'M' = 2;
run;
proc print data = sashelp.class;
format age age_group. sex $gender.;
run;

proc format lib = athiq;
value type low - 90 = 'Thin'
			91 - 100 = 'Medium'
			110 - high = 'Fat';
run;
options fmtsearch = (athiq work);
proc print data = sashelp.class;
format weight type.;
run;
fmtsearch - it is used to assign to search the dataset
			in my library first and den to the work.
;
data new;
set sashelp.class;
label age = 'New_age'
	  sex = 'New_sex';
run;
proc print label;
run;
proc means data = sashelp.class maxdec = 2;
label height = 'New_ht'
	  weight = 'New_wt';
var height weight;
run;
libname athiq 'C:\Documents and Settings\Athik\Desktop\Athiq\SAS';
proc format lib = athiq;
value $sex
		'M' = 'Male'
		'F' = 'Female';
value age
		low-13 = 'AAA'
		14 -15 = 'BBB'
		other = 'NA';
run;
proc format lib = athiq;
value age
		12,13 = 'AAA'
		14,15 = 'BBB'
		other = 'NA';
run;
proc format lib = athiq;
value height
		50-<60 = 'AAA'
		61<-65 = 'BBB'
		other = 'NA';
run;
proc sort data = sashelp.class out = new;
by age;
run;
options fmtsearch = (athiq work);
proc print data = new;
format sex $sex. age age.;
run;
proc print data = new;
format age age.;
run;
proc print data = new;
format height height.;
run;
proc format lib = athiq fmtlib;
run;
proc format lib = athiq;
select age $age;
run;
proc format lib = athiq;
exclude age $age;
run;
proc print data = sashelp.class;
format height dollar5.1 weight;
run;
chp 5:
question_1;
data voter;
input Age Party : $1. (Ques1-Ques4)($1. + 1);
datalines;
23 D 1 1 2 2
45 R 5 5 4 1
67 D 2 4 3 3
39 R 4 4 4 4
19 D 2 1 2 1
75 D 3 3 2 3
57 R 4 3 4 4
;
run;
proc print;
run;
libname athiq 'C:\Documents and Settings\Athik\Desktop\Athiq\SAS';
proc format lib = athiq;
value age
	0-30 = 'AAA'
    31-50 = 'BBB'
    51-70 = 'CCC'
    71-high = 'NA';
value $party
	'D' = Democrat
	'R' = Republican;
value $opinion
	'1'=Strongly Disagree
	'2'=Disagree
	'3'=No Opinion
	'4'=Agree
	'5'=Strongly Agree;
run;
options fmtsearch = (athiq work);
proc print data = voter  label;
format age age. party $party. ques1-ques4 $opinion.;
label Ques1 = 'The president is doing a good job'
	  Ques2 = 'Congress is doing a good job'
	  Ques3 = 'Taxes are too high '
      Ques4 = 'Government should cut spending';
run;
question_2;
proc format lib = athiq;
value $new_opinion
	'1','2' = 'Generally Disagree' 
    '3'='No Opinion'
    '4','5' = 'Generally Agree' ;
run;
proc freq data = voter;
tables ques1-ques4;
format 	ques1-ques4 $new_opinion.;
run;
question_3;
data colors;
input Color : $1. @@;
datalines;
R R B G Y Y . . B G R B G Y P O O V V B
;
run;
proc format lib = athiq;
value $color
	'R','B','G' = 'Group 1'
	'Y','O' = 'Group 2'
	' ' = 'Not Given'
	 others = 'Group 3';
run;
proc freq data = colors;
tables color /missing;
format color $color.;
run;
question_5;
data voter;
input Age Party : $1. (Ques1-Ques4)($1. + 1);
label age = 'New_age'
	  party = 'New_party';
format age age. party party.;
datalines;
23 D 1 1 2 2
45 R 5 5 4 1
67 D 2 4 3 3
39 R 4 4 4 4
19 D 2 1 2 1
75 D 3 3 2 3
57 R 4 3 4 4
;
run;
proc print;
run;
proc format lib = athiq fmtlib;
run;
proc contents data = test;
run;
proc print data = test;
run;

