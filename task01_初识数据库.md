# Task 01：初识数据库

# 初识SQL

## 数据库的创建（ CREATE DATABASE 语句）

创建本课程使用的数据库

```sql
CREATE DATABASE shop;
```

![image-20220613091725781](./img/image-20220613091725781.png)

切换到当前数据库

![image-20220613095013598](./img/image-20220613095013598.png)

## 表的创建（ CREATE TABLE 语句）

![image-20220613101801130](./img/image-20220613101801130.png)

## 表的删除和更新

* 删除 product 表

需要特别注意的是，删除的表是无法恢复的，只能重新插入，请执行删除操作时要特别谨慎。

```sql
DROP TABLE product;
```

![image-20220613112615167](./img/image-20220613112615167.png)

- 添加列的 ALTER TABLE 语句

```sql
ALTER TABLE < 表名 > ADD COLUMN < 列的定义 >;
```

- 添加一列可以存储100位的可变长字符串的 product_name_pinyin 列

```sql
ALTER TABLE product ADD COLUMN product_name_pinyin VARCHAR(100);
```

![image-20220613113548080](./img/image-20220613113548080.png)

![image-20220613113631666](./img/image-20220613113631666.png)



- 删除列的 ALTER TABLE 语句

```sql
ALTER TABLE < 表名 > DROP COLUMN < 列名 >;
```

- 删除 product_name_pinyin 列

```sql
ALTER TABLE product DROP COLUMN product_name_pinyin;
```

![image-20220613113944514](./img/image-20220613113944514.png)

![image-20220613113930285](./img/image-20220613113930285.png)

- 删除表中特定的行（语法）

```sql
-- 一定注意添加 WHERE 条件，否则将会删除所有的数据
DELETE FROM product WHERE COLUMN_NAME='XXX';
```

ALTER TABLE 语句和 DROP TABLE 语句一样，执行之后无法恢复。误添加的列可以通过 ALTER TABLE 语句删除，或者将表全部删除之后重新再创建。

![image-20220613212038764](./img/image-20220613212038764.png)

![image-20220613212219936](./img/image-20220613212219936.png)

![image-20220613212234517](./img/image-20220613212234517.png)

【扩展内容】

* 清空表内容

```sql
TRUNCATE TABLE TABLE_NAME;
```

优点：相比`drop / delete`，`truncate`用来清除数据时，速度最快。

* 数据的更新

基本语法：

```sql
UPDATE <表名>
   SET <列名> = <表达式> [, <列名2>=<表达式2>...]  
 WHERE <条件>  -- 可选，非常重要
 ORDER BY 子句  --可选
 LIMIT 子句; --可选
```

**使用 update 时要注意添加 where 条件，否则将会将所有的行按照语句修改**

```sql
-- 修改所有的注册时间
UPDATE product
   SET regist_date = '2009-10-10';  
-- 仅修改部分商品的单价
UPDATE product
   SET sale_price = sale_price * 10
 WHERE product_type = '厨房用具';  
```

![image-20220613212430190](./img/image-20220613212430190.png)

![image-20220613212416434](./img/image-20220613212416434.png)

![image-20220613214433743](./img/image-20220613214433743.png)

![image-20220613214448951](./img/image-20220613214448951.png)

使用 UPDATE 也可以将列更新为 NULL（该更新俗称为NULL清空）。此时只需要将赋值表达式右边的值直接写为 NULL 即可。

```sql
-- 将商品编号为0008的数据（圆珠笔）的登记日期更新为NULL  
UPDATE product
   SET regist_date = NULL
 WHERE product_id = '0008';  
```

![image-20220613214645729](./img/image-20220613214645729.png)

![image-20220613214632092](./img/image-20220613214632092.png)

和 INSERT 语句一样， UPDATE 语句也可以将 NULL 作为一个值来使用。
**但是，只有未设置 NOT NULL 约束和主键约束的列才可以清空为NULL。**如果将设置了上述约束的列更新为 NULL，就会出错，这点与INSERT 语句相同。

多列更新

UPDATE 语句的 SET 子句支持同时将多个列作为更新对象。

```sql
-- 基础写法，一条UPDATE语句只更新一列
UPDATE product
   SET sale_price = sale_price * 10
 WHERE product_type = '厨房用具';
UPDATE product
   SET purchase_price = purchase_price / 2
 WHERE product_type = '厨房用具';  
```

该写法可以得到正确结果，但是代码较为繁琐。可以采用合并的方法来简化代码。

```sql
-- 合并后的写法
UPDATE product
   SET sale_price = sale_price * 10,
       purchase_price = purchase_price / 2
 WHERE product_type = '厨房用具';  
```

需要明确的是，SET 子句中的列不仅可以是两列，还可以是三列或者更多。

![image-20220613215149875](./img/image-20220613215149875.png)

![image-20220613215212769](./img/image-20220613215212769.png)

##  向 product 表中插入数据

