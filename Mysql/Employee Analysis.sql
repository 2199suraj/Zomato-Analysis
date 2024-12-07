#create database emp_analysis;
use emp_analysis;

#1

create table Employee 
( empno int unique not null, ename varchar(30), Job varchar(30) default("Cleark"), mgr int, hiredate datetime, sal int check(sal>0), comm int, deptno int,
 constraint deptno foreign key (deptno) References Dept (deptno));
 desc Employee;
 
 select * from Employee ;
 
 insert into Employee values 
(7369, "SMITH", "Cleark", 7902, '1890-12-17', 800, null, 20),
(7499, "ALLEN", "SALESMAN", 7698, '1981-02-20', 1600.00, 300.00, 30),
(7521,"WARD", "SALESMAN", 7698, '1981-02-22', 1250.00, 500.00, 30),
(7566, "JONES","MANAGER", 7839, '1981-04-02', 2975.00, null, 20),
(7654, "MARTIN", "SALESMAN", 7698, '1981-09-28', 1250.00, 1400.00, 30),
(7698, "BLAKE","MANAGER", 7839, '1981-05-01', 2850.00, null, 30),
(7782, "CLARK", "MANAGER", 7839, '1981-06-09', 2450.00, null, 10),
(7788, "SCOTT", "ANALYST", 7566, '1987-04-19', 3000.00, null, 20),
(7839, "KING", "PRESIDENT", null, '1981-11-17', 5000.00, null, 10),
(7844, "TURNER", "SALESMAN", 7698, '1981-09-08', 1500.00, 0.00, 30),
(7876, "ADAMS", "CLERK", 7788, '1987-05-23', 1100.00, null, 20),
(7900, "JAMES", "CLERK", 7698, '1981-12-03', 950.00, null, 30),
(7902, "FORD", "ANALYST", 7566, '1981-12-03', 3000.00, null, 20),
(7934, "MILLER", "CLERK", 7782, '1982-01-03', 1300.00, null, 10);

#2
create table Dept (deptno int primary key not null, dname varchar(50), loc varchar(30));
desc Dept;
select * from Dept;

insert into Dept values 
(10, "OPERATIONS", "BOSTON"),
(20, "RESEARCH", "DALLAS"),
(30, "SALES", "CHICAGO"),
(40, "ACCOUNTING", "NEW YORK");

#3
select ename, sal from employee where sal>1000;

#4
select ename, hiredate from  employee where hiredate<19810931;

#5
select ename from employee where ename like "_I%";

#6
select *, sal*0.4 as Allowance, sal*0.1 as P_F, sal-(sal*0.4 + sal*0.1) as Net_Sal from employee; 

#7
select empno, ename, job from employee where mgr is null;

#8
select empno, ename, sal from employee order by sal;

#9
select count(distinct(job)) as Job_Available from employee; 

#10
select job, sum(sal) as TOTAL_PAYABLE_SAL from employee where job="SALESMAN" group by job;

select job, sal from employee where job="SALESMAN";

#11
select job, deptno, avg(sal) Average_Sal from employee group by job, deptno;

#12
select em.ename as Employee_name, em.sal as Emp_Salary, dp.dname as Depart_Name 
from employee em join Dept dp on em.deptno=dp.deptno;

#13
create table grade (grade varchar(10), lowest_sal int, nighest_sal int);
desc grade;

select * from grade;

insert into grade values ("A", 0, 999), ("B", 1000, 1999), ("C", 2000, 2999), ("D", 3000, 3999), ("E", 4000, 5000);
select * from grade;

#14
select ename, sal, grade from employee cross join grade;	

#15
select emp.ename as "Employee_Name", emp.empno as "Emp_ID", emp.mgr as "Mgr_ID", m.ename as "EMP Report to Mgr"
from employee emp LEFT OUTER JOIN employee m ON emp.mgr = m.empno;

#16
select ename, sal, comm, coalesce(sal+ ifnull(comm,0)) as Total_Sal from employee;

#17
select empno, ename, sal from employee where mod(empno, 2) <> 0; #emp with odd empno
select empno, ename, sal from employee where mod(empno, 2) = 0; #emp with even empno

#18
select empno, ename job, sal, deptno, rank() over(partition by deptno order by sal desc) as 'RANK' from employee;
select empno, ename job, sal, deptno, dense_rank() over(partition by deptno order by sal desc) as 'D_RANK' from employee;
select empno, ename job, sal, deptno, row_number() over(partition by deptno order by sal desc) as 'ROW_RANK' from employee;

#19
select ename, sal from employee order by sal desc limit 3;

#20
select ename, sal, deptno from employee where (deptno, sal) in (select deptno, max(sal) from employee group by deptno);