								/*conditinal processing*/
if 
	1. if expression; (subseting if)
	2. if condition then action;
	3. if condition then do;		
						action1;
						action2;
						end;
	4. if condition then action1;
		else if condition then action2;
		else if conditon then action3;
		else action
Logical operators - eq ne le lt ge gt and or;
missing and not missing
Select option without expression
Select option with expression
Select option with do loop;

data female;
set sashelp.class;
if sex = 'F';
run;
proc print data = female;
run;
/*chk out - No observations*/
data one;
set sashelp.class;
if sex = 'F';
if sex = 'M';
run;
proc print;
run;
data female1;
set sashelp.class;
if sex = 'F';
if age >13;
run;
proc print data = female1;
run;
data female2;
set sashelp.class;
if (sex = 'F'and age gt 13) and (height le 64 and weight le 105);
run;
proc print data = female2;
run;

/*logical operators*/

Operators 		Keyword		Description
= 				  EQ		Equal to
^= or ~=		  NE		Not equal to
>				  GT		Greater than
>=				  GE		Greater than or equal to
<				  lT		Less than
<=				  LE		Less than or equal to
& 				  AND		And
||or!			  OR		Or
				  IN		Equal to any one in list

;

data female3;
set sashelp.class;
if age gt 13 & age lt 15;
run;
proc print data = female3;
run;
/*wrong output*/
data one;
set sashelp.class;
if age le 13 or 14;
run;
proc print;
run;
data female4;
set sashelp.class;
if age GE 12 & age LE 15;
run;
proc print data = female4;
run;
data female5;
set sashelp.class;
if sex = 'F'OR height GE 60;
run;
proc print data = female5;
run;
data female6;
set sashelp.class;
if age IN (11,13,15);
run;
proc print ;
run;
data new;
set sashelp.class;
if age in(11 12);
run;
proc print;
run;
data new;
set sashelp.class;
if age in(11 : 13);
run;
proc print;
run;
data female7;
set sashelp.class;
if age GE 12 OR age LE 15;
run;
proc print ;
run;
data one;
set sashelp.class;
if age < = 13 then city = 1;
if age > = 13 and age < = 14 then city = 2;
if age >=14 then city = 3;
run;
proc print;
run;
proc print data = sashelp.class;
run;


* condition1 condition2		AND		OR

True		True			True	True
True 		False			False	True
False		True			False	True
False		False			False	False
;

/*if condition then action*/

data if_ex;
set sashelp.class;
if sex = 'M' then city = 'Bangalore';
run;
proc print;
run;
/*chk out - all observations*/
data new;
set sashelp.class;
if age = 13 then status = 1;
if age = 14 then status = 2;
if age = 15 then status = 3;
else status = 0;
run;
proc print;
run;
data new;
set sashelp.class;
if age = 13 then status = 1;
else if age = 14 then status = 2;
else if age = 15 then status = 3;
else status = 0;
run;
proc print;
run;

data one;
set sashelp.class;
if sex = 'F' then city = 'AAA';
if sex = 'M' then city = 'BBB';
run;
proc print;
run;
data if_ex1;
set sashelp.class;
if sex = 'M' then city = 'Bangalore';
if sex = 'M' then city = 'NA';
run;
proc print;
run;
					/*if - then do conditions*/

data if_ex2;
set if_ex1;
if sex = 'F' then do;
					city = 'Mumbai';
					marks = '200';
					end;
run;
proc print;
run;

data if_ex3;
set sashelp.class;
if sex = 'F' then do;
					city = 'Mumbai';
					marks = '200';
					end;
if sex = 'M' then do;
					city = 'Bangalore';
					marks = '500';
					end;

run;
proc print;
run;
/*chk out - if with else condition in loop*/
data new;
set sashelp.class;
if sex = 'F' then do;
					city = 'Mumbai';
					marks = '200';
					end;
else sex = 'M' then do;
					city = 'Bangalore';
					marks = '500';
					end;
run;
proc print;
run;
data new;
set sashelp.class;
if sex= 'M' then city = 'AAA';
else city = 'BBB';
run;
proc print;
run;
data new;
set sashelp.class;
if sex = 'F' then do;
					city = 'Bombay';
					marks = '200';
					end;
else do;
					city = 'Bangalore';
					marks = '500';
					end;
