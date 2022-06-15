CREATE DATABASE shop;



CREATE TABLE product
(product_id CHAR(4) NOT NULL,
product_name VARCHAR(100) NOT NULL,
product_type VARCHAR(32) NOT NULL,
sale_price INTEGER ,
purchase_price INTEGER ,
regist_date DATE ,
PRIMARY KEY (product_id));

drop Table product;


CREATE TABLE product
(product_id CHAR(4) NOT NULL,
product_name VARCHAR(100) NOT NULL,
product_type VARCHAR(32) NOT NULL,
sale_price INTEGER ,
purchase_price INTEGER ,
regist_date DATE ,
PRIMARY KEY (product_id));

ALTER Table product ADD COLUMN product_name_pinyin VARCHAR(100);

ALTER Table product DROP COLUMN product_name_pinyin;

DELETE FROM product WHERE product_name = 'laptop';

UPDATE product SET regist_date =  '2009-10-10';

UPDATE product SET sale_price = sale_price*10  WHERE product_type = 'tech';

UPDATE product
SET regist_date = NULL
WHERE product_id = '002';

UPDATE product 
SET sale_price = sale_price*10,purchase_price = purchase_price/2
WHERE product_type = 'tech';

CREATE TABLE productins
(product_id    CHAR(4)      NOT NULL,
product_name   VARCHAR(100) NOT NULL,
product_type   VARCHAR(32)  NOT NULL,
sale_price     INTEGER      DEFAULT 0,
purchase_price INTEGER ,
regist_date    DATE ,
PRIMARY KEY (product_id)); 

INSERT INTO productins (product_id, product_name, product_type, sale_price, purchase_price, regist_date) 
VALUES ('0005', '高压锅', '厨房用具', 6800, 5000, '2009-01-15');

INSERT INTO productins VALUES 
('0006', '高压锅', '厨房用具', 6800, 5000, '2009-01-15');

INSERT INTO productins VALUES ('0002', '打孔器', '办公用品', 500, 320, '2009-09-11'),
                              ('0003', '运动T恤', '衣服', 4000, 2800, NULL),
                              ('0004', '菜刀', '厨房用具', 3000, 2800, '2009-09-20');

INSERT INTO productins (product_id, product_name, product_type, sale_price, purchase_price, regist_date) 
VALUES ('0006', '叉子', '厨房用具', 500, NULL, '2009-09-20');

CREATE TABLE productcopy
(product_id    CHAR(4)      NOT NULL,
product_name   VARCHAR(100) NOT NULL,
product_type   VARCHAR(32)  NOT NULL,
sale_price     INTEGER      DEFAULT 0,
purchase_price INTEGER ,
regist_date    DATE ,
PRIMARY KEY (product_id)); 

INSERT INTO productcopy (product_id, product_name, product_type, sale_price, purchase_price, regist_date)
SELECT product_id, product_name, product_type, sale_price, purchase_price, regist_date
  FROM product;

INSERT INTO product VALUES('0001', 'T恤衫', '衣服', 1000, 500, '2009-09-20');
INSERT INTO product VALUES('0002', '打孔器', '办公用品', 500, 320, '2009-09-11');
INSERT INTO product VALUES('0003', '运动T恤', '衣服', 4000, 2800, NULL);
INSERT INTO product VALUES('0004', '菜刀', '厨房用具', 3000, 2800, '2009-09-20');
INSERT INTO product VALUES('0005', '高压锅', '厨房用具', 6800, 5000, '2009-01-15');
INSERT INTO product VALUES('0006', '叉子', '厨房用具', 500, NULL, '2009-09-20');
INSERT INTO product VALUES('0007', '擦菜板', '厨房用具', 880, 790, '2008-04-28');
INSERT INTO product VALUES('0008', '圆珠笔', '办公用品', 100, NULL, '2009-11-11');
COMMIT;

CREATE TABLE mytable(  
 ID INT NOT NULL,   
 username VARCHAR(16) NOT NULL,  
 INDEX (username(16)) );  

CREATE INDEX indexname ON product(product_name);

ALTER table product add INDEX indexname3(product_name);

CREATE TABLE Addressbook(  
    regist_no INT NOT NULL,   
    name VARCHAR(128) NOT NULL,  
    address VARCHAR(256) NOT NULL,
    tel_no VARCHAR(10),
    mail_address VARCHAR(20)
);

ALTER TABLE addressbook ADD column postal_code char(8) NOT NULL;