为了学习  `INSERT` 语句用法，我们首先创建一个名为  productins 的表，建表语句如下：

```sql
CREATE TABLE productins
(product_id    CHAR(4)      NOT NULL,
product_name   VARCHAR(100) NOT NULL,
product_type   VARCHAR(32)  NOT NULL,
sale_price     INTEGER      DEFAULT 0,
purchase_price INTEGER ,
regist_date    DATE ,
PRIMARY KEY (product_id)); 
```

![image-20220613215350679](./img/image-20220613215350679.png)

基本语法：

```sql
INSERT INTO <表名> (列1, 列2, 列3, ……) VALUES (值1, 值2, 值3, ……);  
```

对表进行全列 INSERT 时，可以省略表名后的列清单。这时 VALUES子句的值会默认按照从左到右的顺序赋给每一列。

```sql
-- 包含列清单
INSERT INTO productins (product_id, product_name, product_type, sale_price, purchase_price, regist_date) VALUES ('0005', '高压锅', '厨房用具', 6800, 5000, '2009-01-15');
-- 省略列清单
INSERT INTO productins VALUES ('0005', '高压锅', '厨房用具', 6800, 5000, '2009-01-15');  
```

![image-20220613215624469](./img/image-20220613215624469.png)

![image-20220613215639533](./img/image-20220613215639533.png)

原则上，执行一次 INSERT 语句会插入一行数据。插入多行时，通常需要循环执行相应次数的 INSERT 语句。其实很多 RDBMS 都支持一次插入多行数据

```sql
-- 通常的INSERT
INSERT INTO productins VALUES ('0002', '打孔器', '办公用品', 500, 320, '2009-09-11');
INSERT INTO productins VALUES ('0003', '运动T恤', '衣服', 4000, 2800, NULL);
INSERT INTO productins VALUES ('0004', '菜刀', '厨房用具', 3000, 2800, '2009-09-20');
-- 多行INSERT （ DB2、SQL、SQL Server、 PostgreSQL 和 MySQL多行插入）
INSERT INTO productins VALUES ('0002', '打孔器', '办公用品', 500, 320, '2009-09-11'),
                              ('0003', '运动T恤', '衣服', 4000, 2800, NULL),
                              ('0004', '菜刀', '厨房用具', 3000, 2800, '2009-09-20');  
-- Oracle中的多行INSERT
INSERT ALL INTO productins VALUES ('0002', '打孔器', '办公用品', 500, 320, '2009-09-11')
           INTO productins VALUES ('0003', '运动T恤', '衣服', 4000, 2800, NULL)
           INTO productins VALUES ('0004', '菜刀', '厨房用具', 3000, 2800, '2009-09-20')
SELECT * FROM DUAL;  
-- DUAL是Oracle特有（安装时的必选项）的一种临时表A。因此“SELECT *FROM DUAL” 部分也只是临时性的，并没有实际意义。  
```

![image-20220613215816532](./img/image-20220613215816532.png)

![image-20220613215855931](./img/image-20220613215855931.png)

INSERT 语句中想给某一列赋予 NULL 值时，可以直接在 VALUES子句的值清单中写入 NULL。想要插入 NULL 的列一定不能设置 NOT NULL 约束。

```sql
INSERT INTO productins (product_id, product_name, product_type, sale_price, purchase_price, regist_date) VALUES ('0006', '叉子', '厨房用具', 500, NULL, '2009-09-20');  
```

![image-20220613220148292](./img/image-20220613220148292.png)

![image-20220613220207510](./img/image-20220613220207510.png)

还可以向表中插入默认值（初始值）。可以通过在创建表的CREATE TABLE 语句中设置DEFAULT约束来设定默认值。

```sql
CREATE TABLE productins
(product_id CHAR(4) NOT NULL,
（略）
sale_price INTEGER
（略）	DEFAULT 0, -- 销售单价的默认值设定为0;
PRIMARY KEY (product_id));  
```

![image-20220613220410417](./img/image-20220613220410417.png)

可以使用INSERT … SELECT 语句从其他表复制数据。

```sql
-- 将商品表中的数据复制到商品复制表中
INSERT INTO productcopy (product_id, product_name, product_type, sale_price, purchase_price, regist_date)
SELECT product_id, product_name, product_type, sale_price, purchase_price, regist_date
  FROM Product;  
```

![image-20220613220459963](./img/image-20220613220459963.png)

![image-20220613220515577](./img/image-20220613220515577.png)

* 本课程用表插入数据sql如下：