run;
proc print;
run;
/*chk out - if with else if in loop*/
data new;
set sashelp.class;
if sex = 'F' then do;
					city = 'Mumbai';
					marks = '200';
					end;
else if sex = 'M' then do;
					city = 'Bangalore';
					marks = '500';
					end;
run;
proc print;
run;

data if_ex4;
infile cards firstobs = 2;
input sno age sub1 sub2 sub3;
cards;
sno age		sub1	sub2	sub3 
1	21		30		35		32
2	22		25		26		27
3	26		27		28		29
4	24		28		29		30
5	26		30		31		32
6	23		22		24		28
;
run;
proc print;
run;
data if_ex5;
infile cards firstobs = 2;
input sno age sub1 sub2 sub3;
if sub1 GE 27 then do;
					total_marks = sub1+sub2+sub3;
					percentage = (total_marks/105)*100;
					end;
cards;
sno 	age		sub1		sub2		sub3 
1	21		30		35		32
2	22		25		26		27
3	26		27		28		29
4	24		28		29		30
5	26		30		31		32
6	23		22		24		28
;
run;
proc print;
run;

 *'if_then_do_end' is used to get multiple actions and 'if' is used to 
 get single action; 

data if_ex6;
infile cards firstobs = 2;
input sno age sub1 sub2 sub3;
if sub1 GE 27 then do;
					total_marks = sub1+sub2+sub3;
					percentage = (total_marks/105)*100;
					end;
else total_marks = sub1+sub2+sub3;
cards;
sno age		sub1	sub2	sub3 
1	21		30		35		32
2	22		25		26		27
3	26		27		28		29
4	24		28		29		30
5	26		30		31		32
6	23		22		24		28
;
run;
proc print;
run;

age			age_group
less than 12		Kid
12 - 14			Child
14 - 16			Teen
16 - above		Adult
;
				/*if - else if - else condition*/
data if_ex7;
set sashelp.class;
length age_group $ 5;
if age le 12 then age_group = 'Kid';
else if age le 14 then age_group = 'Child';
else if age le 16 then age_group = 'Teen';
else age_group = ' Adult';
run;
proc print;
run;
data school;
input Age Quiz $ Midterm Final;
if age =  12 then Grade = 6;
/*else if age = 13 then Grade = 8;*/
else grade =  'NA';
datalines;
12 A 92 95
12 B 88 88
13 C 78 75
13 A 92 93
12 F 55 62
13 B 88 82
;
run;
proc print;
run;
question_2;
proc contents data = sashelp. _all_ nods;
run;
/*chk*/
data one;
set sashelp.class;
if age in (12 13)then do;
						new_age = 'A';
						Grade = 'A+';
						end;
else if age in (14 15)then do;
			new_age = 'B';
			Grade = 'B+';
			end;
else do;
		new_age = 'C';
		Grade = 'C+';
		end;
run;
proc print;
run;
question_1;
data vitals;
length pulse_group $ 4 SBP_group $ 4;
input ID $
Age
Pulse
SBP
DBP;
label SBP = "Systolic Blood Pressure"
DBP = "Diastolic Blood Pressure";
if age < 50 and pulse < 70  then
pulse_group = 'Low';
else pulse_group = 'High';
if age < 50 and SBP < 130  then
SBP_group = 'Low';
else SBP_group = 'High';
if age > =  50 and pulse < 74  then
pulse_group = 'Low';
else pulse_group = 'High';
if age > = 50 and SBP < 140  then
SBP_group = 'Low';
else SBP_group = 'High';
datalines;
001 23 68 120 80
002 55 72 188 96
003 78 82 200 100
004 18 58 110 70
005 43 52 120 82
006 37 74 150 98
007 . 82 140 100
;
proc print;
run;
question_3;
data test;
input Score1-Score3;
if not missing(score1-score3) then sub+1;
datalines;
90 88 92
75 76 88
88 82 91
72 68 70
;
proc print;
run;
question_4;
data test;
input Score1-Score3;
if  missing(score1-score3) then sub+1;
datalines;
90 88 .
75 76 88
88 . .
72 68 70
;
proc print;
run;
proc means data = test nmiss;run;
data new;
input day month year;
if missing (day) then date = mdy(month, 15, year);
else date = mdy (month,day,year);
cards;
25 12 2005
. 5 2002
12 8 2006
run;
proc print;
format date mmddyy10.;
run;
chapter_10;
data males females;
set sashelp.class;
if sex = 'F' then output females;
else output males;
run;
proc print data = males;
run;
proc print data = females;
run;
proc print;
run;
question_1;
data subset_A subset_B;
set sashelp.class;
new = height+weight;
if sex = 'F'  and height > 58
then  output subset_A;
else if new > = 100 then
output subset_B;
run;
proc print data = subset_A;
run;
proc print data = subset_B;
run;
/*Chk out if der r missing numeric data between dem as well as continous*/
data one111;
input name$ age;
if missing(name) then new_name+1;
else if missing(age)then new_age+1;
cards;
aaa  .
 .   .
