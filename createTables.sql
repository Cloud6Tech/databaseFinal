DROP TABLE invoice;
DROP TABLE orders;
DROP TABLE customer;
DROP TABLE employee;
DROP TABLE product;

-- PRODUCT table

DROP SEQUENCE product_id_seq;
CREATE SEQUENCE product_id_seq;

CREATE TABLE product(	
	product_id INT NOT NULL,
	product_name VARCHAR2(25), 
	product_description VARCHAR2(100),
	product_ppu FLOAT
);

ALTER TABLE product ADD (
   CONSTRAINT product_pk PRIMARY KEY (product_id)
);

CREATE OR REPLACE TRIGGER product_bir
BEFORE INSERT ON product
FOR EACH ROW

BEGIN
  SELECT product_id_seq.NEXTVAL
  INTO :new.product_id
  FROM dual;
END;
/

-- EMPLOYEE table

DROP SEQUENCE employee_id_seq;
CREATE SEQUENCE employee_id_seq;

CREATE TABLE employee(  
	employee_id INT NOT NULL,
	employee_fname VARCHAR2(15),
	employee_lname VARCHAR2(15),
	employee_address VARCHAR2(30),
	employee_city VARCHAR2(25),
	employee_state CHAR(2),
	employee_zip INT,
	employee_phone VARCHAR2(10),
	employee_hireDate DATE
);

ALTER TABLE employee ADD (
    CONSTRAINT employee_pk PRIMARY KEY (employee_id)
);

CREATE OR REPLACE TRIGGER employee_bir
BEFORE INSERT ON employee
FOR EACH ROW

BEGIN
  SELECT employee_id_seq.NEXTVAL
  INTO :new.employee_id
  FROM dual;
END;
/

-- CUSTOMER table

DROP SEQUENCE customer_id_seq;
CREATE SEQUENCE customer_id_seq;

CREATE TABLE customer(	
	customer_id INT NOT NULL,
	customer_company VARCHAR2(25),
	customer_contact VARCHAR2(25),
	customer_address VARCHAR2(30),
	customer_city VARCHAR2(25),
	customer_state CHAR(2),
	customer_zip INT,
	customer_phone VARCHAR(10),
	employee_id INT
);

ALTER TABLE customer ADD (
    CONSTRAINT customer_pk 
	PRIMARY KEY (customer_id)
);

ALTER TABLE customer ADD (
   CONSTRAINT cusomter_employee_fk 
	FOREIGN KEY (employee_id)
	REFERENCES employee(employee_id)
);

CREATE OR REPLACE TRIGGER customer_bir
BEFORE INSERT ON customer
FOR EACH ROW

BEGIN
  SELECT customer_id_seq.NEXTVAL
  INTO :new.customer_id
  FROM dual;
END;
/


-- ORDERS table

DROP SEQUENCE invoice_num_seq;
CREATE SEQUENCE invoice_num_seq;

CREATE TABLE orders(  	
	invoice_num INT NOT NULL, 
 	customer_id INT,
	order_date DATE
);

ALTER TABLE orders ADD (
    CONSTRAINT orders_pk 
	PRIMARY KEY (invoice_num)
);

ALTER TABLE orders ADD (
    CONSTRAINT order_customer_fk
	FOREIGN KEY (customer_id)
	REFERENCES customer(customer_id)
);

CREATE OR REPLACE TRIGGER orders_bir
BEFORE INSERT ON orders
FOR EACH ROW

BEGIN
  SELECT invoice_num_seq.NEXTVAL
  INTO :new.invoice_num
  FROM dual;
END;
/


-- INVOICE table
CREATE TABLE invoice(
	invoice_num INT NOT NULL, 
 	product_id INT NOT NULL,
	quantity INT
);

ALTER TABLE invoice ADD (
    CONSTRAINT invoice_pk 
	PRIMARY KEY (invoice_num,product_id)
);

ALTER TABLE invoice ADD (
    CONSTRAINT invoice_invoice_fk
	FOREIGN KEY (invoice_num)
	REFERENCES orders(invoice_num)
);

ALTER TABLE invoice ADD (
    CONSTRAINT invoice_product_fk
	FOREIGN KEY (product_id)
	REFERENCES product(product_id)
);