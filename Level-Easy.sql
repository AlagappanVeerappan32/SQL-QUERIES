1. Find the search details for villas and houses with wireless internet access?

SELECT * 
FROM airbnb_search_details 
WHERE property_type IN ('House', 'Villa') 
AND amenities LIKE '%Wireless Internet%'

2. How many orders were shipped by Speedy Express in total?

SELECT COUNT(O.order_id) AS total_orders
FROM shopify_orders O 
JOIN shopify_carriers C ON C.id = O.carrier_id 
WHERE C.name = 'Speedy Express';

3. Unique Employee Logins?

SELECT DISTINCT worker_id 
FROM worker_logins
WHERE DATE(login_timestamp) BETWEEN '2021-12-13' AND '2021-12-19';

4. Find hotels in the Netherlands that got complaints from guests about room dirtiness (word "dirty" in its negative review). Output all the columns in your results?

SELECT * FROM hotel_reviews
WHERE hotel_address LIKE '%Netherlands%' 
    AND negative_review LIKE '%dirty%';

5. Find distinct searches for Los Angeles neighborhoods. Output neighborhoods and remove duplicates?

SELECT DISTINCT neighbourhood FROM airbnb_search_details 
WHERE city = 'LA';

6. For each video game player, find the latest date when they logged in?

SELECT player_id, MAX(login_date) FROM players_logins
GROUP BY player_id;

7. Write a query to get a list of products that have not had any sales. Output the ID and market name of these products?

select prod_sku_id , prod_sku_name FROM dim_product
WHERE prod_sku_id NOT IN (SELECT prod_sku_id FROM fct_customer_sales);

8. You are given a list of posts of a Facebook user. Find the average number of likes?

SELECT AVG(no_of_likes) FROM fb_posts;

9. You have been asked to find the number of employees hired between the months of January and July in the year 2022 inclusive? Your output should contain the number of employees hired in this given time frame.

SELECT COUNT(id) FROM employees
WHERE DATE(joining_date) BETWEEN '2022-01-01' AND  '2022-07-31';

10. You've been asked to arrange a column of random IDs in ascending alphabetical order based on their second character?
  
select * from random_id 
ORDER BY SUBSTRING(id, 2);

11. Find SAT scores of students whose high school names do not end with 'HS'?

SELECT * FROM sat_scores
WHERE school NOT LIKE '%HS';

12. Find the search details made by people who searched for apartments designed for a single-person stay?

SELECT * FROM airbnb_search_details WHERE property_type = 'Apartment' AND 
room_type = 'Private room';

13. Write a query that calculates the difference between the highest salaries found in the marketing and engineering departments. Output just the absolute difference in salaries?

SELECT ABS(
    (SELECT MAX(E.salary) 
     FROM db_employee E 
     JOIN db_dept D ON D.id = E.department_id
     WHERE D.department = 'marketing')
    -
    (SELECT MAX(E.salary) 
     FROM db_employee E 
     JOIN db_dept D ON D.id = E.department_id
     WHERE D.department = 'engineering')
) AS salary_difference;




















