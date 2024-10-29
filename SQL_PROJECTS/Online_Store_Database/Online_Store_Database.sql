# create databse online store database
CREATE DATABASE online_store_database;
SHOW DATABASES;
USE online_store_database;


CREATE TABLE Products (
    product_id INT,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    stock_quantity INT
);
INSERT INTO Products (product_id, product_name, price, stock_quantity) VALUES
(1, 'Laptop', 899.99, 10),
(2, 'Smartphone', 499.99, 25),
(3, 'Headphones', 89.99, 50),
(4, 'Smartwatch', 199.99, 15),
(5, 'Tablet', 299.99, 20),
(6, 'Charger', 19.99, 100),
(7, 'Monitor', 199.99, 30),
(8, 'Keyboard', 49.99, 60),
(9, 'Mouse', 29.99, 75),
(10, 'Printer', 149.99, 5);

CREATE TABLE Customers (
    customer_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15)
);
INSERT INTO Customers (customer_id, first_name, last_name, email, phone) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '555-1234'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '555-5678'),
(3, 'Emily', 'Jones', 'emily.jones@example.com', '555-8765'),
(4, 'Michael', 'Brown', 'michael.brown@example.com', '555-4321'),
(5, 'Sarah', 'Davis', 'sarah.davis@example.com', '555-2468');

CREATE TABLE Orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2)
);
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES
(1, 1, '2024-01-10', 999.98), -- John Doe's order
(2, 2, '2024-01-12', 499.99), -- Jane Smith's order
(3, 3, '2024-01-15', 199.99), -- Emily Jones's order
(4, 1, '2024-01-20', 89.99),  -- John Doe's second order
(5, 4, '2024-01-25', 1199.97); -- Michael Brown's order


CREATE TABLE Order_Items (
    order_item_id INT,
    order_id INT,
    product_id INT,
    quantity INT
);
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity) VALUES
(1, 1, 1, 1),  -- John bought 1 Laptop
(2, 1, 3, 1),  -- John bought 1 Headphones
(3, 2, 2, 1),  -- Jane bought 1 Smartphone
(4, 3, 4, 1),  -- Emily bought 1 Smartwatch
(5, 4, 3, 1),  -- John bought 1 Headphones
(6, 5, 1, 1),  -- Michael bought 1 Laptop
(7, 5, 2, 1),  -- Michael bought 1 Smartphone
(8, 5, 5, 1);  -- Michael bought 1 Tablet


select * from Products;
select * from Customers;
select * from Orders;
select * from Order_Items;

#Select All Products (Basic SELECT)

SELECT * FROM Products;


#Insert a New Product (INSERT)
INSERT INTO Products (product_id, product_name, price, stock_quantity) 
VALUES (11, 'Wireless Mouse', 25.99, 50);
SELECT * FROM Products;

#Update Product Price (UPDATE)
# Disable Safe Update Mode Temporarily
SET SQL_SAFE_UPDATES = 0;

UPDATE Products 
SET price = 24.99 
WHERE product_id = 11;
SELECT * FROM Products;

SET SQL_SAFE_UPDATES = 1;

#Delete a Product (DELETE)

DELETE FROM Products 
WHERE product_id = 11;
SELECT * FROM Products;

#Select all tables Information (INNER JOIN)
select * from orders o
join customers c on c.customer_id = o.customer_id 
join order_items oi on oi.order_id = o.order_id
join products p on p.product_id = oi.product_id;

#Select Orders and Their Customer Information (INNER JOIN)
select * from orders o
join customers c on c.customer_id = o.customer_id;

#Select Orders That Include a Specific Product (JOIN and WHERE clause)

select o.order_id, p.product_name, oi.quantity from Order_Items oi
join orders o on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id
where product_name = 'Smartphone';

#Total Sales of Each Product (GROUP BY and Aggregate Function)

select p.product_name, sum(oi.quantity) as total_sold
from order_items oi
join products p on p.product_id = oi.product_id
group by p.product_name;

#Count the Number of Customers (Aggregate Function COUNT)
select count(*) as total_customers from customers;

#Find the Most Expensive Product (ORDER BY and LIMIT)
select p.product_name, p.price as most_expensive_product from products p
order by p.price desc limit 1;

#Find Customers Who Have Never Placed an Order (LEFT JOIN and WHERE)
select * from customers c
left join orders o on c.customer_id = o.customer_id
where o.order_id is null;

#Find Orders with Total Amount Greater Than 500 (WHERE and Comparison Operator)

select * from orders
where total_amount > 500;


#Find the Average Order Total for Each Customer (JOIN, GROUP BY, and Aggregate Function)
SELECT c.first_name, c.last_name, AVG(o.total_amount) AS avg_order_total
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY c.first_name, c.last_name;

#Find Products with Low Stock (Less than 10 Items) (WHERE and Comparison Operator)
select p.product_name, p.stock_quantity from products p
where p.stock_quantity < 10;

#select Orders Between Two Dates (WHERE with BETWEEN)\
select * from orders o
where o.order_date between '2024-01-10' and '2024-01-15';

#Select Orders with the Most Items (Subquery with HAVING)
SELECT oi.order_id, COUNT(oi.product_id) AS num_items
FROM Order_Items oi
GROUP BY oi.order_id
HAVING COUNT(oi.product_id) = (
    SELECT MAX(item_count) FROM (
        SELECT COUNT(product_id) AS item_count
        FROM Order_Items
        GROUP BY order_id
    ) AS item_counts
);
