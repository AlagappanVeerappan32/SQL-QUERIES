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

-- Question 16:

-- a. How many products are sold by AdventureWorks?
SELECT COUNT(ProductID) FROM Production_Product
WHERE FinishedGoodsFlag=1;

-- b. How many of these products are actively being sold by AdventureWorks?
# FinishedGoodsFlag = 0 - not for sale, 1 - for sale.

SELECT COUNT(ProductID) FROM Production_Product
WHERE FinishedGoodsFlag=1 and SellEndDate is null;

-- c. How many of these active products are made in house vs. purchased?
# MAKE FLAG = 0-PRODUCT IS PURCHASED, 1 = PRODUCT IS MADE IN HOUSE.
    
SELECT COUNT(ProductID),
COUNT(CASE 
WHEN MakeFlag = 0 THEN ProductID
END) as Purchased,
COUNT(CASE 
WHEN MakeFlag = 1 THEN ProductID
END) as made_product
FROM Production_Product
WHERE FinishedGoodsFlag=1 and SellEndDate is null;


-- Question 17

-- We learned in Question 16 that the product table includes a few different type of products - i.e., manufactured vs. purchased.

-- a. Sum the LineTotal in SalesOrderDetail. Format as currency

SELECT CONCAT('$', FORMAT(SUM(LineTotal), 2)) AS lineTotal FROM Sales_SalesOrderDetail;

-- b. Sum the LineTotal in SalesOrderDetail by the MakeFlag in the product table. Use a case statement to specify manufactured vs. purchased. Format as currency.

SELECT 
CASE WHEN P.MakeFlag = 1 THEN 'manufactured' ELSE 'purchased' END AS MakeFlag,
CONCAT('$', FORMAT(SUM(S.LineTotal), 2)) AS lineTotal
FROM Sales_SalesOrderDetail S 
JOIN Production_Product P ON P.ProductID = S.ProductID
GROUP BY p.MakeFlag;


-- c. Add a count of distinct SalesOrderIDs
SELECT 
CASE WHEN P.MakeFlag = 1 THEN 'manufactured' ELSE 'purchased' END AS MakeFlag,
CONCAT('$', FORMAT(SUM(S.LineTotal), 2)) AS lineTotal,
COUNT(DISTINCT S.SalesOrderID) as salesId
FROM Sales_SalesOrderDetail S 
JOIN Production_Product P ON P.ProductID = S.ProductID
GROUP BY p.MakeFlag;

-- d. What is the average LineTotal per SalesOrderID?

SELECT 
CASE WHEN P.MakeFlag = 1 THEN 'manufactured' ELSE 'purchased' END AS MakeFlag,
CONCAT('$', FORMAT(SUM(S.LineTotal), 2)) AS lineTotal,
COUNT(DISTINCT S.SalesOrderID) as salesId,
FORMAT(SUM(S.LineTotal)/COUNT(DISTINCT S.SalesOrderID),2) as avg_total
FROM Sales_SalesOrderDetail S 
JOIN Production_Product P ON P.ProductID = S.ProductID
GROUP BY p.MakeFlag;


-- Question 18

-- The AdventureWorks Cyclery database includes historical and present transactions.

-- a. In the TransactionHistory and TransactionHistoryArchive tables a "W","S", and "P" are used as Transaction types.    What do these abbreviations mean?
# w- workorder, s-salesorder, p-purchaseorder

-- b. Union TransactionHistory and TransactionHistoryArchive

SELECT * FROM Production_TransactionHistory
UNION
SELECT * FROM Production_TransactionHistoryArchive;

-- c. Find the First and Last TransactionDate in the TransactionHistory and TransactionHistoryArchive tables. Use the union written in part b. The current data type for TransactionDate is datetime. Convert or Cast the data type to date.

SELECT
max(DATE(TransactionDate)) as last_date,
min(DATE(TransactionDate)) as first_date
FROM (SELECT * FROM Production_TransactionHistory
UNION
SELECT * FROM Production_TransactionHistoryArchive) AS innerQ;

-- d. Find the First and Last Date for each transaction type. Use a case statement to specify the transaction types. 

SELECT 
CASE WHEN TransactionType = 'W' THEN 'workorder'
WHEN TransactionType = 'S' THEN 'salesorder'
ELSE 'purchaseorder' END as TransactionType,
max(DATE(TransactionDate)) as last_date,
min(DATE(TransactionDate)) as first_date
FROM (SELECT * FROM Production_TransactionHistory
UNION
SELECT * FROM Production_TransactionHistoryArchive) AS innerQ
group by TransactionType;

-- Question 19

-- We learned in Question 18 that the most recent SalesOrder transaction occurred on 2014-06-30 and the First Sales Order transaction occurred on 2011-05-31. 
-- Does the SalesOrderHeader table show a similar Order date for the first and Last Sale? Format as Date 

SELECT
max(DATE(OrderDate)) as last_date,
min(DATE(OrderDate)) as first_date
FROM 
Sales_SalesOrderHeader;


-- Question 20

-- We learned in Question 19 that the first and most recent OrderDate in the SalesOrderHeader t
-- able matches the Sales Order Dates in the transactionHistory table (Question 18).

-- a. Find the other tables and dates that should match the WorkOrder and PurchaseOrder Dates. Format these dates as a date in the YYYY-MM-DD format.

SELECT 'workorder',
max(DATE(StartDate)) as last_date,
min(DATE(StartDate)) as first_date
FROM 
Production_WorkOrder
UNION
SELECT 'purchaseorder',
max(DATE(OrderDate)) as last_date,
min(DATE(OrderDate)) as first_date
FROM 
Purchasing_PurchaseOrderHeader
where status = 1;
