/*SAS-STATISTICS*/

/*FOR ALL TYPES OF STATISTICS VALUE WE USE UNIVARIATE,IN PROC MEANS ONLY 5 DEFAULT VALUES WOULD COME
LIKE THAT UNIVARIATE WILL SHOW ALL STATS VALUES*/

PROC UNIVARIATE DATA = SASHELP.CLASS;
RUN;

PROC UNIVARIATE DATA = SASHELP.CLASS;
VAR weight;
RUN;
/* Result Interpretation 
1. Skewness and Kurtosis - Measures the deviation from normality.

Skewness - indicates symmetric distribution about the mean. 
positive values indicates a right-skewed distribution. 
Negative values indicates left-skewed distribution.

Kurtosis - indicates whether the distribution is more peaked than or flatter than a normal distribution.
Positive values indicates that the distribution is too peaked and tails are too heavy.
Negative values indicates that the distribution is too flat and tails are too light.
   
Coefficient of Variation(CV) - express the standard deviation as a percent of mean.((STD/MEAN)*100)
Std Error - gives estimate of how accurately this estimated the population mean.
Uncorrected SS - Sum of square of all the data values.
Corrected SS - Subtract the mean from each value before sqaure them and then add them up.

2.Measures of location(Mean,Median,Mode) measures of variability(std deviation,variance,range,and interquartile range=2NDMAX-2NDMIN).
3.Determines whether various measures of central location are significantly different from theoretical value(mu).
Default value is mu=0. you can change this value to another values by setting procedure option mu=n, where n is non zero value.
4.List of commonly used quantiles- Quartiles of a set of values are the three points that divide the data set into four equal groups, each representing a fourth of the population being sampled.
5.Displays the five lowest and five highest values in your data set. In case you want to see more then 5 values then use procedure option NEXTROBS=n where n is no of observation)
6.Tells How many observations had a missing value for the variable of interest.
  Also expresses this number as the percent of all your observations.

Syntax:-
ODS GRAPHICS ON;
PROC UNIVARIATE;
VAR variable-list;
Plot-request variable-list / options;
RUN;

list of plot:
CDFPLOT requests a cumulative distribution function plot
HISTOGRAM requests a histogram
PPPLOT requests a probability-probability plot
PROBPLOT requests a probability plot
QQPLOT requests a quantile-quantile plot

Available distributions options include: BETA, EXPONENTIAL, GAMMA,
LOGNORMAL, NORMAL, and WEIBULL

*/

ODS GRAPHICS ON;
PROC UNIVARIATE DATA = SASHELP.class;
VAR age;
HISTOGRAM age/NORMAL;
PROBPLOT age;
TITLE;
RUN;

DATA class;
INFILE cards;
INPUT Score @@;
cards;
56 78 84 73 90 44 76 87 92 75
85 67 90 84 74 64 73 78 69 56
87 73 100 54 81 78 69 64 73 65
;
RUN;
proc print;
run;

PROC UNIVARIATE DATA = class;
VAR Score;
TITLE;
RUN;


PROC UNIVARIATE DATA = class mu0=75 NEXTROBS=7;
VAR Score;
TITLE;
RUN;

/*PROC MEANS */
DATA booklengths;
INFILE cards;
INPUT NumberOfPages @@;
cards;
34 30 29 32 52 25 24 27 31 29
24 26 30 30 30 29 21 30 25 28
28 28 29 38 28 29 24 24 29 31
30 27 45 30 22 16 29 14 16 29
32 20 20 15 28 28 29 31 29 36
;
RUN;
proc print;
run;
/*
List of Options - 
CLM two-sided confidence limits RANGE the range
CSS corrected sum of squares SKEWNESS skewness
CV coefficient of variation STDDEV standard deviation
KURTOSIS kurtosis STDERR standard error of the mean
LCLM lower confidence limit SUM the sum
MAX maximum value SUMWGT sum of weight variables
MEAN mean UCLM upper confidence limit
MIN minimum value USS uncorrected sum of squares
MODE mode VAR variance
N number of non-missing values PROBT probability for Student’s t
NMISS number of missing values T Student’s t
MEDIAN (P50) median Q3 (P75) 75% quantile
Q1 (P25) 25% quantile P5 5% quantile
P1 1% quantile P90 90% quantile
P10 10% quantile P99 99% quantile
P95 95% quantile */

*Produce summary statistics;
PROC MEANS DATA=booklengths N MEAN MEDIAN CLM ALPHA=.10;
TITLE 'Summary of Picture Book Lengths';
RUN;

