CREATE TABLE Product_table (
 ProductID INT PRIMARY KEY,
 Name VARCHAR(100),
 Category VARCHAR(50),
 Price DECIMAL(10, 2),
 Quantity INT
);

/*Product table*/

INSERT INTO Product_table (ProductID, Name, Category, Price, Quantity)
VALUES
 (1, 'Apple', 'Fruits', 1.00, 50),
 (2, 'Banana', 'Fruits', 0.50, 100),
 (3, 'Milk', 'Dairy', 2.50, 20),
 (4, 'Bread', 'Bakery', 1.80, 30),
 (5, 'Chicken', 'Meat', 5.00, 10);

 select * from Product_table;


CREATE TABLE Customers_table (
 CustomerID INT PRIMARY KEY,
 FirstName VARCHAR(50),
 LastName VARCHAR(50),
 Email VARCHAR(100),
 Phone VARCHAR(20)
);

/*customer table*/

INSERT INTO Customers_table (CustomerID, FirstName, LastName, Email, Phone)
VALUES
 (1, 'John', 'Doe', 'johndoe@example.com', '123-456-7890'),
 (2, 'Jane', 'Smith', 'janesmith@example.com', '987-654-3210'),
 (3, 'Michael', 'Johnson', 'michaeljohnson@example.com', '555-123-4567'),
 (4, 'Emily', 'Brown', 'emilybrown@example.com', '999-888-7777'),
 (5, 'David', 'Taylor', 'davidtaylor@example.com', '444-555-6666');

 select* from Customers_table;

 CREATE TABLE Orders_table (
 OrderID INT PRIMARY KEY,
 CustomerID INT,
 ProductID INT,
 OrderDate DATE,
 Quantity INT,
 TotalAmount DECIMAL(10, 2),
 FOREIGN KEY (CustomerID) REFERENCES Customers_table (CustomerID),
 FOREIGN KEY (ProductID) REFERENCES Product (ProductID)
);
/*order table*/

INSERT INTO Orders_table (OrderID, CustomerID, ProductID, OrderDate, Quantity, TotalAmount)
VALUES
 (1, 1, 1, '2023-07-01', 5, 5.00),
 (2, 2, 3, '2023-07-02', 2, 5.00),
 (3, 3, 5, '2023-07-03', 1, 5.00),
 (4, 4, 2, '2023-07-04', 3, 1.50),
 (5, 5, 4, '2023-07-05', 2, 3.60);

 SELECT * FROM Orders_table;
 

/* Write a query to retrieve all products with a quantity less than 20*/


SELECT * FROM Product_table WHERE Quantity <20 ;

/*write a query to retrieve the names and email addresses of customers who have placed an order*/
SELECT c.FirstName, c.LastName, c.Email
FROM Customers_table c
INNER JOIN Orders_table o ON c.CustomerID = o.CustomerID;

/*. Write a query to calculate the total revenue generated from each category (Category) of products*/

SELECT p.Category, SUM(o.TotalAmount) AS TotalRevenue
FROM Product_table p
INNER JOIN Orders_table o ON p.ProductID = o.ProductID
GROUP BY p.Category;

/* Write a query to retrieve the customer names and their respective orders, sorted by the order date in 
ascending order.*/
SELECT c.FirstName, c.LastName, o.OrderID, o.OrderDate
FROM Customers_table c
INNER JOIN Orders_table o ON c.CustomerID = o.CustomerID
ORDER BY o.OrderDate ASC;
/*. Write a query to calculate the total quantity of each product sold.*/

SELECT p.ProductID, p.Name, SUM(o.Quantity) AS TotalQuantity
FROM Product_table p
INNER JOIN Orders_table o ON p.ProductID = o.ProductID
GROUP BY p.ProductID, p.Name;

/*. Write a query to retrieve the products that have been ordered more than 5 times*/

SELECT p.ProductID, p.Name, p.Category, COUNT(*) AS OrderCount
FROM Product_table p
INNER JOIN Orders_table o ON p.ProductID = o.ProductID
GROUP BY p.ProductID, p.Name, p.Category
HAVING COUNT(*) > 5;

/* Write a query to calculate the average total amount (TotalAmount) of all orders.
*/
SELECT AVG(TotalAmount) AS AverageTotalAmount
FROM Orders_table;

/*. Write a query to retrieve the customers who have placed orders for products in the "Meat" category.*/

SELECT DISTINCT c.CustomerID, c.FirstName, c.LastName
FROM Customers_table c
INNER JOIN Orders_table o ON c.CustomerID = o.CustomerID
INNER JOIN Product_table p ON o.ProductID = p.ProductID
WHERE p.Category = 'Meat';

/*. Write a query to calculate the total revenue generated from each customer.*/

SELECT c.CustomerID, c.FirstName, c.LastName, SUM(o.TotalAmount) AS TotalRevenue
FROM Customers_table c
INNER JOIN Orders_table o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;

/*. Write a query to retrieve the customer names and their respective order dates for orders placed on or after 
July 3, 2023*/

SELECT c.FirstName, c.LastName, o.OrderDate
FROM Customers_table c
INNER JOIN Orders_table o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate >= '2023-07-03';