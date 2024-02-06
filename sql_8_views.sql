USE sql_invoicing;
CREATE VIEW sales_by_client AS -- creating a view 
	SELECT 
		c.client_id,
		c.name ,
		SUM(invoice_total) AS total_sales
	FROM clients c
	JOIN invoices i USING(client_id)
	GROUP BY client_id, name;
    

SELECT * 
FROM sales_by_client -- using created view 
JOIN clients USING(client_id);


CREATE VIEW clients_balance AS 
SELECT 
	c.client_id,
    c.name,
    SUM(invoice_total - payment_total) AS balalce
FROM clients c
JOIN invoices i
USING(client_id)
GROUP BY (client_id);

DROP VIEW clients_balance; -- DELETEING VIEWS 

CREATE OR REPLACE VIEW clients_balance AS -- ALTRING A VIEW 
SELECT 
	c.client_id,
    c.name,
    SUM(invoice_total - payment_total) AS balalce
FROM clients c
JOIN invoices i
USING(client_id)
GROUP BY (client_id);
-- you cant delete update the views here unless it is updatable views

-- updatable views means a view that you can delete /alter  the values of the records
-- if you don't have DISTINCT &
-- Aggregate Functions
-- group by and having
-- union 
-- we can call view that updatable views
CREATE OR REPLACE VIEW invoices_with_balance AS
SELECT 
	invoice_id,
    number,
    client_id,
    invoice_total,
    payment_total,
    invoice_total - payment_total AS balance,
    invoice_date,
    due_date,
    payment_date
    
FROM invoices
WHERE (invoice_total - payment_total) > 0 
WITH CHECK OPTION; -- IF THE VIEW SET THE DATA AND FALED TO PASS WHERE CLOUSE IT WILL CHECK AND PRVENTS TO UPDATE 

-- that means this the above view is updatable view 

DELETE FROM invoices_with_balance
WHERE invoice_id = 1;

UPDATE invoices_with_balance
SET due_date = DATE_ADD(due_date, INTERVAL 2 DAY)
WHERE invoice_id = 2;

-- you can use your views to update and delete data if asuming your views are updatable   

-- option check valuse 

UPDATE invoices_with_balance
SET payment_total = invoice_total
WHERE invoice_id = 3

-- USE OF VIEWS 
-- simplify queries 
-- reduce of the impact of changes 
-- restrict access to the data