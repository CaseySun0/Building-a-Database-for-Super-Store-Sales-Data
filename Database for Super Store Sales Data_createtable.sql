/*
GROUP NUMBER: 2
NAME: Karan Bhosale, Yingzi Yuan, Priyanka Chahande, Yiming Sun
TITLE: superstore sales data
*/

CREATE TABLE 201_G02.regional_manager(
	region_id INT(10) NOT NULL AUTO_INCREMENT,
    manager_name VARCHAR(20),
    region_name VARCHAR(20),
    PRIMARY KEY(region_id)
    );

CREATE TABLE 201_G02.cust_segment(
	cust_seg_id INT(10) NOT NULL AUTO_INCREMENT,
    cust_seg_name VARCHAR(20),
    PRIMARY KEY(cust_seg_id)
    );
    
CREATE TABLE 201_G02.customer(
	cust_id INT(10) NOT NULL,
    cust_name VARCHAR(100),
    PRIMARY KEY(cust_id)
	);

CREATE TABLE 201_G02.shipmode(
	shipmode_id INT(10) NOT NULL AUTO_INCREMENT,
    shipmode_name VARCHAR(20),
    PRIMARY KEY(shipmode_id)
    );
    
CREATE TABLE 201_G02.product_category(
	product_category_id INT(10) NOT NULL AUTO_INCREMENT,
    product_category_name TEXT,
    PRIMARY KEY(product_category_id)
    );
 
CREATE TABLE 201_G02.product_subcategory(
	product_subcategory_id INT(10) NOT NULL AUTO_INCREMENT,
    product_category_id INT(10) NOT NULL,
    product_subcategory_name TEXT,
    PRIMARY KEY(product_subcategory_id),
    CONSTRAINT product_category_fk FOREIGN KEY(product_category_id)
		REFERENCES 201_G02.product_category(product_category_id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
	);

CREATE TABLE 201_G02.address(
	address_id INT(10) NOT NULL AUTO_INCREMENT,
    country VARCHAR(20),
    region_id INT(10) NOT NULL,
    state VARCHAR(20),
    city VARCHAR(20),
    zip_code VARCHAR(10),
    PRIMARY KEY(address_id),
    CONSTRAINT regional_manager_fk FOREIGN KEY(region_id)
		REFERENCES 201_G02.regional_manager(region_id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
	);

CREATE TABLE 201_G02.product(
	product_id INT(10) NOT NULL AUTO_INCREMENT,
    product_subcategory_id INT(10) NOT NULL,
    product_name TEXT,
    product_base_margin DECIMAL(5,2),
    product_container VARCHAR(20),
    unit_price DECIMAL(8,2),
    PRIMARY KEY(product_id),
    CONSTRAINT product_subcategory_fk FOREIGN KEY(product_subcategory_id)
		REFERENCES 201_G02.product_subcategory(product_subcategory_id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
	);
 

CREATE TABLE 201_G02.order(
	order_id INT(10) NOT NULL,
	order_priority VARCHAR(20),
	order_date datetime,
	address_id INT(10) NOT NULL,
	cust_id INT(10) NOT NULL,
    cust_seg_id INT(10) NOT NULL,
	PRIMARY KEY(order_id),
	CONSTRAINT address_fk FOREIGN KEY(address_id)
		REFERENCES 201_G02.address(address_id)
		ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT customer_fk FOREIGN KEY(cust_id)
		REFERENCES 201_G02.customer(cust_id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT cust_segment_fk FOREIGN KEY(cust_seg_id)
		REFERENCES 201_G02.cust_segment(cust_seg_id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
	);

   
CREATE TABLE 201_G02.order_product(
	product_id INT(10) NOT NULL,
    order_id INT(10) NOT NULL,
    discount DECIMAL(8,2),
    shipmode_id INT(10) NOT NULL,
    ship_date DATETIME,
    shipping_cost DECIMAL(8,2),
    sales DECIMAL(8,2),
    profit DECIMAL(16,4),
    quantity_order_new INT(10),
    PRIMARY KEY(product_id, order_id),
    CONSTRAINT product_fk FOREIGN KEY(product_id)
		REFERENCES 201_G02.product(product_id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT order_fk FOREIGN KEY(order_id)
		REFERENCES 201_G02.order(order_id)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT shipmode_fk FOREIGN KEY(shipmode_id)
		REFERENCES 201_G02.shipmode(shipmode_id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
	);
    
    
    