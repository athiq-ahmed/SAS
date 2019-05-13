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
input name $  unitsold comma5.+1  revenue dollar7.+1 ;
cards;
philip 2,125 $37,000
mary 3,211 $51,000
janet 4,217 $67,000
;
run; 
proc print data = nine;
run;
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
run;
proc print data = ten;
format  growthrate percent6.
        revenue dollar6.;
run; 
data eleven;
infile cards;
input  name $ dob :date7.+1 doj :ddmmyy8.;
cards;
david 26oct82 15/04/10
amelia 17sep82 07/02/12
rajmohan 04jan85 08/2/8
;
run;
proc print data = eleven;
run;
proc print data =eleven;
format dob :date7. doj :ddmmyy8.;
run;
















