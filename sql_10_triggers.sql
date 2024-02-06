DROP TRIGGER IF EXISTS payments_after_insert ;
-- creating trigger 
-- trigger is a code block that runs after or befor some sql statments
-- naming convenstions tablename_after/before_thestatement/insert  
DELIMITER $$

CREATE TRIGGER payments_after_insert 
	AFTER INSERT ON payments
    FOR EACH ROW 
BEGIN 
	UPDATE invoices 
    SET payment_total = payment_total + NEW.amount
    WHERE invoice_id = NEW.invoice_id;
    INSERT INTO payment_audit
    VALUES (NEW.client_id , NEW.date, NEW.amount, 'Insert', NOW());
END $$
DELIMITER ;
-- -------------------------------------------------------------
DROP TRIGGER IF EXISTS payments_after_delete ;
DELIMITER $$
CREATE TRIGGER payments_after_delete
	AFTER DELETE ON payments
    FOR EACH ROW
BEGIN 
	UPDATE invoices
    SET payment_total = payment_total - OLD.amount
    WHERE invoice_id = OLD.invoice_id;
    
	INSERT INTO payment_audit
    VALUES (OLD.client_id , OLD.date, OLD.amount, 'Delete', NOW());

END $$

DELIMITER ;
-- -------------------
SHOW TRIGGERS LIKE 'payments%';

-- -----------------------------------------


INSERT INTO payments
VALUES( DEFAULT , 5, 3, '2019-01-01' ,10 , 1);

DELETE FROM payments
WHERE payment_id = 24;

-- ------------------------------------------------

USE sql_invoicing;

CREATE TABLE payment_audit
(
	client_id     INT            NOT NULL,
    date          DATE           NOT NULL,
    amount        DECIMAL(9,2 )  NOT NULL,
    action_type   VARCHAR(50)    NOT NULL,
    action_date   DATETIME       NOT NULL
);

-- -------------------------------------

-- EVENTS mean a block of code or a task the get executed according to a schedule 

SHOW VARIABLES LIKE 'event%'; -- chekind the even status 
SET GLOBAL event_scheduler = ON; -- turn it on the even listner

-- creating an Event 
-- THE TAST ONLY ONE TIME L73
DELIMITER $$

CREATE EVENT yearly_delete_stale_audit_rows
ON SCHEDULE
	-- AT '2019-05-01' 
    EVERY 1 YEAR STARTS '2019-01-01' ENDS '2029-01-01'
DO BEGIN 
	DELETE FROM payments_audit
    WHERE action_date < NOW() - INTERVAL 1 YEAR ;
END $$
DELIMITER ;

SHOW EVENTS;
DROP EVENT IF EXISTS EVENT_NAME;

ALTER EVENT yearly_delete_stale_audit_rows DISABLE -- TO TEMPORALY TURN AAN EVEN OFF 
    