proc sql;
create table first(name char(10),id varchar(10),team char(10));
insert into first values('AAA','A1','A');
insert into first values('BBB','A2','B');
insert into first values('CCC','A3','C');
insert into first values('DDD','A4','D');
insert into first values('EEE','A5','E');
insert into first (name,id) values('EEE','A5');
select * from first;
quit;
proc sql;
create table second(name char(10),id varchar(10),age num);
insert into second values('ABC','A1',22);
insert into second values('BFD','A8',33);
insert into second values('CER','A3',11);
insert into second values('DRT','A4',55);
insert into second values('EWQ','A5',66);
select * from second;
quit;
/*Cartesian Product*/
proc sql;
select * from first,second;
quit;
/*Inner_Joins*/
proc sql;
select * from first,second
where first.id = second.id;
quit;
/*Eliminating Duplicate Columns*/
proc sql;
select first.name,first.id,team,age from first,second
where first.id = second.id;
quit;
proc sql;
select first.*,age from first,second
where first.id = second.id;
quit;
/*Specifying a Table Alias*/
proc sql;
select * from first as a,second as b
where a.id = b.id;
quit;
proc sql;
create table staffmaster(id num,lastname char(10),firstname char(10),state varchar(10));
insert into staffmaster values(100,'ahm','athiq','K');
insert into staffmaster values(101,'bsd','athiq','K');
insert into staffmaster values(102,'gfrc','athiq','K');
insert into staffmaster values(103,'hgrd','athiq','K1');
insert into staffmaster values(104,'ehgr','athiq','K');
select * from staffmaster;
quit;
proc sql;
create table payrollmaster(empid num,jobcode char(10),age num);
insert into payrollmaster values(101,'AAA',22);
insert into payrollmaster values(103,'BBB',23);
insert into payrollmaster values(104,'CCC',24);
select * from payrollmaster;
quit;
*Suppose you want to display the names (first initial and last name), job codes, and
ages of all company employees who live in New York. You also want the results to be
sorted by job code and age;
proc sql;
select substr(lastname,1,1)||'.'||firstname as Name,Jobcode,Age 
from staffmaster,payrollmaster
where staffmaster.id = payrollmaster.empid
and state = 'K'
order by 2,3;
quit;
proc sql;
select jobcode,count(p.empid) as Employess
from staffmaster as s,payrollmaster as p
where s.id = p.empid
and state = 'K'
group by jobcode
order by jobcode;
quit;
proc sql;
select * from first as a inner join second as b
on a.id = b.id;
quit;
proc sql;
select * from first,second
where first.id = second.id 
	and first.team is not missing;
quit;
/*Left Join*/
proc sql;
select * from first left join second
on first.id = second.id;
quit;
proc sql;
select first.* from first left join second
on first.id = second.id;
quit;
/*Right Join*/
proc sql;
select * from first right join second
on first.id = second.id;
quit;
proc sql;
select first.* from first right join second
on first.id = second.id;
quit;
/*Full Join*/
proc sql;
select * from first full join second
on first.id = second.id;
quit;
/*Advantages of Sql Joins*/
PROC SQL joins do not require sorted or indexed tables
PROC SQL joins do not require that the columns in join expressions have the same name
PROC SQL joins can use comparison operators other than the equal sign (=)
;
proc sql;
create table a1(x num,a char(1));
insert into a1 values(1,'a');
insert into a1 values(2,'b');
insert into a1 values(4,'d');
select * from a1;
quit;
proc sql;
create table a2(x num,b char(1));
insert into a2 values(2,'x');
insert into a2 values(3,'y');
insert into a2 values(5,'y');
select * from a2;
quit;
/*SAS Output*/
data merged;
merge a1 a2;
by x;
run;
proc print;run;
/*Wrong Output*/
proc sql;
select a1.x,a,b from a1 full join a2
on a1.x = a2.x;
quit;
/*Correct Output(Same as SAS Output) - using Coalesce function*/
proc sql;
create table c1 as
select coalesce(a1.x,a2.x) as x,a,b from a1 full join a2
on a1.x = a2.x;
select * from c1;
quit;
/*Query That Contains an In-Line View*/
proc sql;
select sex,
average format=3.0 label='New_Average',
max format=3.0 label='New_Maximum',
late/(late+early) as prob format=5.2 label='Probability'
from (select sex,
	avg(height) as average,
	max(height) as max,
	sum(height > 50) as late,
	sum(height <= 50) as early
from sashelp.class
group by sex)
order by average;
quit;
/*Reflexive joins*/
proc sql;
select distinct e.firstname, e.lastname
from sasuser.flightschedule as a,
	sasuser.staffmaster as b,
	sasuser.payrollmaster as c,
	sasuser.supervisors as d,
	sasuser.staffmaster as e