/*The average number of pages in the children’s books sampled was 28. The median value of 29 says*/
/*that half the books sampled had 29 pages or fewer. The confidence limits tell us that we are 90%*/
/*certain that the true population mean (all children’s picture books) falls between 26.44 and 29.56*/
/*pages. From this analysis your friend concludes that she should make her books between 26 and 30*/
/*pages long to maximize her chances of getting published (of course subject matter and writing style*/
/*might also help).*/


/*PROC FREQ;*/
/*The most common uses of PROC FREQ is to test the hypothesis of  association between the variables. */
/*Another use is to compute measures of association, which indicate the strength of the relationship */
/*between the variables. The best known of these is chi-square.The basic form of PROC FREQ is :*/

PROC FREQ DATA=<dsn>;
TABLES variable-combinations / options;

DATA bus;
/*INFILE 'D:\Studying stuff\SAS\Alok\Documents\Bus.dat';*/
INFILE cards;	
INPUT BusType $  OnTimeOrLate $ @@;
cards;
E O E L E L R O E O E O E O R L R O R L
R O E O R L E O R L R O E O E O R L E L
E O R L E O R L E O R L E O R O E L E O
E O E O E O E L E O E O R L R L R O R L
E L E O R L R O E O E O E O E L R O R L
;
RUN;

PROC PRINT;
RUN;

PROC FREQ DATA = bus;
TABLES BusType * OnTimeOrLate / CHISQ;
TITLE;
RUN;

/*The probability of obtaining a chi-square this large or larger by chance alone is 0.0071. So the*/
/*data do support the idea that there is an association between type of bus and arrival time.*/

/*AGREE 	- requests tests and measures of classification agreement including McNemar’s test, Bowker’s test, */
/*			Cochran’s Q test, and kappa statistics.*/
/*CHISQ	- requests chi-square tests of homogeneity and measures of association*/
/*CL		- requests confidence limits for measures of association*/
/*CMH		- requests Cochran-Mantel-Haenszel statistics*/
/*EXACT	- requests Fisher’s exact test for tables larger than 2X2*/
/*MEASURES- requests measures of association including Pearson and Spearman correlation coefficients, gamma, */
/*			Kendall’s tau-b, Stuart’s tau-c, Somer’s D, lambda, odds ratios, risk ratios, and confidence intervals*/
/*PLCORR	- requests polychoric correlation coefficient*/
/*RELRISK	- requests relative risk measures for 2X2 tables*/
/*TREND	- requests the Cochran-Armitage test for trend*/


/*	PROC CORR	*/

PROC CORR DATA = dsn;
VAR varlist;
WITH  varname;
RUN;

/*The CORR procedure, which is included with Base SAS software, computes correlations. A correlation coefficient*/
/*measures the strength of the relationship between two variables, or how corelated they are. If two variables */
/*were completely unrelated, they would have a correlation of 0. If two variables were perfectly correlated, they */
/*would have a correlation of 1.0 or –1.0.*/

/*Variables listed in the VAR statement appear across the top of the table of correlations, while variables listed */
/*in the WITH statement appear down the side of the table. If you use a VAR statement but no WITH statement, then */
/*the variables appear both across the top and down the side.*/

DATA corr_data;
INPUT Score Television Exercise @@;
CARDS;
56 6 2   78 7 4   84 5 5   73 4 0   90 3 4
44 9 0   76 5 1   87 3 3   92 2 7   75 8 3
85 1 6   67 4 2   90 5 5   84 6 5   74 5 2
64 4 1   73 0 5   78 5 2   69 6 1   56 7 1
87 8 4   73 8 3  100 0 6   54 8 0   81 5 4
78 5 2   69 4 1   64 7 1   73 7 3   65 6 2
;
PROC PRINT;
RUN;

PROC CORR DATA = corr_data;
   VAR Television Exercise;
   WITH Score;
RUN;

/*This report starts with descriptive statistics for each variable and then lists the correlation matrix which */
/*contains: 1.correlation coefficients (in this case, Pearson), and 2. the probability of getting a larger absolute */
/*value for each correlation assuming the population correlation is zero.*/
/**/
/*In this example, both hours of television and hours of exercise are correlated with test score, but exercise is */
/*positively correlated while television is negatively correlated. This means students who watched more television */
/*tended to have lower scores, while the students who spent more time exercising tended to have higher scores.*/


ODS GRAPHICS ON;
PROC CORR DATA = corr_data PLOTS = (SCATTER MATRIX);
VAR Television Exercise;
WITH Score;
TITLE ’Correlations for Test Scores’;
TITLE2 ’With Hours of Television and Exercise’;
RUN;
/* no result - not avaible with this version */


