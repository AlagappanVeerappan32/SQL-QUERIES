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


14.Total Revenue for Each Company? 

SELECT company, SUM(revenue) as revenue FROM games
GROUP BY company;

15. Games Produced per Year with Average Revenue and Cost? 

SELECT production_year, count(*) as count,  AVG(production_cost) as avg_cost, AVG(revenue) as avg_revenue FROM games
GROUP BY production_year;

16. Number of Profitable Games of Each Game Type  (i.e. the revenue was greater than the production cost).

SELECT type, COUNT(*) as count FROM games
WHERE revenue > production_cost
GROUP BY type;

17. Total Revenue per Game Type in PS2 and PS3 Systems

SELECT type, systems, SUM(revenue) AS TOTAL_REVENUE FROM games
WHERE systems IN ('PS2','PS3')
GROUP BY type, systems;

18. For all companies present in the table, obtain their names and the sum of gross profit over all years. (Assume that gross profit = revenue - cost of production). Name this column gross_profit_sum. Order the results by gross profit, in descending order.

SELECT company, SUM(revenue - production_cost) AS gross_profit_sum 
FROM games
GROUP BY company
ORDER BY gross_profit_sum desc;

19. Obtain the yearly gross profit of each company. In other words, we want a report with the company name, the year, and the gross profit for that year. Order the report by company name and year.

SELECT company, production_year, SUM(revenue - production_cost) AS gross_profit_sum 
FROM games
GROUP BY company, production_year
ORDER BY company, production_year;

20. For each company, select its name, the number of games it’s produced (as the number_of_games column), and the average cost of production (as the avg_cost column). Show only companies producing more than one game.

SELECT company, COUNT(*) AS number_of_games, AVG(production_cost) AS avg_cost
FROM games
GROUP BY company
HAVING number_of_games>1;

21. We are interested in good games produced between 2000 and 2009. A good game is a profitable game with a rating higher than 6. For each company, show the company name, its total revenue from good games produced between 2000 and 2009 (as the revenue_sum column), and the number of good games it produced in this period (as the number_of_games column). Only show companies with good-game revenue over 4 000 000.

SELECT company, 
       SUM(revenue) AS revenue_sum, 
       COUNT(*) AS number_of_games 
FROM games
WHERE (production_year BETWEEN 2000 AND 2009) 
  AND rating > 6
GROUP BY company
HAVING SUM(revenue) > 4000000;




