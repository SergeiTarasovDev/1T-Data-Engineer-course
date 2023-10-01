-- 1. Возвращает список клиентов (имя и фамилия) с наибольшей общей суммой заказов.
SELECT rso.lastname  AS "Фамилия",
       rso.firstname AS "Имя"
FROM (
         SELECT so.lastname,
                so.firstname,
                RANK() OVER (ORDER BY so.totalSum DESC) as orderRank
         FROM (
                  SELECT c.FirstName,
                         c.LastName,
                         SUM(o.totalamount) as totalSum
                  FROM Customers AS c
                           INNER JOIN Orders AS o
                                      ON c.CustomerId = o.CustomerId
                  GROUP BY c.CustomerId
              ) as so
     ) as rso
WHERE rso.orderRank = 1;