Infile options
1. Firstobs
2. Obs
3. Missover
4. Truncover
5. Dlm
6. Dsd
/*firsobs tells SAS to start reading data from line no. m*/

/*obs it tells SAS to stop reading data at line no. n*/
;
filename ref 'C:\Documents and Settings\Athik\Desktop\Athiq\SAS\Datasets';
data infile_option;
/*infile "C:\Documents and Settings\Athik\Desktop\Athiq\SAS\Datasets\infile1.txt";*/
infile ref('infile1.txt');
input sno name$;
run;
proc print data = infile_option;
run;
data infile_option1;
infile "C:\Documents and Settings\Athik\Desktop\Athiq\SAS\Datasets\infile1.txt " firstobs = 4 obs =7;
/*infile ref (infile1.txt);*/
input sno name$;
run;
proc print data = infile_option1;
run;
/*missover tells SAS to assign missing values to the remaining values 
if datalines runs out of data. it is used only for the last 
missing value and not inbetween the values*/
;
data infile_option2;
infile ref('infile2.txt') missover;
input name$ match1 match2;
run;
proc print data = infile_option2;
run;
data student;
infile ref('student.txt') missover firstobs = 2;
input name$ sub1 sub2 sub3 ;
run;
proc print data = student;
run;
data one;
infile cards missover;
input sex$ a1-a3;
cards;
M 50 68 155
F 60 101
M 65 72 220
F 35 65 133
M 15 71 166
;
run;
proc print;
run;

/*truncover - it tells SAS to read the data for the variable until it
reaches the end of the data line or the last column range specified
in the informat which ever it comes first*/
;
data playerinfo;
infile ref(playerinfo.txt) truncover firstobs = 2;
/*length city$ 9;*/
input name$ city$ 9.;
run;
proc print data = playerinfo;
run;
data playerinfo1;
infile ref(playerinfo.txt)firstobs = 2 ;
input name$ city $:9.;
run;
proc print data = playerinfo1;
run;
/*dlm - delimiter (separator)
dsd - delimiter sensitive data - it ignores the quotation mark 
as data value and it ignores the dlm inside the quotation mark
and it considers two conscutive dlm as missing value.*/
;
1.It changes the default delimiter from a blank to a comma. 
2.Next, if there are two delimiters in a row, it assumes there is a missing value between. 
3.Finally, if character values are placed in quotes (single or double quotes), 
the quotes are stripped from the value;
data productinfo;
infile ref(productinfo.txt)firstobs = 2  dlm = ',';
input prod$ type$ :19. comp$;
run;
proc print data = productinfo;
run;
data one;
infile cards dlm = '09'x ;
input name$ sex$;
cards;
aaa								f
bbb 							m
ccc								f
ddd								m
;
run;
proc print;
run;
data one;
infile cards dlm =':' ;
/*infile cards dlm ='09'x ;*/
input sex$ a1-a3;
cards;
M:50:68:155
F:23:60:101
M:65:72:220
F:35:65:133
M:15:71:166
run;
proc print;
run;
data one;
infile cards dsd;
input id$ :3. name$ : 26. doj:mmddyy10. salary:dollar8.;
cards;
"001","Christopher Mullens",11/12/1955,"$45,200"
"002","Michelle Kwo",9/12/1955,"$78,123"
"003","Roger W. McDonald",1/1/1960,"$107,200"
;
run;
proc print;
format doj mmddyy10. salary dollar8.;
run;
proc contents data = one;
run;
data one_1;
informat id $3. name $26. doj mmddyy10. salary dollar8.;
infile cards  dsd;
input id name doj salary;
cards;
"001","Christopher Mullens",11/12/1955,"$45,222"
"002","Michelle Kwo",9/12/1955,"$78,123"
"003","Roger W. McDonald",1/1/1960,"$107,200"
;
run;
proc print;
format doj mmddyy10. salary dollar8.;
run;
data one_2;
input id$: 3. name$ & 23. doj : mmddyy10.  salary dollar8.;
cards;
001 Christopher Mullens  11/12/1955 $45,200
002 Michelle Kwo  9/12/1955 $78,123
003 Roger W. McDonald  1/1/1960 $107,200
run;
proc print;
format doj mmddyy10. salary dollar8.;
run;
proc contents data = one_2;
run;
data question_2;
infile cards dsd;
input state$ party$ age;
cards;
"NJ",Ind,55
"CO",Dem,45
"NY",Rep,23
"FL",Dem,66
"NJ",Rep,34
run;
proc print;
run;
proc freq data = question_2;
tables party;
run;
data question_3;
infile cards dlm ='$' dsd;
input lastname$ empno$ salary;
cards;
Roberts$M234$45000
Chien$M74777$$
Walters$$75000
Rogers$F7272$78131
run;
proc print;
run;
data question_4;
filename aaa ' C:\Documents and Settings\Athik\Desktop\SAS Certification Prep Guide\question2.txt';
infile aaa dsd;
input state$ party$ age;
run;
proc print;
run;
data question_11;
infile cards dsd;
input id$:3. name$ :18. depart$ datehire:mmddyy10. salary dollar8.;
cards;
123,"Harold Wilson",Acct,01/15/1989,$78,123
128,"Julia Child",Food,08/29/1988,$89,123
007,"James Bond",Security,02/01/2000,$82,100
828,"Roger Doger",Acct,08/15/1999,$39,100
900,"Earl Davenport",Food,09/09/1989,$45,399
906,"James Swindler",Acct,12/21/1978,$78,200
run;
proc print;
format datehire mmddyy10. salary dollar8.;
run;
proc contents data = question_11;
run;
data productinfo1;
infile "D:\Athiq\productinfo1.txt" firstobs = 2 dlm = '-' dsd;
input prod$ type$ :19. comp$;
run;
proc print data = productinfo1;
run;
data matchsummary;
infile "D:\Athiq\matchsummary.txt" firstobs = 3  dlm = ' ' dsd;
input player$  score _4s _6s balls;
run;
proc print data = matchsummary;
run;
data question_11;
infile cards dsd;
input id$:3. name$ :18. depart$ datehire:mmddyy10. salary dollar8.;
cards;
123,"Harold Wilson",Acct,01/15/1989,$78,122
128,"Julia Child",Food,08/29/1988,$89,123
007,"James Bond",Security,02/01/2000,$82,100
828,"Roger Doger",Acct,08/15/1999,$39,100
900,"Earl Davenport",Food,09/09/1989,$45,399
906,"James Swindler",Acct,12/21/1978,$78,200
run;
proc print;
format datehire mmddyy10. salary dollar8.;
run;
data demographics;
/*infile cards dlm = ',' dsd;*/
infile cards dsd;
input Gender $ Age Height Weight ;
cards;
"M",50,68,155
"F",23,60,101
"M",65,72,220
"F",35,65,133
"M",15,71,166
;
run;
proc print;
run;