```sql
- DML ：插入数据
STARTTRANSACTION;
INSERT INTO product VALUES('0001', 'T恤衫', '衣服', 1000, 500, '2009-09-20');
INSERT INTO product VALUES('0002', '打孔器', '办公用品', 500, 320, '2009-09-11');
INSERT INTO product VALUES('0003', '运动T恤', '衣服', 4000, 2800, NULL);
INSERT INTO product VALUES('0004', '菜刀', '厨房用具', 3000, 2800, '2009-09-20');
INSERT INTO product VALUES('0005', '高压锅', '厨房用具', 6800, 5000, '2009-01-15');
INSERT INTO product VALUES('0006', '叉子', '厨房用具', 500, NULL, '2009-09-20');
INSERT INTO product VALUES('0007', '擦菜板', '厨房用具', 880, 790, '2008-04-28');
INSERT INTO product VALUES('0008', '圆珠笔', '办公用品', 100, NULL, '2009-11-11');
COMMIT;
```

![image-20220613220616521](./img/image-20220613220616521.png)

![image-20220613220637052](./img/image-20220613220637052.png)

##  索引

- 索引的作用

MySQL索引的建立对于MySQL的高效运行是很重要的，索引可以大大提高MySQL的检索速度。

打个比方，如果合理的设计且使用索引的 MySQL 是一辆兰博基尼的话，那么没有设计和使用索引的 MySQL 就是一个人力三轮车。

拿汉语字典的目录页（索引）打比方，我们可以按拼音、笔画、偏旁部首等排序的目录（索引）快速查找到需要的字。

索引创建了一种有序的数据结构，采用二分法搜索数据时，其复杂度为 ![1](http://latex.codecogs.com/svg.latex?log_2(N)) ，1000多万的数据只要搜索23次，其效率是非常高效的。

- 如何创建索引

创建表时可以直接创建索引，语法如下：

```sql
CREATE TABLE mytable(  
 
ID INT NOT NULL,   
 
username VARCHAR(16) NOT NULL,  
 
INDEX [indexName] (username(length))  
 
);  
```

![image-20220613222034331](./img/image-20220613222034331.png)

也可以使用如下语句创建：
    

```sql
-- 方法1
CREATE INDEX indexName ON table_name (column_name)

-- 方法2
ALTER table tableName ADD INDEX indexName(columnName)
```

![image-20220613222143204](./img/image-20220613222143204.png)

![image-20220613222307030](./img/image-20220613222307030.png)

- 索引分类

  - 主键索引

  建立在主键上的索引被称为主键索引，一张数据表只能有一个主键索引，索引列值不允许有空值，通常在创建表时一起创建。

  - 唯一索引

  建立在UNIQUE字段上的索引被称为唯一索引，一张表可以有多个唯一索引，索引列值允许为空，列值中出现多个空值不会发生重复冲突。

  - 普通索引

  建立在普通字段上的索引被称为普通索引。

  - 前缀索引

  前缀索引是指对字符类型字段的前几个字符或对二进制类型字段的前几个bytes建立的索引，而不是在整个字段上建索引。前缀索引可以建立在类型为char、varchar、binary、varbinary的列上，可以大大减少索引占用的存储空间，也能提升索引的查询效率。

  - 全文索引

  利用“分词技术”实现在长文本中搜索关键字的一种索引。

  语法：`SELECT * FROM article WHERE MATCH (col1，col2，...) AGAINST (expr [ search _ modifier ])`

  1、MySQL 5.6 以前的版本，只有 MyISAM 存储引擎支持全文索引；

  2、MySQL 5.6 及以后的版本，MyISAM 和 InnoDB 存储引擎均支持全文索引;

  3、只有字段的数据类型为 char、varchar、text 及其系列才可以建全文索引。

  4、如果可能，请尽量先创建表并插入所有数据后再创建全文索引，而不要在创建表时就直接创建全文索引，因为前者比后者的全文索引效率要高。

  - 单列索引

  建立在单个列上的索引被称为单列索引。

  - 联合索引（复合索引、多列索引）

  建立在多个列上的索引被称为联合索引，又叫复合索引、组合索引。





# 练习题

## 1.1

编写一条 CREATE TABLE 语句，用来创建一个包含表 1-A 中所列各项的表 Addressbook （地址簿），并为 regist_no （注册编号）列设置主键约束

表1-A　表 Addressbook （地址簿）中的列

![图片](H:\面试\wonderful-sql-main\wonderful-sql-main\img\ch01\ch01.04习题1.png)

![image-20220613222638115](./img/image-20220613222638115.png)

![image-20220613222654103](./img/image-20220613222654103.png)

## 1.2 

假设在创建练习1.1中的 Addressbook 表时忘记添加如下一列 postal_code （邮政编码）了，请编写 SQL 把此列添加到 Addressbook 表中。

列名        ： postal_code

数据类型 ：定长字符串类型（长度为 8）

约束        ：不能为 NULL

![image-20220613222850047](./img/image-20220613222850047.png)

![image-20220613222911513](./img/image-20220613222911513.png)

## 1.3 填空题

请补充如下 SQL 语句来删除 Addressbook 表。

```sql
(    ) table Addressbook;
```

- **DROP**

## 1.4 判断题

是否可以编写 SQL 语句来恢复删除掉的 Addressbook 表？

- **不能**
