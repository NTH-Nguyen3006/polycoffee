CREATE DATABASE PolyCoffee;
GO

USE PolyCoffee;
GO

CREATE TABLE Users (
    id NVARCHAR(50) PRIMARY KEY,
    fullname NVARCHAR(50),
    email VARCHAR(25) UNIQUE,
    password NVARCHAR(255) NOT NULL,
    phone VARCHAR(10),
    role INT DEFAULT 1, -- 0: ADMIN, 1: USER, 2: EMPLOYEE
    is_active BIT DEFAULT 1,
    create_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE Categories (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50) NOT NULL,
    description NVARCHAR(MAX)
);

CREATE TABLE PROMOTIONS (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    code VARCHAR(50) UNIQUE NOT NULL,
    discount_type NVARCHAR(20),
    discount_value DECIMAL(18, 2),
    min_order_value DECIMAL(18, 2),
    start_date DATETIME,
    end_date DATETIME,
    usage_limit INT
);

CREATE TABLE PRODUCTS (
    id INT IDENTITY(1,1) PRIMARY KEY,
    category_id INT NOT NULL,
    name NVARCHAR(255) NOT NULL,
    base_price FLOAT DEFAULT 0,
    description NVARCHAR(MAX),
    thumbnail_url NVARCHAR(255),
    is_available BIT DEFAULT 1,
    is_featured BIT DEFAULT 0,
    CONSTRAINT FK_Products_Categories FOREIGN KEY (category_id) REFERENCES Categories(id)
);

CREATE TABLE PRODUCT_OPTIONS (
    id INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT NOT NULL,
    option_group NVARCHAR(100),
    option_name NVARCHAR(100),
    additional_price FLOAT DEFAULT 0,
    CONSTRAINT FK_Options_Products FOREIGN KEY (product_id) REFERENCES PRODUCTS(id)
);

CREATE TABLE Orders (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id NVARCHAR(50) NOT NULL, 
    promotion_id BIGINT,
    order_code VARCHAR(50) UNIQUE,
    total_amount DECIMAL(18, 2),
    shipping_address NVARCHAR(255),
    status NVARCHAR(50),
    payment_status NVARCHAR(50),
    note NVARCHAR(MAX),
    CONSTRAINT FK_Orders_Users FOREIGN KEY (user_id) REFERENCES Users(id),
    CONSTRAINT FK_Orders_Promotions FOREIGN KEY (promotion_id) REFERENCES PROMOTIONS(id)
);

CREATE TABLE ORDER_ITEMS (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    product_name NVARCHAR(255) NOT NULL,
    quantity INT DEFAULT 1,
    price DECIMAL(18, 2),
    options_snapshot NVARCHAR(MAX),
    CONSTRAINT FK_OrderItems_Orders FOREIGN KEY (order_id) REFERENCES Orders(id)
);

CREATE TABLE PAYMENTS (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    payment_method NVARCHAR(50),
    transaction_id VARCHAR(100),
    amount DECIMAL(18, 2),
    payment_date DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Payments_Orders FOREIGN KEY (order_id) REFERENCES Orders(id)
);

CREATE TABLE Carts (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id NVARCHAR(50) NOT NULL,
    total_items INT DEFAULT 0,
    temp_total_price DECIMAL(18, 2) DEFAULT 0,
    CONSTRAINT FK_Carts_Users FOREIGN KEY (user_id) REFERENCES Users(id)
);

-- 10. Cart Items table
CREATE TABLE Cart_Items (
    id INT IDENTITY(1,1) PRIMARY KEY,
    cart_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT DEFAULT 1,
    selected_options NVARCHAR(MAX), -- JSON representation
    sub_total DECIMAL(18, 2),
    CONSTRAINT FK_CartItems_Carts FOREIGN KEY (cart_id) REFERENCES Carts(id),
    CONSTRAINT FK_CartItems_Products FOREIGN KEY (product_id) REFERENCES PRODUCTS(id)
);
