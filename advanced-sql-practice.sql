
USE online_store;

-- Displaying tables
select * from customers;
select * from orders;

-- Task 1: INNER JOIN
-- Display customers who have placed orders.
SELECT
    customers.id,
    customers.first_name,
    customers.last_name,
    orders.id AS order_id,
    orders.order_date,
    orders.total_amount
FROM customers
INNER JOIN orders
    ON customers.id = orders.customer_id;

-- Task 2: LEFT JOIN
-- Display all customers, including those without orders.
SELECT
    customers.id,
    customers.first_name,
    customers.last_name,
    orders.id AS order_id,
    orders.total_amount
FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id;

-- Task 3: GROUP BY with COUNT
-- Count how many orders each customer has placed.
SELECT
    customers.id,
    customers.first_name,
    customers.last_name,
    COUNT(orders.id) AS total_orders
FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id
GROUP BY
    customers.id,
    customers.first_name,
    customers.last_name;

-- Task 4: GROUP BY with SUM
-- Calculate the total amount spent by each customer.
SELECT
    customers.id,
    customers.first_name,
    customers.last_name,
    SUM(orders.total_amount) AS total_spent
FROM customers
INNER JOIN orders
    ON customers.id = orders.customer_id
GROUP BY
    customers.id,
    customers.first_name,
    customers.last_name;

-- Task 5: HAVING
-- Find customers who have placed more than one order.
SELECT
    customers.id,
    customers.first_name,
    customers.last_name,
    COUNT(orders.id) AS total_orders
FROM customers
INNER JOIN orders
    ON customers.id = orders.customer_id
GROUP BY
    customers.id,
    customers.first_name,
    customers.last_name
HAVING COUNT(orders.id) > 1;

-- Task 6: Subquery with AVG
-- Find orders with an amount greater than the average order amount.
SELECT *
FROM orders
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM orders
);

-- Task 7: Subquery with IN
-- Find customers who have placed at least one order.
SELECT *
FROM customers
WHERE id IN (
    SELECT customer_id
    FROM orders
    WHERE customer_id IS NOT NULL
);

-- Task 8: JOIN, GROUP BY, and HAVING
-- Find customers whose total order amount exceeds $200.
SELECT
    customers.id,
    customers.first_name,
    customers.last_name,
    SUM(orders.total_amount) AS total_spent
FROM customers
INNER JOIN orders
    ON customers.id = orders.customer_id
GROUP BY
    customers.id,
    customers.first_name,
    customers.last_name
HAVING SUM(orders.total_amount) > 200;
