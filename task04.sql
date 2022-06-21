select product_id,product_name
from product
UNION
select product_id,product_name
from product2;

select *
from product
where (sale_price-purchase_price)/sale_price >= 0.5 or sale_price < 800
UNION
select *
from product2
where (sale_price-purchase_price)/sale_price >= 0.5 or sale_price < 800;

-- 参考答案:
SELECT  product_id,product_name,product_type
       ,sale_price,purchase_price
  FROM PRODUCT 
 WHERE sale_price<800
  
 UNION
 
SELECT  product_id,product_name,product_type
       ,sale_price,purchase_price
  FROM PRODUCT 
 WHERE sale_price>1.5*purchase_price;

-- 保留重复行
SELECT product_type
  FROM Product
 UNION ALL
SELECT product_type
  FROM Product2;

SELECT * 
  FROM Product 
 WHERE sale_price < 1000
 UNION ALL
SELECT * 
  FROM Product 
 WHERE sale_price < 1.5 * purchase_price;

 SELECT * 
  FROM Product 
 WHERE sale_price < 1000
 UNION ALL
SELECT * 
  FROM Product 
 WHERE sale_price < 1.5 * purchase_price;

 SELECT product_id, product_name, '1'
  FROM Product
 UNION
SELECT product_id, product_name,sale_price
  FROM Product2;

SELECT SYSDATE(), SYSDATE(), SYSDATE()
 
 UNION
 
SELECT 'chars', 123, null;

SELECT product_id, product_name
  FROM Product
  
INTERSECT
SELECT product_id, product_name
  FROM Product2;

select p1.product_id,p1.product_name
from product p1
inner join product p2
on p1.product_id = p2.product_id;

select *
from product
where product_id not IN(
  select product_id
  from product2
);

select *
from product
where sale_price > 2000
and product_id not in (
  select product_id
  from product
  where sale_price < 1.3*purchase_price
);

select *
from product
where product_id not in(SELECT product_id from product2)
UNION
select *
from product2
where product_id not in(select product_id from product);

SELECT SP.shop_id
       ,SP.shop_name
       ,SP.product_id
       ,P.product_name
       ,P.product_type
       ,P.sale_price
       ,SP.quantity
from shopproduct as SP
inner join product as p 
on sp.product_id = p.product_id;

SELECT *
FROM (-- 第一步查询的结果
       SELECT SP.shop_id
               ,SP.shop_name
               ,SP.product_id
              ,P.product_name
               ,P.product_type
               ,P.sale_price
               ,SP.quantity
        FROM shopproduct AS SP INNER JOIN product AS P
        ON SP.product_id = P.product_id) AS STEP1
 WHERE shop_name = '东京'
   AND product_type = '衣服';

SELECT SP.shop_id
       ,SP.shop_name
       ,SP.product_id
      ,P.product_name
       ,P.product_type
       ,P.sale_price
       ,SP.quantity
from shopproduct as SP inner join product as p
on (SP.product_id = P.product_id
   AND SP.shop_name = '东京'
   AND P.product_type = '衣服') ;

select sp.shop_id,sp.shop_name,MAX(p.sale_price) as max_price
from shopproduct as sp inner join product as p
on sp.product_id = p.product_id
GROUP BY sp.shop_id,sp.shop_name;

select product_type,product_name,sale_price
from product as p1
where sale_price > (
  select avg(sale_price)
  from product as p2
  where p1.product_id = p2.product_id
  group by product_type
);

select product_type,AVG(sale_price) as avg_price
from product
group by product_type;

select p1.product_id,
       p1.product_name,
       p1.product_type,
       p1.sale_price,
       p2.avg_price
from product as p1 inner join(
  select product_type,avg(sale_price) as avg_price
  from product
  group by product_type
) as p2 on p1.product_type = p2.product_type;


select p1.product_id,
       p1.product_name,
       p1.product_type,
       p1.sale_price,
       p2.avg_price
from product as p1 inner join(
  select product_type,avg(sale_price) as avg_price
  from product
  group by product_type
) as p2 on p1.product_type = p2.product_type
where p1.sale_price > p2.avg_price;

SELECT *  FROM shopproduct NATURAL JOIN Product;

select sp.shop_id,sp.shop_name,sp.product_id,
        p.product_name,p.sale_price
from product as p left join shopproduct as sp
on sp.product_id = p.product_id;

select p.product_id,p.product_name,p.sale_price,
       sp.shop_id,sp.shop_name,sp.quantity
from product as p
left join (
  select *
  from shopproduct
  where quantity < 50
) as p
on sp.product_id = p.product_id;

SELECT P.product_id
      ,P.product_name
      ,P.sale_price
       ,SP.shop_id
      ,SP.shop_name
      ,SP.quantity 
  FROM product AS P
  LEFT OUTER JOIN-- 先筛选quantity<50的商品
   (SELECT *
      FROM shopproduct
     WHERE quantity < 50 ) AS SP
    ON SP.product_id = P.product_id;

CREATE TABLE InventoryProduct
( inventory_id       CHAR(4) NOT NULL,
product_id         CHAR(4) NOT NULL,
inventory_quantity INTEGER NOT NULL,
PRIMARY KEY (inventory_id, product_id));


SELECT SP.shop_id
       ,SP.shop_name
       ,SP.product_id
      ,P.product_name
       ,P.sale_price
       ,IP.inventory_quantity
 FROM shopproduct AS SP
INNER JOIN product AS P
   ON SP.product_id = P.product_id
 INNER JOIN inventoryproduct AS IP
   ON SP.product_id = IP.product_id
WHERE IP.inventory_id = 'P001';

SELECT P.product_id
       ,P.product_name
       ,P.sale_price
      ,SP.shop_id
       ,SP.shop_name
       ,IP.inventory_quantity
 FROM product AS P
  LEFT OUTER JOIN shopproduct AS SP
ON SP.product_id = P.product_id
LEFT OUTER JOIN inventoryproduct AS IP
ON SP.product_id = IP.product_id;

SELECT  product_id
       ,product_name
       ,sale_price
       ,COUNT(p2_id) AS my_rank
  FROM (--使用自左连结对每种商品找出价格不低于它的商品
       SELECT P1.product_id
              ,P1.product_name
              ,P1.sale_price
              ,P2.product_id AS P2_id
              ,P2.product_name AS P2_name
              ,P2.sale_price AS P2_price
         FROM Product AS P1 
        LEFT OUTER JOIN Product AS P2
           ON P1.sale_price <= P2.sale_price
        ) AS X
 GROUP BY product_id, product_name, sale_price
 ORDER BY my_rank;

 -- 1.使用关键字 CROSS JOIN 显式地进行交叉连结
SELECT SP.shop_id
       ,SP.shop_name
       ,SP.product_id
      ,P.product_name
       ,P.sale_price
  FROM ShopProduct AS SP
CROSS JOIN Product AS P;

select *
from product
where sale_price > 500
UNION
select *
from product2
where sale_price > 500;

SELECT * from product
where product_id not in(SELECT product_id 
  FROM Product
 WHERE product_id NOT IN (SELECT product_id FROM Product2)
UNION
SELECT product_id
  FROM Product2
 WHERE product_id NOT IN (SELECT product_id FROM Product));



SELECT p.product_type,max(p.sale_price),sp.shop_name
from product as p LEFT join shopproduct as sp
on p.product_id = sp.product_id
GROUP BY product_type;

select *
from product
where sale_price in(select max(sale_price)
from product
GROUP BY product_type);

select *
from product as p1 INNER join product as p2
where p1.;

select product_id,product_name,sale_price,(SELECT sum(sale_price) from product)
from product
order by sale_price;