where a.date=’04mar2000’d and
	a.destination=’CPH’ and
	a.empid=b.empid and
	a.empid=c.empid and
	d.jobcategory=substr(c.jobcode,1,2)
	and d.state=b.state
	and d.empid=e.empid;
quit;
proc sql;
create table discount(destination char(3) label = 'New_Dept',
begindate num format date9.,enddate num format date9.);
insert into discount values('A','4Mar2012'd,'22Apr2001'd);
select * from discount;
quit;
/*Case Expressions*/
proc sql;
create table new as
select * from sashelp.class;
select * from new;
quit;
proc sql;
update new
		set age = age*100
		where substr(name,1,1) = 'A';
update new
		set age = age *200
		where substr(name,1,1) = 'B';
update new
		set age = age *300
		where substr(name,1,1) = 'C';
select * from new;
quit;
proc sql;
update new
	set age=age*100
	where substr(name,1,1)='A';
update new
	set age=age*200
	where substr(name,1,1)='B';
update new
	set age=age*300
	where substr(name,1,1)='C';
select * from new;
quit;
proc sql;
update new
set age=age*
case
	when substr(name,1,1)='J'
	then 100
	when substr(name,1,1)='T'
	then 200
	when substr(name,1,1)='L'
	then 300
	else 1
end;
select * from new;
quit;
proc sql;
update new
set age=age*
case substr(name,1,1)
	when 'J' then 100
	when 'T' then 200
	when 'L' then 300
	else 1
end;
select * from new;
quit;

proc sql;
update new
set age = age*
case
	when age = 12 then 10
	when age = 13 then 20
	when age = 14 then 30
	else 1
end;
select * from new;
quit;
proc sql;
create table one (X num ,A char(1));
insert into one values(1,'a');
insert into one values(1,'a');
insert into one values(1,'b');
insert into one values(2,'c');
insert into one values(3,'v');
insert into one values(3,'v');
insert into one values(4,'e');
insert into one values(6,'g');
select * from one;
quit;
proc sql;
create table two (X num ,B char(1));
insert into two values(1,'x');
insert into two values(2,'y');
insert into two values(3,'z');
insert into two values(3,'v');
insert into two values(5,'w');
select * from two;
quit;

proc sql;
select * from one
except
select * from two;
quit;

proc sql;
select * from one
except all
select * from two;
quit;

proc sql;
select * from one
except corr
select * from two;
quit;

proc sql;
select * from one
intersect
select * from two;
quit;

proc sql;
select * from one
intersect all
select * from two;
quit;

proc sql;
select * from one
intersect corr
select * from two;
quit;

proc sql;
select * from one
union
select * from two;
quit;

proc sql;
select * from one
union all
select * from two;
quit;

proc sql;
select * from one
union corr
select * from two;
quit;

*Suppose you want to list the names of supervisors for the crew on the flight to
Copenhagen on March 4, 2000

Sasuser.Flightschedule - EmpID, Date, Destination
Sasuser.Staffmaste - EmpID, FirstName, LastName, State
Sasuser.Payrollmaster - EmpID, JobCode
Sasuser.Supervisors - EmpID, State, JobCategory
;

proc sql;
select distinct e.firstname, e.lastname
from sasuser.flightschedule as a,
	sasuser.staffmaster as b,
	sasuser.payrollmaster as c,
	sasuser.supervisors as d,
	sasuser.staffmaster as e
where a.date='04mar2000'd and
	a.destination='CPH' and
	a.empid=b.empid and
	a.empid=c.empid and
	d.jobcategory=substr(c.jobcode,1,2)
	and d.state=b.state
	and d.empid=e.empid;
quit;
proc format;
value $sex
		'M' = 'Male'
		'F' = 'Female';
run;
data new;
set sashelp.class;
format sex $sex.;
run;
proc print;run;
proc contents data = new;run;

proc datasets lib=work;
   modify new;
     attrib _all_ label= ' '; 
     attrib _all_ format=;
quit;
proc contents data = new;run;
data one;
input name$ age sex$;
if cmiss(name,age,sex) then delete;
cards;
aaa 12 .
bb . f
cc . .
ddd 45 f
eee 55 m
fff 34 f
;
run;
proc print;
run;
proc means data = one nmiss n;
run;
a1 a2 a3 a4 a5 = a1 - a5
a1 aw d3 r5 f6 = a1 - - f6;
			/*SQL*/
