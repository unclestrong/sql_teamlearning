select product_name,product_type,sale_price,
        rank() over (partition by product_type
                     ORDER BY sale_price) as ranking
from product;

select product_name,product_type,sale_price,
        rank() over (order by sale_price) as ranking,
        dense_rank() over (order by sale_price) as dense_ranking,
        row_number() over (order by sale_price) as row_bnum
    from product;

select product_id,product_name,sale_price,
        sum(sale_price) over (order by product_id) as current_sum,
        avg(sale_price) over (order by product_id) as current_avg
    from product;

select product_id,product_name,sale_price,
        avg(sale_price) over (order by product_id
                              rows 2 preceding) as moving_avg,
        avg(sale_price) over (order by product_id
                              rows between 1 preceding and 1 following) as moving_avg
    from product;    

select product_type,regist_date,sum(sale_price) as sum_price
from product
group by product_type,regist_date with rollup;      



use shop;

PREPARE stmt1 FROM     
'SELECT  product_id, product_name FROM product 
 WHERE product_id = ?';

SET @pcid = '0005'; 

EXECUTE stmt1 USING @pcid;

DEALLOCATE PREPARE stmt1;

SELECT *
from product;

SELECT  product_id
       ,product_name
       ,sale_price
       ,MAX(sale_price) OVER (ORDER BY product_id) AS Current_max_price
  FROM product;

select product_id,product_name,sale_price,regist_date,
        sum(sale_price) over (order by regist_date) as current_sum_price
    from product;

SELECT product_name
       ,product_type
       ,sale_price
       ,RANK() OVER (ORDER BY sale_price) AS ranking
  FROM product;  
 
SELECT product_name
       ,product_type
       ,sale_price
       ,RANK() OVER (PARTITION BY product_type
                         ORDER BY sale_price) AS ranking
FROM product; 

-- 1.动态创建多张表存储过程：
DELIMITER $$
DROP PROCEDURE IF EXISTS world.p
CREATE DEFINER=`root`@`localhost` PROCEDURE `world`.`p`()
BEGIN
DECLARE i INT;
DECLARE table_name VARCHAR(20);
DECLARE table_pre VARCHAR(20);
DECLARE sql_text VARCHAR(2000);
SET i=1;
SET table_name='';
SET table_pre='table';
SET sql_text='';
WHILE i<21 DO
IF i<10 THEN SET table_name=CONCAT(table_pre,'0',i);
ELSE SET table_name=CONCAT(table_pre,i);
END IF;
SET sql_text=CONCAT('CREATE TABLE ', table_name, '(product_id CHAR(4) NOT NULL,
 product_name VARCHAR(100) NOT NULL,
 product_type VARCHAR(32) NOT NULL,
 sale_price INTEGER ,
 purchase_price INTEGER ,
 regist_date DATE ,
 PRIMARY KEY (product_id))');
SELECT sql_text;
SET @sql_text=sql_text;
PREPARE stmt FROM @sql_text;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
SET i=i+1;
END WHILE;
END$$
DELIMITER ;
-- 2.执行存储过程，创建表
CALL p();