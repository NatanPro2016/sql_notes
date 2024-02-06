-- inserting  hierarchical 
USE sql_store;

INSERT INTO orders ( customer_id, order_date, status)
VALUES (1, '1019-01-02', 1);

INSERT INTO order_items
VALUES ( LAST_INSERT_ID(), 1, 1, 2.95 ),
		( LAST_INSERT_ID() , 2, 2, 4.95 );

-- compying table and inserting all data to the new table
CREATE TABLE  orders_archived AS
SELECT * FROM orders;

INSERT INTO orders_archived
SELECT * 
FROM orders
WHERE order_date < '2019-01-01';

USE sql_invoicing;
CREATE TABLE invoices_archived AS 
SELECT
		invoice_id, 
        number, 
        name AS client_name,
        invoice_total , 
        payment_total , 
        invoice_date, 
        due_date , 
        payment_date 
FROM invoices i 
JOIN clients c
USING(client_id)
WHERE i.payment_date IS NOT NULL;



SELECT * 
FROM invoices i , clients c
WHERE i.client_id = c.client_id AND i.payment_date IS NOT NULL ;


-- updating data 

UPDATE invoices
SET payment_total = 10, 
	payment_date = '2019-03-01'
WHERE invoice_id = 1;

-- you can use other column data for updating 

UPDATE invoices
SET payment_total = invoice_total * 0.5,
	payment_date = due_date -- like this
WHERE invoice_id = 1
    
