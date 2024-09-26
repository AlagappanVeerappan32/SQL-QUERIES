1. Workers With The Highest Salaries.You have been asked to find the job titles of the highest-paid employees.
Your output should include the highest-paid title or multiple titles with the same salary?

SELECT T.worker_title FROM worker W JOIN title T
ON T.worker_ref_id = W.worker_id
WHERE W.salary = (SELECT MAX(salary) FROM worker)
ORDER BY W.salary desc




