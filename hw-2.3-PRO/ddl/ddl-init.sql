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
    TotalAmount decimal(18, 2),
    CONSTRAINT fk_customer FOREIGN KEY (CustomerId) REFERENCES Customers (CustomerId)
);

CREATE TABLE IF NOT EXISTS public.Products
(
    ProductId   serial primary key,
    ProductName varchar(125),
    CategoryId  bigint,
    Price       decimal(18, 2)
);

CREATE TABLE IF NOT EXISTS public.OrderDetails
(
    OrderDetailId serial primary key,
    OrderId       bigint,
    ProductId     bigint,
    Quantity      int,
    UnitPrice     decimal(18, 2),
    CONSTRAINT fk_order FOREIGN KEY (OrderId) REFERENCES Orders (OrderId),
    CONSTRAINT fk_product FOREIGN KEY (ProductId) REFERENCES Products (ProductId)
);

CREATE TABLE IF NOT EXISTS public.ProductReviews
(
    ReviewId   serial primary key,
    ProductId  bigint,
    CustomerId bigint,
    Rating     int,
    ReviewText text,
    CONSTRAINT fk_product FOREIGN KEY (ProductId) REFERENCES Products (ProductId),
    CONSTRAINT fk_customer FOREIGN KEY (CustomerId) REFERENCES Customers (CustomerId)
)