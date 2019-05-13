Meaning 

Infile - it specifies the location or path of the file.

Informats - it tells SAS how to read the data.

Formats - it tells SAS how to display the data. It displays as per users choice.

input styles - list input method and column input method (range method and width method) and formatted input method.

/*+n - tells the SAS to skip 'n' no. of columns*/

/*@n - tells the SAS to start reading data from the nth column*/

/*reading multiple observation from single line*/
 /*we want sas to read multiple obsevation from a single line 
 /*- DOuble Trailing (@@) also known as 'line holdin specifier*/

/*'/' - it tells SAS to jump to the next line*/

/*'#n'- it tells SAS to go nth line*/

/*':' it tells SAS to stop reading data whenever it encounters single space*/

/*'&' it tells SAS to stop reading data whenever it encounters multiple space*/

/*single trailing is used to read the data on certain conditions 
and it refers to single line whereas double trailing is used to 
read multiple observations from a single line*/

/*character pointer - @'symbol'*/

Input styles :
1. List method
2. Column method - range method and width method
+n and @n
3. Formatted method - comma,dollar,percent,date
Reading missing values using column method
Assignment statement
@@ and @
/ and #
: and &
;

/*input styles 
list method*/;
data one;
infile cards;
input name$ sex$ age;
cards;
athiq m 24
raj m 23
prem m 24
;
run;
proc print data = one;
run;
/*range method*/
data two;
infile cards;
input company $1-3 rank 4 city $5-7;
cards;
tcs4mum
hcl2chn
csc3blr
;
run;
proc print data =two;
run;
data four;
infile cards;
input player $1-6 age 10-11 score 15-16;
cards;
sachin   37   16
sehwag   34   22
virat    23   45
;
run;
proc print data =four;
run;

/*width method*/
data three;
infile cards;
input company $3. rank 1. city $3.;
cards;
tcs4mum
hcl2chn
csc3blr
;
run;
proc print data =three;
run;

/*+n - tells the SAS to skip 'n' no. of columns*/
data five;
infile cards;
input player $6. +3 age 2. +3 score 2.;
cards;
sachin   37   16
sehwag   34   22
virat    23   45
;
run;
proc print data =five;
run;
data one_1;
input name$ sal comma6. +1 sal_1 dollar7.2 +1 growth comma3.;
cards;
aaa 12,344 $235.12 13%
bbb 63,222 $467.65 23%
;
run;
proc print;
format sal comma6. sal_1 dollar7.2 growth comma3.;
run;

/*@n - tells the SAS to start reading data from the nth column*/
data six;
infile cards;
input player $6. @10 age 2. @15 score 2.;
cards;
sachin   37   16
sehwag   34   22
virat    23   45
;
run;
proc print data =six;
run;
data one;
input name$ @5 score 7;
cards;
aaa 123445
bbb 634676
;
run;
proc print;
run;
proc contents data = one;
run;
*If you are specifying a range of character variables, 
both the variable list and the $ sign must be enclosed in parentheses;
data one;
input name$ (score1 - score3) ($);
cards;
aaa 12 23 34
bbb 44 44 55
;
run;
proc print;
run;

/*missing values using width method*/
data seven;
infile cards;
input player $6. @10 city $9. @20 score 2.;
cards;
sachin   mumbai    37
sehwag   chennai    
virat    bangalore 23   
         hyderabad 28
;
run;
proc print data =seven;
run;
/*missing values using range method*/
data eight;
infile cards;
input player $ 1-6 city $10-19 score 20-22;
cards;
sachin   mumbai    37
sehwag   chennai    
virat    bangalore 23   
         hyderabad 28
;
run;
proc print data =eight;
run;
data nine;
infile cards;
input name $  unitsold comma5.  revenue dollar7. ;
cards;
philip 2,125 $37,000
mary 3,211 $51,000
janet 4,217 $67,000
;
run; 
proc print data = nine;
run;
data nine;
infile cards;
input name$  unitsold comma5.+1  revenue dollar7.+1 ;
cards;
philip 2,125 $37,000
mary 3,211 $51,000
janet 4,217 $67,000
;
run; 
proc print data = nine;
run;
/*formatted style */
proc print data = nine;
format unitsold comma5.
       revenue comma7.;
run; 
data ten;
infile cards;
input year $1-4  @10 growthrate percent3. @15 revenue comma6.;
cards;
1994     0.7% 34,127
1995     1.3% 52,162
1996     1.6% 25,343
;
run; 
proc print data = ten;
format  growthrate percent6.
        revenue dollar6.;
