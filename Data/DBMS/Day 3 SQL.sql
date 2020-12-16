-------------------------------------------Day 3----------------------------------------------------

					joins

equi										non equi

natural join


natural joins
table can have more than one same columnso it will join based on both columns value
in natural if two tables have same column name and data type then based on common values they are joined
no need to write any condition
you ccant restrict natural join so it is called natural

Natural Join joins two tables based on same attribute name and datatypes. 
The resulting table will contain all the attributes of both the table but keep only one copy of each common column.




inner join

Inner Join joins two table on the basis of the column which is explicitly specified in the ON clause. 
The resulting table will contain all the attributes from both the tables including common column also.

reference
https://www.geeksforgeeks.org/difference-between-natural-join-and-inner-join-in-sql/




select * from employees
natural join
departments 

select * from employees e
inner join
departments d on e.manager_id=d.manager_id

select * from employees e
inner join
departments d on e.manager_id>=d.mgr_id

select * from employees e
join
departments d using(manager_id,department_id)


SELECT job_title, first_name || ' ' || last_name AS Employee_name, 
    max_salary-salary AS salary_difference 
    FROM hr.employees 
        NATURAL JOIN hr.jobs;

select * from jobs

select job_title,first_name||' '||last_name,max_salary,salary,max_salary-salary as Dff
from employees emp, jobs job 
where emp.job_id=job.job_id
--from and join ->where->group by->having->select->distinct->order by

-- Equi join  , Non-equi join
-- Natural join : is an equi join, all common attributes
select * from hr.employees
natural join
hr.departments -- join condition include all common attributes of both table

select * from hr.employees
natural join
hr.departments
where employee_id>200

select * from hr.employees
join
hr.departments -- using and on 

select * from hr.employees e
join
hr.departments d on e.manager_id=d.mgr_id 

select * from hr.employees e
join
hr.departments d using(manager_id,)

select * from hr.employees e
join
hr.departments d on e.department_id=d.department_id
               --and employee_id>200
                and e.manager_id=d.manager_id
--where employee_id>200

select * from hr.employees e
join
hr.departments d using(department_id)
where employee_id>200

--real time inner join example
-- retrieve all customers who has credit cards
--Customer (Customer_id,name,...)
--CreditCard (CreditNo  Type customer_id)

Customer:
customer_id customer_name 
   1          John
   2          Mathew
   3          Leena
   
CreditCard
CreditNo   Type    customer_id
   1001    Gold     1
   1002    Plat     2
DebitCard
  DebitNo    Type   customer_id
  



SELECT cust_no, cust_name, cred.cred_num 
FROM customer c
INNER JOIN 
credit_cards cred
USING(cust_no)
-- list of customers who do not have credit cards
SELECT cust.customer_name
FROM customer cust
JOIN cerdit_card cerdit 
on cust.customer_id != cerdit.customer_id;

-- 

--Display job title and average salary of employees
select job_title,avg(salary)
from employees
natural join
jobs group by job_title

-- Display job title, department name, employee last name,
--starting date for all jobs from 2000 to 2005.
SELECT job_title, department_name, last_name, hire_date 
from hr.employees e Natural join hr.departments d
inner join
hr.jobs j on e.job_id = j.job_id
WHERE to_char(hire_date,'YYYY') between '2000' and '2005'

SELECT JOB_TITLE, DEPARTMENT_NAME, LAST_NAME, START_DATE 
FROM JOB_HISTORY JOIN JOBS USING (JOB_ID) JOIN DEPARTMENTS 
USING (DEPARTMENT_ID) JOIN  EMPLOYEES USING (EMPLOYEE_ID) 
WHERE TO_CHAR(START_DATE,'YYYY') BETWEEN 2000 AND 2005


select * from job_history

-- Outer joins ( left, right and full)
--left outer join: displays all records of left(first) and matching records
-- of right table(second,....)

select employee_id,first_name,jh.job_id,start_date
from employees e
left outer join
job_history jh using(employee_id)

select employee_id,first_name,jh.job_id,start_date
from employees e
right outer join
job_history jh using(employee_id)

