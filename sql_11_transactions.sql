-- transaction is a group of SQL statements that represent a single unit of work 
-- creating  Transactions 

USE sql_store;

START TRANSACTION;

INSERT INTO orders( customer_id, order_date, status )
VALUES (1, '2019-01-01', 1);

INSERT INTO order_items
VALUES (LAST_INSERT_ID(), 1, 1, 1); 

-- COMMIT;

-- ROLLBACK
SHOW VARIABLES LIKE 'AUTO%';


-- CONCURRENCY AND LOKING ;

USE sql_store;

START TRANSACTION;
UPDATE customers
SET points = points + 10
WHERE customer_id = 1; 
COMMIT;


