-- 1. Customer's Country
SELECT DISTINCT(country) FROM customers;

-- 2. Customer's From Each Country
SELECT DISTINCT(country), COUNT(country) FROM customers
GROUP BY country ORDER BY COUNT(country) DESC;
 
-- 3. TOP 10 Countries Based On The Sales
WITH RankedCountries AS (
    SELECT country, SUM(priceEach*quantityOrdered) AS Total_Spent, ROW_NUMBER() OVER (ORDER BY SUM(priceEach*quantityOrdered) DESC) AS RowNum
    FROM customers JOIN orders USING (customerNumber) JOIN orderdetails USING (orderNumber)
    GROUP BY country
)
SELECT RowNum, country, Total_Spent
FROM RankedCountries WHERE RoWNum<=10
ORDER BY Total_Spent DESC;

-- 4. Top 10 Customers Based On Sales
WITH RankedCustomers AS (
    SELECT customerName, SUM(priceEach*quantityOrdered) AS Total_Spent, ROW_NUMBER() OVER (ORDER BY SUM(priceEach*quantityOrdered) DESC) AS RowNum
    FROM customers JOIN orders USING (customerNumber) JOIN orderdetails USING (orderNumber)
    GROUP BY customerName
)
SELECT RowNum, customerName, Total_Spent
FROM RankedCustomers WHERE RoWNum<=10
ORDER BY Total_Spent DESC;

-- 5. Top 10 Performing Employees
SELECT CONCAT(employees.firstName,' ',employees.lastName) AS Employee_Names,
SUM(priceEach*quantityOrdered) AS Total_Sales_Made_By_Them
FROM employees JOIN customers
ON employees.employeeNumber=customers.salesRepEmployeeNumber
JOIN orders USING (customerNumber) 
JOIN orderdetails USING(orderNumber)
GROUP BY Employee_Names
ORDER BY Total_Sales_Made_By_Them DESC LIMIT 10; 

-- 6. ProductLine With Their Total Sales
SELECT productLine, SUM(priceEach*quantityOrdered) 
FROM orders JOIN orderdetails USING (orderNumber) 
JOIN products USING (productCode) 
GROUP BY productLine 
ORDER BY SUM(priceEach*quantityOrdered) DESC;

-- 7. Top 10 Products
SELECT productName, SUM(priceEach*quantityOrdered) 
FROM  orders  JOIN orderdetails USING (orderNumber) 
JOIN products USING (productCode) 
GROUP BY productName
ORDER BY SUM(priceEach*quantityOrdered) DESC LIMIT 10;

-- 8. Total Number Of Orders 
SELECT COUNT(*) FROM Orders;

-- 9. Total Number Of Orders With Status="Shipped"
SELECT COUNT(*) FROM Orders WHERE status="Shipped";

-- 10. Total Orders From Each Country
 SELECT country, count(country) FROM customers JOIN orders USING (customerNumber) GROUP BY country ORDER BY COUNT(country) DESC;
 
-- 11. Total Orders From Each Customer
SELECT customerName, count(customerName) FROM customers JOIN orders USING (customerNumber) GROUP BY customerName ORDER BY COUNT(customerName) DESC;

-- 12. Year Wise Total Orders
SELECT YEAR(orderDate), COUNT(*) FROM orders GROUP BY YEAR(orderDate);

-- 13. Year 2003 Total Sales
SELECT SUM(priceEach*quantityOrdered) FROM orderdetails JOIN orders USING(orderNumber) WHERE YEAR(orderDate)=2003;

-- 14. Year 2004 Total Sales
SELECT SUM(priceEach*quantityOrdered) FROM orderdetails JOIN orders USING(orderNumber) WHERE YEAR(orderDate)=2004;

-- 15. Year 2005 Total Sales
SELECT SUM(priceEach*quantityOrdered) FROM orderdetails JOIN orders USING(orderNumber) WHERE YEAR(orderDate)=2005;