select * from job_history
-- 102	13-01-01	24-07-06	IT_PROG	60
select * from employees where employee_id=102

select employee_id,first_name,d.department_id,department_name
from employees e
left outer join 
departments d on e.department_id=d.department_id

--
select candidate_id,name,employee_id 
from candidate c
left outer join employees e
on c.candidate_id=e.employee_id
-- list of employee who are allocated and not allocated any department
-- and list of department which has employees and don't have employees
select employee_id,first_name,d.department_id,department_name
from employees e
full outer join 
departments d on e.department_id=d.department_id

select employee_id,first_name,d.department_id,department_name
from employees e
left outer join 
departments d on e.department_id=d.department_id

select * from employees where department_id=220

-- Self join 
select emp.employee_id,emp.first_name,emp.manager_id,
mgr.first_name
from employees emp
join
employees mgr 
on emp.manager_id=mgr.employee_id

-- dispay employees who have joined on the same date
select count(employee_id),hire_date from employees
group by hire_date having count(employee_id)>1

display employees who have joined on the same date
-- employee_id1  employee_id2 hire_date 

select emp.employee_id,emp.first_name,sam.employee_id,
sam.first_name,sam.hire_date
from hr.employees emp join hr.employees sam
on emp.hire_date=sam.hire_date
where emp.employee_id > sam.employee_id

select employee_id,first_name,hire_date
from employees

Display employee name if the employee joined before his manager.

SELECT e.first_name as employee_name,h.first_name as manager_name,
e.hire_date,h.hire_date from hr.employees e 
join hr.employees h on e.manager_id=h.employee_id 
and e.hire_date < h.hire_date;

SELECT emp.first_name || ' ' || emp.last_name AS "Full Name" ,
emp.hire_date , man.first_name
FROM hr.employees emp
JOIN hr.employees man ON emp.manager_id = man.employee_id 
AND emp.hire_date < man.hire_date
--ORDER BY emp.employee_id;


--Subqueries: A query written inside another query.
-- display all employees whose salary is higher than average salary of all employees.
select employee_id,salary from employees where salary>(select avg(salary) from employees)

--display all employees whose salary is higher than max salary of all department 30.
select employee_id,salary from employees where salary>
        (select max(salary) from employees where department_id=30)

--display all employees whose salary is higher than max salary of
-- those department_id 10,20,30,40,50
select employee_id,salary from employees where salary>
        (select max(salary) from employees where department_id
                  in(10,20,30,40)
                  --between 10 and 40)
--display first_name,salary of employee who work in the same department
-- as 'Pat'

select employee_id,first_name from employees
  where department_id=(select department_id from employees where first_name='Pat')

-- display all employee who work in Seattle.
Select employee_id, first_name From hr.employees Where department_id IN
(Select department_id From hr.departments Where location_id = 
(Select location_id From hr.locations Where city = 'Seattle'));

Display details of departments managed by ‘Smith’.
select * from hr.departments where manager_id IN(
select employee_id from hr.employees where last_name='Smith');

