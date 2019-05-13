DATA T_SERIES;
SET SASHELP.AIR;
RUN;
PROC PRINT;RUN;
1./*To Check Heteroscedasticity*/
*Heteroscedasticity occurs when the variance
of the error terms differ across observations;
PROC GPLOT DATA = T_SERIES;
PLOT AIR*DATE;
RUN;QUIT;
*Data fans out = log or square root transformation
Data fans in = Exponential or square transformation;
DATA T_SERIES;
SET T_SERIES;
LOG_AIR = LOG(AIR);
SQRTT_AIR = AIR**0.5;
RUN;
PROC GPLOT DATA = T_SERIES;
PLOT LOG_AIR*DATE;
RUN;QUIT;
2./*Check for Seasonality/Stationarity*/
*Stationarity is a random process where all of its statistical properties
do not vary with time;
PROC ARIMA DATA = T_SERIES;
IDENTIFY VAR = LOG_AIR STATIONARITY = (ADF);
RUN;QUIT;
*Ho = The Model is Non - Stationary
1.If the "p" values of the test are < 0.01, we reject Ho and claim that the model is 
stationary.
2.The smaller the P value, the more strongly the test rejects the null hypothesis,
that is, the hypothesis being tested.
3.A p-value of 0.05 or less rejects the null hypothesis "at the 5% level" that is, the 
statistical assumptions used imply that only 5% of the time would the supposed statistical 
process produce a finding this extreme if the null hypothesis were true;
/*Variable Transformation (Lag transformation through difference operator)*/
DATA T_SERIES;
SET T_SERIES;
DIF_LOG_AIR = DIF(LOG_AIR);
RUN;
PROC ARIMA DATA = T_SERIES;
IDENTIFY VAR = DIF_LOG_AIR STATIONARITY = (ADF);
RUN;QUIT;
/*Check for the presence of Seasonality Pattern in the Dataset */
PROC ARIMA DATA = T_SERIES;
IDENTIFY VAR = DIF_LOG_AIR NLAG = 84;
RUN;QUIT;
*In order to reduce the seasonality pattern from the dataset, we take a 12 period time 
difference lag of the transformed variable in the data set;
/*Variable Transformation (Lag transformation through difference operator) */
DATA T_SERIES;
SET T_SERIES;
D12_DIF_LOG_AIR = DIF12(DIF_LOG_AIR);
RUN;
*Seasonality from the dataset has been reduced considerably after taking transformation 
of the transformed variable with a 12 period time lag;
PROC ARIMA DATA = T_SERIES;
IDENTIFY VAR = D12_DIF_LOG_AIR NLAG = 84;
RUN;QUIT;
*Divide the Whole dataset into two halves based on the no. of observations, 
we introduce a "pos" variable in the original dataset;
DATA T_SERIES;
SET T_SERIES;
POS = _N_;
RUN;
DATA PART1 PART2;
SET T_SERIES;
IF POS LE 132 THEN OUTPUT PART1;
ELSE OUTPUT PART2;
RUN;
/*Estimating the range of values for p & q through "minic" criterion */
PROC ARIMA DATA = PART1;
IDENTIFY VAR = D12_DIF_LOG_AIR MINIC;
RUN;QUIT;
PROC ARIMA DATA = PART1;
IDENTIFY VAR = D12_DIF_LOG_AIR MINIC;
ESTIMATE P=0 Q=1;
RUN;QUIT;
PROC ARIMA DATA = PART1;
IDENTIFY VAR = D12_DIF_LOG_AIR MINIC;
ESTIMATE P=0 Q=2;
RUN;QUIT;
PROC ARIMA DATA = PART1;
IDENTIFY VAR = D12_DIF_LOG_AIR MINIC;
ESTIMATE P=0 Q=3;
RUN;QUIT;
PROC ARIMA DATA = PART1;
IDENTIFY VAR = D12_DIF_LOG_AIR MINIC;
ESTIMATE P=1 Q=0;
RUN;QUIT;
PROC ARIMA DATA = PART1;
IDENTIFY VAR = D12_DIF_LOG_AIR MINIC;
ESTIMATE P=2 Q=0;
RUN;QUIT;
PROC ARIMA DATA = PART1;
IDENTIFY VAR = D12_DIF_LOG_AIR MINIC;
ESTIMATE P=3 Q=0;
RUN;QUIT;
PROC ARIMA DATA = PART1;
IDENTIFY VAR = D12_DIF_LOG_AIR MINIC;
ESTIMATE P=1 Q=1;
RUN;QUIT;
PROC ARIMA DATA = PART1;
IDENTIFY VAR = D12_DIF_LOG_AIR MINIC;
ESTIMATE P=1 Q=2;
RUN;QUIT;
PROC ARIMA DATA = PART1;
IDENTIFY VAR = D12_DIF_LOG_AIR MINIC;
ESTIMATE P=1 Q=3;
RUN;QUIT;
PROC ARIMA DATA = PART1;
IDENTIFY VAR = D12_DIF_LOG_AIR MINIC;
ESTIMATE P=2 Q=1;
RUN;QUIT;
PROC ARIMA DATA = PART1;
IDENTIFY VAR = D12_DIF_LOG_AIR MINIC;
ESTIMATE P=2 Q=2;
RUN;QUIT;
PROC ARIMA DATA = PART1;
IDENTIFY VAR = D12_DIF_LOG_AIR MINIC;
ESTIMATE P=3 Q=2;
RUN;QUIT;
PROC ARIMA DATA = PART1;
IDENTIFY VAR = D12_DIF_LOG_AIR MINIC;
ESTIMATE P=2 Q=3;
RUN;QUIT;
PROC ARIMA DATA = PART1;
IDENTIFY VAR = D12_DIF_LOG_AIR MINIC;
ESTIMATE P=3 Q=1;
RUN;QUIT;
PROC ARIMA DATA = PART1;
IDENTIFY VAR = D12_DIF_LOG_AIR MINIC;
ESTIMATE P=3 Q=3;
RUN;QUIT;
*From the above iterations, we select the following four p & q combinations (models):

