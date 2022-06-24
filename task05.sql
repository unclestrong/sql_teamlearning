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