-- in any all
-- if(salary>8000 and salary>6000 and salary>9000
--if(salary>8000 or salary>6000 or salary>9000
--if(salary=8000 or salary=6000 or salary=9000
select * from employees where salary >all(6000,8000,9000)
select * from employees where salary >any(6000,8000,9000)
select * from employees where salary =any(6000,8000,9000)
select * from employees where salary =all(6000,8000,9000)
select * from employees where salary <all(6000,8000,9000) -- 7000
select salary from employees where salary <>all(6000,8000,9000) -- 7000
select salary from employees where salary =any(6000,8000,9000) -- 7000
select salary from employees where salary <>all(6000,8000,9000) -- 7000
-- display employee whose salary is less than any salary of department
-- number 30
select employee_id,salary from employees where salary<any
(select salary from employees where department_id=30)

select employee_id,salary from employees where salary>all
(select salary from employees where department_id=30)

--Correlated subqueries
--display employee details(id,firstname) whose salary is
--greater than average salary of his/her department

select employee_id,first_name,department_id,salary from employees emp  -- current row
where salary>(select avg(salary) from employees where
department_id=emp.department_id)

select avg(salary) from employees where department_id=100

--display top 5 highest salary in the employee table
select employee_id,salary from 
(select employee_id,salary from employees order by salary desc)
where rownum<=5

-- display the 2nd highest salary 

select employee_id,salary from employees where 
salary<(select max(salary) from employees)
and rownum=1

Select  Max(salary) from hr.employees 
where salary <> (Select max(salary) from hr.employees);

select max(salary) from hr.employees 
where salary < (select max(salary) from hr.employees)

--find third highest salary
SELECT MIN(salary)
FROM (
SELECT DISTINCT salary 
FROM hr.employees
ORDER BY salary DESC)
WHERE ROWNUM<=3;
24000,17000,14000,13500,13000
select employee_id,salary 
from employees emp
where  5 = (select count( distinct salary ) 
            from employees
            where  salary > emp.salary)
            
select count( distinct salary ) 
            from employees
            where  salary >14000

select salary from employees order by salary desc
-------------------------------------------Day 4-------------------------------------------------
--DDL: Data Definition Language:  create,alter,drop,truncate,rename
--DDL is used to define or modify the structure of the database objects(table,view,procedures,functions..)
-- table constraints(entity integrity,referential integrity,domain constraints,default...)
--Schema for banking application(Customer,Account,Transactions)
--entity integrity(PK): each object in this world are unique, hence they should be uniquely identified
--candidate key: columns which are eligble to become a PK
--alternate key: post PK is declared, remaining candidate keys are considered alternate keys.

create table customers
(
customer_id number(6) primary key,   -- number // autogenerated column --entity integrity
customer_name varchar2(100) not null,  --char(50),varchar,varchar2 -- not null constraint
customer_age number check(customer_age>18), -- domain integrity constraint
customer_phone varchar2(10) check(length(customer_phone)=10),     -- candidate key
customer_city varchar2(100) default 'Mumbai'    --default constraint
)

create sequence cust_seq start with 1001 increment by 1

insert into customers values(cust_seq.nextval,'John',23,'8987675849','Mumbai')
insert into customers values(cust_seq.nextval,'Hudson',21,'7575675849','London')
--partial insert
insert into customers(customer_id,customer_name,customer_age,customer_phone)
    values(cust_seq.nextval,'Mike',22,'7684849393')

insert all 
into customers(customer_id,customer_name,customer_age,customer_phone)
  values(1005,'Peter',24,'7684867545')
into customers(customer_id,customer_name,customer_age,customer_phone,customer_city)
  values(1006,'Mark',22,'7684867545','Paris')
into customers(customer_id,customer_name,customer_age,customer_phone,customer_city)
  values(1007,'Alisa',23,'7684867545','NY')
into customers(customer_id,customer_name,customer_age,customer_phone,customer_city)
  values(1008,'James',21,'7684867545','CA')
select * from dual

insert into customers
    values(cust_seq.nextval,'Andrew',24,'6767849393','Venice')
    
create table accounts
(
    account_no number(10),
    account_type varchar2(20), --check(account_type in('current','savings'))  -- current or saving account
    balance number(10,2),                       -- 10000000.00
    customer_id number(6) references customers(customer_id), --referential integrity,
    constraint acc_pk  primary key (account_no) --constraint <constraint-name> <constraint-type> <column-name>
)
create sequence acc_seq start with 2001 increment by 1
-- Alter: modify the structure 
alter table accounts add constraint acc_type_chk check(account_type in('current','savings'))

alter table accounts modify account_type varchar2(30)
alter table accounts modify balance number(12,2) not null

create table transactions
(
    transaction_id number(30),      --primary key
    transaction_date date default sysdate,
    transaction_type varchar2(50) check(transaction_type in('debit','credit')),
    amount number(12,2) not null,
    acc_no number(10)                --foreign key
)
ALTER TABLE transactions ADD CONSTRAINT trn_pk PRIMARY KEY(transaction_id);

ALTER TABLE transactions ADD CONSTRAINT trn_frk FOREIGN KEY (acc_no) REFERENCES accounts(account_no);

select * from  SYS.user_constraints

select constraint_name,constraint_type from sys.user_constraints 
where lower(table_name)='transactions'

alter table transactions drop constraint trn_frk
alter table transactions drop column amount
alter table transactions add amount number(12,2) not null

rename transactions to trn
rename trn to transactions
desc transactions
select * from customers
desc transactions
------- Anomalies -> insert,update and delete
select * from customers
select * from accounts
select * from transactions
insert into accounts values(acc_seq.nextval,'savings',10000,1008)
create sequence tx_seq start with 3000 increment by 1
insert into transactions(TRANSACTION_ID,TRANSACTION_TYPE,ACC_NO,AMOUNT) 
values(tx_seq.nextval,'debit',2001,5000)

delete from accounts where account_no=2001 -- error
--1. on delete/update cascade : it will perform the same(delete/update) operation in the child table
-- we can apply this while declaring foreign key constraint
--2. on delete/update null : it will perform the same(delete/update) operation in the child table
-- we can apply this while declaring foreign key constraint

select constraint_name,constraint_type from sys.user_constraints 
where lower(table_name)='transactions'


ALTER TABLE transactions drop CONSTRAINT trn_frk

alter table transactions add constraint trn_frk FOREIGN KEY (acc_no)
REFERENCES accounts(account_no) on delete cascade

delete from accounts where account_no=2001 -- error
select * from transactions

ALTER TABLE transactions drop CONSTRAINT trn_frk

alter table transactions add constraint trn_frk FOREIGN KEY (acc_no)
REFERENCES accounts(account_no) on delete set null


insert into accounts values(acc_seq.nextval,'savings',10000,1008)
select * from accounts

insert into transactions(TRANSACTION_ID,TRANSACTION_TYPE,ACC_NO,AMOUNT) 
values(tx_seq.nextval,'debit',2002,5000)

select * from transactions
delete accounts where account_no=2002

drop table customers

-- truncate ->DDL : is used to delete rows from the table
-- in delete, we can have 'where' clause to delete specific rows
-- but in truncate, it will delete all the rows.
-- if used truncate, operation cannot be rolled back
-- truncate, it cleans up the memory space
-- truncate, drops the table and re-create it 
-- sequence, in case of truncate, re-initializes the sequence.
select * from customers

delete customers
select * from customers
insert into customers values(cust_seq.nextval,'John',23,'8987675849','Mumbai')

truncate table customers
drop table transactions
drop table accounts
-- 
DDL,DML,DQL, DCL(Data control language), TCL(Transaction control Language)

---------------------------------------PL/SQL-----------------------------------------------
-- Programming in Oracle
-- declare variables,constructs(if,switch,looping statement,break , contiue
-- PL/SQL blocks(Program: set of instructions): blocks are compiled and executed.
-- PL/SQL blocks: 1. anonymous block(compiled and executed again and again),
--                2. Named blocks(compiled once and executed many times)

-- anonymous block
declare       --optional

begin

exeception    ----- optional 

end;
------------------
set SERVEROUTPUT ON
begin
    dbms_output.put_line('Hello PL/SQL');
end;
-------------
begin
    dbms_output.put_line(10+20);
end;

declare
    num1 number(10):=10;
    num2 number(10):=30;
begin
    dbms_output.put_line('Sum '||(num1+num2));
end;

----------------
declare
    num1 number(10);
    --num2 number(10):=20;
    num2 number(10)default 20;
    num3 constant number(10):=50;
begin
    num1:=10;
    --num2:=70;
    num3:=100
    dbms_output.put_line('Sum '||(num1+num2+num3));
end;

------------------------------------------------
create table emps as select * from employees
select * from emps
--------------------------------------
declare 
    emp_id number(10);
    emp_fname varchar2(50);
    emp_lname varchar2(50);
    emp_salary number(12,2);
begin
    --emp_id:=100;
    select first_name,last_name,salary into emp_fname,emp_lname,emp_salary from emps where employee_id=100;
    DBMS_OUTPUT.PUT_LINE('Hi '||emp_fname||' '||emp_lname||', Your salary is: '||emp_salary);
end;
-----
declare 
    emp_id emps.employee_id%type;
    emp_fname emps.first_name%type;
    emp_lname emps.last_name%type;
    emp_salary emps.salary%type;
begin
    emp_id:=&eid;
    --emp_id:=:eid;
    select first_name,last_name,salary into emp_fname,emp_lname,emp_salary 
    from emps where employee_id=emp_id;
    DBMS_OUTPUT.PUT_LINE('Hi '||emp_fname||' '||emp_lname||', Your salary is: '||emp_salary);
end;

-- rowtype
select * from emps
set serveroutput on
declare
    emp_rec emps%rowtype;
    emp_fname emps.first_name%type;
begin
    emp_fname:='&first_name';
    select * into emp_rec from emps where first_name=emp_fname;
    DBMS_OUTPUT.PUT_LINE(emp_rec.employee_id||' '||emp_rec.first_name||' '||emp_rec.salary);
end;
select * from emps where first_name='Neena';

---------constructs : if , if else , if elsif else 

declare
    emp_rec emps%rowtype;
    emp_fname emps.first_name%type;
begin
    emp_fname:='&first_name';
    select * into emp_rec from emps where first_name=emp_fname;
    if emp_rec.commission_pct is null then
        dbms_output.put_line('Sorry, you don''t have commission');
    else
        dbms_output.put_line('Congratulation,you have commission');
    end if;
end;
select * from emps where first_name='Neena'
----------------
declare
    emp_rec emps%rowtype;
    emp_fname emps.first_name%type;
begin
    emp_fname:='&first_name';
    select * into emp_rec from emps where first_name=emp_fname;
    if emp_rec.salary>15000 then
        dbms_output.put_line('High Salary');
    elsif emp_rec.salary>10000 then
        dbms_output.put_line('Average Salary');
    else
        dbms_output.put_line('Low Salary');
    end if;
end;
-- Write PL/SQL block to calculate total annual salary of an based including commission
select * from emps
-- if no commission: salary*12
-- if commission: (salary+salary*commission_pct)*12
declare
    emp_rec emps%rowtype;
    emp_fname emps.first_name%type;
    emp_sal emps.salary%type;
begin
    emp_fname := '&first_name';
    select * into emp_rec from emps where first_name = emp_fname;
    if emp_rec.commission_pct is null then
        emp_sal:=emp_rec.salary*12;
    else
        emp_sal:=(emp_rec.commission_pct+1)*emp_rec.salary*12;
    end if;
    DBMS_OUTPUT.PUT_LINE('Annual Salary= '||emp_sal);
end;

--Simple Case

select employee_id,first_name,job_id,
    (case job_id
        when 'AD_PRES' then 'Additional President'
        when 'AD_VP' then 'Additional Vice President'
        when 'IT_PROG' then 'Programmer'
        else 'N/A'
    end) Job_Details
from emps where employee_id<110
select * from emps
select * from departments
-- 10	Administration
--20	Marketing
--30	Purchasing
--40	Human Resources
-- else Unknown
--display employee_id,department_id and department_name(select case)
select employee_id,department_id,
    (case department_id
        when 10 then 'Administration'
        when 20 then 'Marketing'
        when 30 then 'Purchasing'
        when 40 then 'Human Resources'
        else 'Unknown'
    end) Department_Name
from emps WHERE department_id IN (10, 20, 30, 40, 100)

--Search Case
select employee_id,first_name,salary,
    (case 
        when salary>15000 then 'High Salary'
        when salary>10000 then 'Average Salary'
        when salary<=10000 then 'Low Salary'
    end) Grade
from emps order by salary desc

-----
declare 
    sal_grade varchar2(50);
    sal emps.salary%type;
begin
    select salary into sal from emps where employee_id=&eid;
    sal_grade:=case 
        when sal>15000 then 'High'
        when sal>10000 then 'Average'
        when sal<=10000 then 'Low'
    end;
    DBMS_OUTPUT.PUT_LINE('You salary '||sal||' comes under '||sal_grade||' grade');
end;

-- ierations: For, while, loop
begin
    for i in 1..10 loop
        dbms_output.put_line(i);
    end loop;
end;

declare 
    i number:=1;
begin
    while i<=10 loop
        dbms_output.put_line(i);
        i:=i+1;
    end loop;
end;

declare 
    i number:=1;
begin
    while true loop
        dbms_output.put_line(i||' ');
        i:=i+1;
        if i>15 then
            exit;
        end if;
    end loop;
end;
-- to find the sum upto n terms
declare 
    last_num number(3):=&n;
    res number(6):=0;
    i number(3):=1;
begin
    loop
        res:=res+i;
        i:=i+1;
        if i>last_num then
            exit;
        end if;
    end loop;
    DBMS_OUTPUT.PUT_LINE('Sum= '||res);
end;

--
declare 
    last_num number(3):=&n;
    res number(6):=0;
    i number(3):=1;
begin
    loop
        res:=res+i;
        i:=i+1;
        if i>last_num then
            goto endstatement;
        end if;
    DBMS_OUTPUT.PUT_LINE('Sum= '||res);    
    end loop;
    DBMS_OUTPUT.PUT_LINE('Final Sum= '||res);  
    DBMS_OUTPUT.PUT_LINE('XYZ');
    --<<endstatement>>
    --null;
    --<<statement1>>
    DBMS_OUTPUT.PUT_LINE('Final Sum= '||res);    
end;
---------------

declare
    res number(3):=0;
    nm number(2):=&num;
begin
    <<startstatement>>
    res:=res+nm;
    nm:=nm-1;
    if nm>0 then
        goto startstatement;
    else
        goto endstatement;
    end if;
    <<endstatement>>
    DBMS_OUTPUT.PUT_LINE('Sum= '||res);
end;

------------- Exception Handling-------------------
declare
    emp_rec emps%rowtype;
    emp_fname emps.first_name%type;
    emp_sal emps.salary%type;
    emp_lastname char(3);
begin
    emp_fname := '&first_name';
    select * into emp_rec from emps where first_name = emp_fname;
    --select last_name into emp_lastname from emps where first_name = emp_fname;
    if emp_rec.commission_pct is null then
        emp_sal:=emp_rec.salary*12;
    else
        emp_sal:=(emp_rec.commission_pct+1)*emp_rec.salary*12;
    end if;
    DBMS_OUTPUT.PUT_LINE('Annual Salary= '||emp_sal);
    exception 
        when TOO_MANY_ROWS then dbms_output.put_line('Multiple records found.');
        when NO_DATA_FOUND then dbms_output.put_line('Employee not found');
        --when others then dbms_output.put_line('Unknown exception.');
    DBMS_OUTPUT.PUT_LINE('End of Block');
end;

--------------------------- Cursors----------------------------
-- list of the employees who are drawing salary less than a specific amount.
-- implicit cursor and explicit cursors

declare 
    emp_sal emps.salary%type:=&sal;
begin
    for emp_cur in (select * from emps where salary<emp_sal) 
    loop
        dbms_output.put_line(emp_cur.employee_id||' '||emp_cur.salary);        
    end loop;
end;

-- display employee_id,salary and commission_pct of all employees who do not earn commission

begin
    for emp_cur in (select * from emps where commission_pct is null)
    loop
        dbms_output.put_line(emp_cur.employee_id||' '||emp_cur.salary||' '||nvl(emp_cur.commission_pct,0));
    end loop;
end;

---
declare 
    cursor emp_cur is select * from emps where department_id=&dept;
    emp_rec emps%rowtype;
begin
    open emp_cur;
    loop
        fetch emp_cur into emp_rec;
        exit when emp_cur%notfound;
        DBMS_OUTPUT.PUT_LINE(emp_rec.employee_id||' '||emp_rec.first_name);
    end loop;
    DBMS_OUTPUT.PUT_LINE('No. of records: '||emp_cur%rowcount);
    close emp_cur;
end;

-- write a cursor to update the commission based of below condition
-- if no commission and salary is less than 5000, then allocate 3% commission.
-- if no commission and salary is less than 10000, then allocate 2% commission
-- if commission and salary is less than 5000, then increment commission by 1%.
-- if commssion and salary greater than and equals to 5000, no record updation.

declare 
    cursor emp_cur is select * from emps for update;
    emp_rec emps%rowtype;
    new_comm emps.commission_pct%type;
begin
    open emp_cur;
    loop
        fetch emp_cur into emp_rec;
        exit when emp_cur%notfound;
        if emp_rec.commission_pct is null and emp_rec.salary<5000 then
            new_comm:=0.03;
        elsif emp_rec.commission_pct is null and emp_rec.salary<10000 then
            new_comm:=0.02;
        elsif emp_rec.commission_pct is not null and emp_rec.salary<5000 then
            new_comm:=emp_rec.commission_pct+0.01;
        else
            new_comm:=0;
        end if;
        update emps set commission_pct=new_comm where current of emp_cur;
    end loop;
    close emp_cur;
end;

select * from emps where salary<5000
---------------
DECLARE 
    cursor emp_cur IS SELECT * FROM emp FOR UPDATE; 
    new_comm emp.commission_pct%type;
BEGIN
    FOR emp_curr IN emp_cur 
    LOOP
        IF emp_curr.commission_pct IS NULL AND emp_curr.salary < 5000
            THEN new_comm := 0.03;
        ELSIF emp_curr.commission_pct IS NULL AND emp_curr.salary < 10000
            THEN new_comm := 0.02;
        ELSIF emp_curr.commission_pct IS NOT NULL AND emp_curr.salary < 5000
            THEN new_comm := NVL(emp_curr.commission_pct, 0) + 0.01;
        ELSE
            new_comm := NVL(emp_curr.commission_pct, 0) + 0;
        END IF;
    UPDATE emp SET commission_pct = new_comm WHERE CURRENT OF emp_cur;
    END LOOP;
END;

----------------- implicit cursor----------------------------------

declare 
    
begin
    update emps set salary=salary+100 where department_id=100;
    dbms_output.put_line('No. of rows affected: '||sql%rowcount);
end;

declare 
    emp_rec emps%rowtype;
begin
    select * into emp_rec from emps where employee_id=10098;
      if sql%found then
        dbms_output.put_line('record found');
    end if;
    exception
        when NO_DATA_FOUND then 
        if sql%notfound then
            dbms_output.put_line('record not found');
        end if;
end;

select count(*) from emps where department_id=100


-------------------- parameterized cursor----------------------------

declare 
    cursor emp_cur(dep_id in emps.department_id%type) 
    is 
    select * from emps where department_id=dep_id;
    emp_rec emps%rowtype;
begin
    open emp_cur(100);
    --open emp_cur(&d_id);
    loop
        fetch emp_cur into emp_rec;
        exit when emp_cur%notfound;
        dbms_output.put_line(emp_rec.employee_id||' '||emp_rec.department_id);
    end loop;
    close emp_cur;
end;
-------------------------------------------Named Blocks( Procedure,Functions,Triggers,packages)
drop  procedure p1

create or replace procedure p1
is
begin
    dbms_output.put_line('My Procedure called');
end;

exec p1

-- procedure: are basically used execute DML operations. e.g: increment the salary of employees
-- functions: are basically used for calculation or processing and must always return value. e.g add,lower

select lower('SIMANT') from dual

create procedure addition(num1 in number,num2 in number)
is
    res number(8):=0;
begin
    res:=num1+num2;
    DBMS_OUTPUT.PUT_LINE('Sum= '||res);
end;

create or replace procedure addition(num1 in number,num2 in number,res out number)
is
begin
    res:=num1+num2;
end;

declare 
r number(8):=0;
begin
addition(10,20,r);
dbms_output.put_line('Sum= '||r);
end;

-- finding sqaure of a number
create or replace procedure findSquare(side in out number)
as
begin
    side:=side*side;
end;

declare 
    s number(5,2):=&a;
begin
    findsquare(s);
    DBMS_OUTPUT.PUT_LINE('Square= '||s);
end;


create or replace procedure incr_salary(dept_id in number,pct in number,rec out number)
as
begin
    update emps set salary=salary+salary*pct where department_id=dept_id;
    rec:=sql%rowcount;
end;

declare
    rec number(5);
begin
    incr_salary(90,0.1,rec);
    DBMS_OUTPUT.PUT_LINE(rec||' employees salary incremented');
end;

create or replace procedure incr_salary_by_employee(empsal in number,pct in number)
as
    cursor emp_cur(esal in emps.salary%type) is select * from emps where salary<esal
    for update;
    emp_rec emps%rowtype;
begin
    open emp_cur(empsal);
    loop
        fetch emp_cur into emp_rec;
        exit when emp_cur%notfound;
        update emps set salary=salary+salary*pct where current of emp_cur;
    end loop;
    close emp_cur;
end;
exec incr_salary_by_employee(3000,0.1);
select * from emps where employee_id=190

-- function--------------

create or replace function welcome(name in varchar2)
return varchar2
is
begin
    return 'Welcome '||name;
end;

select welcome('Simant') from dual

begin
dbms_output.put_line(welcome('Simant'));
end;


-- write a function to return salary of an employee
-- write a function to return the sum of salary of a department

create or replace function find_salary(emp_id in number)
return number
as
    sal number(10,2);
begin
    select salary into sal from emps where employee_id=emp_id;
    return sal;
end;

select find_salary(100) from dual

create or replace function sum_of_salary(dept_id in number)
return number
as
    sumsal number(10,2);
begin
    select sum(salary) into sumsal from emps where department_id=dept_id;
    return sumsal;
end;

select sum_of_salary(90) from dual

-- assignment_plsql_name

--------------------Trigger-------------------------------
create or replace trigger trg_update_emps
after update on emps
--after update or insert or delete on emps
for each row
begin
    dbms_output.put_line('Row updated');
end;

update emps set salary=salary+200 where department_id in(100,101,102,103)

delete emps where department_id=90

-------------
create or replace trigger trg_update_emps
after update on emps
--after update or insert or delete on emps
for each row
begin
    --dbms_output.put_line('Row updated');
    dbms_output.put_line(:old.salary||' is updated to '||:new.salary);
    insert into old_salary values(:old.employee_id,:old.salary);
end;

create table old_salary as select employee_id,salary from emps;
select * from old_salary
truncate table old_salary
update emps set salary=salary+200 where department_id in(100,101,102,103)
select * from emps where employee_id=109

-----------
CREATE TABLE deleted_emps AS SELECT employee_id , first_name, last_name FROM emps;
TRUNCATE TABLE deleted_emps;

CREATE OR REPLACE TRIGGER trg_lef_emp
AFTER DELETE ON emps
FOR EACH ROW
BEGIN
    INSERT INTO deleted_emps VALUES(:old.employee_id,:old.first_name,:old.last_name);
END;
DELETE emps WHERE employee_id = 141;
SELECT * FROM emps;
SELECT * FROM deleted_emps;

--------------------
-- write a trigger to get fired only when salary is updated
-- and check if the increment amount is more than 50% of current salary then
-- we do not allow to update the salary

create or replace trigger udate_salary
before update of salary on emps
for each row
declare 
    cur_sal number(12,2);
    new_sal number(12,2);
begin
    cur_sal:=:old.salary;
    new_sal:=:new.salary;
    if new_sal>(cur_sal+cur_sal*0.5) then
        raise_application_error(-20100,'Cannot update salary');
    else
        dbms_output.put_line('Salary updated successfully');
    end if;
end;
select * from emps where employee_id=105 select 4800+4800*0.5 from dual
update emps set salary=6500 where employee_id=105




































































































































