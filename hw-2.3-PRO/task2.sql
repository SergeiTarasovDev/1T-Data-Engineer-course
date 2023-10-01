-- 2. Заказы клиентов должны быть разделены на две категории:
--    «Новые заказы» (заказы, созданные менее месяца назад) и
--    «Старые заказы» (заказы, созданные более месяца назад).
SELECT CASE
           WHEN
               o.orderdate > CURRENT_DATE - INTERVAL '1' MONTH
               THEN
               'Новый'
           ELSE
               'Старый'
           END AS orderStatus,
       c.customerid
FROM orders o
         LEFT JOIN customers c
                   ON o.customerid = c.customerid;