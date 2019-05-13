/*assignment1*/

data one;
a = 33;
b = 22;
c = 44;
d = 11;
e = 55;
m1 = max(of a - - e);
max = max(a,b,c,d,e);
min = min(a,b,c,d,e);
sum = sum(a,b,c,d,e);
larg = largest(2,of a - - e);
smal=smallest(2,a,b,c,d,e);
s1 = larg+smal;
run;
proc print data = one;
run;

/*assignment2*/
data two;
infile cards;
input subj$ @5 dob ddmmyy8. @14 gender$ @16 salary comma7. growth comma3.;
bonus = .05 * salary;
cards;
001 21/10/88 m $71,213 18%
002 15/08/87 f $51,213 18%
003 11/11/87 m $41,213 18%
004 17/06/89 f $22,213 18%
;
run;
proc print data = two;
format bonus salary comma7. dob date7. growth percent3.2;
run;

/*character functions*/

upcase(),lowcase(),propcase()
substr()(its length),scan()(200)
length(),lenghtc(),lenghtn() - numeric default(8)
Length statement
cat(),catx(),cats()	- 200 (whereas if we use || then its length is the total of a,b)
left(),right(),strip()
compress(),compbl()	- the length of the variable
translate()- the length of the variable, tranwrd() - 200 
index(),indexw(),indexc - numeric default(8)
find(),findw(),findc() - numeric default(8)
anyalpha,anydigit,anyalnum  - numeric default(8)
notalpha,notdigit,notalnum
verify
compare
spedis
;
data char_func;
a = 'BangALORE';
up = upcase(a);
low = lowcase(a);
prop = propcase(a);
run;
proc print data =  char_func;
run;
data char_func1;
set sashelp.class;
name1 = upcase(name);
name2 = lowcase(name);
su = sum(height,weight);
su1 = height+weight;
diff = su1-su;
run;
proc print data = char_func1;
run;

/*substr()  scan()*/
substring - it is used to return set of *characters* from a given string.
Length of the variable depends on the no of characters.
scan - it is used to return *word* from given positions in given sentence.
The default length of the variable for scan is 200.
syntax -substr = var_name = substr (string,position,no of characters)
		scan = var_name = scan (string,position)
;

data char_func2;
x = 'Bangalore';
s1 = substr(x,3,2);
s2 = substr(x,3,5);
s3 = substr(x,3);
s4 = substr(x,7);
run;
proc print data = char_func2;
run;
/*Chk out*/
data new_two;
a = 'bangalore';
/*a1 = substr(a,4,-2);*/
substr(a,1,2) = 'BA';
run;
proc print;
run;
data char_func3;
x = ' This is my first SAS program';
s1 = scan(x,3);
s2 = scan(x,5);
s3 = scan(x,-1);
s4 = scan(x,-5);
run;
proc print data = char_func3;
run;
data one;
a = 'this is bangalore city';
a1 = scan(a,1);
a2 = scan(a,-1);
run;
proc print;
run;
data one;
a = 'this is,bangalore, city';
a1 = scan(a,2,',');
a2 = scan(a,2,' ,');
run;
proc print;
run;
data last;
set original;
length LastName $ 15;
LastName = scan(Name,-1,' ');
run;
proc print;
run;
proc sort data=last;
by LastName;
run;
title "Alphabetical list of names";
proc print data=last noobs;
var Name;
run;

In SAS we have 3 types of blanks

------- SAS -------   Program-----
Leading     Embedded           Trailing 
Blanks 	    Blanks	           Blanks

length()  lenghtc()
length() -  It is used to return the no of characters excluding trailing
			blank.
lenghtc() - It is used to return the no of characters including trailing
			blank.

