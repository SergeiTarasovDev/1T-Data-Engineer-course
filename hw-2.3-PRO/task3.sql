-- 3. Вам нужно рассчитать среднюю оценку продукта для каждого клиента
--    на основе отзывов, оставленных ими о продуктах.

-- ПРИМЕЧАНИЕ: не понял задачу, в этом решении мы видим среднюю оценку товаров (по каждому товару), ниже сделал второй вариант
SELECT *
FROM orders o
         LEFT JOIN orderdetails od
                   ON od.orderid = o.orderid
         LEFT JOIN customers c
                   ON c.customerid = o.customerid
         LEFT JOIN (
    SELECT pr.productid,
           ROUND(AVG(pr.rating), 2) as avgRating
    FROM productreviews pr
    GROUP BY pr.productid
) AS r
                   ON r.productid = od.productid;

-- 3a. Вам нужно рассчитать среднюю оценку продукта для каждого клиента
--    на основе отзывов, оставленных ими о продуктах.

-- ПРИМЕЧАНИЕ: второй вариант, в котором рассчитал среднюю оценку клиента, на купленные им товары
SELECT c.*,
       ROUND(AVG(p.rating), 2) avgRating
FROM orders o
         LEFT JOIN orderdetails od
                   ON od.orderid = o.orderid
         LEFT JOIN customers c
                   ON c.customerid = o.customerid
         LEFT JOIN productreviews p
                   ON p.productid = od.productid
GROUP BY c.customerid;