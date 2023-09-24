-- 1. Ваш SQL-запрос должен расшириться для учета общей суммы заказов
--    и общего количества товаров, купленных каждым клиентом.
SELECT c.customerid,
       c.lastname,
       c.firstname,
       SUM(od.quantity * od.unitprice) AS totalOrderSum,
       SUM(od.quantity)                as totalQuantity
FROM customers AS c
         LEFT JOIN orders o
                   ON c.customerid = o.customerid
         LEFT JOIN orderdetails od
                   ON od.orderid = o.orderid
GROUP BY c.customerid;