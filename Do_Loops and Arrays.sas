data missing_assignment;
input x;
if missing(x) then do ;
					miss_value = 'yes';
					misscount=1;
					end;
else miss_value = 'no';
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
proc print;
sum misscount;
run;

data batting;
infile 'D:\Athiq\Datasets\batting.txt';
input batting $ & 15. @ 10 description $ & 48. @ 25 R 
@ 27 B @ 29 _4s @ 32 _6s @ 35 S/R;
run;
proc print;
run;

Output = it is an instruction for SAS to write out an observation
			to the output data set. An output usually occurs
			automatically at the bottom of data set ie when
			SAS finds run.But if you are using output stt. 
			anywhere in data set SAS does not execute an automatic
			ouput

Put - It gives instruction for SAS to write an observation to 
		log window;
*do loops 
General
incremental do loop + if conditions
dicremental do loop + if conditions
range
specifications
combined - range and specifications
nested do loops
dim
leave and continue
do while and do until
conditional statements
along with point statement
;

		/*INCREMENTAL DO - LOOP*/

data do_ex;
name = '        ';
a = 0;
do i = 1 to 10;
a = a +10;
if a > 75 then name = 'athiq';
else name = 'zero';
output;
end;
run;
proc print;
sum a i;
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
/*chk out*/
data one;
do i = 1 to 30;
i = i*i;
output;
end;
run;
proc print;
run;
data do_ex2;
do n = 1 to 50;
square =n*n;
square_root = sqrt(n);
output;
end;
run;
proc print;
run;
/*chk out - by 2 changes the values of 'i' and not a*/
data do_ex1;
a = 0;
do i = 1 to 10 by 2;
a = a +10;
output;
end;
run;
proc print;
run;
/*chk out - even in decremental loop the value of 'i' changes and not of a*/
data do_ex1;
a = 0;
do i = 10 to 1 by -2;
a = a +10;
output;
end;
run;
proc print;
run;

data do_ex3;
do n = 1 to 50 BY 2;
square =n*n;
square_root = sqrt(n);
output;
end;
run;
proc print;
run;

		/*DECREMENTAL DO - LOOP*/

data do_ex4;
do n = 49 to 1 BY -2;
square =n*n;
square_root = sqrt(n);
output;
end;
run;
proc print;
run;
question_5;
data one;
do n = 1 to 20;
LogN = log(n);
output;
end;
run;
proc print;
run;
question_6;
data one;
do n = 5 to 100 by 5;
LogN = log(n);
output;
end;
run;
proc print;
run;
question_7;
data new;
do x = 0 to 10 by 0.1;
y = 3*x**2-5*x + 10;
output;
end;
run;
proc print;
run;
question_9;
data temperatures;
do day = 'mon','tue','wed','thu','fri','sat','sun';
do temp = 70,72,74,76,77,78,85;
output;
end;
end;
run;
proc print;
run;
question_10;
data new_12;
do speed = 'A','B','C';
do subjects = 1 to 10 ;
input results @@;
/*input results @;*/
output;
end;
end;
cards;
250 255 256 300 244 268 301 322 256 333
267 275 256 320 250 340 345 290 280 300
350 350 340 290 377 401 380 310 299 399
;
proc print;
run;
question_11;
data new_13;
length city $ 7;
do city = 'Dallas','Houston';
do hour = 1 to 24;
input temp @;
output;
end;
end;
cards;
80 81 82 83 84 84 87 88 89 89
91 93 93 95 96 97 99 95 92 90 88
86 84 80 78 76 77 78
80 81 82 82 86
88 90 92 92 93 96 94 92 90
88 84 82 78 76 74
;
proc print;
run;

