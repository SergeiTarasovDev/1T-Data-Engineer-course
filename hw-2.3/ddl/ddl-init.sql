CREATE TABLE IF NOT EXISTS public.Customers
(
    CustomerId serial primary key,
    FirstName  varchar(255),
    LastName   varchar(255),
    Email      varchar(100)
);

CREATE TABLE IF NOT EXISTS public.Orders
(
    OrderId     serial primary key,
    CustomerId  bigint,
    OrderDate   timestamp,
    TotalAmount decimal,
    CONSTRAINT fk_customer FOREIGN KEY (CustomerId) REFERENCES Customers (CustomerId)
);

CREATE TABLE IF NOT EXISTS public.OrderDetails
(
    OrderDetailId serial primary key,
    OrderId       bigint,
    ProductId     bigint,
    Quantity      int,
    UnitPrice     decimal,
    CONSTRAINT fk_order FOREIGN KEY (OrderId) REFERENCES Orders (OrderId)

);