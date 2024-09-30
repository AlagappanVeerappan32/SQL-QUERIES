1. Workers With The Highest Salaries.You have been asked to find the job titles of the highest-paid employees.
Your output should include the highest-paid title or multiple titles with the same salary?

SELECT T.worker_title FROM worker W JOIN title T
ON T.worker_ref_id = W.worker_id
WHERE W.salary = (SELECT MAX(salary) FROM worker)
ORDER BY W.salary desc

2. Meta/Facebook Messenger stores the number of messages between users in a table named 'fb_messages'. In this table 'user1' is the sender, 'user2' is the receiver, and 'msg_count' is the number of messages exchanged between them.
Find the top 10 most active users on Meta/Facebook Messenger by counting their total number of messages sent and received. Your solution should output usernames and the count of the total messages they sent or received?


SELECT user AS username, SUM(total_messages) AS total_msg_count
FROM (
    SELECT user1 AS user, SUM(msg_count) AS total_messages
    FROM fb_messages
    GROUP BY user1
    UNION ALL
    SELECT user2 AS user, SUM(msg_count) AS total_messages
    FROM fb_messages
    GROUP BY user2
) AS user_messages
GROUP BY user
ORDER BY total_msg_count DESC
LIMIT 10;