data new;
set sashelp.class;
rate = 0;
do i = 1 to 5;
rate = height+weight*5;
output;
end;
run;
proc print;
run;
data new;
do i = 1 to 10;
i = i*i; *chk out;
i_root = sqrt(i);
output;
end;
run;
proc print;
run;
data new_1;
do i = 1,2,5,10; * separated by commas;
n = i*i;
i_root = sqrt(n);
output;
end;
run;
proc print;
run;
data new_2;
do i = 'jan','feb','mar'; * the values of months are jan,feb..;
months = 2000;
months = months *2;
output;
end;
run;
proc print;
run;
data new_3;
/*do n = 1,3, 5 to 9 by 2, 100 to 200 by 50;*/
output;
end;
run;
proc print;
run;
data easyway;
do Group = 'Placebo','Active';
do Subj = 1 to 5;
/*chk with giving same nested do name as input variable name*/
input Score @;
output;
end;
end;
datalines;
250 222 230 210 199
166 183 123 129 234
;
proc print;
run;

/*Chk out w/wo year+1 as well as output*/
*As soon i exceeds the stop value it increases by 1 and then stops if no output statement
is mentioned. year +1 adds a +1 to the end value;
i by(by 2) year(year+2) outcome
1 	+2 			.		= 3
3 	+2			+2		= 7
5 	+2			+2		= 9
7 	+2			+2		= 
9 	+2			+2		= 	;
data work.earn ;
       Value=2000;
       do i=1 to 20 by 2;
/*	   do year=1 to 20;*/
            Interest=value*.075; 
            value+interest; 
/*            Year+3; */
			year+2;
			output;
       end;
proc print;
run;
data work.earn; 
    Capital=2000;
do year = 1 to 5;
capital +2000;
	   do month=1 to 12;
       Interest=capital*(.075/12);
       capital+interest;
	   output;
       end;
	end;
run; 
proc print;
run;
data work.earn_1; 
    Capital=2000;
	   do month=1 to 12;
       Interest=capital*(.075/12);
       capital+interest;
	   output;
       end;
run; 
proc print;
run;
data do_ex5;
Int =0.04;
Amount = 1000;
do year = 1 to 5;
amount = amount + amount*int;
output;
end;
run;
proc print data = do_ex5;
run;
data rates;
input Institution$ &17. 	Rate	Years;
cards;
MBNA America	0.0817	5
Metropolitan Bank	0.0814	3
Standard Pacific	0.0806	4
;
run;
proc print;
run;
*Notice that the data set variable Years is used as the stop value in the iterative DO statement.
As a result, the DO loop executes the number of times that are specified by the current value 
of Years;
data new;
set rates;
investment = 5000;
do i = 1 to years;
investment+rate*investment;
output;
end;
run;
proc print;
run;
/*chk out the value of year @ different instances*/
data a1;
amount = 2000;
int = 0.05;
do while ( amount le 3000);
amount = amount + amount * int;
year+1;
output;
/*year+1;*/
end;
run;
proc print;
run;
data a1;
amount = 4000; 
/*chk wat if the amt is greater than the value specified in the do until*/
int = 0.05;
do until ( amount ge 3000);
amount = amount + amount * int;
output;
end;
run;
proc print;
run;
data leave_it;
Interest = .0375;
Total = 100;
do Year = 1 to 100;
Total = Total + Interest*Total;
output;
if Total ge 200 then leave;
end;
format Total dollar10.2;
run;
proc print;
run;
data continue_on;
Interest = .0375;
Total = 100;
do Year = 1 to 100 until (Total ge 200);
Total = Total + Interest*Total;
if Total le 150 then continue;
output;
end;
format Total dollar10.2;
run;
proc print;
run;

*The stop option is not specified since do until is used so the number of years remains the
same even if the output statement is removed or added except the details part;
data work.invest; 
   do until(Capital>=50000);
      capital+2000; 
      capital+capital*.10; 
      Year+1; 
	  output;
   end;
run; 
proc print;
run;
/*Using Conditional Clauses with the Iterative DO Statement */
data work.invest; 
   do until(Capital>=50000);     
      capital+2000;
      capital+capital*.10;
	  Year+1;
	  output;
   end; 
