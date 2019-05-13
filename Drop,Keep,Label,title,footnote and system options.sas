
data new;
infile cards firstobs = 2;
input (east west north south central) ($);
cards;
east west north south central
7412 2312 9565 8088 7223
6217 3217 9495 6768 2327
;
run;
proc print;
run;

data addnew1;
set new;
add = '1';
east = add || east;
drop add;
run;
proc print data=addnew1;
run;

data new_database;
set new;
array train(*)$ east -- central ;
do i = 2 to dim(train);
train (i) = '1' || train(i);
end;
drop i;
run;
proc print;
run;

		/*DROP KEEP RENAME*/
DROP = it is used during fetching the data
		;
data female;
set sashelp.class (drop = age weight);
if sex = 'F';
run;
proc print;
run;

/*drop statement and drop option*/
proc print data = sashelp.class(drop = age);
drop sex;
run;

/*	SOURCE  -  BUFFER  -  DESTINATION*/

data female1 (drop =  age);
set sashelp.class ;
if sex = 'F' & age > 13;
run;
proc print;
run;

data female2(BUFFER); 
set sashelp.class(SOURCE) ;
if sex = 'F' & age > 13;
drop age(DESTINATION);
run;
proc print;
run;

data male ;
set sashelp.class(keep = name sex height) ;
if sex = 'M';
run;
proc print;
run;

data male1(keep = name sex height) ;
set sashelp.class;
if sex = 'M' & age >13;
run;
proc print;
run;

data male2;
set sashelp.class;
if sex = 'M';
keep name sex height;
run;
proc print;
run;

data male3 (keep = height);
set sashelp.class;
if sex = 'M';
keep name sex height;
run;
proc print;
run;

		/*RENAME*/
it is used to rename the columns;
data male4;
set sashelp.class (rename = (sex= gender));
if gender = 'M';
run;
proc print;
run;

data male5(drop = sex);
set sashelp.class (rename = (sex= gender));
if gender = 'M';
run;
proc print;
run;

data senior_citizen (keep = name weight);
set sashelp.class;
if age ge 15 ;
run;
proc print data = senior_citizen;
run;

data senior_citizen1 (drop = age);
set sashelp.class (keep = name age weight);
if age ge 15 ;
run;
proc print data = senior_citizen1;
run;

		/*LABEL TITLE FOOTNOTE*/
LABEL is used in both data step as well as proc step.
if it is used in proc print it is temporary
and the same is in permanent in data step;
proc print data = sashelp.class label;
label name = 'Employee Name'
		sex = 'Gender';
where sex = 'M';
run;

data myclass;
set sashelp.class;
label name = 'employee name';
run;
proc print data = myclass label;
run;

proc print data = myclass label;
label name = 'HR Employee';
run; 

		/*TITLE*/
TITLE - Its like a header and the maximum no. of titles 
		given are 10 and its a global statement (used in
		both data step as well as proc step)
;
proc print data = sashelp.class;
title ' MY First Title';
run;

proc print data = sashelp.Buy;
run;

proc print data = sashelp.Buy;
title 'sashelp.buy result';
run;

proc print data = sashelp.class;
/*title ' MY First Title';*/
title2 ' MY 2nd new Title';
/*title3 ' MY 3rd Title';*/
run;

proc print data = sashelp.class;
title ' MY First Title';
title2 ' MY 2nd Title';
title3 ' MY 3rd Title';
title ;
run;

proc print data = sashelp.class;
title ' MY First Title';
title ' My Best Title';
run;

		/*FOOTNOTE*/

FOOTNOTE -  Its a global statement and max limit is 10
;
proc print data = sashelp.class;
footnote 'My First Footnote';
footnote2 'My 2nd Footnote';
footnote3 'My 3rd Footnote';
run;

proc print data = sashelp.class;
footnote 'My First Footnote';
footnote2 'My 2nd Footnote';
footnote3 'My 3rd Footnote';
footnote;
run;

proc print data = sashelp.class;
title '1st';
title2 '2nd';
title3 '3rd';
run;

proc print data = sashelp.shoes;
title2 'my';
run;
proc print data = sashelp.class;
run;
data one;
set sashelp.class;
set sashelp.class;
run;
proc print;
run;
proc print data = sashelp.class;
where age in (13,15);
run;
title " hi";
title3 "how are you";
title4 "im fine";
proc print data = sashelp.class;
run;
/*note : der is a blank between title and title3 since title2 is missing*/
title "hi";
title3 "yes boss";
proc print data = sashelp.class;
run;
/*note : the title 4 is removed since title3 is updated*/
title;
proc print data = sashelp.class;
run;
label statement;
proc print data = sashelp.class label;
label age = "New_age" 
	  height = "New_heihgt";
run;
proc print data = new label;
label age = "Ques_age" 
	  height = "Ques_ht" 
      weight ="Ques_wt";
id age;
run;


		/*SYSTEM OPTIONS*/

It is used to display the o/p as per the user choice.
options center/nocentre;

options centre/nocentre;
options nocentre;

proc print data = sashelp.class;
run;

options date/nodate;
options nodate;

proc print data = sashelp.class;
run;

options number/nonumber;
options nonumber;
proc print data = sashelp.class;
run;

options linesize; = min value = 15 it lies b/w 64 - 256, 
					it decides the no of char in one line;
options pagesize; = it decides the no of lines in one page
					15 <PS <32676;
options pageno; = starting page no for output, default = 1;

proc options option= linesize ;
run;

options linesize = 200;
options center;
proc print data = sashelp.shoes;
run;

options pagesize = 20;
proc print data = sashelp.shoes;
run;

options pageno ;
proc print data = sashelp.shoes;
run;

options				Firstobs = 10 			(Default = 1)
Options				Obs = 10				(Default = Max)
;

proc options;
proc print data = sashelp.shoes;
run;


