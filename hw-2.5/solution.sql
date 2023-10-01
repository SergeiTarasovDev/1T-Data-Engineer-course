WITH
sales_with_period AS (
    SELECT *,
           TO_CHAR(s.sale_date, 'YYYY-MM') AS period,
           DATE_PART('days', DATE_TRUNC('month', s.sale_date)
            + '1 MONTH'::INTERVAL
            - '1 DAY'::INTERVAL) AS period_days
    FROM sales AS s
),
sales_by_day AS (
    SELECT
        ROUND((SUM(s.sales_cnt) OVER (PARTITION BY s.shop_id, s.product_id, s.period) / s.period_days)::DECIMAL, 2) AS avg_sales_per_day,


        *
    FROM sales_with_period AS s
)
select *
from sales_by_day
order by shop_id, product_id, period;


     ,
sales_by_month AS (
	SELECT
           s.shop_id,
	       s.product_id,
		   TO_CHAR(s.sale_date, 'YYYY-MM') AS period,
	       SUM(s.sales_cnt) AS sales_fact,
	       MAX(s.sales_cnt) AS max_sales_cnt
	FROM sales AS s
	GROUP BY s.shop_id, s.product_id, TO_CHAR(s.sale_date, 'YYYY-MM')
    ORDER BY s.shop_id, s.product_id, TO_CHAR(s.sale_date, 'YYYY-MM')
)
SELECT
       sh.name AS shop_name,
       pr.product_name,
       s.sales_fact,
       sp.plan_cnt,
       ROUND(s.sales_fact::DECIMAL / sp.plan_cnt, 2) AS "sf/sp",
       s.sales_fact * pr.price AS income_fact,
       sp.plan_cnt * pr.price AS income_plan,
       ROUND((s.sales_fact * pr.price) / (sp.plan_cnt * pr.price), 2) AS "if/ip",
       ROUND(s.sales_fact / (DATE_PART('days', DATE_TRUNC('month', NOW())
            + '1 MONTH'::INTERVAL
            - '1 DAY'::INTERVAL))::DECIMAL, 2) AS sales_per_day,
       s.max_sales_cnt
FROM sales_by_month AS s
INNER JOIN sales_plan AS sp
    ON sp.shop_id = s.shop_id
    AND sp.product_id = s.product_id
    AND TO_CHAR(sp.plan_date, 'YYYY-MM') = s.period
INNER JOIN products AS pr
    ON pr.product_id = s.product_id
INNER JOIN shops AS sh
    ON sh.shop_id = s.shop_id
ORDER BY s.shop_id, s.product_id, s.period
