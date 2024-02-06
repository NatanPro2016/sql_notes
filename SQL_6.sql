-- Find products that are more expensice than Lettuce (id = 3)
SELECT * 
FROM products
WHERE unit_price > (
		SELECT unit_price 
        FROM products 
        WHERE product_id = 3);
-- In sql_hr database 
-- Find employees whose earn more than average 
USE sql_hr;

SELECT * 
FROM employees
WHERE salary > 
		( SELECT AVG(salary) FROM employees );
        
-- sub query with IN opprations 
USE sql_store;

SELECT * 
FROM products
WHERE product_id NOT IN (
SELECT DISTINCT product_id
FROM order_items);

-- select clients without incoices
SELECT * 
FROM clients
WHERE client_id NOT IN (
		SELECT DISTINCT client_id
		FROM invoices
);

SELECT * 
FROM clients c
LEFT JOIN invoices i
USING(client_id)
WHERE invoice_id IS NULL ;


-- Find Customers who have ordered lettuce (id = 3 )
-- select Customer_id , first_name , last_name

USE sql_store;

SELECT * 
FROM products;



SELECT DISTINCT customer_id , first_name, last_name
FROM customers
JOIN orders
USING (customer_id)
JOIN order_items oi
using(order_id)
WHERE oi.product_id = 3 ;

SELECT customer_id, first_name, last_name
FROM customers
WHERE customer_id IN (
		SELECT DISTINCT o.customer_id 
		FROM orders o
		JOIN order_items oi
		USING (order_id)
		WHERE product_id = 3);

SELECT client_id FROM order_items WHERE product_id = 3;

-- Select invoices larger than all invoices of 

USE sql_invoicing;

SELECT client_id , COUNT(*) AS invoicing
FROM invoices
GROUP BY (client_id)
HAVING invoicing >(
	SELECT COUNT(*)
	FROM invoices
	WHERE client_id = 3
	GROUP BY (client_id)
);
SELECT * 
FROM invoices
WHERE invoice_total >(
	SELECT MAX(invoice_total)
	FROM invoices
	WHERE client_id = 3
);

-- tha all key word 

SELECT * 
FROM invoices
WHERE invoice_total >ALL (
	SELECT invoice_total 
    FROM invoices
    WHERE client_id = 3
);
-- use all key word to compare a list 
-- SELECT * FROM invoices WHERE invoice_total >= (123, 456, 890)
-- like for loop it test the conditions from all the list
-- some times a subquery returns a list or a table 
-- use this when the subquery returns a list of values 

-- ANY/ SOME key word

SELECT * 
FROM clients 
WHERE client_id = SOME  ( -- equvalent to IN some how 
		SELECT client_id
		FROM invoices
		GROUP BY client_id 
		HAVING COUNT(*) >= 2
);

-- correlated Subqueries 


USE sql_hr;

SELECT * 
FROM employees e
WHERE  salary >(
	SELECT AVG(salary)
    FROM employees
    WHERE office_id = e.office_id
);
-- Get invoices that are larger than the client's average invoice amount 
USE sql_invoicing;

SELECT * 
FROM invoices i 
WHERE invoice_total > (
		SELECT AVG(invoice_total)
        FROM invoices
        WHERE client_id = i.client_id
        );
        
-- the exixts Operator 

-- if this have large set of list (long list) on in clouse it is more effecent to use exists 
-- EXISTS dosn't return list it returns true or false 
SELECT * 
FROM clients c
WHERE EXISTS (
	SELECT client_id
    FROM invoices
    WHERE client_id = c.client_id 
    );
    
-- this is equvalent to 

SELECT * 
FROM clients
WHERE client_id IN (
	SELECT DISTINCT client_id
    FROM invoices
);
USE sql_store ;
SELECT * 
FROM products p
WHERE NOT EXISTS (
	SELECT product_id
    FROM order_items
    WHERE product_id = p.product_id 
);

-- using sub queries on select clouse
SELECT 
	invoice_id,
    invoice_total,
    (SELECT AVG (invoice_total) FROM invoices ) AS invoice_average,
    invoice_total - (SELECT invoice_average) AS differce
FROM invoices;


SELECT *
FROM clients;


SELECT  AVG(invoice_total)
FROM invoices;

SELECT c.client_id ,
	name ,
    (SELECT SUM(invoice_total) FROM invoices WHERE client_id = c.client_id) AS total_sales,
	(SELECT AVG(invoice_total) FROM invoices) AS average,
    (SELECT total_sales - average) AS difference 
FROM clients c ;
-- using subquery on FROM

SELECT * 
FROM (
	SELECT c.client_id ,
		name ,
		(SELECT SUM(invoice_total) FROM invoices WHERE client_id = c.client_id) AS total_sales,
		(SELECT AVG(invoice_total) FROM invoices) AS average,
		(SELECT total_sales - average) AS difference 
	FROM clients c
    ) sales_summry


