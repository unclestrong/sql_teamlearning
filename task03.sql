create view productsum(product_type, cnt_product)
AS
SELECT product_type,count(*)
from product
GROUP BY product_type;

CREATE TABLE shop_product
(shop_id    CHAR(4)       NOT NULL,
 shop_name  VARCHAR(200)  NOT NULL,
 product_id CHAR(4)       NOT NULL,
 quantity   INTEGER       NOT NULL,
 PRIMARY KEY (shop_id, product_id));

INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000A',	'东京',		'0001',	30);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000A',	'东京',		'0002',	50);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000A',	'东京',		'0003',	15);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000B',	'名古屋',	'0002',	30);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000B',	'名古屋',	'0003',	120);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000B',	'名古屋',	'0004',	20);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000B',	'名古屋',	'0006',	10);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000B',	'名古屋',	'0007',	40);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000C',	'大阪',		'0003',	20);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000C',	'大阪',		'0004',	50);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000C',	'大阪',		'0006',	90);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000C',	'大阪',		'0007',	70);
INSERT INTO shop_product (shop_id, shop_name, product_id, quantity) VALUES ('000D',	'福冈',		'0001',	100);

create view view_shop_product(product_type, sale_price,shop_name)
AS
SELECT product_type,sale_price,shop_name
from product,shop_product
where product.product_id = shop_product.product_id;

SELECT sale_price, shop_name
from view_shop_product
where product_type = '衣服';

alter view productsum
as
select product_type,sale_price
from product
where regist_date > '2009-09-11';

update productsum
set sale_price = '5000'
where product_type = '办公用品';

select product_id, product_name, sale_price
from product
where sale_price > (SELECT avg(sale_price) from product);

SELECT avg(sale_price) from product;

SELECT product_id,
       product_name,
       sale_price,
       (SELECT AVG(sale_price)
          FROM product) AS avg_price
  FROM product;

  select product_type, product_name,sale_price
  from product as p1
  where sale_price > (
    select AVG(sale_price)
    from product as p2
    where p1.product_type = p2.product_type
    GROUP BY product_type
  );

alter view ViewPractice5_1(product_name,sale_price,regist_date)
as
SELECT product_name, sale_price,regist_date
from product
where sale_price >= 1000 and regist_date = '2009-09-20';

INSERT INTO ViewPractice5_1 VALUES (' 刀子 ', 300, '2009-11-02');

select product_id,product_name,product_type,sale_price,(SELECT avg(sale_price) from product) as sale_price_avg
from product;

create view AvgPriceByType(product_id,product_name,product_type,sale_price,);


create view type(product_type,avg)
AS
select product_type,AVG(sale_price)
from product as p1
GROUP BY product_type;



select * from
(select product_type,AVG(sale_price)
from product as p1
GROUP BY product_type) as p2
where p1.product_type = p2.product_type;


USE shop;
DROP TABLE IF EXISTS samplemath;
CREATE TABLE samplemath
(m NUMERIC(10,3),
 n INT,
 p INT);

-- DML ：插入数据
START TRANSACTION; -- 开始事务
INSERT INTO samplemath(m, n, p) VALUES (500, 0, NULL);
INSERT INTO samplemath(m, n, p) VALUES (-180, 0, NULL);
INSERT INTO samplemath(m, n, p) VALUES (NULL, NULL, NULL);
INSERT INTO samplemath(m, n, p) VALUES (NULL, 7, 3);
INSERT INTO samplemath(m, n, p) VALUES (NULL, 5, 2);
INSERT INTO samplemath(m, n, p) VALUES (NULL, 4, NULL);
INSERT INTO samplemath(m, n, p) VALUES (8, NULL, 3);
INSERT INTO samplemath(m, n, p) VALUES (2.27, 1, NULL);
INSERT INTO samplemath(m, n, p) VALUES (5.555,2, NULL);
INSERT INTO samplemath(m, n, p) VALUES (NULL, 1, NULL);
INSERT INTO samplemath(m, n, p) VALUES (8.76, NULL, NULL);
COMMIT; -- 提交事务
-- 查询表内容
SELECT * FROM samplemath;

SELECT m,
    ABS(m)ASabs_col ,
    n, p,
    MOD(n, p) AS mod_col,
    ROUND(m,1) AS round_col
FROM samplemath;

USE  shop;
DROP TABLE IF EXISTS samplestr;
CREATE TABLE samplestr
(str1 VARCHAR (40),
str2 VARCHAR (40),
str3 VARCHAR (40)
);
-- DML：插入数据
START TRANSACTION;
INSERT INTO samplestr (str1, str2, str3) VALUES ('opx',	'rt', NULL);
INSERT INTO samplestr (str1, str2, str3) VALUES ('abc', 'def', NULL);
INSERT INTO samplestr (str1, str2, str3) VALUES ('太阳',	'月亮', '火星');
INSERT INTO samplestr (str1, str2, str3) VALUES ('aaa',	NULL, NULL);
INSERT INTO samplestr (str1, str2, str3) VALUES (NULL, 'xyz', NULL);
INSERT INTO samplestr (str1, str2, str3) VALUES ('@!#$%', NULL, NULL);
INSERT INTO samplestr (str1, str2, str3) VALUES ('ABC', NULL, NULL);
INSERT INTO samplestr (str1, str2, str3) VALUES ('aBC', NULL, NULL);
INSERT INTO samplestr (str1, str2, str3) VALUES ('abc哈哈',  'abc', 'ABC');
INSERT INTO samplestr (str1, str2, str3) VALUES ('abcdefabc', 'abc', 'ABC');
INSERT INTO samplestr (str1, str2, str3) VALUES ('micmic', 'i', 'I');
COMMIT;

SELECT * FROM samplestr;

select str1,str2,str3,
CONCAT(str1,str2,str3) as str_concat,
length(str1) as len_str,
lower(str1) as low_str,
replace(str1,str2,str3) as rep_str,
substring(str1 from 3 for 2) as sub_str
from samplestr;

SELECT SUBSTRING_INDEX('www.mysql.com', '.', 2);

SELECT SUBSTRING_INDEX('www.mysql.com', '.', -2);

SELECT SUBSTRING_INDEX(SUBSTRING_INDEX('www.mysql.com', '.', 2), '.', -1);

SELECT CURRENT_DATE;
SELECT CURRENT_TIME;
SELECT CURRENT_TIMESTAMP;

SELECT CURRENT_TIMESTAMP as now,
EXTRACT(YEAR   FROM CURRENT_TIMESTAMP) AS year,
EXTRACT(MONTH  FROM CURRENT_TIMESTAMP) AS month,
EXTRACT(DAY    FROM CURRENT_TIMESTAMP) AS day,
EXTRACT(HOUR   FROM CURRENT_TIMESTAMP) AS hour,
EXTRACT(MINUTE FROM CURRENT_TIMESTAMP) AS MINute,
EXTRACT(SECOND FROM CURRENT_TIMESTAMP) AS second;

SELECT CAST('0001' AS SIGNED INTEGER) AS int_col;
SELECT CAST('2009-12-14' AS DATE) AS date_col;

SELECT COALESCE(NULL, 11) AS col_1,
COALESCE(NULL, 'hello world', NULL) AS col_2,
COALESCE(NULL, NULL, '2020-11-01') AS col_3;