/*	PROC REG WILL GIVE BELOW EQUATION FOR BETWEEN TWO VARIABLES.	
    Y=MX+C -> LINEAR REGRESSION EQUATION.
	HERE Y AND X ARE VARIABLES.
	Y-> DEPENDENT VARIABLE
	X -> INDEPENDENT VARIABLE
REGRESSION IS MAINLY USED FOR FORCASTING THE VALUES.
*/

/*SYNATX:
	PROC REG DATA = dsn;
    MODEL dependent = independent;
    PLOT dependent * independent;
	QUIT;
*/

DATA hits;
INPUT Height Distance @@;
CARDS;
50 110  49 135  48 129  53 150  48 124
50 143  51 126  45 107  53 146  50 154
47 136  52 144  47 124  50 133  50 128
50 118  48 135  47 129  45 126  48 118
45 121  53 142  46 122  47 119  51 134
49 130  46 132  51 144  50 132  50 131
;
RUN;
PROC PRINT;
RUN;

PROC REG DATA = hits;
   MODEL Distance = Height;
   PLOT Distance * Height;
   TITLE 'Results of Regression Analysis';
QUIT;
/*
The distance the ball was hit did increase with the player’s height. The slope of
the model is significant (significance probability = .0003) but the relationship is not very strong
(R-square = 0.3758). Perhaps age or years of experience are better predictors of how far the ball
will go.


/*PROC RANK*/
/*PROC RANK computes the RANKS from one or more numeric variables across observations in a SAS ® data*/
/*set and creates a new data set that captures these rankings.*/

data test ;
input WEEK spend @@ ;
datalines;
1 1345 2 235 3 12 4 5677 5 214 6 432 7 121 8 1567
;
run;
PROC PRINT NOOBS; 
RUN;

proc rank data=test out=r_test; 
var spend;
run;
proc print data=r_test NOOBS;
run;

/*RANKS - names the variable you wish to store the value of ranks in.*/
proc rank data=test out=r_test1;
var spend;
ranks r_spend; 
run;

proc print data=r_test1;
run;

/*By default, RANKS are in ascending order. if you want to reverse the order. then use DESCENDING option in 
PROC RANK.*/

proc rank data=test out=r_test2 descending;
var spend;
ranks r_spend;
run;
proc print data=r_test2;
run;

/*If there are tied values in the variable that is being ranked, the RANK procedure has a number of options to 
handle ties. The default option is MEANS where the mean rank is returned for tied values. */
/*IF THERE WOULD BE A TIE THEN MIDDLE VALUE WOULD BE CONSIDERED BY SAS  LIKE 12 12 ,TWO VALUES HAVE MIDDLE 
 VALUE 1.5 AND IF 12 12 12 ,THEN MIDDLE VALUE WOULD BE 2*/

data test1;
input spend @@;
datalines;
12 1345 235 5677 214 432 121 12 1567 235 12
;
run;
proc rank data=test1 out=r_test3 ;
var spend;
ranks r_spend;
run;
proc print data=r_test3;
run;

/*Other options for ties include TIES=LOW, TIES=HIGH, and TIES=DENSE (added in SAS 9.2). */
/*TIES=LOW, the tied values are assigned to the lower rank. */
/*TIES=HIGH, tied values are assigned to the higher rank. */
/*TIES=DENSE, the ranks are consecutive integers that begin with 1 end with the number of unique values */
/*	of the VAR variable. (used for SAS 9.2)*/

proc rank data=test1 out=r_test4 ties=low; /* WILL TAKE LOWEST RANK VALUE IN LOW*/
var spend;
ranks r_spend;
run;
proc print; run;

proc rank data=test1 out=r_test5 ties=high;
var spend;
ranks r_spend;
run;
proc print data=r_test5; run;

/*PROC TTEST*/
/*TO COMPARE TWO GROUPS MEAN VALUE*/
/*THERE ARE TWO TYPES OF TTEST
  1.PAIRED TTEST
  2.UNPAIRED TTEST(CONTAINS ONLY 1 GROUP ALWAYS)
*/

/*UNPAIRED TTEST EXAMPLE*/
data time;
input time @@;
datalines;
43  90  84  87  116   95  86   99   93  92
121  71  66  98   79  102  60  112  105  98
;
run;

proc ttest DATA=TIME h0=80 alpha=0.1; /*IDEAL CASE FOR ALPHA IS 0.10(90%)*/
var time;
run;
   
proc ttest h0=85 alpha=0.1;
var time;run;
   

data scores;
input Gender $ Score @@;
datalines;
f 75  f 76  f 80  f 77  f 80  f 77  f 73
m 82  m 80  m 85  m 85  m 78  m 87  m 82
;
run;

  
 proc ttest DATA=SCORES cochran ci=equal umpu;
 class Gender;
 var Score;
 run;


