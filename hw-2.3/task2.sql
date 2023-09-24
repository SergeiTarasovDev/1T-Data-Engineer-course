-- 2. Для каждого клиента из пункта 1 выводит список его заказов
--    (номер заказа и общая сумма) в порядке убывания общей суммы заказов.
SELECT orso.firstname AS "Имя",
       orso.lastname  AS "Фамилия",
       o.orderid      AS "Номер заказа",
       o.totalamount  AS "Общая сумма заказа"
FROM (
         SELECT rso.customerid,
                rso.lastname,
                rso.firstname
         FROM (
                  SELECT so.customerid,
                         so.lastname,
                         so.firstname,
                         RANK() OVER (ORDER BY so.totalSum DESC) as orderRank
                  FROM (
                           SELECT c.customerid,
                                  c.FirstName,
                                  c.LastName,
                                  SUM(o.totalamount) as totalSum
                           FROM Customers AS c
                                    INNER JOIN Orders AS o
                                               ON c.CustomerId = o.CustomerId
                           GROUP BY c.CustomerId
                       ) as so
              ) as rso
         WHERE rso.orderRank = 1
     ) as orso
         LEFT JOIN orders o
                   ON o.customerid = orso.customerid
ORDER BY o.totalamount DESC;