ccc  .
ddd 55
run;
proc print;
run;
data psych(drop = q1 - q10);
input ID $ Q1-Q10;
if n(of Q1-Q10) ge 7 then do Score = mean(of Q1-Q10);
							 MaxScore = max(of Q1-Q10);
							 MinScore = min(of Q1-Q10);
							 end;
else do;
		   	   maxscore = max(of q1 -q10);
			   MinScore = min(of Q1-Q10);
   			   end;
datalines;
001 4 1 3 9 1 2 3 5 . 3
002 3 5 4 2 . 1 . 2 4 .
003 9 8 7 6 5 4 3 2 1 5
;
run;
proc print;
run;
data new;
input name$ score1-score4;
a1 = mean(of score1-score4);
cards;
aaa 2 2 3 1
bbb 3 . 2 1
ccc . . . 3
ddd 4 2 . 2
;
run;
proc print;
run;
*data assignment;
infile cards firstobs =2;
input height type;
length type$ 6;
if height le 60 then type = 'small';
else if height le 65 then type= 'medium';
else age_group = ' Adult';
run;
cards;
height			type
less than 60 		small
60 - 65			medium
65 - 70 		taller
;

proc print;
run;

/*select option*/

data select;
set sashelp.class;
length age_group $5;
select;
when (age lt 12) age_group = 'kid';
when (age lt 14) age_group = 'Child';
when (age lt 16) age_group = 'Teen';
otherwise age_group = 'Adult';
end;
run;
proc print;
run;
/*select statement without select expression*/
data new;
set sashelp.class;
select;
when(age<13) new_age = 'AAA';
when(age<14) new_age = 'BBB';
when(age<15) new_age = 'CCC';
otherwise new_age = 'NA';
end;
run;
proc print;
run;
/*select statement with select expression*/
data new;
set sashelp.class;
select(sex);
when('F') new_sex = 'AA+';
when('M') new_sex = 'BB+';
/*when(<15) new_age = 'CC+';*/
/*otherwise new_age = 'NA+';*/
end;
run;
proc print;
run;
proc contents data = sashelp.class;
run;
/*select statement with do loop*/
data new;
set sashelp.class;
select(sex);
when('F') 
		do;
		new_sex = 'AA+';
		old_sex = 'Female';
		end;
otherwise new_sex = 'BB+';
end;
run;
proc print;
run;
data one;
set sashelp.class;
select ;
when (age = 11)  age_group = 1;
when (age = 12)  age_group = 2;
otherwise age_group = 3;
end;
run;
proc print;
run;
data one_1;
set sashelp.class;
select (age);
when (11) new_age = 'A';
when (12)  new_age = 'B';
otherwise new_age = 'C';
end;
run;
proc print;
var name age sex;
run;

/*yet to solve*/
data new;
set sashelp.class;
/*select <with expression>;*/
select(age);
when (le 12) new_age= 'AA-';
when (ge 13) new_age= 'BB-';
otherwise new_age = 'NA';
end;
run;
proc print;
run;

highlights of this section:
1.chk out
if sex = 'F' ;
if sex = 'M';
	it doesnt work;

2.chk out
the same if statement along with some conditions like
if sex = 'F' then city ='AAA';
if sex = 'M' then city ='BBB';
	it works

3.chk out
the do end works well with if and if or if with else if 
and not with if and else

4.chk out
The do loop and select statement should ends with "END" statement

5.select with expression holds good only if the inside when statement does nt cotains
any arithmetic operators