run; 
/*date format*/
data eleven;
infile cards;
input  name$ dob:date7. doj ddmmyy8.;
cards;
david 26oct82 15/04/10
amelia 17sep82 07/02/12
rajmohan 04jan85 08/2/8
;
run;
proc print data = eleven;
format dob date7. doj ddmmyy8.;
run;
data twelve;
infile cards;
input  name$  dob date9.+1 doj ddmmyy8.;
cards;
david 26 oct 82 15/04/11
amelia 17 sep 82 07/02/12
rajmohan 04 jan 85 08/2/8
;
run;
proc print data = twelve;
format dob date7. doj ddmmyy8.;
run;
/*Assignment*/
data one;
infile cards;
input @6 name$ @12 team$ @18 strtwt @22 endwt @1 id;
cards;
1046 david red   186 175
1045 raju  yelow 185 165
1054 prem  red   195 185
;
run;
proc print data= one;
run;
data two;
infile cards;
input ID @12 Team$ @6 name$  @22 endwt ;
cards;
1046 david red   186 175
1045 raju  yelow 185 165
1054 prem  red   195 185
;
run;
proc print data= two;
run;
data three;
infile cards;
input @12 team$  @6 name$ @22 endwt @18 strtwt  ;
cards;
1046 david red   186 175
1045 raju  yelow 185 165
1054 prem  red   195 185
;
run;
proc print data= three;
run;
data four;
infile cards;
input stock$ 1-4 purchasing_date date7. purchasing_price 12-15 qty 17-19 selling_date date7. selling_price 28-31;
cards;
tcs 13nov102100 10012dec10 2300
infy17nov102900 15011dec11 2200
hdfc24nov102800 20024dec12 2400
;
run;
proc print data = four;
format purchasing_date selling_date date7.;
run;
proc contents data = four;
run;
data five;
infile cards;
input stock$4. purchasing_date date7. @12 purchasing_price @17 qty 3.
@20 selling_date:date7. selling_price ;
cards;
tcs 13nov102100 10012dec10 2333
infy17nov102900 15011dec11 2200
hdfc24nov102800 20024dec12 2400
;
run;
proc print data = five;
format purchasing_date selling_date date7.;
run;
data one;
input id$ 1-3 dob$ 4-13 sex$ 14 revenue 16-21;
cards;
00110/21/1955M 1145
00211/18/2001F 18722
00305/07/1944M 123.45
00407/25/1945F -12345
run;
title 'dob = character variable';
proc print;
run;
proc contents data = one;
run;
data portfolio;
input symbol$ price number_of_shares;
value = price*number_of_shares;
cards;
AMGN 67.66 100
DELL 24.60 200
GE 34.50 100
HPQ 32.32 120
IBM 82.25 50
MOT 30.24 100
;
run;
proc print;
run;
proc means data = portfolio mean maxdec =2;
var price number_of_shares;
run;
data question_1;
input sex$ 1. score1-score4;
average = mean(of score1 - score4);
summation = sum(of score1 - score4);
minimum = min(of score1 - score4);
maximum = max(of score1 - score4);
cards;
M 80 82 85 88
F 94 92 88 96
M 96 88 89 92
F 95 . 92 92
run;
proc print;
run;
proc contents data = question_1;
run;
data question_5;
input x y;
z=100 + 50*x + 2*x**2-25*Y + y**2;
cards;
1 2
3 6
5 9
3 11
;
run;
proc print;
run;
data question_6;
input name$ 1-15 acct$ 16-20 balance 21-26 rate 27-30;
interest = balance * rate;
cards;
Philip Jones   V1234 4322 32
Nathan Philips V1399 1520 245
Shu Lu 		   W8892 45123345
Betty Boop     V7677 5000 278
run;
proc print;
run;
data question_7;
input name$ 1-20 longdeg 21-22 longmin 23-28 latdeg 29-30 latmin 31-36;
cards;
Higgensville Hike   4030.2937446.539
Really Roaring      4027.4047442.147
Cushetunk Climb     4037.0247448.014
Uplands Trek        4030.9907452.794
run;
proc print;
run;
data question_8;
input name$ &14. @17 acct$  balance  rate ;
interest = balance * rate;
cards;
Philip Jones    V1234 4322  32
Nathan Philips  V1399 1520  245
Shu Lu 			W8892 45123 345
Betty Boop      V7677 5000  278
run;
proc print;
run;
data question_9;
input name$ &17.  @21 longdeg 8. @28 longmin 2. @30 latdeg 6. @36 latmin ;
cards;
Higgensville Hike   4030.2937446.5311 1
Really Roaring      4027.4047442.1471
Cushetunk Climb     4037.0247448.0141
Uplands Trek        4030.9907452.7941
run;
proc print;
run;
data question_10;
input stock$ 4. @5 purdate mmddyy10. @15 purprice:dollar5.1 number:3.
selldate:mmddyy10. sellprice dollar5.1;
totalpur=number*purprice;
totalsell=number*sellprice;
profit = totalsell-totalpur;
cards;
IBM 5/21/2006 $80.0 100 07/20/2006 $88.5
CSCO04/05/2005$17.5 200 09/21/2005 $23.6
MOT 03/01/2004$14.7 500 10/10/2006 $19.9
XMSR04/15/2006$28.4 200 04/15/2007 $12.7
BBY 02/15/2005$45.2 100 09/09/2006 $56.8
;
run;
proc print;
format purdate date9. purprice dollar5.1 selldate date9. sellprice dollar5.1; 
sum profit;
run;
proc contents data =question_10;
run;
data question_11;

