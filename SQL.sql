SELECT * FROM sql_invoicing.clients;
use sql_store;
select * from customers 
-- where customer_id = 1
order by first_name;


USE sql_store;
-- AND AND OR --

SELECT * 
FROM Customers;

SELECT *
FROM order_items 
WHERE order_id = 6 AND (quantity * unit_price) > 30;




-- in oprator --
SELECT *
FROM customers
WHERE state = 'VA' OR state = 'FL'OR state = 'GA';

SELECT * 
FROM customers
WHERE state NOT IN ('VA', 'FL', 'GA');


SELECT * 
FROM products
WHERE quantity_in_stock IN(49, 38, 72);

-- between --

SELECT * 
FROM customers
WHERE points >= 1000 AND points <= 3000;

SELECT * 
FROM customers 
WHERE points between 1000 AND 3000;

SELECT * 
FROM customers
WHERE birth_date BETWEEN '1990-01-01' AND '2000-1-1';

-- like --
SELECT * 
FROM customers
WHERE last_name LIKE 'b%'; -- start with b  not case senetive --


-- last name end with y --
SELECT * 
FROM customers
WHERE last_name LIKE '%Y';

-- use % to any number of caracters --

SELECT *
FROM customers 
WHERE last_name LIKE '_____y';

-- use _ for saying single character --

SELECT * 
FROM customers
WHERE phone LIKE '%9';

-- regular expression --

SELECT *
FROM customers
WHERE last_name REGEXP 'field'; -- this is the same as LIKE '%field%' --

SELECT * 
FROM customers
WHERE last_name REGEXP '^brus$'; -- use  ^ for to say it must start weith 'brush' AND use $ to indicate end must end with the string --

SELECT * 
FROM customers
WHERE last_name REGEXP '^brus|mac|rose'; -- use | for OR

SELECT * 
FROM customers
WHERE  last_name REGEXP '[gim]e';
-- this means all that have or contains ge, ie, me le 
-- this letters [gim] can came before te letter e 
SELECT * 
FROM customers
WHERE  last_name REGEXP 'e[gim]';
-- like the first one but the revers the letters can came after the letter e
SELECT * 
FROM customers
WHERE  last_name REGEXP '[a-z]e';

-- you can use range this means starts from the letter a  to the letter z 
-- use ^ beggin of the string 
-- use $ the end of string 
-- use | or 
-- [] to indicate contain 
-- [-] range 


-- eXrcise 

SELECT * 
FROM customers
WHERE first_name REGEXP '^INES$|^AMBUR$';

SELECT * 
FROM customers
WHERE last_name REGEXP 'EY$|ON$' ;

SELECT * 
FROM customers
WHERE last_name REGEXP '^MY|SE';

SELECT * 
FROM customers 
WHERE last_name REGEXP 'B[RU]';

-- geting null values 
SELECT * 
FROM customers
WHERE phone IS NULL   ;

SELECT * 
FROM customers
WHERE phone IS NOT NULL ;

SELECT * 
FROM orders
WHERE shipped_date IS NULL OR shipper_id IS NULL;

-- order by --

SELECT * 
FROM customers
ORDER BY state;

-- ex 

SELECT * 
FROM order_items 
WHERE order_id = 2
ORDER BY quantity * unit_price DESC;

-- LMIT 

SELECT * 
FROM customers
LIMIT 6 , 3;
-- SKIP 6 AND RETRIVE 3 ROW 

SELECT * 
FROM customers
ORDER BY points DESC
LIMIT 3


