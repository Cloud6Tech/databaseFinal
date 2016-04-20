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



CREATE TABLE orders(  	
	invoice_num INT NOT NULL, 
	product_id INT NOT NULL,
 	customer_id INT,
    	employee_id INT,
	quantity INT,
	order_date DATE
);

ALTER TABLE orders ADD (
    CONSTRAINT orders_pk 
	PRIMARY KEY (invoice_num, product_id)
);

ALTER TABLE orders ADD (
    CONSTRAINT order_product_fk
	FOREIGN KEY (product_id)
	REFERENCES product(product_id)
);

ALTER TABLE orders ADD (
    CONSTRAINT order_customer_fk
	FOREIGN KEY (customer_id)
	REFERENCES customer(customer_id)
);

ALTER TABLE orders ADD (
    CONSTRAINT order_employee_fk
	FOREIGN KEY (employee_id)
	REFERENCES employee(employee_id)
);

INSERT INTO product VALUES (1,'20lb letter','Multiuse paper suitable for document printing',14.99);
INSERT INTO product VALUES (2,'120lb letter-sand','Toothy stock in beige suitable for executive letterhead',39.99);
INSERT INTO product VALUES (3,'130lb matte card letter','Ultraheavy cardstock suitable for invitations and artwork',59.99);
INSERT INTO product VALUES (4,'135lb glossy card letter','Glossy cardstock suitable for durabel flyers',69.99);
INSERT INTO product VALUES (5,'50lb letter','Midweight paper suitable for more rugged printing',22.99);
INSERT INTO product VALUES (6,'24lb legal','Light duty legal paper, suitable for cheap law offices',19.99);
INSERT INTO product VALUES (7,'white index cards','Old fashioned and relaible',6.99);
INSERT INTO product VALUES (8,'colored index cards','A neon twist on a classic',8.99);
INSERT INTO product VALUES (9,'A4 lightweight','Useful for suspiciously european offices',11.99);
INSERT INTO product VALUES (10,'A4 heavyweight','A nice gag gift for the discerning paper consumer',13.99);
INSERT INTO product VALUES (11,'ledger','For the man or woman who already has everything',15.99);

INSERT INTO employee VALUES (1,'Bob','Loblaw','555 Main St','Sudden Valley','CA',94532,'1234567890',TO_DATE('2003/05/03', 'yyyy/mm/dd'));
INSERT INTO employee VALUES (2,'Doc','Holiday','1 OK Coral','Carnival','KA',66775,'9876543210',TO_DATE('2005/12/01', 'yyyy/mm/dd'));
INSERT INTO employee VALUES (3,'Franklin','Oliver','123 Generic Ave','Nondescript','CA',94522,'8520147890',TO_DATE('1999/10/02', 'yyyy/mm/dd'));
INSERT INTO employee VALUES (4,'Stanley','TheCat','10 Animal Shelter Way','San Francisco','CA',91586,'9825461350',TO_DATE('2009/11/22', 'yyyy/mm/dd'));
INSERT INTO employee VALUES (5,'Lester','Reuben','3 Not Sure Ct','Oakland','CA',91088,'6451239105',TO_DATE('2003/05/07', 'yyyy/mm/dd'));
INSERT INTO employee VALUES (6,'Ellie','McGear','768 Imnotcreative Dr','Talahassee','FL',10352,'9251847952',TO_DATE('2001/08/12', 'yyyy/mm/dd'));
INSERT INTO employee VALUES (7,'Wudderbumple','Widdershins','3 NowImJustNaming Ln','Wilmington','DE',11775,'1597560258',TO_DATE('2003/11/22', 'yyyy/mm/dd'));
INSERT INTO employee VALUES (8,'Tobias','Funke','4 DnDcharacters Blvd','Boulder','CO',52085,'4682513790',TO_DATE('1992/06/17', 'yyyy/mm/dd'));
INSERT INTO employee VALUES (9,'Ograk','Smash','6 Lazynaming Hwy','SantaFe','NM',45654,'6482467952',TO_DATE('2013/04/20', 'yyyy/mm/dd'));
INSERT INTO employee VALUES (10,'Benny','AndTheJets','29 Colonel Sanders Rd','Los Angeles','CA',92571,'5159841855',TO_DATE('2005/05/03', 'yyyy/mm/dd'));

