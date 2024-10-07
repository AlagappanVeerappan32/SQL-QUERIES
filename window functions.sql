1. Rank employees within each department, using data from the employees and departments tables. USE rank function to rank employees within their department based on salary in descending order.

SELECT E.employee_id, E.name, D.department_name, E.salary, RANK() OVER (PARTITION BY D.department_id ORDER BY E.salary DESC) AS RANKS
FROM employees_new E JOIN departments D
ON D.department_id = E.department_id;

2. Find the top 2 highest-paid employees from each department, using data from both employees and departments tables.

SELECT * FROM (SELECT E.employee_id, E.name, D.department_name, E.salary, ROW_NUMBER() OVER (PARTITION BY D.department_id ORDER BY E.salary DESC) AS RANKS
FROM employees_new E JOIN departments D
ON D.department_id = E.department_id) AS Temp 
WHERE RANKS <= 2;
 
3. List employees who have the second-highest salary within their department.

SELECT * FROM (SELECT E.employee_id, E.name, D.department_name, E.salary, ROW_NUMBER() OVER (PARTITION BY D.department_id ORDER BY E.salary DESC) AS RANKS
FROM employees_new E JOIN departments D
ON D.department_id = E.department_id) AS Temp 
WHERE RANKS = 2;

4. Rank the products sold within each category based on total sales. Use two tables: products and sales. Join them, then use RANK() to rank products within each category by total sales.

SELECT p.product_id, p.category_id, p.product_name, S.sale_amount, RANK() OVER (PARTITION BY p.category_id ORDER BY S.sale_amount desc) as ranks
FROM products p JOIN sales S
ON S.product_id = p.product_id;

5.Show the top 2 products by total sales within each category. After joining products and sales, use ROW_NUMBER() to identify the top 2 products by sales amount for each category.

SELECT  * FROM (SELECT p.product_id, p.category_id, p.product_name, S.sale_amount, ROW_NUMBER() OVER (PARTITION BY p.category_id ORDER BY S.sale_amount desc) as ranks
FROM products p JOIN sales S
ON S.product_id = p.product_id) AS TEMP
WHERE ranks <=2;

6. Rank the products sold within each category based on total sales. Use two tables: products and sales. Join them, then use RANK() to rank products within each category by total sales.

SELECT p.product_id, p.category_id, p.product_name, SUM(S.sale_amount) as total_sales, RANK() OVER (PARTITION BY p.category_id ORDER BY SUM(S.sale_amount) desc) as ranks
FROM products p JOIN sales S
ON S.product_id = p.product_id
GROUP BY p.product_id, p.category_id, p.product_name;

7. Show the top 2 products by total sales within each category. After joining products and sales, use ROW_NUMBER() to identify the top 2 products by sales amount for each category.

SELECT  * FROM (SELECT p.product_id, p.category_id, p.product_name, SUM(S.sale_amount) as total_sales, ROW_NUMBER() OVER (PARTITION BY p.category_id ORDER BY SUM(S.sale_amount) desc) as ranks
FROM products p JOIN sales S
ON S.product_id = p.product_id
GROUP BY p.product_id, p.category_id, p.product_name
) AS TEMP
WHERE ranks <=2;

8. Find customers who placed the second-highest number of orders in each city. Use the customers and orders tables. Use DENSE_RANK() to rank customers within each city based on the number of orders they placed.

SELECT * FROM (  SELECT C.customer_id, C.customer_name, C.city, DENSE_RANK() OVER (PARTITION BY C.city ORDER BY COUNT(O.order_id) desc) as ranks
FROM customers C JOIN orders O 
ON O.customer_id = C.customer_id
group by C.customer_id,C.customer_name, C.city) AS TEMP
WHERE ranks = 2 ;

9.Display the employees who are paid in the top 10% of their department's salary distribution. First calculate the percentile of the salaries within each department using window functions. Then filter for employees who are in the top 10%.

SELECT * FROM ( SELECT E.employee_id, E.name, D.department_name, PERCENT_RANK() OVER (PARTITION BY D.department_name ORDER BY E.salary DESC) AS PR
FROM employees_new E JOIN departments D
ON D.department_id = E.department_id) AS TEMP 
WHERE PR <=0.10;
  
10. Find the top 3 customers who have placed the largest total order amounts across all cities. Use customers and orders tables. Sum up the order amounts and use RANK() or ROW_NUMBER() to find the top 3 customers.

SELECT * FROM (SELECT C.customer_id, C.customer_name, C.city, SUM(O.order_amount), rank() OVER (ORDER BY SUM(O.order_amount)DESC ) AS RANKS
FROM  customers C JOIN orders O 
ON O.customer_id = C.customer_id
group by C.customer_id,C.customer_name, C.city) AS TEMP WHERE RANKS <=3