run; 
proc print;
run;
*This iterative DO statement enables you to execute the DO loop until Capital is greater than 
or equal to 50000 or until the DO loop executes 10 times, whichever occurs first;
data work.invest(drop=i); 
  do i=1 to 10 until(Capital>=50000); 
     Year+1;
     capital+2000;
     capital+capital*.10;
	 output;
  end; 
run; 
proc print;
run;
/*Increase the amount to 4000*/
data work.invest(drop=i); 
   do i=1 to 10 until(Capital>=50000); 
      Year+1;
      capital+4000;
      capital+capital*.10;
	  output;
   end; 
run; 
proc print;
run;
*If the OUTPUT statement were placed after the DO loop, only the last observation would be 
written;
data work.subset; 
   do sample=1 to 10 by 2; 
      set sashelp.class point=sample;
      output;
   end; 
   stop;
run; 
proc print;
run;
proc print data = sashelp.class;
run;
data work.invest; 
   do year=1990 to 2004; 
      Capital+5000; 
      capital+(capital*.10); 
      output; 
   end; 
run;
proc print ;
run;
data one_12;
amount = 1000;
int = 0.425;
do while (amount < 30000);
year +1;
do quarter = 1 to 4;
/*year + 1;*/
amount = amount + amount * int/4 ;
/*year + 1;*/
output;
end;
end;
run;
proc print;
run;
data do_ex6;
Int =0.04;
Amount = 1000;
do until (amount ge 2000);
year+1;
amount = amount + amount*int;
output;
end;
run;
proc print data = do_ex6;
run;
 do until -it checks at the bottom of the loop
        	false - go inside the loop;
			true - terminate the loop;
do while - it checks at the top of the loop
        	true - go inside the loop;
			false - terminate the loop;
;
data do_ex7;
Int =0.04;
Amount = 1000;
do while (amount le 2000);
year+1;
amount = amount + amount*int;
output;
end;
run;
proc print data = do_ex7;
run;

data do_ex8;
Int =0.04;
Amount = 1000;
do i = 1 to 100 until (amount ge 2000);
year+1;
amount = amount + amount*int;
output;
end;
run;
proc print data = do_ex8;
run;

write a sas code to find the no. of years for fixed deposit
of amt 50,000 at a rate of int 8.5 % if tax slab is of 2,00,000

	/*nested do - loops*/
;
data do_ex9;
Int = 0.04;
A = 1000;
do year = 1 to 5;
do i = 1 to 2;
A = A + A*Int/2;
output;
end;
end;
run;
proc print data = do_ex9;
run;
/*Assignment*/
Q) 4,00,000 r =12%  emi = ? n =5
;
data do_ex10;
do salesman = 1 to 3;
do year = 1 to 3;
input revenue @@; 
output;
end;
end;
cards;
10 11 13 11 14 12 10 15 16
;
run;
proc print data = do_ex10;
run;
question_12;
data one_11;
amount = 1000;
int = 0.425;
do while (amount < 30000);
year + 1;
amount = amount + amount * int;
output;
end;
run;
proc print;
run;
question_13;
data one_12;
amount = 1000;
int = 0.425;
do while (amount < 30000);
year +1;
do quarter = 1 to 4;
amount = amount + amount * int/4 ;
output;
end;
end;
run;
proc print;
run;
question_14;
data neww;
do n = 1 to 100;
square = n*n;
squr = sqrt(square);
if squr gt 100 then leave;
output;
end;
run;
proc print;
run;

					/*Arrays*/

Its a collection of similar type of variables.
They are stored in certain order.
It helps identify only the columns n nt the rows.
In the o/p string the values of the variables are found n n
nt abt arrays.
	syntax -
array name(size) var1 var2 var3....n; = numeric array
array name(size) $ var1 var2 var3....n; = character array
;
*Array 
General
dim function
array + do loops
array + do loops + dim
nested array + do loop
defining a new variable( 3 arrays) + do loop
Temporary assigning values;