/*The CLASS statement contains the variable that distinguishes the groups being compared, */
/*and the VAR statement specifies the response variable to be used in calculations. */
/*The COCHRAN option produces -values for the unequal variance situation by using the Cochran */
/*and Cox (1950) approximation. Equal-tailed and uniformly most powerful unbiased (UMPU) confidence intervals */
/*for are requested by the CI= option*/


/*		PROC ANOVA	
PROC ANOVA is specifically designed for balanced data—data where there are equal numbers of observations in
each combination of the classification factors. 
If you are not doing one-way analysis of variance and your data are not balanced, then you should use the GLM 
procedure, whose statements are almost identical to those of PROC ANOVA.

PROC ANOVA;
CLASS variable-list;
MODEL dependent = effects;

The CLASS statement must come before the MODEL statement and defines the classification variables. 
For one-way analysis of variance, only one variable is listed. The MODEL statement defines the dependent 
variable and the effects. For one-way analysis of variance, the effect is the classification variable.

MEANS statement, which calculates means of the dependent variable for any of the main effects in the MODEL 
statement. In addition, the MEANS statement can perform severaltypes of multiple comparison tests including 
Bonferroni t tests (BON), Duncan’s multiple-range test (DUNCAN), Scheffe’s multiple-comparison procedure 
(SCHEFFE), pairwise t tests (T), and Tukey’s studentized range test (TUKEY). The MEANS statement has the 
following general form:
MEANS effects / options;

SYNTAX:
PROC ANOVA DATA = dsn;
CLASS varlist;
MODEL dependent = effects;
MEANS effects / options;
QUIT;
*/

DATA basket;
INPUT Team $ Height @@;
CARDS;
red  55 red  48 red  53 red  47 red  51 red  43
red  45 red  46 red  55 red  54 red  45 red  52
blue 46 blue 56 blue 48 blue 47 blue 54 blue 52
blue 49 blue 51 blue 45 blue 48 blue 55 blue 47
gray 55 gray 45 gray 47 gray 56 gray 49 gray 53
gray 48 gray 53 gray 51 gray 52 gray 48 gray 47
pink 53 pink 53 pink 58 pink 56 pink 50 pink 55
pink 59 pink 57 pink 49 pink 55 pink 56 pink 57
gold 53 gold 55 gold 48 gold 45 gold 47 gold 56
gold 55 gold 46 gold 47 gold 53 gold 51 gold 50
;
PROC PRINT DATA = BASKET;
RUN;

PROC ANOVA <options> ;
    CLASS variables </ option> ;
    MODEL dependents=effects </ options> ;
    ABSORB variables ;
    BY variables ;
    FREQ variable ;
    MANOVA <test-options></ detail-options> ;
    MEANS effects </ options> ;
    REPEATED factor-specification </ options> ;
    TEST <H=effects> E=effect ; 
RUN;

/*	ABSORB	-	absorbs classification effects in a model*/
/*	BY		-	specifies variables to define subgroups for the analysis*/
/*	CLASS	-	declares classification variables*/
/*	FREQ	-	specifies a frequency variable*/
/*	MANOVA	-	performs a multivariate analysis of variance*/
/*	MEANS	-	computes and compares means*/
/*	MODEL	-	defines the model to be fit*/
/*	REPEATED-	performs multivariate and univariate repeated measures analysis of variance*/
/*	TEST	-	constructs tests that use the sums of squares for effects and the error term you specify */

PROC ANOVA DATA = basket;
   CLASS Team;
   MODEL Height = Team;
   MEANS Team / SCHEFFE;
QUIT;

/*
Here the CLASS variable is Team. It has five levels with values blue, gold, gray, pink, and red
representing the five teams. There are a total of 60 observations in the data set.

In this case, Team is the classification variable and also the effect in the MODEL statement. Height
is the dependent variable. The MEANS statement will produce means of the girls’ heights for each
team, and the SCHEFFE option will test which teams are different from the others.

*/
/*GLM - generalized linear model 
ANOVA IS USED TO FOR SYMMETRIC TYPE OF DATA MEANS IN EACH GROUP THERE 
SHOULD EQUAL NO OF OBSERVATION. BUT IF THERE IS ASYMMETRIC DATA THAT EACH
GROUP HAVE DIFFERENT NO OF OBSERVATION THEN PERFORM GLM.
*/

PROC glm DATA = basket;
   CLASS Team;
   MODEL Height = Team;
   MEANS Team / SCHEFFE;
QUIT;






