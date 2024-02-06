-- numeric function 
 SELECT ROUND(5.523, 2); -- THE FIRST ONE IS THE NUMBER TO BE ROUNDED THE
 -- SECOND ONE IS HOW MANY THE DECMAL VALUE TO BE AFTER ROUDED 
  SELECT CEILING(5.523); -- RETURNS THE SMALLER INTIGER GRATHER THAN THE NO
  SELECT FLOOR(5.523) -- RETURNS THE BIGGEST INTIGER LESS THAN THE NO
 ABS(123)-- absolute value 
 RAND() -- FOR GENERATING RANDOM NUMBER 0 - 1 
 
 
 -- STRING FUNCTION 
LENGTH()
UPPER()
LOWER()
LTRIM("     sky") -- REMOVES SPACE BEFORE A STRING
RTRIM("sky        ") -- REMOVES SPACE AFTER WARDS
TRIM("   sky      ") -- REMOVE SPACE BOTH WAYS
LEFT("kindergarten", 6) -- returns kinder
RIGHT("kindergarten", 6) -- retuns graten
SUBSTRING("kindergarten", 3, 5) -- returns nderg strates from the 3rd character SELECTS 5 CHARACTERS 
SUBSTRING("kindergarten", 3 ) -- FROM THE THIRD CARACTER TO THE END OF THE STRING 
LOCATE('n', 'kindergarten') -- returns the index of first occour in string in this case n is located on 3
LOCATE('garten', 'kindergarten') -- it works for sequce of charachers as well

-- some date functions

-- formating Dates and times 
SELECT DATE_FORMAT(NOW() , '%M %D, %Y')  -- RETURNS'January 25th, 2024'
SELECT DATE_FORMAT(NOW() , '%m %d, %y') -- IF YOU USED SMALL LATTERS '01 25, 24'

-- GOOGLE DATE AND TIME FORMATER FOR MORE
-- CALULATING DATES AND TIMES 
SELECT DATE_ADD(NOW(), INTERVAL 1 DAY) -- BY THIS YO UCAN ADD 1 DAY FROM CURRENT DATE 
SELECT DATE_ADD(NOW(), INTERVAL 1 YEAR) 
SELECT DATE_ADD(NOW(), INTERVAL -1 YEAR)  -- LAST YEAR 
DATE_SUB(NOW(), INTERVAL 1 YEAR) -- LAST YEAR
SELECT DATEDIFF('2019-01-05', '2019-01-01') -- GET SUBSTRATION OF DATE WITHOUT THE TIME
SELECT TIME_TO_SEC('06:00')  -- COUNTS THE TIME CHANGED TO SECONDS SELECT 6 * 60 * 60

-- SOME USEFULL FUNCTIONS

USE sql_store;

SELECT 
	order_id,
    IFNULL(shipper_id, 'Not assigned') AS shipper -- we can susbstitue null values with the string 
FROM orders ;


SELECT 
	order_id,
    COALESCE(shipper_id, comments, 'Not assigned') AS shipper -- if shipper_id is null it will returns comments if comments is null as well it will return the string place on 
FROM orders ;

SELECT 
	CONCAT(first_name ," ", last_name ) AS customer ,
	IFNULL(phone , "Unknown") AS phone
FROM customers;
-- THE IF STATMENTS 


SELECT 
	order_id,
    order_date,
    IF(YEAR(order_date) = '2019',
    'Active', 
    'Archived') AS category 
FROM orders ;

SELECT 
	product_id , 
    name,
	count(*) AS orders ,
    IF (count(*) > 1 , 'Many times' , 'Once' ) AS frequency
FROM products 
JOIN  order_items 
USING(product_id)
GROUP BY (product_id, name);

-- the case operator

SELECT 
	order_id,
    order_date,
    CASE 
		WHEN YEAR(order_date) = 2019 THEN 'Active'
		WHEN YEAR(order_date) = 2018 THEN 'Last Year'
    	WHEN YEAR(order_date) < 2018 THEN 'Archived' 
        ELSE 'Futher'
	END AS category
FROM orders ;

SELECT 
	CONCAT(first_name,' ', last_name) AS customer ,
    points,
    CASE
		WHEN points > 3000 THEN 'Gold'
        WHEN points >= 2000 THEN 'Silver'
        WHEN points < 2000 THEN 'Bronze'
	END AS category
FROM customers
ORDER BY  points DESC

