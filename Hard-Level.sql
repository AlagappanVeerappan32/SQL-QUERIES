1. Meta/Facebook is developing a search algorithm that will allow users to search through their post history. You have been assigned to evaluate the performance of this algorithm.
We have a table with the user's search term, search result positions, and whether or not the user clicked on the search result.
Write a query that assigns ratings to the searches in the following way:
•	If the search was not clicked for any term, assign the search with rating=1
•	If the search was clicked but the top position of clicked terms was outside the top 3 positions, assign the search a rating=2
•	If the search was clicked and the top position of a clicked term was in the top 3 positions, assign the search a rating=3
As a search ID can contain more than one search term, select the highest rating for that search ID. Output the search ID and its highest rating.
Example: The search_id 1 was clicked (clicked = 1) and its position is outside of the top 3 positions (search_results_position = 5), therefore its rating is 2.

SELECT search_id, 
    MAX(CASE
        WHEN clicked = 0 THEN 1
        WHEN clicked > 0 AND search_results_position > 3 THEN 2
        WHEN clicked > 0 AND search_results_position <= 3 THEN 3
    END )AS rating
FROM fb_search_events
GROUP BY search_id

2. ABC Corp is a mid-sized insurer in the US and in the recent past their fraudulent claims have increased significantly for their personal auto insurance portfolio. They have developed a ML based predictive model to identify propensity of fraudulent claims. Now, they assign highly experienced claim adjusters for top 5 percentile of claims identified by the model.
Your objective is to identify the top 5 percentile of claims from each state. Your output should be policy number, state, claim cost, and fraud score?

WITH ranked_claims AS (
    SELECT policy_num, state, claim_cost, fraud_score,
        NTILE(100) OVER (PARTITION BY state ORDER BY fraud_score DESC) AS percentile_rank
    FROM fraud_score
)
SELECT policy_num, state, claim_cost, fraud_score
FROM ranked_claims
WHERE percentile_rank <= 5;

