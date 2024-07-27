create database project;
use project;
-- Create User table
CREATE TABLE User (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    ContactNumber VARCHAR(20),
    ShippingAddress VARCHAR(255)
);

-- Create Product table
CREATE TABLE Product (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL,
    StockLevel INT NOT NULL
);

-- Create Order table
CREATE TABLE `Order` (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    OrderDate DATE NOT NULL,
    TotalCost DECIMAL(10, 2) NOT NULL,
    ShippingDetails VARCHAR(255),
    OrderStatus VARCHAR(50) NOT NULL,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

-- Create Transaction table
CREATE TABLE Transaction (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT UNIQUE,
    PaymentMethod VARCHAR(50) NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    TransactionStatus VARCHAR(50) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Order(OrderID)
);

-- Create Inventory table
CREATE TABLE Inventory (
    ProductID INT PRIMARY KEY,
    StockLevel INT NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Create Interaction table
CREATE TABLE Interaction (
    InteractionID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    InteractionType VARCHAR(50) NOT NULL,
    InteractionDate DATETIME NOT NULL,
    InteractionDetails TEXT,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

-- Create Analytics table
CREATE TABLE Analytics (
    AnalyticsID INT AUTO_INCREMENT PRIMARY KEY,
    Date DATE NOT NULL,
    UserActivity TEXT,
    SalesData TEXT,
    WebsitePerformanceMetrics TEXT
);

-- Inserting sample data into the Order table
INSERT INTO Order (UserID, OrderDate, TotalCost, ShippingDetails, OrderStatus) VALUES
(1, '2024-05-10', 799.99, '123 Main St, City, Country', 'Processing'),
(2, '2024-05-09', 599.99, '456 Oak St, Town, Country', 'Shipped'),
(1, '2024-05-08', 149.99, '789 Elm St, Village, Country', 'Delivered');

-- Inserting sample data into the Transaction table
INSERT INTO Transaction (OrderID, PaymentMethod, Amount, TransactionStatus) VALUES
(1, 'Credit Card', 799.99, 'Completed'),
(2, 'PayPal', 599.99, 'Pending'),
(3, 'Debit Card', 149.99, 'Completed');

-- Inserting sample data into the Inventory table with product information
INSERT INTO Inventory (ProductID, ProductName, StockLevel) VALUES
(1, 'Men\'s Shirt', 50),
(2, 'Women\'s Dress', 100),
(3, 'Unisex Hoodie', 200);
-- Inserting sample data into the Analytics table
INSERT INTO Analytics (Date, UserActivity, SalesData, WebsitePerformanceMetrics) VALUES
('2024-05-10', 'User logins: 150, New registrations: 20', 'Total sales: $2000, Average order value: $100', 'Page load time: 2.5s, Conversion rate: 3%'),
('2024-05-09', 'User logins: 180, New registrations: 25', 'Total sales: $2500, Average order value: $110', 'Page load time: 2.7s, Conversion rate: 3.5%'),
('2024-05-08', 'User logins: 200, New registrations: 30', 'Total sales: $3000, Average order value: $120', 'Page load time: 2.8s, Conversion rate: 4%');

SELECT OrderID, Name AS UserName, Email AS UserEmail, OrderDate, TotalCost, ShippingDetails, OrderStatus
FROM Order
JOIN User ON Order.UserID = User.UserID;

Copy code
SELECT Date, SUM(Amount) AS TotalSales
FROM Transaction
JOIN Order ON Transaction.OrderID = Order.OrderID

SELECT ProductID, Name AS ProductName, StockLevel
FROM Inventory
JOIN Product ON Inventory.ProductID = Product.ProductID
ORDER BY StockLevel DESC
LIMIT 5;

SELECT InteractionID, Name AS UserName, InteractionType, InteractionDate, InteractionDetails
FROM Interaction
JOIN User ON Interaction.UserID = User.UserID
WHERE Interaction.UserID = 1;

