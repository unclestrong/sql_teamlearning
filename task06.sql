SELECT d.name as Department,e.name as Employee,e.salary as Salary
FROM department as d left outer join employee as e
ON d.id = e.departmentid
WHERE e.Salary IN (
SELECT MAX(Salary) 
FROM Employee AS Em
WHERE Em.DepartmentId=e.DepartmentId);

select p.id ,p.student
from(
		select id-1 as id,student from seat where mod(id,2)=0
		union
		select id+1 as id,student from seat where mod(id,2)=1 and id != (select count(*) from seat)
		union
		select id,student from seat where id = (select count(*) from seat)
    )as p
order by id;

SELECT class,score_avg,
       RANK() OVER w AS 'standard_rank',
       DENSE_RANK() OVER w AS 'dense_rank',
       ROW_NUMBER() OVER w AS 'row_number_rank'
FROM score
WINDOW w AS (ORDER BY score_avg DESC);

select p.Num as ConsecutiveNums
from (select Id,Num,
			lead(Num,1) over ()as Num2,
			lead(Num,2) over ()as Num3
			from logs)as p
where p.Num = p.Num2
and p.Num = p.Num3;

SELECT Name 
FROM Employee2 
WHERE Id IN (SELECT ManagerID
             FROM (SELECT Id,Name,ManagerId, 
                    COUNT(Id) OVER (PARTITION BY ManagerId ORDER BY ManagerId) AS num_same_manager
			        FROM Employee2) AS temp 
	         WHERE num_same_manager >= 5);