data short;
input x;
datalines;
1
2
3
;
data long;
input x;
datalines;
4
5
6
7
;
data new;
set short;
output;
set long;
output;
run;
proc print;
run;
/*ssn11. - is a format which adds dashes...*/
data division1;
input SS  DOB mmddyy10. Gender $;
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
input SS $ 11.  JobCode $ Salary;
/*input ss comma11.*/ 
cards;
111-22-3333 A10 45123
123-45-6789 B5 35400
987-65-4321 A20 87900
run;
proc print;
run;
data Monday2002;
input date ddmmyy6. year;
cards;
010410 12
050415 13
run;
proc print;
format date date9.;
run;

/*assignment statement*/
data six;
infile cards;
input stock$4.  @5 purchasing_date date7. @12 purchasing_price @17 qty 3.
@20 selling_date date7. @28 selling_price ;
profit_loss = (selling_price -purchasing_price)*qty;
cards;
tcs 13nov102100 10012dec10 2300
infy17nov102900 15011dec11 2200
hdfc24nov102800 20024dec12 2400
;
run;
proc print data = six;
format purchasing_date selling_date date7.;
sum profit_loss;
run;
data prob2;
input ID $
Height /* in inches */
Weight /* in pounds */
SBP /* systolic BP */
DBP /* diastolic BP */;
wtkg = 2.2;
htcm = 2.54;
avebp = dbp + (1/3*(sbp-dbp));
HtPolynomial=2*htcm+1.5*htcm**3;
datalines;
001 68 150 110 70
002 73 240 150 90
003 62 101 120 80
;
title "Listing of PROB2";
proc print data=prob2;
run;
/*reading complex data*/
/*reading multiple observation from single line*/
/*we want sas to read multiple obsevation from a single line 
/*- DOuble Trailing (@@) also known as 'line holdin specifier*/

data seven;
infile cards;
input name$ age score @@;
cards;
aa 23 34 bb 45 34
cc 42 25
;
run;
proc print data = seven;
run;
question_2;
data monthsales;
input month sales @@;
sumsales+sales;
datalines;
1 4000 2 5000 3 . 4 5500 5 5000 6 6000 7 6500 8 4500
9 5100 10 5700 11 6500 12 7500
;
proc print;
run;

data account;
input id $ income @@;
cards;
001 45000 47000 47500 48000 48000 52000 53000 55000
002 67130 68000 72000 70000 65000 52000 49000 40100
run;
proc print;
run;


/*reading single observation from multiple line*/
data eight;
infile cards;
input name$ sex$ team$ strtwt endwt;
cards;
aa m
red
145 158
bb f 
yellow
245 221
cc m 
green
212 195
;
run;
proc print data = eight;
run;
/*multiple inputs for multiple lines*/
data eight1;
infile cards;
input name$;
input team$;
input @5 endwt ;
cards;
aa m
red
145 158
bb f 
yellow
245 221
cc m 
green
212 195
;
run;
proc print data = eight1;
run;
/*'/' - it tells SAS to jump to the next line*/
data eight2;
infile cards;
input name$ /team$/startwt;
cards;
aa m
red
145 158
bb f 
yellow
245 221
cc m 
green
212 195
;
run;
proc print data = eight2;
run;
/*'#n'- it tells SAS to go nth line*/
data eight3;
infile cards;
input #2 team$ #1 name$ #3 startwt;
cards;
aa m
red
145 158
bb f 
yellow
245 221
cc m 
green
212 195
;
run;
proc print data = eight3;
run;
data eight4;
infile cards;
input name$ / team$/;
cards;
aa m
red
145 158
bb f 
yellow
245 221
cc m 
green
212 195
;
run;
proc print data = eight4;
run;
/*':' it tells SAS to stop reading data whenever 
it encounters a space*/
data nine;
infile cards;
input name$:9. age sex$;
cards;
davidshaw 28 m
ravikr 29 m
monalisa 30 f
;
run;
proc print data = nine;
run;
data one;
input NAME$ 3. AGE sex$ 1. rank;
cards;
aaa 22 f 1
bbb 33 m 2
;
run;
proc print;
run;
proc contents data = one;
run;
proc contents data = one varnum;
run;
*Note: The list is in alphabetical order because all the variable names are in lowercase. If
you also have uppercase variable names, they will be grouped first in the list,
followed by any lowercase names;