proc sort data = sasuser.payrollmaster out = new;
by jobcode;
run;
proc sort data = sashelp.class out = new;
by age;
run;
proc print data = new;run;
/*ANY*/
proc sql;
select * from new
where age < all (select age from new where age = 14);
quit;
/*ALL*/
proc sql;
select * from new
where dateofbirth < all (select dateofbirth from new where jobcode = 'FA3');
quit;
/*New_Column*/
proc sql;
select name,age,height,weight,
age+height+weight as total
from sashelp.class;
quit;
/*Error Msg*/
proc sql;
select name,age,height,weight,
age+height+weight as total
from sashelp.class
where total < 150;
quit;
/*Correct Output*/
proc sql;
select name,age,height,weight,
age+height+weight as total
from sashelp.class
where calculated total < 150;
/*where age+height+weight < 150*/
quit;
/*Defining a New Variable based on Calculated Variable*/
proc sql;
select name,age,height,weight,
age+height+weight as total,
calculated total/2 as Half
from sashelp.class;
quit;
/*Specifying Titles Labels Formats*/
proc sql;
title 'First Title';
select name label= 'Employee_Name',
	   age label= 'New_Age',
	   sex label= 'New_Sex',
	   height*100 as New_Ht format=dollar9.2
	   from sashelp.class
	   where age > 13
	   order by Sex;
quit;
/*Specifying Character Constant*/
proc sql;
select name as New_Name,
	   sex as New_Sex,
	   'New_definition is :',height*100 as New_Data
	   from sashelp.class;
quit;
proc sql;
title 'First Title';
select name label= 'Employee_Name',
	   age label= 'New_Age',
	   sex label= 'New_Sex',
	   'New_Height is :',height*100 format=dollar9.2 
	   from sashelp.class
	   where age > 13
	   order by Sex;
quit;
/*Specifying one Column as Argument(Avg,Count)*/
proc sql;
select avg(height) as Avg_Ht
from sashelp.class;
quit;
/*Specifying Multiple Columns as Arguments(Mean,n,sum...)*/
proc sql;
select sum(age,height,weight) as total
from sashelp.class;
quit;
/*Using a Summary Function without a group by clause*/
proc sql;
select avg(height) as New_Ht from sashelp.class;
quit;
/*Count*/
proc sql;
/*select count(*) as New_Count from sashelp.class;*/ *Counting all rows;
/*select count(age) as New_age from sashelp.class;*/ *Counting Specific rows;
select count(distinct age) as NW_Age from sashelp.class; *Counting Unique rows;
quit;
/*Subsetting Data by using Noncorrelated Subqueries*/
proc sql;
select sex,avg(height) as New_Ht format = 5.2 from sashelp.class
group by sex
having age > (select age from sashelp.class where name ='Carol');
quit;
proc sql;
select name,age,sex from sashelp.class
where age in (select age from sashelp.class where sex = 'F');
quit;
/*Subsetting Data by using correlated Subqueries*/
proc sql;
select * from sasuser.staffmaster
order by empid;
quit;
proc sql;
select lastname,firstname from sasuser.staffmaster
where 'NA' = (select jobcategory from sasuser.supervisors where staffmaster.empid = supervisors.empid);
quit;
proc sql;
select phonenumber,empid from sasuser.staffmaster
where 'BC' = (select jobcategory from sasuser.supervisors where staffmaster.empid = supervisors.empid);
quit;
/*Inner_Join*/
proc sql;
select lastname,firstname from sasuser.flightattendants inner join sasuser.flightschedule
on flightattendants.empid = flightschedule.empid;
run;
/*Correlated Subquery with Not Exists*/
proc sql;
select lastname,firstname from sasuser.flightattendants
where not exists (select * from sasuser.flightschedule where flightattendants.empid = flightschedule.empid);
quit;
/*Noexec - Statement not executed due to NOEXEC option*/
proc sql noexec;
select * from sashelp.class;
quit;
/*Validate -  PROC SQL statement has valid syntax*/
proc sql;
validate
select * from sashelp.class;
quit;
/*Feedback - To write the expanded list of Columns to the SAS Log*/
proc sql feedback;
select * from sashelp.class;
quit;
proc sql;
/*select * from first cross join second;*/
/*select * from first full join second on first.id = second.id;*/
/*select * from first union join second;*/
select * from first natural join second;
quit;
proc sql;
select *,coalesce(team,0) as New_Value from first;
quit;
/*Sub queries*/
proc sql;
select * from sashelp.class
where age > (select age from sashelp.class where name ="Carol");
quit;
/*Multiple Sub queries*/
proc sql;
select * from first
where id in (select id from second);
/*where id not in (select id from second);*/
quit;

