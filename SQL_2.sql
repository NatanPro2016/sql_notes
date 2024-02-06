SELECT order_id , first_name , last_name 
FROM orders 
JOIN customers
	ON orders.customer_id = customers.customer_id;


SELECT * 
FROM customers o
JOIN orders c
	ON c.customer_id = o.customer_id 
ORDER BY o.customer_id;


-- relationship from the same database
SELECT order_id, o.product_id , name , quantity, o.unit_price 
FROM order_items o
JOIN products p 
	ON o.product_id = p.product_id;

-- relationship across different database 
	SELECT * 
	FROM order_items oi
	JOIN sql_inventory.products p 
		ON  oi.product_id = p.product_id;

-- selef relations 
USE sql_hr;

SELECT 
	e.employee_id,
	e.first_name,
	m.first_name AS manager 
FROM employees e
JOIN employees m
	ON e.reports_to = m.employee_id;

-- TWO OR MORE TABLES 

USE sql_store;

SELECT 
	o.order_id,
    o.order_date,
    c.first_name,
    c.last_name,
    os.name AS status
FROM orders o 
JOIN customers c
	ON o.customer_id = c.customer_id
JOIN order_statuses os
	ON o.status = os.order_status_id;
    
USE sql_invoicing;

SELECT 
	p.payment_id,
    p.date,
    c.name,
    pm.name AS "payment method"
FROM payments AS p
JOIN clients AS c
	ON p.client_id = c.client_id
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id;


-- composed primary key with realtions ship 
USE sql_store;

SELECT * 
FROM order_items oi
JOIN order_items oin
	ON oi.order_id = oin.order_id
    AND oi.product_id = oin.product_id;


-- Implpicit Join Syntax or old join snitax

SELECT * 
FROM orders o , customers c
WHERE o.customer_id = c.customer_id;


-- outer join that means all from the one table will be visble 

-- if you use LEFT key word before JOIN it will show all data from the left table 
SELECT 
	c.customer_id,
	c.first_name,
    o.order_id
FROM customers c
LEFT JOIN orders o
	ON c.customer_id= o.customer_id 
ORDER BY customer_id;


SELECT p.product_id ,p.name, oi.quantity
FROM products p 
LEFT JOIN order_items oi
	ON  ot.product_id = p.product_id;
    
    
SELECT 
	c.customer_id,
    c.first_name,
    o.order_id,
    sh.name AS shipper ,
    o.status
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id;


SELECT 
	o.order_date ,
	o.order_id , 
    c.first_name , 
    s.name AS shipper , 
    os.name AS status
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
LEFT JOIN shippers s
	ON s.shipper_id = o.shipper_id
JOIN order_statuses os
	ON o.status = os.order_status_id;

USE sql_hr;

-- sele outer joins 
SELECT 
	e.employee_id,
    e.first_name,
    m.first_name
FROM employees e
RIGHT JOIN employees m
	ON e.employee_id = m.reports_to;
    
-- the USING() clause 
SELECT 
	o.order_date ,
	o.order_id , 
    c.first_name , 
    s.name AS shipper , 
    os.name AS status
FROM orders o
JOIN customers c
	USING(customer_id)
LEFT JOIN shippers s
	USING(shipper_id)
JOIN order_statuses os
	ON o.status = os.order_status_id;


SELECT *
FROM order_items oi
JOIN order_item_notes oin
	USING(order_id, product_id);


-- exerise 
SELECT 
	p.date,
    c.name AS client,
    p.amount,
    pm.name AS "payment Method "
FROM payments p
JOIN clients c
	USING(client_id)
JOIN payment_methods pm
	ON pm.payment_method_id = p.payment_method;
	

-- natural joins 

SELECT * 
FROM orders o 
NATURAL JOIN customers c;

-- cross join 

SELECT 
	c.first_name,
     p.name
FROM customers c
CROSS JOIN products p 
ORDER BY c.first_name;

SELECT * 
FROM  shippers
CROSS JOIN products;

SELECT * 
FROM shippers , products;

-- union key word use union key word to connect two statement 
SELECT 
	order_id,
    order_date,
    'Active' AS status
FROM orders 
WHERE order_date >= '2019-01-01'
UNION
SELECT 
	order_id,
    order_date,
    'Archived' AS status
FROM orders
WHERE order_date <= '2019-01-01';

-- union from different table 

SELECT first_name
FROM customers 
UNION 
SELECT name
FROM shippers;


SELECT 
	customer_id  ,
    first_name ,
    points ,
    "Gold" AS type
FROM customers
WHERE points >= 3000
UNION 
SELECT customer_id,
	first_name,
    points,
    "Silver" AS type
FROM customers
WHERE points BETWEEN 2000 AND 3000
UNION 
SELECT 
	customer_id,
	first_name,
    points,
    "Bronze" AS type
FROM customers
WHERE points <= 2000
ORDER BY first_name