question_1;
/*Chk out the dob in 7/4/1983 and 7/04/1983 in cards*/
libname learn 'C:\Documents and Settings\Athik\Desktop\SAS Certification Prep Guide';
/*data learn.perm*/
data perm ;
input ID$ Gender$ DOB:mmddyy10. Height Weight;
label DOB = 'Date of Birth'
Height = 'Height in inches'
Weight = 'Weight in pounds';
format DOB date9.;
datalines;
011 M 10/21/1946 68 150
002 F 5/26/1950 63 122
003 M 5/11/1981 72 175
004 M 7/4/1983 70 128
005 F 12/25/2005 30 40
;
proc print;
run;
proc contents data = learn.perm;
run;
/*chk out the diff of  learn.perm by using proc print and viewtable window*/

/*'&' it tells SAS to stop reading data whenever it encounters multiple space*/
data nine1;
infile cards;
input name$&15. age sex$;
cards;
mr. david shaw  28 m
mr. ravi kr  28 m
ms. monalisa  26 f 
;
run;
proc print data = nine1;
run;


/*Assignment 1*/

data assignment;
infile cards;
input Id $3. @5 name$ 5-18 /dept$ doj mmddyy10./ salary dollar7.;
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
proc print data = assignment;
format doj mmddyy10. salary dollar7.;
run;

/*single trailing - @ - It tells SAS to hold the 
data for single iteration*/
/*single trailing is used to read the data on certain conditions 
and it refers to single line whereas double trailing is used to 
read multiple observations from a single line*/
;
data ten;
infile cards;
input @13 team$ @;
if team = 'red';
/*if team = 'red' then;*/
input @1 id @6 name$ @20 startwt @24 endwt;
cards;
1046 david  red    186 146
1027 amelia yellow 137 121
1021 ravi   red    156 127
1033 philip yellow 177 159 
;
run;
proc print data = ten;
run;
/*character pointer - @'symbol'*/
data eleven;
infile cards;
input @'{' india $:31.;
cards;
http:{www.sas.com an official webseite}
wap.http:{www.study.sas.co.in for FAQ}
mob.wap.http:{www.m.google.com for mobile users}
;
run;
proc print data = eleven;
run;
data eleven1;
infile cards;
input @'+' india$ &42.;
cards;
http:{www.sas.com +an official webseite  }
wap.http:{www.study.sas.co.in +for FAQ  }
mob.wap.http:{www.m.google.com +for mobile users  }
;
run;
proc print data = eleven1;
run;

data alpha;
input name$ age sex;
cards;
aaa 22 m
bbb 33 f
run;
proc print;
run;
data beta;
input name$ age;
cards;
ccc 22
ddd 33
run;
proc print;
run;
filename data1 'C:\Documents and Settings\Athik\Desktop\Athiq\SAS\Datasets\data1.txt';
filename data2 'C:\Documents and Settings\Athik\Desktop\Athiq\SAS\Datasets\data2.txt';
data combined;
if last=0 then infile data1 end = last;
else infile data2;
input name$ age;
run;
proc print data = combined;
run;
filename both 
( 'C:\Documents and Settings\Athik\Desktop\Athiq\SAS\Datasets\data1.txt'
 'C:\Documents and Settings\Athik\Desktop\Athiq\SAS\Datasets\data2.txt');
data both;
infile both;
input name$;
run;
proc print;
run;
data new;
input name$ age sex $ year;
cards;
aaa 11 m 1991
bbb 12 m 1992
ccc 13 f 1993
ddd 14 m 1994
run;
proc print;
run;
filename data3 'C:\Documents and Settings\Athik\Desktop\Athiq\SAS\Datasets\data3.txt';
data new_one3;
infile data3;
input @10 year @;
/*if year = 1991 then ;*/
/*input @1 name$ @5 age;*/
if year = 1991 then delete;
input @1 name$ @5 age;
else if year = 1992 then;
input @5 age @8 sex$;
else 
input @1 name$ @5 age @8 sex$;
run;
proc print;
run;
