-- 3. Выводит только тех клиентов, у которых общая сумма заказов превышает
--    среднюю общую сумму заказов всех клиентов.
SELECT *
FROM (
         SELECT rso.firstname                       AS "Имя",
                rso.lastname                        AS "Фамилия",
                rso.totalSum,
                ROUND(AVG(rso.totalSum) OVER (), 2) AS "avg"
         FROM (
                  SELECT *
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
     ) as arso
WHERE arso.totalSum > arso.avg