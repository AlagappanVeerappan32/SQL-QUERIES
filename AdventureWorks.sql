# Question 1:

## a. How many employees exist in the Database?

SELECT COUNT(*) AS employees_count FROM HumanResources_Employee;

## b. How many of these employees are active employees? NOTE: CURRENT_FLAG = 0-inactive, 1-active.

SELECT COUNT(*) AS active_employees FROM HumanResources_Employee
WHERE CurrentFlag = 1;

## c. How many Job Titles equal the 'SP' Person type?

SELECT COUNT(DISTINCT e.JobTitle) AS jon_title_count 
FROM HumanResources_Employee E JOIN Person_Person P
ON P.BusinessEntityID = E.BusinessEntityID
WHERE P.PersonType = 'SP';

## d. How many of these employees are sales people?

SELECT COUNT(e.BusinessEntityID) AS employees_count 
FROM HumanResources_Employee e JOIN Person_Person p
ON  P.BusinessEntityID = E.BusinessEntityID
WHERE P.PersonType = 'SP';

-- Question 2:

-- a. What is the name of the CEO? Concatenate first and last name.

SELECT CONCAT(p.FirstName, ' ', p.LastName) As ceo_name
FROM Person_Person p JOIN HumanResources_Employee e
ON p.BusinessEntityID = e.BusinessEntityID
WHERE e.JobTitle = 'Chief Executive Officer';

-- b. When did this person start working for AdventureWorks

SELECT HireDate FROM HumanResources_Employee 
WHERE JobTitle = 'Chief Executive Officer';

-- c. Who reports to the CEO? Includes their names and title

SELECT CONCAT(p.FirstName, ' ', p.LastName) As name, e.JobTitle 
FROM Person_Person p JOIN HumanResources_Employee e
ON p.BusinessEntityID = e.BusinessEntityID
WHERE OrganizationLevel = 1;


-- Question 3

-- a. What is the job title for John Evans

SELECT e.JobTitle 
FROM HumanResources_Employee e JOIN Person_Person p
ON p.BusinessEntityID = e.BusinessEntityID
WHERE p.FirstName = "John" AND p.LastName ="Evans";

-- b. What department does John Evans work in?

SELECT D.DepartmentID, D.Name
FROM HumanResources_Department D JOIN HumanResources_EmployeeDepartmentHistory DH
ON DH.DepartmentID = D.DepartmentID JOIN Person_Person P
ON P.BusinessEntityID = DH.BusinessEntityID
WHERE P.FirstName = "John" AND P.LastName ="Evans";


-- Question 4

-- a. Which Purchasing vendors have the highest credit rating?

SELECT Name, CreditRating FROM Purchasing_Vendor
WHERE CreditRating = 1
ORDER BY CreditRating asc;

-- b. Using a case statement replace the 1 and 0 in Vendor.PreferredVendorStatus to "Preferred" vs "Not Preferred."   How many vendors are considered Preferred?

SELECT COUNT(*) AS PreferredVendorCount
FROM Purchasing_Vendor
WHERE 
    CASE 
        WHEN PreferredVendorStatus = 1 THEN 'Preferred'
        ELSE 'Not Preferred'
    END = 'Preferred';

-- c. For Active Vendors only, do Preferred vendors have a High or lower average credit rating?

SELECT AVG(CreditRating) FROM Purchasing_Vendor
WHERE ActiveFlag = 1 AND PreferredVendorStatus = 1;

-- d. How many vendors are active and Not Preferred?

SELECT COUNT(*) AS active_not_preferred FROM Purchasing_Vendor
WHERE ActiveFlag = 1 AND PreferredVendorStatus = 0;


-- Question 15:

-- Assume today is August 15, 2014.

-- a. Calculate the age for every current employee. What is the age of the oldest employee?
-- NOTE: CURRENT_FLAG = 0-inactive, 1-active.

SELECT BusinessEntityID, FLOOR(DATEDIFF('2014-08-05', BirthDate)/365.25) AS age
FROM HumanResources_Employee
WHERE CurrentFlag = 1
ORDER BY FLOOR(DATEDIFF('2014-08-05', BirthDate)/365.25) desc
limit 1;

-- b. What is the average age by Organization level? Show answer with a single decimal


SELECT OrganizationLevel, round(avg((DATEDIFF('2014-08-05', BirthDate)/365.25)),1) AS age
FROM HumanResources_Employee
GROUP BY OrganizationLevel;


-- c. Use the ceiling function to round up

SELECT OrganizationLevel, ceil(avg((DATEDIFF('2014-08-05', BirthDate)/365.25))) AS age
FROM HumanResources_Employee
GROUP BY OrganizationLevel;


-- d. Use the floor function to round down

SELECT OrganizationLevel, floor(avg((DATEDIFF('2014-08-05', BirthDate)/365.25))) AS age
FROM HumanResources_Employee
GROUP BY OrganizationLevel;

#Alternative: USING TIMESTAMPDIFF. 

SELECT BusinessEntityID, FLOOR(TIMESTAMPDIFF(YEAR, BirthDate, '2014-08-05')) AS age
FROM HumanResources_Employee
ORDER BY 2 DESC
