/*    SECTION A — JOINS */

/* Q1. Retrieve customer names along with their corresponding order IDs */
SELECT c.name, o.order_id
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

/* Q2. List all customers and their orders, including customers who have not placed any order */
SELECT c.name, o.order_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

/* Q3. Display all order IDs and customer names, including orders that have no matching customer record */
SELECT o.order_id, c.name
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.customer_id;

/* Q4. Show customer name, order ID and order amount for all orders placed in June 2023 */
SELECT c.name, o.order_id, o.total_amount
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_date BETWEEN '2023-06-01' AND '2023-06-30';

/* Q5. Retrieve all product names purchased by each customer */
SELECT c.name, oi.product_name
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id;

/* Q6. Find the names of customers who purchased the product "Soap" */
SELECT DISTINCT c.name
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
WHERE oi.product_name = 'Soap';

/* Q7. Display customer name, city, product name and quantity purchased */
SELECT c.name, c.city, oi.product_name, oi.quantity
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id;

/* Q8. Identify orders that contain more than one item */
SELECT order_id
FROM order_items
GROUP BY order_id
HAVING COUNT(item_id) > 1;

/* Q9. Retrieve customers who have never placed any order */
SELECT c.name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

/* Q10. For each order, show the total number of items included in that order */
SELECT order_id, SUM(quantity) AS total_items
FROM order_items
GROUP BY order_id;


/*    SECTION B — GROUPING & AGGREGATION */

/* Q11. Find the number of orders placed by each customer */
SELECT c.name, COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.name;

/* Q12. Calculate the total revenue generated from each city */
SELECT c.city, SUM(o.total_amount) AS total_revenue
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.city;

/* Q13. Find the average order value for each customer */
SELECT c.name, AVG(o.total_amount) AS avg_order_value
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.name;

/* Q14. Count total units sold for each product */
SELECT product_name, SUM(quantity) AS total_units_sold
FROM order_items
GROUP BY product_name;

/* Q15. Identify the highest total order amount recorded */
SELECT MAX(total_amount) AS highest_order_amount
FROM orders;

/* Q16. Calculate the total revenue generated on each date */
SELECT order_date, SUM(total_amount) AS total_revenue
FROM orders
GROUP BY order_date;

/* Q17. Create a summary showing:
   customer_name | total_orders | total_items | total_spent */
SELECT 
    c.name AS customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity) AS total_items,
    SUM(o.total_amount) AS total_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.name;

/* Q18. Identify the top 2 customers based on total spending */
SELECT c.name, SUM(o.total_amount) AS total_spent
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 2;

/* Q19. Determine which product generated the highest total revenue */
SELECT product_name, SUM(quantity * price) AS total_revenue
FROM order_items
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 1;

/* Q20. Find the average quantity ordered per order */
SELECT AVG(total_quantity) AS avg_quantity_per_order
FROM (
    SELECT order_id, SUM(quantity) AS total_quantity
    FROM order_items
    GROUP BY order_id
) t;