data do_ex11;
set sashelp.class;
array employee(4) age height weight sum_ht_wt;
employee (4) = employee(2)+employee(3);
run;
proc print;
run;

one hyphen for certain series or in cerain order
two hyphen in case we dnt no abt series and to execute as per
	the order in the dataset;

dataset 1 = age height weight marks salary dob
array one(*) height -- salary
array one1(*) salary height weight marks
dataset 2 = s1 s2 s3 s4 s5 s6 s7 s8s s9 s10
array two(*) s2 - s10
;
data array_ex;
set sashelp.class;
array diff(*) diffc1 - diffc3;
diff (2) = height - age;
diff (3) = weight - age;
diff (1) = age;
run;
proc print;
run;

data array_ex1;
array total(*) t1 - t7;
size = dim(total);
do i = 1 to dim(total);
total(i) = 10+ i;
output;
end;
run;
proc print;
run;

data array_ex2;
set sashelp.class;
array personal(2)$ name sex;
sex_name = personal(2) || personal(1);
run;
proc print;
run;
data one;
set sashelp.class;
array rate{4} height weight age new;
rate{4} = height+weight+age;
run;
proc print;
run;
data fitclass;
input Name$	Weight1	Weight2	Weight3	Weight4	Weight5	Weight6;
cards;
Alicia	69.6	68.9	68.8	67.4	66.0	66.2
Betsy	52.6	52.6	51.7	50.4	49.8	49.1
Brenda	68.6	67.6	67.0	66.4	65.8	65.2
Carl	67.6	66.6	66.0	65.4	64.8	64.2
Carmela	63.6	62.5	61.9	61.4	60.8	58.2
David	70.6	69.8	69.2	68.4	67.8	67.0
run;
proc print;
run;

data new;
set sashelp.class;
array measure(4) 3 age height weight rate1;
measure(4) = measure(1)+measure(2)+measure(3);
rate1 = age + height + weight;
run;
proc print;
run;
proc contents data = new;
run;
data new (drop = i weight1-weight6);
set fitclass;
array wt(6) weight1 - weight6;
array new_wt(4) _temporary_ ( 1 ,2, 3, 4);
array total_wt(4);
do i = 1 to 4;
total_wt(i) = new_wt(i)*wt(i);
/*output;*/
end;
run;
proc print;
run;

/*It multiples everything and the result will overlap on the existing variables*/
data one;
set fitclass;
array new(6) weight1 - weight6;
do i = 1 to 6;
new(i) = new(i) * 2;
/*output;*/
end;
run;
proc print;
run;
/*It creates the new variable and does not affect the existing variables*/
data one;
set fitclass;
array new(6) weight1 - weight6;
array new_one(4);
do i = 1 to dim(new_one);
new_one(i) = new(i) * 2;
/*output;*/
end;
run;
proc print;
run;
/*It multiples the variales with the variables we specified*/
data one;
set fitclass;
array new(6) weight1 - weight6;
array new_one(4) _temporary_ (1 2 3 4 );
array totally_new(4);
do i = 1 to 4;
totally_new(i) = new(i)*new_one(i);
/*output;*/
end;
run;
proc print;
run;

data convert; 
   set fitclass; 
   array wt{6} weight1-weight6; 
   do i=1 to 6;
      wt{i}=wt{i}*2.2046;
	  if wt{i} < 135  then status = 'AAA';
	  else status= 'BBB';
/*	  output;*/
   end;
run; 
proc print;
run;
*Dim function - When you use the DIM function, you do not have to re-specify the stop value 
of an iterative DO statement if you change the dimension of the array;
data convert; 
   set fitclass; 
   array wt{6} weight1-weight6; 
   do i=1 to dim(wt);
      wt{i}=wt{i}*2.2046;
/*	  output*/
   end;
run; 
proc print;
run;
/*Creating Variables in an ARRAY Statement */
data diff; 
   set convert; 
   array wt{6} weight1-weight6; 
