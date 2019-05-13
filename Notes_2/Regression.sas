data modelling;
input invoice horsepower mpg_city mpg_highway weight;
cards;
25000 200 20 25 4000
21000 215 15 27 4500
28000 258 19 58 5500
30000 325 56 29 4902
31858 420 38 38 3982
42000 401 28 39 2145
32454 268 38 48 3125
41025 478 45 48 3456
;
run;

/*Initial Examination Prior to Modeling*/
proc plot data=modelling;/*checking for linearity*/
plot invoice*(horsepower mpg_city mpg_highway weight);
run;quit;
ODS GRAPHICS ON; 
PROC TRANSREG DATA = modelling test;
MODEL BOXCOX(invoice) = identity(mpg_city mpg_highway horsepower weight);
output out=a1;
RUN; 
ODS GRAPHICS OFF;

proc print data = a1;run;
proc plot data = a1;
plot invoice *(mpg_city mpg_highway horsepower weight);
run;quit;

proc corr data=modelling;/*checking for multicollinearity*/
var horsepower mpg_city mpg_highway weight;
run;

/*Creating the Model*/
/*SAS Code for Information Criteria*/
proc reg data=modelling outest=est;
model invoice = horsepower mpg_city mpg_highway weight / selection=adjrsq sse aic bic sbc adjrsq cp rmse;
run; quit;
proc reg data=modelling outest=est0;
model invoice = horsepower mpg_city mpg_highway weight / noint selection=adjrsq sse aic bic sbc adjrsq cp rmse;
run; quit;
data estout;
set est est0; run;
proc print data = estout;run;

proc sort data=estout; by _aic_;
proc print data=estout(obs=8); title 'best model by AIC'; run;

proc sort data=estout; by _bic_;
proc print data=estout(obs=8); title 'best model by BIC'; run;

proc sort data=estout; by _sbc_;
proc print data=estout(obs=8); title 'best model by SBC'; run;

/*SAS Code for Model Diagnostics*/
proc sort data=estout; by _rmse_;
proc print data=estout(obs=8); title 'best model by RMSE'; run;

proc sort data=estout; by _cp_;
proc print data=estout(obs=8); title 'best model by CP'; run;

proc sort data=estout; by descending _adjrsq_; ** want largest adjusted R2;
proc print data=estout(obs=8); title 'best model by adjusted R2'; run;

/*SAS Code for Heuristic Method*/
proc reg data=modelling outest=est1;
model invoice =horsepower mpg_city mpg_highway weight  / slentry=0.15 selection=forward sse aic bic sbc;
run; quit;
proc reg data=modelling outest=est2;
model invoice = horsepower mpg_city mpg_highway weight / slstay=0.15 selection=backward sse aic bic sbc;
run; quit;
proc reg data=modelling outest=est3;
model invoice = horsepower mpg_city mpg_highway weight  / slstay=0.15 slentry=0.15 selection=stepwise sse aic bic sbc;
run; quit;

/*Test of Assumptions*/
PROC REG DATA=modelling;
MODEL invoice = horsepower weight / DW SPEC ;
OUTPUT OUT=RESIDS R=RES;
RUN;QUIT;
PROC UNIVARIATE DATA=RESIDS
NORMAL PLOT;
VAR RES;
RUN;

/*Testing for Multicollinearity*/
/*A severe multicollinearity problem exists if the variance inflation factors (VIF) for the are greater than 10*/
proc reg data= modelling outest=a2;
model invoice = horsepower weight/vif;
run;

/*Testing for Autocorrelation*/
PROC REG DATA=modelling;
MODEL invoice = horsepower weight /DW;
RUN;
quit;

/*Testing for Outliers*/
proc reg data= modelling outest=a2;
model invoice = horsepower weight / influence r ;
run;
quit;

/*Testing the Fit of the Model*/
PROC RSREG DATA=modelling;
MODEL invoice= horsepower weight/LACKFIT;
RUN;
quit;

/*Another check you can perform on your model is to plot the error term against the dependent variable Y.*/


