data assignment;
set sashelp.class;
length type$ 6;
if height le 60 then type = 'small';
else if height le 65 then type= 'medium';
else if  height le 70  then type = 'taller';
run;
proc print;
run;
data one;
set sashelp.class;
if age < = 13 and (height <65 and weight < 65);
run;
proc print;
run;

*where statement - it applies this condition on the source file.
				whereas the if statement first reads the data 
				from the source and then applies the condition.
				run the 2 programmes and check the log for 
				better understanding;
;
data where_ex;
set sashelp.class;
where age > 13;
run;
proc print;
run;

data if_ex; 
set sashelp.class;
if age > 13;
run;
proc print;
run;
*dnt give 2 where conditions since it overwrites the previous 
where condition;
;
data where_ex1;
set sashelp.class;
where age > 13 ;
where sex = 'F';
run;
proc print;
run;
data if_ex1;
set sashelp.class;
if age > 13 ;
if sex = 'F';
run;
proc print;
run;

data where_ex2;
set sashelp.class;
where age > 13 and sex = 'F';
run;
proc print;
run;
data if_ex1; 
set sashelp.class;
if age > 13;
if sex = 'F';
run;
proc print;
run;
proc print data = sashelp.class;
where age > 13;
run;
data monday20022;
set monday2002;
where date = 010410;
/*age = round(date);*/
run;
proc print;
run;

	if									where
1. multiple conditions can 			only single condition is allowed
	be used			

2. only used in data step 			used in data step as well as 
										proc step

3. read the data first and 			it directly apply the condition 
	then apply the condition		 and then read the data.


   ;
special characters with respect to where
between
missing 
contains
like
;
data one;
set sashelp.class;
where age between 13 and 14;
run;
proc print;
run;
proc print data = sashelp.class;
where age between 13 and 15;
run;

proc print data = sashelp.class;
where age is missing;
run;

proc print data = sashelp.class;
where name contains 'b';
run;
*% -> Any number of digits in between
_ -> Single digit
__ -> Two digit;

proc print data = sashelp.class;
where name likes 'J%';
run;

proc print data = sashelp.class;
where name like '%e';
run;

proc print data = sashelp.class;
where name like 'J_n%';
run;

proc print data = sashelp.class;
where name like 'J__e%';
run;

proc print data = sashelp.class;
where name like 'J%e';
run;

data weekly_revenue;
infile cards;
input day$ revenue dollar5.;
cards;
mon	$1000
tue $1500
wed $ .
thu $2000
fri $3000
;
run;
proc print;
run;
data new;
input name$ scores;
if missing(scores) then count+100;
else count+10;
cards;
aaa 23
bbb 33
ccc .
ddd 55
eee 66
fff	.
;
run;
proc print;
run;

proc print data =sashelp.class;
where age in ( 12:13);
run;
proc print data = sashelp.class;
/*where name is missing;*/
/*where name is null;*/
/*where age between 14 and 16;*/
/*where name like '%m';*/
/*where name contains 'Judy';*/
/*where name = * 'James';*/
run;
proc print data = sashelp.class;
/*where age = 11 or age = 12 or age =13;*/
where age in (11,12,13);
run; 

/*retain is used to retain the privious value of the variable.*/
/*chk out - retain statement gives missing values if it is used with '+'*/
data one;
set weekly_revenue;
retain total 0;
total = total + revenue;
run;
proc print;
run;
data weekly_revenue1;
set weekly_revenue;
retain total 0;
total = sum(total,revenue);
run;
proc print;
run;
/*sum statement = variable + increment*/

1.First it creates a new variable and initialize is '0'
2.It retain the previous value of the variable.
3.If increment is having missing value then it ll be 
	ignored.
	;
data weekly_revenue2;
set weekly_revenue;
total_revenue + revenue;
run;
proc print;
run;
/*sum statement -  it ignores the missing valves*/
data one;
input name$ revenue;
total + revenue;
cards;
aaa 24000
bbb 45000
ccc  .
ddd 55000
;
run;
proc print;
sum total;
run;
/*retain statement-sum statement -  it considers the missing valves*/
data one;
input name$ revenue;
retain total  0;
/*if not missing (revenue) then*/
total = total + revenue;
cards;
aaa 24000
bbb 45000
ccc  .
ddd 55000
;
run;
proc print;
run;
data revenue;
retain Total 0;
retain Total_11;
input Day : $3.
Revenue : dollar6.;
Total = Total + Revenue; /* Note: this does not work */
Total_11 = sum(total_11,revenue);
format Revenue Total Total_11 dollar8.;
datalines;
Mon $1,000
Tue $1,500
Wed .
Thu $2,000
Fri $3,000
;
proc print;
run;

missing function - it returns either 0 or 1.
					0 when variable is not missing,
					1 when variable is missing.
					;
data one;
set weekly_revenue;
if missing(revenue) =1 then new_revenue = 'correct';
else if missing(revenue) =0 then new_revenue = 'Nt_crt';
run;
proc print;
run;

data weekly_revenue3;
set weekly_revenue;
if missing (revenue) then delete;
retain total 0;
total = total +revenue;
run;
proc print;
run;
data one_1;
input name$ revenue;
/*if missing(revenue) then miss_count + 1;*/
cards;
aaa 24000
bbb 45000
ccc  .
ddd 55000
eee   .
;
run;
proc print;
run;

data missing_ex;
input name$ :9. age;
if name = ' ' then name = 'not found';
if age = '.'  then age = 0;
cards;
david  28
.      30
alan   .
amelia 35
;
run;
proc print;
run;

data missing_ex1;
input name$ :9. age;
if missing(name) then name = 'not found';
if missing(age) then age = 0;
cards;
david  28
.      30
alan   .
amelia 35
;
run;
proc print;
run;
data one;
input name$ score;
retain total 0;
if not missing (score) then total = total + score;
cards;
aaa 12
bbb .
ccc 14
ddd 23
eee  .
;
run;
proc print;
run;
*Sum statement - If the expression in a Sum statement 
produces a missing value, the Sum statement ignores it;
data onee;
input name$ score;
total+score;
cards;
aaa 12
bbb .
ccc 23
ddd 34
eee  .
;
run;
proc print ;
run;
*Assignment statement - It assign a missing value 
if the expression produces a missing value;
data onee;
input name$ score;
sum = 20 + score;
cards;
aaa 12
bbb .
ccc 23
ddd 34
eee  .
;
run;
proc print ;
run;
/*assignment*/
1.create a new variable with the name of miss value
whose value depend on x if x is missing then miss_value should
have yes and if x is not missing then miss value should have 
no.
2.create one more variable with the name of miss_count which
gives no. of missing values for x .
data missing_assignment;
input x;
cards;
2
3
.
.
5
.
6
.
7
;
run;

do loop - it is used to perfom repetative task.

syntax = Do index = start TO stop BY increment;
		 Sas code;
		 END;
output is used to save the value of the 
		 variables to output dataset.
		 ;
data do_ex;
a = 0;
do i = 1 to 10;
a = a +10;
output;
end;
run;
proc print;
run;

data do_ex1;
a = 0;
do i = 1 to 10;
a = a +10;
put a i;
end;
run;
proc print;
run;
Highlights of this section:

1. Check out
The two if statements works - it checks the first IF statement and within that IF statement
it checks other IF statement
The two where statements works - it overwrites the previous where statement

2. Check out
Check out the retain statement with '+' symbol and sum function
contains works without '%'
like works with '%'
sum statement ignores missing values
missing function outputs 1 if it is true(anything is missing) else 0