1. p = 2 q = 3
2. p = 3 q = 3
3. p = 0 q = 1
4. p = 1 q = 0

Since they have the minimum average value of AIC and SBC in all the 15 iterations;
PROC ARIMA DATA = PART2;
IDENTIFY VAR = D12_DIF_LOG_AIR;
ESTIMATE P = 2 Q = 3;
FORECAST LEAD = 12 ID = DATE OUT = T_SERIES_MODEL1;
RUN;QUIT;

PROC ARIMA DATA = PART2;
IDENTIFY VAR = D12_DIF_LOG_AIR;
ESTIMATE P = 3 Q = 3;
FORECAST LEAD = 12 ID = DATE OUT = T_SERIES_MODEL2;
RUN;QUIT;

PROC ARIMA DATA = PART2;
IDENTIFY VAR = D12_DIF_LOG_AIR;
ESTIMATE P = 0 Q = 1;
FORECAST LEAD = 12 ID = DATE OUT = T_SERIES_MODEL3;
RUN;QUIT;

PROC ARIMA DATA = PART2;
IDENTIFY VAR = D12_DIF_LOG_AIR;
ESTIMATE P = 1 Q = 0;
FORECAST LEAD = 12 ID = DATE OUT = T_SERIES_MODEL4;
RUN;QUIT;

DATA T_SERIES2;
SET T_SERIES;
RUN;

PROC ARIMA DATA = T_SERIES2;
IDENTIFY VAR = D12_DIF_LOG_AIR;
ESTIMATE P = 0 Q = 1; 
FORECAST LEAD = 12 ID = DATE OUT = T_SERIES_AIRFORECAST;
RUN;QUIT;

PROC ARIMA DATA = T_SERIES2;
IDENTIFY VAR = LOG_AIR(1,12);
ESTIMATE P =0 Q = 1;
FORECAST LEAD = 12 ID = DATE OUT = T_SERIES_AIRFORECAST_TRANS;
RUN;QUIT;

 