;
data char_func4;
x = '      SAS  Program     ';
l = length(x);
lc = lengthc(x);
run;
proc print data = char_func4;
run;
data char_func5;
set sashelp.class;
l = length(name);
lc = lengthc(name);
run;
proc print data = char_func5;
run;
data new;
a = '    bangalore     ';
b = ' ' ;
a1 = length(a);
a2 = lengthc(a);
a3 = lengthn(a);
b1 = length(b);
b2 = lengthc(b);
b3 = lengthn(b);
*This function is identical to LENGTH except it returns a length of 0 (instead of a 
length of 1) for a character missing value (also called a null string—hence the N at 
the end of the function name);
run;
proc print;
run;

In case of character variable when you are assigning any value its 
length become fixed only in case of character variable n nt numeric
variable;

data char_func6;
x = 'abc';
y = 123;
x = 'pqrabcdefghi';
y = 1234567;
run;
proc print data = char_func6;
run;

/*Length statement - it is used to assign or define the varible.*/

data char_func7;
length x $5;
x = 'abc';
y = '123';
x = 'pqrstbcdefghi';
y = '1234567';
run;
proc print data = char_func7;
run;

/*concatenate*/
/*cat(),catx(),cats()*/

cat() - it is used to concatenate two or more strings.
catx() - it is used to concatenate two or more strings with the 
		 help of separator.The first argument work as a separator.
cats() - it removes leading and trailing blanks and then join 
		 the strings.
;

data char_func8;
first = 'ron';
last = 'cody';
name = first||last;
name1 = cat(first,last);
run;
proc print data = char_func8;
run;

data char_func9;
first = ' ron ';
last = ' cody ';
name = catx('*',first,last,'sas','author');
name1 = cats('*',first,last,'sas','author');
name2 =cat('*',first,last,'sas','author');
run;
proc print data = char_func9;
run;

data char_func10;
first = ' ron ';
last = ' cody ';
name = catx(first,last,'sas','author');
name1 = cats(first,last,'sas','author');
run;
proc print data = char_func10;
run;

/*left(),right(),strip()*/

left() - it will align all leading blank to right most corner.
right() - it will align all trailing blank to left
			most corner.
strip() - it will remove the trailing and leading blank.
;
data char_func11;
name = ' sas ';
l = cat('*',left(name),'*');
r = cat('*',right(name),'*');
d = cat('*',trim(name),'*');
s = cat ('*',strip(name),'*');
run;
proc print data = char_func11;
run;
proc contents data = char_func11;
run;
data one;
a = '   Athiq    ';
a1 =cat('*',a,'*');
a2 =cat('*',trim(a),'*');
a3 =cat('*',right(a),'*');
run;
proc print;run;
data blanks;
String = '   ABC  ';
***There are 3 leading and 2 trailing blanks in String;
JoinLeft = ':' || left(String) || ':';
JoinTrim = ':' || trim(String) || ':';
JoinStrip = ':'	 || strip(String) || ':';
run;
proc print;
run;

/*assignment*/

 data assignment
 input name$;
 cards;
 Dhoni
 SEHWAG
 sachin
 VIRAT
 raina
 ;
 run;
*compress(),compbl()
compress - it is used to remove all blanks.
compbl - compblank is used to compress all blanks into single blank;

data char_func12;
x = 'my     sas       program     ';
a = compress(x);
b = compbl(x);
c = compress(x,'s');
/*d = compbl(x,'s');*/
run;
proc print data = char_func12;
run;

