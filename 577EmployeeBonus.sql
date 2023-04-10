/*

https://leetcode.com/problems/employee-bonus/

Table: Employee

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| empId       | int     |
| name        | varchar |
| supervisor  | int     |
| salary      | int     |
+-------------+---------+
empId is the primary key column for this table.
Each row of this table indicates the name and the ID of an employee in addition to their salary and the id of their manager.
 

Table: Bonus

+-------------+------+
| Column Name | Type |
+-------------+------+
| empId       | int  |
| bonus       | int  |
+-------------+------+
empId is the primary key column for this table.
empId is a foreign key to empId from the Employee table.
Each row of this table contains the id of an employee and their respective bonus.
 

Write an SQL query to report the name and bonus amount of each employee with a bonus less than 1000.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Employee table:
+-------+--------+------------+--------+
| empId | name   | supervisor | salary |
+-------+--------+------------+--------+
| 3     | Brad   | null       | 4000   |
| 1     | John   | 3          | 1000   |
| 2     | Dan    | 3          | 2000   |
| 4     | Thomas | 3          | 4000   |
+-------+--------+------------+--------+
Bonus table:
+-------+-------+
| empId | bonus |
+-------+-------+
| 2     | 500   |
| 4     | 2000  |
+-------+-------+
Output: 
+------+-------+
| name | bonus |
+------+-------+
| Brad | null  |
| John | null  |
| Dan  | 500   |
+------+-------+



*/

-- Schema
use leetcode;

Create table If Not Exists 577Employee (
	empId int, 
    name varchar(255), 
    supervisor int, 
    salary int);
    
Create table If Not Exists 577Bonus (
	empId int, 
    bonus int);
    
-- Truncate table Employee
insert into 577Employee (empId, name, supervisor, salary) values ('3', 'Brad', null, '4000');
insert into 577Employee (empId, name, supervisor, salary) values ('1', 'John', '3', '1000');
insert into 577Employee (empId, name, supervisor, salary) values ('2', 'Dan', '3', '2000');
insert into 577Employee (empId, name, supervisor, salary) values ('4', 'Thomas', '3', '4000');
-- Truncate table Bonus
insert into 577Bonus (empId, bonus) values ('2', '500');
insert into 577Bonus (empId, bonus) values ('4', '2000');


-- Solution

-- Write your MySQL query statement below

-- select id
-- from (
-- select id,recorddate,temperature,
--         lag(temperature,1) over(order by recorddate) as prev_temp,
--         lag(recorddate,1) over(order by recorddate) as prev_record_date
-- from weather) as a
-- where temperature > prev_temp 
--         and (recorddate-prev_record_date)=1 
--         and datediff(prev_record_date,prev_record_date) = 0


select
    curr_wea.id 
from
    Weather as curr_wea
    join Weather as prev_wea
    on curr_wea.recordDate = DATE_ADD(prev_wea.recordDate, INTERVAL 1 DAY)
where
    curr_wea.temperature > prev_wea.temperature;



--     select e.*,bonus
-- from 577employee as e
-- left join (select *,
-- 			case when bonus is null then 0 else bonus end as bonus_flag
--             from 577bonus) as b on e.empId = b.empId
-- where bonus_flag < 1000;

select e.name,
        bonus
from employee as e
left join (select empId, bonus
            from bonus  ) as b on e.empId = b.empId
where ifnull(bonus,0) < 1000;