INSERT INTO customer VALUES (1,'Dukakis Leather','Jenny Dukakis','134 Cat st','Orange','CA',45678,'8451325821',5);
INSERT INTO customer VALUES (2,'Randomness','Andrew Bernwalace','234 Dog Ave','Lagrange','WI',65498,'4152689520',1);
INSERT INTO customer VALUES (3,'GrassFed Beef','Duke Cornfarmer','563 Elephant Rd','Green','OR',52102,'5552154768',7);
INSERT INTO customer VALUES (4,'BassExpert Shoppe','Crawdad Joe','7632 Capybara Ct','Louisville','KT',65482,'8524659545',6);
INSERT INTO customer VALUES (5,'All Things Blue','Ellie Aoi','6732 Dingo Pkwy','Wilmington','VA',64852,'9413654825',4);
INSERT INTO customer VALUES (6,'Craziness Co','Rob Bobson','9205 Dodo Way','Oakland','CA',20158,'9156202584',3);
INSERT INTO customer VALUES (7,'WeScamU LLC','Bob Robson','2302 Gerbil St','Salt Lake City','UT',75395,'9446585210',2);
INSERT INTO customer VALUES (8,'WeDontScamU LLC','Robert Bobson III','6732 Orangutan Alley','Seattle','WA',15978,'5554851352',9);
INSERT INTO customer VALUES (9,'Not A Front Inc','Larry McMint','2062 Fennec Dr','Las Vegas','NV',85264,'9841516848',10);
INSERT INTO customer VALUES (10,'FluffyAnimals Unlimited','Angela Bamboo','7372 Lizard Ln','Monterey Bay','CA',16482,'9150648521',8);

INSERT INTO orders VALUES (1,1,1,1,122,TO_DATE('2015/05/03', 'yyyy/mm/dd'));
INSERT INTO orders VALUES (1,2,1,1,450,TO_DATE('2015/05/03', 'yyyy/mm/dd'));
INSERT INTO orders VALUES (1,3,1,1,900,TO_DATE('2015/05/03', 'yyyy/mm/dd'));
INSERT INTO orders VALUES (2,4,2,2,175,TO_DATE('2015/07/13', 'yyyy/mm/dd'));
INSERT INTO orders VALUES (2,5,2,2,1300,TO_DATE('2015/07/13', 'yyyy/mm/dd'));
INSERT INTO orders VALUES (3,6,3,3,1100,TO_DATE('2016/01/05', 'yyyy/mm/dd'));
INSERT INTO orders VALUES (3,7,3,3,250,TO_DATE('2016/01/05', 'yyyy/mm/dd'));
INSERT INTO orders VALUES (4,8,5,4,1000,TO_DATE('2016/01/10', 'yyyy/mm/dd'));
INSERT INTO orders VALUES (4,9,5,4,2000,TO_DATE('2016/01/10', 'yyyy/mm/dd'));
INSERT INTO orders VALUES (4,10,5,4,10,TO_DATE('2016/01/10', 'yyyy/mm/dd'));
INSERT INTO orders VALUES (4,1,5,4,20,TO_DATE('2016/01/10', 'yyyy/mm/dd'));
INSERT INTO orders VALUES (5,2,4,6,2650,TO_DATE('2016/01/19', 'yyyy/mm/dd'));
INSERT INTO orders VALUES (6,3,6,7,3245,TO_DATE('2016/02/01', 'yyyy/mm/dd'));
INSERT INTO orders VALUES (7,4,7,8,752,TO_DATE('2016/02/16', 'yyyy/mm/dd'));
INSERT INTO orders VALUES (8,6,9,9,1564,TO_DATE('2016/02/26', 'yyyy/mm/dd'));
INSERT INTO orders VALUES (9,5,8,10,3000,TO_DATE('2016/03/13', 'yyyy/mm/dd'));
INSERT INTO orders VALUES (10,7,10,5,10,TO_DATE('2016/03/27', 'yyyy/mm/dd'));
INSERT INTO orders VALUES (11,6,4,3,150,TO_DATE('2016/04/18', 'yyyy/mm/dd'));