data char_func13;
x = '    my     sas       program     ';
c = compress(x);
cb = compbl(x);
c1 = compress(x,'sp');
run;
proc print data = char_func13;
run;
proc contents data = char_func13;
run;
/*chk out for compress option*/
*cat - It is almost the same as using the || operator, except that the length of the 
resulting string defaults to 200 if you do not define the length first;
data phone_old;
length phone$ 16;
input phone$ ;
cards;
(908)232-4851
210.343.4757
*516#343-9293
9342342345
run;
proc print;
run;
data phone(drop = phone);
length PhoneNumber $ 10;
set phone_old;
PhoneNumber = compress(Phone,'()-.#*');
run;
proc print;
run;
*Notice that if you want to use modifiers and you do not specify a second argument, you
need to use two commas together to indicate that the modifiers are the third argument;
data one;
string = 'bangalore1234';
a1 = compress(String,,'a');
a2 = compress(String,,'kd');
a3 = compress(String,'ang','i');
a4 = compress("A?B C99",,'pd');
run;
proc print;
run;
data one_11;
input weight$ height$;
cards;
100Kgs. 59in
180lbs 60inches
88kg 150cm.
50KGS 160CM
run;
proc print;
run;
data new;
set one_11;
a1 = compress(weight,,'kd');
a2 = compress(height,,'kd');
run;
proc print;
run;
data one;
a = 'bangalore123';
a1 = find(a,'12');
run;
proc print;
run;
data English;
set one_11(rename=(Weight = Char_Weight Height = Char_Height));
if find(Char_Weight,'lb','i') then
Weight = input(compress(Char_Weight,,'kd'),8.);
else if find(Char_Weight,'kg','i') then
Weight = 2.2*input(compress(Char_Weight,,'kd'),8.);
if find(Char_Height,'in','i') then
Height = input(compress(Char_Height,,'kd'),8.);
else if find(Char_Height,'cm','i') then
Height = input(compress(Char_Height,,'kd'),8.)/2.54;
drop Char_:;
run;
proc print;
run;

/*translate(), tranwrd()*/

translate - it is used to replace a specific character with a
			new set of character
tranwrd - it is used to replace the specific character with a 
		  new word
syntax - translate = var_name(string,to-string,from-string)
		 tranwrd = var_name(string,from-string,to-string)
;

data char_func14;
x = 'my    SAS  program';
tr = translate(x,'12','SA');
tw = tranwrd(x,'SAS','sql');
run;
proc print data = char_func14;
run;

/*index(),indexw(),indexc()*/
/*find(),findw(),findc()*/
index - it is used to return the position of first occurence of 
		given string as a part of word or separte word may be 	
		anything.
indexw - it is used to return the position of first occurence of 
		 given string as a separte word.
indexc - it is used to return the position of first occurence of
		 given string as a individual character.
;
data char_func15;
x = 'This is my first st sas class';
in = index(x,'st');
inw = indexw(x,'st');
inc = indexc(x,'st');
run;
proc print data = char_func15;
run;

data char_func16;
x = 'This is my first sas class';
fn = find(x,'ST','i');
/*fnw = findw(x,'st');*/
/*fnc = findc(x,'st');*/
run;
proc print data = char_func16;
run;
data new_three;
a = 'this is bangalore       ';
a1 = find(a,'BANGALOre','i');
run;
proc print;
run;
/*find(string, find-string, modifiers, starting-position)*/
data new;
a = find('there is the dog','the');
b = findw('there is the dog','the');
c = findc('there is the dog','the');
d = findw('pear:apple','apple',':');
e = findc('how are you','o');

a2 = index('there is the dog','the');
b2 = indexw('there is the dog','the');
c2 = indexc('there is the dog','the');
d2 = indexw('pear:apple','apple',':');
e2 = indexc('how are you','o');
run;
proc print;
run;
data new_1;
A = find('XYZCBA','ABC');
b = findw('XYZCBA','ABC');
c = findc('XYZCBA','ABC');
d = find('D','DEABC');
e = findc('D','ABCDE');
run;
proc print;
run;
data look_for_roger;
input String $15.;
if findw(String,'Roger') then Match = 'Yes';
else Match = 'No';
datalines;
Will Rogers
Roger Cody
Was roger here?
Was Roger here?
;
proc print;
run;
*anyalpha,anydigit,anyalnum,anyspace,anypunct;
data only_alpha mixed;
infile cards truncover;
input ID $10.;
if anydigit(ID) then output mixed;
else output only_alpha;
cards;
ABc123
XrayMan
142abc
Agent007
Terminator
;
run;
proc print data = only_alpha;
run;
proc print data = mixed;
run;