/*INDEX*/
proc sql;
create index height on sashelp.class(height);
quit;
proc sql;
drop index height,age from sashelp.class;
quit;
/*VIEW*/
proc sql;
create view new as 
select sex,count(age) 'New_Age' from sashelp.class
group by sex;
select * from new;
quit;
proc sql;
create view Latest as
select *
from sashelp.class as newreserves
using libname sashelp.class oracle
user=username
pass=password
path='dbms-path';
quit;
proc sql;
drop view new;
quit;
proc sql;
create view abc as 
select * from first;
select * from abc;
quit;
proc sql;
update first 
		set age = 300 where age =13;
select * from first;
quit;
proc SQL;
create table company_events (event_name varchar(100),event_date date );
/*insert into company_events values ( 'Event 1',New('2-DEC-2006','DD-MON-YYYY'));*/
insert into company_events ( event_name, event_date ) values ( 'Event 3',  DATE '2006-10-11' );
select * from company_events;
quit;
proc sql;
create table one as
select * from sashelp.class;
select * from one;
quit;
proc sql inobs =10;
select * from one;
quit;
proc sql outobs = 5;
select * from one;
quit;
proc sql loops = 2;
select * from one;
quit;
proc sql stimer;
select * from one;
quit;
proc sql noprint;
select * from one;
reset print number;
select *  from one;
quit;
proc sql;
reset print number;
select * from one;
quit;
proc sql;
/*describe table DICTIONARY.MEMBERS; *SAS FILES;*/
/*describe table DICTIONARY.OPTIONS; *current settings of SAS system options;*/
/*describe table DICTIONARY.STYLES; *ODS styles;*/
/*describe table DICTIONARY.TABLES; *SAS data files and views;*/
/*describe table DICTIONARY.INDEXES; *indexes that exist for SAS data sets;*/
/*describe table DICTIONARY.VIEWS; *SAS data views;*/
quit;
/*Using DICTIONARY.TABLES*/
proc sql;
title 'All Tables and Views in the SQL Library';
select libname, memname, memtype, nobs
from dictionary.tables
where libname='SQL';
quit;
proc sql;
title 'All Tables that Contain the Country Column';
select libname, memname, name
from dictionary.columns
where name='Country' and libname='SQL';
/*Creating Macro Variables*/
proc sql noprint;
select name,age into :name1,:age1 from sashelp.class;
quit;
%put &name1 &age1;

proc sql noprint;
select max(age) into :age_1 from sashelp.class;
reset print;
title "The Maximum Age is &age_1";
select name,age,sex from sashelp.class;
quit;

/*Creating Multiple Macro Variables*/
proc sql;
select name,age into :name1 - :name4,:age1 - :age4 from sashelp.class;
%put &name1 &age1;
%put &name2 &age2;
%put &name3 &age3;
%put &name4 &age4;

/*Concatenating Values in Macro Variables*/
proc sql noprint inobs=5;
select Name
into :name1 separated by ', ' 
from sashelp.class;
%put &name1;
quit;

proc sql noprint inobs=5;
select Name
/*If you do not want the blanks to be trimmed, then add NOTRIM to the INTO clause*/
into :name1 separated by ', ' notrim 
from sashelp.class;
%put &name1;
quit;

Proc sql;
create table referee (Name char(15), Subject char(15));
/* define the macro */
%macro addref(name,subject);
%local count;
/* are there three referees in the table? */
reset noprint;
select count(*) into :count from referee
where subject="&subject";
%if &count ge 3 %then %do;
reset print;
title "ERROR: &name not inserted for subject -- &subject..";
title2 " There are 3 referees already.";
select * from referee where subject="&subject";
reset noprint;
%end;
%else %do;
insert into referee(name,subject) values("&name","&subject");
%put NOTE: &name has been added for subject -- &subject..;
%end;
%mend;

%addref(Conner,sailing);
%addref(Fay,sailing);
%addref(Einstein,relativity);
%addref(Smythe,sailing);
%addref(Naish,sailing);

