Creation of table;
Inserting values in it;
Alter table - Add,Modify and drop;
Update and delete;
Where,Having,Group by and Order by;
Distinct;
Joins - Inner,Left,Right and Full Join;
Union;
Proc Import;

proc sql;
select * from nn
order by sex desc;
quit;
		/*Selection*/
proc sql;
/*select * from sashelp.class;*/
select name,age,height from sashelp.class;
quit;
		/*Creation of Table*/
proc sql;
/*create table abc (name char(10),age num,sex char(10));*/
/*create table bbb like sashelp.class;*/
create table ccc as
	select name,age,weight from sashelp.class;
describe table ccc;
quit;
		/*Inserting Values*/
proc sql;
/*insert into abc values('AAA',22,'M');*/
/*insert into abc(name,age) values('CCC',24);*/
/*insert into abc */
/*		select name,age,sex from sashelp.class;*/
insert into abc set name = 'Athiq',age = 25,sex = 'M';
select * from abc;
quit;
		/*Altering Table*/
/*	Add,Modify and Drop*/
proc sql;
alter table abc
/*	add height num,weight num;*/
/*	modify name char(15),sex char (15);*/
	drop height,weight;
describe table abc;
quit;
		/*Update*/
proc sql;
update abc
	set name = upcase(name),
		 age = age + 100;	
select * from abc;
quit;
		/*Conditions*/
proc sql;
select * from nn;
quit;
proc sql;
select * from nn
where age = 14 and sex ='F';
quit;
proc sql;
select sex,sum(age) as SS from nn
group by sex;
quit;
proc sql;
select * from nn
order by sex desc;
quit;
proc sql;
select * from nn
having age = max(age);
quit;
proc sql;
select * from nn
having age >(select age from nn where name = 'Carol');
quit;

proc sql;
select count(*) as nn from three;
quit;

proc sql;
select coalesce (part1.id,part2.id) as id,name,sex 
from part1 full join part2 on part1.id = part2.id;
quit;

proc sql;
create table player_list as
select * from part1 union
select * from part1a;
select * from player_list;
quit;

proc import datafile = '<path>'
			out = filename
			dbms = excel
			replace;
			sheet = ;
			range =	;
			getnames = ;