data one;
a = 'abcd12 3?';
a1 = anydigit(a);
a2 = anyalpha(a);
a3 = anyalnum(a);
a4 = anyspace(a);
a5 = anypunct(a);
run;
proc print;
run;
data two;
a = 'abcd12 3?';
a1 = notdigit(a);
a2 = notalpha(a);
a3 = notalnum(a);
a4 = notspace(a);
a5 = notpunct(a);
run;
proc print;
run;
data one two;
input id$ 10.;
*notalpha notdigit notalnum;
if notalnum(id) then output one;
else output two; 
cards;
ABc123
XrayMan
142abc
Agent007
Terminator
run;
proc print data = one;
run;
proc print data = two;
run;
data errors valid;
input ID $ Answer$ :5.;
if verify(Answer,'ABCDE') then output errors;
else output valid;
datalines;
001 AABDE
001 AABDF
002 A5BBD
003 12345
;
run;
proc print data = errors;
run;
proc print data = valid;
run;
data original;
input Name $ 16.;
datalines;
Jeffrey Smith
Ron Cody
Alan Wilson
Alfred E. Newman
;
data first_last;
set original;
length First Last $ 15;
First = scan(Name,1,' ');
Last = scan(Name,2,'.');
run;
proc print;
run;
*The colon modifier specifies that you want to truncate the longer 
string to the length of the shorter string before making the comparison;
data diagnosis;
input Code $10.;
/*chk w and w/out :*/
if compare(Code,'V450','i:') eq 0 then Match = 'Yes';
else Match = 'No';
datalines;
V450
v450
v450.100
V900
;
proc print;
run;
proc contents data = diagnosis;
run;
data one;
String1 = 'ABC   ';
String2 = 'ABCXYZ';
Compare1 = compare(String1,String2,':');
Compare2 = compare(trim(String1),String2,':');
run;
proc print;
run;
*The SPEDIS function returns a 0 if the two arguments match exactly. The function
assigns penalty points for each type of spelling error. For example, getting the first letter
wrong is assigned more points than misspelling other letters. Interchanging two letters is
a relatively small error, as is adding an extra letter to a word;

data fuzzy;
input Name $20.;
Value = spedis(Name,'Friedman');
datalines;
Friedman
Freedman
Xriedman
Freidman
Friedmann
Alfred
FRIEDMAN
;
proc print;
run;
question_1(chapter_12);
data storage;
length A $ 4 B $ 4;
Name = 'Goldstein';
AandB = A || B;
Cat = cats(A,B);
if Name = 'Smith' then Match = 'No';
else Match = 'Yes';
Substring = substr(Name,5,2);
run;
proc print;
run;
proc contents data = storage;
run;
question_3;
data names_and_more(drop = type1 type2);
length phone$ 14 ;
infile cards missover;
input name$ &16. phone$ type1$ type2$ score1 score2$;
value1 = input(compress(phone,,'kd'),10.);
value2 = input(compress(type1,,'kd'),8.);
value3 = input(compress(type2,,'kd'),8.);
cards;
Roger Cody  (908)782-1234 5ft. 10in. 50 1/8
Thomas Jefferson  (315)848-8484 6ft. 1in. 23 1/2
Marco Polo  (800)123-4567 5Ft. 6in. 40
Brian Watson  (518)355-1766 5ft. 10in 89 3/4
Michael DeMarco  (445)232-2233 6ft. . 76 1/3
;
run;
proc print;
run;

							*date function;

The default value for year cut off is 1920 (100period) - 1920 - 2019;
data date_func1;
name = 'David';
age = 28;
dob = "15oct19"d;
run;
proc print data = date_func1;
format dob date9.;
run;

data date_func2;
name = 'David';
age = 28;
dob = '15oct19'd;
run;
proc print data = date_func2;
format dob weekdate29.;
run;

data date_func3;
name = 'David';
age = 28;
dob = '15oct19'd;
run;
proc print data = date_func3;
format dob worddate18.;
run;
