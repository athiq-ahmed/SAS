PROC MI --->
		1. REGRESSION - MONOTONE MISSING PATTERN
		2. PROPENSITY - MONOTONE MISSING PATTERN
		3. MCMC(MARKOV CHAIN MONTE CARLO) - ARBITRARY MISSING PATTERN

A data set is said to have a monotone missing pattern when
a variable Yj is missing for the individual i implies that all
subsequent variables Yk, k>j, are all missing for the individual i;

DATA FITNESS1;
INPUT OXYGEN RUNTIME RUNPULSE @@;
CARDS;
44.609 11.37 178 45.313 10.07 185
54.297 8.65 156 59.571 . .
49.874 9.22 . 44.811 11.63 176
45.681 11.95 176 49.091 10.85 .
39.442 13.08 174 60.055 8.63 170
50.541 . . 37.388 14.03 186
44.754 11.12 176 47.273 . .
51.855 10.33 166 49.156 8.95 180
40.836 10.95 168 46.672 10.00 .
46.774 10.25 . 50.388 10.08 168
39.407 12.63 174 46.080 11.17 156
45.441 9.63 164 54.625 8.92 146
45.118 11.08 . 39.203 12.88 168
45.790 10.47 186 50.545 9.93 148
48.673 9.40 186 47.920 11.50 170
47.467 10.50 170
;
RUN;
PROC PRINT;RUN;
Regression Method
In the regression method, a regression model is fitted for
each variable with missing values, with the previous variables
as covariates. Based on the resulting model, a new
regression model is then fitted and is used to impute the
missing values for each variable (Rubin 1987, pp. 166-167.)
Since the data set has a monotone missing data pattern, the
process is repeated sequentially for variables with missing
values;
PROC MI DATA = FITNESS1 SEED = 37851 OUT = MIOUT1;
MULTINORMAL METHOD = REGRESSION;
VAR OXYGEN RUNTIME RUNPULSE;
RUN;
PROC PRINT DATA = MIOUT1(OBS = 10);RUN;

In the propensity score method, a propensity score is generated for each
variable with missing values to indicate the probability of
that observation being missing. The observations are then
grouped based on these propensity scores, and an approximate
Bayesian bootstrap imputation (Rubin 1987, p. 124)
is applied to each group;

PROC MI DATA = FITNESS1 SEED = 37851 OUT = MIOUT2;
MULTINORMAL METHOD = PROPENSITY(NGROUPS = 10);
VAR OXYGEN RUNTIME RUNPULSE;
RUN;
PROC PRINT DATA = MIOUT2(OBS = 10);RUN;
Notes:
NIMPU=number 
	specifies the number of imputations. The default is NIMPU=5
SEED=number
	specifies a positive integer that is used to start the pseudorandom
	number generator. The default is a value generated
	from reading the time of day from the computer’s clock.

;
DATA FITNESS2;
INPUT OXYGEN RUNTIME RUNPULSE @@;
CARDS;
44.609 11.37 178 45.313 10.07 185
54.297 8.65 156 59.571 . .
49.874 9.22 . 44.811 11.63 176
. 11.95 176 49.091 10.85 .
39.442 13.08 174 60.055 8.63 170
50.541 . . 37.388 14.03 186
44.754 11.12 176 47.273 . .
51.855 10.33 166 49.156 8.95 180
40.836 10.95 168 46.672 10.00 .
. 10.25 . 50.388 10.08 168
39.407 12.63 174 46.080 11.17 156
45.441 9.63 164 . 8.92 146
45.118 11.08 . 39.203 12.88 168
45.790 10.47 186 50.545 9.93 148
48.673 9.40 186 47.920 11.50 170
47.467 10.50 170
;
RUN;
PROC PRINT;RUN;

PROC MI DATA = FITNESS2 NIMPU = 3 OUT = MIOUTMC;
MULTINORMAL METHOD = MCMC;
VAR OXYGEN RUNTIME RUNPULSE;
RUN;

/*MIANALYZE PROCEDURE*/

