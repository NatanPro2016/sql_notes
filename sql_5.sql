SELECT MAX(invoice_total) AS Highst,
		MIN(invoice_total) AS Lowest,
        AVG(invoice_total) AS Average,
        SUM(invoice_total * 1.1 ) AS total, -- you can use expressions as well 
        COUNT(invoice_total) AS Numbers, -- it dose't include null values
        COUNT(DISTINCT client_id), -- counting none duplacated values 
        COUNT(*)  -- to count nulls as well
FROM invoices
WHERE invoice_date > '2019-07-01' ;-- I added this to sohw you can use filters as well ;




SELECT  "First Half of 2019" AS date_range,
		SUM(invoice_total) AS total_sales,
		SUM(payment_total) AS total_payment, 
        SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-6-30' 
UNION 
SELECT  "Second Half of 2019" AS date_range,
		SUM(invoice_total) AS total_sales,
		SUM(payment_total) AS total_payment, 
        SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-06-01' AND '2019-12-31' 
UNION 
SELECT  "total" AS date_range,
		SUM(invoice_total) AS total_sales,
		SUM(payment_total) AS total_payment, 
        SUM(invoice_total- payment_total)  AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-12-31' ;


-- group by clause 

SELECT state, city , SUM(invoice_total) AS total_sales
FROM invoices
JOIN clients USING (client_id)
GROUP BY state, city;

-- exercice

SELECT 
	p.date , 
    pm.name AS payment_method ,
    SUM(p.amount) AS total_payment
FROM payments p
JOIN payment_methods pm
ON p.payment_method = pm.payment_method_id
GROUP BY p.date , pm.name
ORDER BY p.date ;

-- having 
-- having means filtring data you might say i have where for that but you cant use where after grouping data 
-- so that is why you use having 
-- the different between where and having is you can use where before grouping data and use having after grouping data  
SELECT 
	p.date , 
    pm.name AS payment_method ,
    SUM(p.amount) AS total_payment
FROM payments p
JOIN payment_methods pm
ON p.payment_method = pm.payment_method_id
GROUP BY p.date , pm.name
HAVING total_payment > 20 -- filtering data after grouping 
ORDER BY p.date;

SELECT 
	client_id,
    SUM(invoice_total) AS total_sales,
    COUNT(*) AS number_of_invoices
FROM invoices
GROUP BY client_id
HAVING total_sales > 500 AND number_of_invoices > 5;

-- exercise 


        
SELECT 
	customer_id,
    SUM(oi.unit_price * oi.quantity) AS total_payment
FROM customers c
JOIN orders o 
USING(customer_id)
JOIN order_items oi
USING( order_id)
WHERE state = 'VA'
GROUP BY customer_id
HAVING total_payment > 100;

SELECT 
	c.state,
    c.city,
    SUM(invoice_total) AS total_sales
FROM invoices i
JOIN clients c
USING	(client_id)
GROUP BY state, city WITH ROLLUP;

SELECT pm.name,  SUM(p.amount)
FROM payments p 
JOIN payment_methods pm
ON pm.payment_method_id = p.payment_method
GROUP BY pm.name WITH ROLLUP



