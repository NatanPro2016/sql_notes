CREATE DATABASE er_digrams;
USE er_digrams;

CREATE TABLE Branch(
	branch_id VARCHAR(20),
    branch_name VARCHAR(50),
    mgr_id VARCHAR(20),
    mgr_start_date DATE,
    PRIMARY KEY (branch_id)
);
CREATE TABLE Employee(
	emp_id VARCHAR(20) NOT NULL ,
    first_name VARCHAR(50) ,
    last_name VARCHAR(50),
    birth_date DATE, 
    sex CHAR(1),
    salary INT,
    super_id VARCHAR(20) ,
	brach_id VARCHAR(20),
    PRIMARY KEY (emp_id),
    FOREIGN KEY (super_id) REFERENCES Employee(emp_id),
    FOREIGN KEY (brach_id) REFERENCES Branch(branch_id)

);



CREATE TABLE Client(
	client_id VARCHAR(20),
    client_name VARCHAR(100),
    branch_id varchar(20),
    PRIMARY KEY (client_id),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

CREATE TABLE branch_supplier(
	branch_id VARCHAR(20) NOT NULL,
    supplier_name VARCHAR(20) NOT NULL,
    supply_type VARCHAR(50) ,
    PRIMARY KEY (branch_id , supplier_name),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);
CREATE TABLE Works_on(
	emp_id VARCHAR(20) NOT NULL ,
    client_id VARCHAR(20) NOT NULL,
    total_sales VARCHAR(50), 
    PRIMARY KEY(emp_id , client_id),
    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id),
    FOREIGN KEY (client_id) REFERENCES Client(client_id)
);

ALTER TABLE Employee
DROP FOREIGN KEY Employee_ibfk_1;



INSERT INTO Branch
VALUES ("1" , "Scranton" , "101" , "1992-04-06");
INSERT INTO Branch
VALUES ("2" , "Stamford" , "102" , "1998-02-13");
INSERT INTO Branch
VALUES ("3" , "Corporate" , "108" , "2005-02-09");

INSERT INTO Employee
VALUES ("100" , "Jon" , "Levisnion" , "1961-05-11" ,"F" ,110000, "101" , "1");
INSERT INTO Employee
VALUES ("101" , "Michael" , "Scott" , "1964-03-15" ,"M" ,75000, "100" , "2");
INSERT INTO Employee
VALUES ("102" , "Josh" , "Martin" , "1969-09-05" ,"M" ,78000, "100" , "3");
INSERT INTO Employee
VALUES ("103" , "Angela" , "Brenard" , "1971-06-25" ,"F" ,63000, "101" , "2");
INSERT INTO Employee
VALUES ("104" , "Andy" , "Halpert" , "1973-07-22" ,"M" ,65000, "102" , "3");
INSERT INTO Employee
VALUES ("105" , "Jim" , "Halpert" , "1978-10-01" ,"M" ,71000, "102" , "3");
INSERT INTO Employee
VALUES ("106" , "kelly" , "Kapoor" , "1980-02-05" ,"F" ,55000, "101" , "2");
INSERT INTO Employee
VALUES ("107" , "Stanley" , "Hudson" , "1958-02-19" ,"M" ,69000, "101" , "2");
INSERT INTO Employee
VALUES ("108" , "David" , "Wallance" , "1967-11-17" ,"M" ,25000, NULL , "1");

DELETE  FROM Employee
WHERE Super_id = "108" ;

UPDATE Employee
SET super_id = "108"
WHERE emp_id = "100";

ALTER TABLE Employee
ADD CONSTRAINT FK_Manages
FOREIGN KEY (super_id) REFERENCES Employee(emp_id);

ALTER TABLE Employee
DROP FOREIGN KEY FK_Manages;

ALTER TABLE Branch
ADD CONSTRAINT FK_Manages
FOREIGN KEY (mgr_id) REFERENCES Employee(emp_id);

INSERT INTO Client
VALUES ("400" , "Dunmore Highschool" , "2");
INSERT INTO Client
VALUES ("401" , "Laclwana Country" , "2");
INSERT INTO Client
VALUES ("402" , "FedEx" , "3");
INSERT INTO Client
VALUES ("403" , "John daly Law LCC" , "3");
INSERT INTO Client
VALUES ("404" , "Scranton Whitepages" , "2");
INSERT INTO Client
VALUES ("405" , "Timesaper" , "3");
INSERT INTO Client
VALUES ("406" , "FedEX" , "2");

INSERT INTO Works_on VALUES ("107", "400", 55000);
INSERT INTO Works_on VALUES ("101", "401", 267000);
INSERT INTO Works_on VALUES ("105", "402", 22500);
INSERT INTO Works_on VALUES ("104", "403", 5000);
INSERT INTO Works_on VALUES ("105", "403", 12000);
INSERT INTO Works_on VALUES ("107", "404", 33000);
INSERT INTO Works_on VALUES ("104", "405", 26000);
INSERT INTO Works_on VALUES ("101", "406", 15000);
INSERT INTO Works_on VALUES ("107", "406", 130000);

INSERT INTO branch_supplier VALUES("2" , "Hammer Mill", "Paper");
INSERT INTO branch_supplier VALUES("2" , "Uni-ball", "Writing Utensils");
INSERT INTO branch_supplier VALUES("3" , "Patriot Paper", "Paper");
INSERT INTO branch_supplier VALUES("2" , "J.T Forms & Labels", "Custome Forms");
INSERT INTO branch_supplier VALUES("3" , "Uni-ball", "Writting Ultensis ");
INSERT INTO branch_supplier VALUES("3" , "Hammer Mill", "Paper");
INSERT INTO branch_supplier VALUES("3" , "Samfour Lames", "Customer Forms");