Proc sql;
create table employee(name char(10),age num,sex char(10));
%macro add(name,age,sex);
reset noprint;
select name,age,sex into :name,:age,:sex from employee where name = "&name" and age = &age and sex = "&sex";;
insert into employee(name,age,sex) values("&name",&age,"&sex");
reset print;
select * from employee ;
%mend;

%add(a,32,f);
%add(b,22,m);
%add(c,33,f);

proc sql;
select * from employee;
quit;

proc sql noprint;
select * from employee;
%put SQLOBS=*&sqlobs* SQLOOPS=*&sqloops* SQLRC=*&sqlrc*;

ods html body='C:\Athiq\sas\odsout.html';
proc sql outobs=12;
title 'ODS outpue';
select *
from sashelp.class;
ods html close;

/*You want to compute the Sum of the column of values*/
proc sql;
select sex ,sum(height) as New_Ht from sashelp.class
group by sex;
quit;

/*COALESCE*/
proc sql;
create table missing(name char(10),age num);
insert into missing values ('A',10);
insert into missing values ('B',10);
insert into missing(name) values ('C');
insert into missing(age) values (20);
insert into missing(age) values (30);
select * from missing;
quit;

proc sql;
create table missing2(name char(10),age num);
insert into missing2 values ('D',10);
insert into missing2 values ('E',10);
insert into missing2(name) values ('C');
insert into missing2(age) values (50);
select * from missing2;
quit;

proc sql;
select coalesce(name,'NA') as New_Name,coalesce(age,0) as New_Age from missing;
quit;

proc sql;
select coalesce(missing.name,missing2.name) as name,age from missing full join missing2
on missing.age = missing2.age;
quit;

/*Computing Percentages within Subtotals*/
proc sql;
create table survey(state char(10),Answer char(10));
insert into survey values('A','Yes');
insert into survey values('B','Yes');
insert into survey values('C','Yes');
insert into survey values('D','Yes');
insert into survey values('E','Yes');
insert into survey values('F','Yes');
insert into survey values('A','Yes');
insert into survey values('B','Yes');
insert into survey values('C','No');
insert into survey values('D','Yes');
insert into survey values('E','Yes');
insert into survey values('A','No');
insert into survey values('B','No');
insert into survey values('C','No');
insert into survey values('D','No');
insert into survey values('E','No');
select * from survey;
quit;

title;

Proc sql;
select answer,state,count(state) as Answer_count from survey
group by answer,state;
quit;

proc sql;
select survey.Answer,count(state) as Count,calculated count/subtotal as Percent format = percent8.2 from survey,
(select Answer,count(*) as subtotal from survey group by Answer)as survey2
where survey.Answer = survey2.Answer
group by Survey.Answer,state;
quit;

/*Counting Duplicate Rows in a Table*/

proc sql;
select *,count(*) as Count from survey
group by answer,state having count(*) > 1;
quit;

/*Expanding Hierarchial Data in a table*/

proc sql;
create table employees(ID num,Lastname char(10),Firstname char(10),Supervisor num);
insert into employees values(100,'Smith','John',101);
insert into employees values(101,'Smith','Watson',101);
insert into employees values(102,'Walker','John',100);
insert into employees values(103,'Peterson','George',103);
insert into employees values(104,'Smith','Mary',101);
insert into employees values(105,'John','Mary',105);
insert into employees values(106,'Kill','John',105);
insert into employees values(107,'Will','Rock',101);
insert into employees values(108,'Sanu','Kumar',107);
insert into employees values(109,'Kumar','John',101);
insert into employees values(110,'Garcia','Joe',103);
select * from employees;
quit;

Proc sql;
title 'Expanded Employee and Supervisor Data';
select A.id label = 'Employee Id',trim(A.firstname)||' '||trim(A.lastname) label = 'Employee Name',
       B.id label = 'Supervisor Id',trim(B.firstname)||' '||trim(B.lastname) label = 'Supervisor Name'
from employees A,employees B
where A.supervisor = B.id;
quit;

/*Summarizing Data in Multiple Columns*/

proc sql;
create table sales(salesperson char(10),january num,february num ,march num);
insert into sales values('A',125,147,258);
insert into sales values('B',125,147,258);
insert into sales values('C',125,147,258);
insert into sales values('D',125,147,258);
insert into sales values('E',125,147,258);
insert into sales values('AA',125,147,258);
insert into sales values('AB',125,147,258);
insert into sales values('AC',125,147,258);
insert into sales values('AD',125,147,258);
insert into sales values('AG',125,147,258);
select * from sales;
quit;