/*Chk by assigning more or less number in wgtdiff compared to wt*/
array WgtDiff{5}; 
   do i=1 to 5;
      wgtdiff{i}=wt{i+1}-wt{i};
   end;
run; 
proc print;
run;
/*Assigning Initial values*/
data diff; 
   set convert; 
   array wt{6} weight1-weight6; 
   array WgtDiff{6} (100 200 300 400 500 600); 
   array calculated(6);
   do i=1 to 6;
      calculated(i) = wgtdiff(i) + wt(i) /2;
   end;
run; 
proc print;
run;
/*creating Temporary Array elements*/
data diff; 
   set convert; 
   array wt{6} weight1-weight6; 
   array WgtDiff{6} _Temporary_ (100 200 300 400 500 600); 
   array calculated(6);
   do i=1 to 6;
      calculated(i) = wgtdiff(i) + wt(i) /2;
   end;
run; 
proc print;
run;
/*chk out the example for multidimensional array and rotate in the book*/
data new;
set sashelp.class;
array new_var{3} height weight age;
/*This list of variables must be all numeric or all character—you cannot mix them.*/
/*array mychars{20} $ 2 Q1-Q20;*/
do i = 1 to 3;
new_var{i} = (height + weight + age )*i;
output;
end;
run;
proc print;
run;
data new_11;
set sashelp.class;
array new_1 {1} $ sex;
/*array new_1{*}*/
do i = 1 to dim(new_1);
if new_1(i) = 'F' then aaa = 'A';
else aaa = 'B';
output;
end;
run;
proc print;
run;
data new;
set sashelp.class;
array new_age {1} age;
do i = 1 to dim(new_age);
if new_age(i) <14 then aaa = 'A';
else aaa = 'B';
output;
end;
run;
proc print;
run;
data new_123;
set sashelp.class;
array new_1 {3} age height weight;
do i = 1 to dim(new_1);
if new_1(i) < 55 then NEW_ONE = age + height +weight;
else NEW_ONE = age;
output;
end;
run;
proc print;
run;
data new_12;
set sashelp.class;
array new_new {*} height weight age;
do i = 1 to dim(new_new);
if new_new(i) < 55 then New = 'A1';
else New = 'B1';
output;
end;
run;
proc print;
run;
data temp;
input Fahren1-Fahren24 @@;
array Fahren[24];
array Celsius[24] Celsius1-Celsius24;
do Hour = 1 to 24;
Celsius{Hour} = (Fahren{Hour} - 32)/1.8;
end;
/*drop Hour;*/
datalines;
35 37 40 42 44 48 55 59 62 62 64 66 68 70 72 75 75
72 66 55 53 52 50 45
;
run;
proc print;
run;
data one;
input name$;
/*a = propcase(name);*/
cards;
athiQ
AHMED
raJ
malHOTRa
;
run;
proc print;
run;
data one_1 (drop = i);
set one;
array new(*) $ name;
do i = 1 to dim(new);
new(i) = propcase(new(i));
end;
run;
proc print;
run;
data two;
input (east west north south central) ($);
cards;
7412 2312 9565 8088 7223
6217 3217 9495 6768 2327
;
run;
proc print;
run;
data two_1 (drop = i);
set two;
array new(*) $ east west north south central;
do i = 1 to dim(new);
new(i) = cat('1',new(i));
end;
run;
proc print;
run;
data score;
array ans{10} $ 1;
array key{10} $ 1 _temporary_
('A','B','C','D','E','E','D','C','B','A');
input ID (Ans1-Ans10)($1.);
RawScore = 0;
do Ques = 1 to 10;
RawScore + (key{Ques} eq Ans{Ques});
end;
Percent = 100*RawScore/10;
keep ID RawScore Percent;
datalines;
123 ABCDEDDDCA
126 ABCDEEDCBA
129 DBCBCEDDEB
;
proc print;
run;
