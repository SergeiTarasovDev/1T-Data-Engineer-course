-- 4. Выведите список клиентов вместе с их общей суммой заказов, общим количеством товаров,
--    новыми и старыми заказами, а также средней оценкой продукта.
SELECT c.customerid,
       c.firstname AS "Имя",
       c.lastname AS "Фамилия",
       sumOrders.totalOrderSum AS "Общая сумма заказов",
       sumOrders.totalQuantity AS "Общее количество товаров",
       orderStatus.orderid AS "Номер заказа",
       orderStatus.orderStatus AS "Статус заказа",
       avgRating.avgRating AS "Средняя оценка продукта"
FROM customers c
         LEFT JOIN (
    SELECT c.customerid,
           SUM(od.quantity * od.unitprice) AS totalOrderSum,
           SUM(od.quantity)                as totalQuantity
    FROM customers AS c
             LEFT JOIN orders o
                       ON c.customerid = o.customerid
             LEFT JOIN orderdetails od
                       ON od.orderid = o.orderid
    GROUP BY c.customerid
) AS sumOrders
                   ON sumOrders.customerid = c.customerid
         LEFT JOIN (
    SELECT c.customerid,
           o.orderid,
           CASE
               WHEN
                   o.orderdate > CURRENT_DATE - INTERVAL '1' MONTH
                   THEN
                   'Новый'
               ELSE
                   'Старый'
               END AS orderStatus
    FROM orders o
             LEFT JOIN customers c
                       ON o.customerid = c.customerid
) as orderStatus
                   ON orderStatus.customerid = c.customerid
LEFT JOIN (
    SELECT c.*,
       ROUND(AVG(p.rating), 2) avgRating
FROM orders o
         LEFT JOIN orderdetails od
                   ON od.orderid = o.orderid
         LEFT JOIN customers c
                   ON c.customerid = o.customerid
         LEFT JOIN productreviews p
                   ON p.productid = od.productid
GROUP BY c.customerid
    ) AS avgRating
ON avgRating.customerid = c.customerid