Proc sql;
title 'Total First Quarter Sales';
select sum(January) as JanTotal,
	   sum(February) as FebTotal,
	   sum(March) as MarTotal,
	   sum(calculated JanTotal,calculated FebTotal,calculated MarTotal) as GrandTotal format = dollar5.
	   from sales;
quit;

/*Creating a Summary Report*/
Proc sql;
create table sales(Product char(10),Invoice_date num,Amount num);
insert into sales values ('A',101241,147);
insert into sales values ('B',101241,258);
insert into sales values ('C',101241,458);
insert into sales values ('A',102241,369);
insert into sales values ('A',102241,159);
insert into sales values ('A',102241,458);
insert into sales values ('A',103241,142);
insert into sales values ('A',103241,784);
insert into sales values ('A',103241,100);
insert into sales values ('A',103241,222);
select * from sales;
quit;

proc sql;
select product,sum(amount) as New_Amount from sales
group by product;
quit;

Proc sql;
select product,
			sum(Jan) label = 'Jan',
			sum(Feb) label = 'Feb',
			sum(Mar) label = 'Mar'
from (select product,
				case
					when substr(Invoice_date,3,1) = '1' then
					amount end as Jan,
				case
					when substr(Invoice_date,3,1) = '2' then
					amount end as Feb,
				case
					when substr(Invoice_date,3,1) = '3' then
					amount end as Mar
		from sales)
group by product;
quit;

proc sql;
select sex,count(sex) as NEw_sex from sashelp.class
group by sex;
quit;

proc sql;
select * from sashelp.class
having age = max(age);
quit;

/*Creating a Customized Sort Order*/
proc sql;
create table chores(project char(10),hours num,season char(10));
insert into chores values('A',10,'SUMMER');
insert into chores values('B',10,'WINTER');
insert into chores values('C',10,'SUMMER');
insert into chores values('D',10,'FALL');
insert into chores values('AB',10,'SUMMER');
insert into chores values('AC',10,'SUMMER');
insert into chores values('AB',10,'SUMMER');
insert into chores values('HA',10,'SRRING');
insert into chores values('JA',10,'FALL');
insert into chores values('PA',10,'SPRING');
insert into chores values('SA',10,'WINTER');
select * from chores;
quit;

proc sql;
select project,hours,season 
		from (select project,hours,season,
				case
					when season = 'SPRING' THEN 1
					when season = 'SUMMER' THEN 2
					when season = 'FALL' THEN 3
					when season = 'WINTER' THEN 4
					else .
					end as sorter
					from chores)
order by sorter;
quit;

/*Conditionally Updating a Table*/

proc sql;
create table incentives(name char(10),department varchar(10),payrate num,gadgets num,whatnots num);
insert into incentives values('A','A1',8,1000,1100);
insert into incentives values('B','A2',3,2000,120);
insert into incentives values('C','A1',7,1500,2400);
insert into incentives values('A','A2',9,700,4320);
insert into incentives values('D','A3',8,400,1560);
insert into incentives values('B','A3',7,4400,1000);
insert into incentives values('C','A4',8,450,440);
insert into incentives values('E','A1',2,2000,450);
insert into incentives values('G','A2',2,1500,1090);
insert into incentives values('C','A1',7,1700,1600);
select * from incentives;
quit;

proc sql;
update incentives
		set payrate = case
						when gadgets < 500 then
						payrate+5
						when gadgets between 500 and 1500 then
						case
							when department in('A1','A2') then 
							payrate + 2
							else payrate + 3
						end
					 else payrate
					 end;
update incentives
		set payrate = case
						when whatnots < 2000 then
						payrate+10
						when whatnots > 2000 then
						case
							when department in('A3','A4') then
							payrate+7
							else payrate+3.5
						end
						else payrate
						end;
select * from incentives;
quit;

proc sql;
create table one(id varchar(10),name char(10),salary num(10),
constraint id primary key(id),
constraint name not null(name),
constraint salary check(salary > 20000));
describe table one;
quit;

proc sql;
insert into one values('A111','A',25000);
insert into one values('A123','B',21000);
insert into one values('A112','A',35000);
insert into one values('A113','C',45000);
select * from one;
quit;

proc sql;
create table two(name char(10),team char(10),
constraint name foreign key(name) references one,
constraint team unique(team));
describe table two;
quit;

proc sql;
insert into two values('A','TAM');
insert into two values('B','TA');
insert into two values('A','T');
insert into two values('C','AM');
select * from two;
quit;

