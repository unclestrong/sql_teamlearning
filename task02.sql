use shop;

SELECT product_name, product_type
FROM product
WHERE product_type='衣服';

SELECT product_name
FROM product
WHERE product_type = '衣服';

select * from product;

select product_id As id,product_name As name,purchase_price as '进货单价' from product;

select distinct product_type from product;

select product_name,product_type from product where sale_price = 500;

SELECT *
  FROM product
 WHERE purchase_price is not NULL;

 SELECT product_name,sale_price,sale_price * 2 as 'sale_price×2'
 from product;

 select product_name,sale_price,purchase_price 
 from product
 where sale_price - purchase_price >= 500;

 create table chrs
 (chr char(3) not null,
 primary key(chr));
 select chr from chars WHERE chr > '2';

 select product_name,purchase_price
 from product
 where purchase_price is null;

 select product_name, product_type, sale_price
 from product
 where not sale_price >= 1000;

 select product_name,product_type,regist_date
 from product
 where product_type = '办公用品'
 and regist_date = '2009-09-11'
 or regist_date = '2009-09-20';

 select product_name,product_type,regist_date
 from product
 where product_type = '办公用品'
 and (regist_date = '2009-09-11' or regist_date = '2009-09-20');

 SELECT *
  FROM product
 WHERE purchase_name > NULL;

 select product_name,sale_price,purchase_price
 from product
 where sale_price-purchase_price >= 500;

 SELECT product_name,sale_price,purchase_price
 from product
 where not sale_price-purchase_price < 500;

 select product_name,product_type
 from product
 where sale_price*0.9 - purchase_price >=100;


select count(*) from product;

select count(purchase_price) from product;

select sum(sale_price),sum(purchase_price) from product;

SELECT AVG(sale_price), AVG(purchase_price)
  FROM product;
-- MAX和MIN也可用于非数值型数据
SELECT MAX(regist_date), MIN(regist_date)
  FROM product;

  select COUNT(distinct product_type)
  from product;

  select product_type,count(*) from product;

select product_type,count(*)
from product
GROUP BY product_type;

select product_type,sale_price
from product
GROUP BY product_type;

select product_type from product GROUP BY product_type;

select distinct product_type,count(*) from product;

SELECT purchase_price,count(*)
from product
GROUP BY purchase_price;

SELECT purchase_price,count(*)
from product
WHERE product_type = '衣服'
GROUP BY purchase_price;

SELECT purchase_price
from product
WHERE product_type = '衣服';

SELECT product_type, COUNT(*)
from product
GROUP BY product_type
HAVING count(*) >= 2;

SELECT product_id,product_name,sale_price,purchase_price
from product
ORDER BY sale_price DESC;

CREATE TABLE user (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(5),
    date_login DATE,
    PRIMARY KEY (id)
);

INSERT INTO user(name, date_login) VALUES
(NULL,    '2017-03-12'), 
('john',   NULL), 
('david', '2016-12-24'), 
('zayne', '2017-03-02');

SELECT * from user
ORDER BY name is null,name ASC;

SELECT * from `user`
ORDER BY isnull(name),name ASC;

SELECT * FROM `user`
ORDER BY coalesce(name,'zzzzzz') ASC;

SELECT * from `user`
ORDER BY name is not null,name DESC;

SELECT * FROM `user`
ORDER BY -date_login;

SELECT * from `user`
ORDER BY name is NOT null;


select * from(SELECT product_type,SUM(sale_price) as sum1,SUM(purchase_price) as sum2
from product
GROUP BY product_type
HAVING sum1 > sum2*1.5);

SELECT product_type,SUM(sale_price) as sum,SUM(purchase_price) as sum
from product
GROUP BY product_type
HAVING SUM(sale_price) > SUM(purchase_price)*1.5;


SELECT * 
from product
ORDER BY regist_date desc,regist_date DESC;

SELECT product_id
--本SELECT语句中存在错误。
  FROM product 
 GROUP BY product_type 