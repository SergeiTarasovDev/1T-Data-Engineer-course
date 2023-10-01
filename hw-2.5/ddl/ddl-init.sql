CREATE TABLE IF NOT EXISTS public.shops
(
    shop_id serial primary key,
    name  	varchar(150)
);

CREATE TABLE IF NOT EXISTS public.products
(
    product_id  	serial primary key,
    product_name	varchar(150),
    price   		numeric
);

CREATE TABLE IF NOT EXISTS public.sales
(
    sale_id			serial primary key,
    shop_id			bigint,
    product_id	    bigint,
    sale_date		date,
    sales_cnt		int,
    CONSTRAINT fk_shop FOREIGN KEY (shop_id) REFERENCES shops (shop_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products (product_id)
);

CREATE TABLE IF NOT EXISTS public.sales_plan
(
    plan_id			serial primary key,
    shop_id			bigint,
    product_id	    bigint,
    plan_cnt		int,
    plan_date		date,
    CONSTRAINT fk_shop FOREIGN KEY (shop_id) REFERENCES shops (shop_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products (product_id)
)