/*Assignment 1*/
/*name dpt salary*/
data one;
infile cards;
input @5 name$&18. /dpt$/ salary dollar9.;
cards;
123 harold wilson
Acct 01/15/1989
$78,123
007 James Bond
Sect 02/17/1988
$1,22,217
127 Julia child
Food 03/21/1989
$ 15,729
;
run;
proc print data = one;
run;
data one;
infile ' D:\Athiq\Datasets\sample.txt' firstobs = 2 missover;
input sno @5 product$ @9 remarks$ &9.;
run;
proc print data = one;
run;
data two;
infile ' D:\Athiq\Datasets\sample.txt' firstobs = 2 truncover;
input sno @5 product$ @9 remarks$ 9.;
run;
proc print data = two;
run;
data three;
infile ' D:\Athiq\Datasets\marks.txt' firstobs = 2 missover;
input s1$ 1-2 s2 4-5  s3  8- 9 s4 12 - 13;
run;
proc print data = three;
run;
data four;
infile ' D:\Athiq\Datasets\marks.txt' firstobs = 2 truncover;
input s1$ 1-2 s2 4-5  s3  8-9 s4 12 -13;
run;
proc print data = three;
run;
data five;
infile ' D:\Athiq\Datasets\marks1.txt' firstobs = 2 truncover;
input s1$ 1-2 s2 4-5  s3  8- 9 s4 12-15 ;
run;
proc print data = five;
run;
/*SAS functions - to perform a specific task
syntax : vari - name =function(argument1,argument2,.. argumentn);*/

/*Numeric function*/
*MAX MIN SUM(0) MEAN
INT FLOOR CELL ROUND
LOG LOG10 MOD FACT 
ABS SQRT EXP
LAG LAG2 LAG3 
DIF	
LARGEST SMALLEST;
data num_fun;
a=10;
b=20;
c=-30;
d=40;
mx = max (a,b,c,d);
mn = min (a,b,c,d);
su = sum (a,b,c,d);
avg = mean (a,b,c,d);
run; 
proc print data = num_fun;
run;
data new;
a = 2;
b = 4;
c = 6;
a1 = mean(a,b,c);
run;
proc print;
run;

arithematic operator

example		operator		description			priority
4+2=6			+			addition			lowest
4-2=2			-			subtraction			lowest
4*2=8			*			multiplication		next heighest
4/2=2			/			division			next heighest
4**2=16			**			exponential			highest
-4=-4			-			negation			highest
;
data arithmetic_function
x=2+3*4;
y=(2+3)*4;
z=2**3+4*-5;
run;
proc print data = arithmetic_function;
run;
/*SET - it is used to create duplicate or a copy of existing data set*/
proc print data =sashelp.class;
run;
/*BMI = weight/height**2*/

data athiq.myclass;
set sashelp.class;
run;
/*convert kg to pound and inch to centimeter*/

data athiq.bmi;
set athiq.myclass;
bmi=(weight/2.2)/((height*.0254)**2);
run;
proc print data =bmi;
run;
data athiq.bmi1;
set athiq.myclass;
weight(pds) =(weight/2.2);
height(cmts)=((height*.0254)**2);
bmi=weight/height;
run;
proc print data =bmi1;
run;
data num_fun1;
a=10;
b=20;
c=.;
d=30;
su = a+b+c+d;
su1 = sum (a,b,c,d);
avg1 = mean (a,b,c,d);
avg=(a+b+c+d)/4;
run; 
proc print data = num_fun1;
run;

/*int,floor.ceil,round*/
;
int - it is used to return the integer part of the value
floor - it is used to return lowest nearest integer value
ceil - it is used to return nearest highest integer value
round - it is used to round the number either to the nearest integer
		or to other values such as 10th,100th..
example : 
		int 	floor	 ceil	 round
45.23		45	45	  46	 45
45.55		45	45	  46	 46
45.98		45	45	  46     46	
;
data num_fun2;
x=2567.6789;
r1=round(x);
r2=round(x,.001);
r3=round(x,.01);
r4=round(x,.1);
r5=round(x,10);
r6=round(x,100);
run;
proc print data = num_fun2;
format x r1- r6 9.4;
run;

/*log log10 mod fact*/
10***3 = 1000
log10 1000  = 3
log1000 = ?
e = 2.72
;
data num_fun3;
l101 = log10(1000);
l102 = log10(10);
l103 = log10(1);
l1 = log(1000);
l2 = log(2.72);
l3 = log(1);
run;
proc print data = num_fun3;
run;

/*mode - it is used to return the remainder value;*/

data num_fun4;
m1 = mod(10,2);
m2 = mod(10,3);
m3 = mod(10,4);
m4 = mod(10.5,4);
m5 = mod(0,6);
run;
proc print data = num_fun4;
run;

fact - factorial 
5!=5*4*3*2*1 = 120;
0!=1
;
data num_fun5;
f1 = fact(10);
f2 = fact(5);
f3 = fact(1);
f4 = fact(0);
run;
proc print data = num_fun5;
run;
data new;
a = 100;
b = 200;
c = . ;
/*a1 = a + b + c; - this doesnt work if der is a missing value*/
a2 = sum(a,b,c);
run;
proc print;
run;
data new_1;
a = .;
b = .;
c = . ;
/*a1 = sum(0,a,b,c); - to return the sum value 0 if all the values are 0*/
a1 = sum(2,a,b,c);
run;
proc print;
run;
data math;
input x @@;
Absolute = abs(x);
Square = sqrt(x);
Exponent = exp(x);
Natural = log(x);
datalines;
2 -2 10 100
;
proc print;
run;
data look_back;
input Time Temperature;
Prev_temp = lag(Temperature);
Two_back = lag2(Temperature);
Three_back = lag3(Temperature);
datalines;
1 60
2 62
3 65
4 70
;
proc print;
run;
data laggard;
input x @@;
if X ge 5 then Last_x = lag2(x);
datalines;
9 8 7 1 2 12
;
proc print;
run;
data diff;
input Time Temperature;
Diff_temp = dif(Temperature);
datalines;
1 60
2 62
3 65
4 70
;
proc print;
run;
*The CONSTANT function returns values of commonly used mathematical constants such
as pi and e.
Note:To compute the largest integer stored in n bytes, you provide a second argument
indicating the number of bytes;
data constance;
Pi = constant('pi');
e = constant('e');
Integer3 = constant('exactint',3);
Integer4 = constant('exactint',4);
Integer5 = constant('exactint',5);
Integer6 = constant('exactint',6);
Integer7 = constant('exactint',7);
Integer8 = constant('exactint',8);
run;
proc print;
run;
data new;
set sashelp.class;
if ranuni(2345123)le .4;
run;
proc print;
run;
proc surveyselect data=sashelp.class
				  out=subset
				  method=srs
				  sampsize=10;
run;

