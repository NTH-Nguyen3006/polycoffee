USE polycoffee;
GO

-- 1. Insert PROMOTIONS
INSERT INTO PROMOTIONS (code, discount_type, discount_value, min_order_value, start_date, end_date, usage_limit)
VALUES 
('WELCOME20', 'PERCENTAGE', 20.00, 100000, GETDATE(), DATEADD(day, 30, GETDATE()), 100),
('FREESHIP', 'FIXED', 15000, 50000, GETDATE(), DATEADD(day, 7, GETDATE()), 500),
('SALE50K', 'FIXED', 50000, 200000, GETDATE(), DATEADD(day, 14, GETDATE()), 50);

-- Declaring variables to hold dynamic UUIDs for products and users
DECLARE @ProductId1 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM PRODUCTS WHERE category_id = 1); -- Coffee
DECLARE @ProductId2 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM PRODUCTS WHERE category_id = 4); -- Milk Tea
DECLARE @UserId1 UNIQUEIDENTIFIER = (SELECT TOP 1 id FROM Users WHERE username = 'user1');
DECLARE @CartId1 UNIQUEIDENTIFIER = NEWID();

-- 2. Insert PRODUCT_OPTIONS
INSERT INTO PRODUCT_OPTIONS (product_id, option_group, option_name, additional_price)
VALUES 
(@ProductId1, N'Size', N'M', 0),
(@ProductId1, N'Size', N'L', 10000),
(@ProductId1, N'Đá', N'Ít đá', 0),
(@ProductId1, N'Đá', N'Bình thường', 0),

(@ProductId2, N'Size', N'M', 0),
(@ProductId2, N'Size', N'L', 15000),
(@ProductId2, N'Topping', N'Trân châu trắng', 10000),
(@ProductId2, N'Topping', N'Thạch trái cây', 10000);

-- 3. Insert Carts
INSERT INTO Carts (id, user_id, selected_options, total_items, temp_total_price)
VALUES (@CartId1, @UserId1, N'M, Ít đá', 2, 70000);

-- 4. Insert Cart_Items
INSERT INTO Cart_Items (cart_id, product_id, quantity, selected_options, sub_total)
VALUES (@CartId1, @ProductId1, 2, N'M, Ít đá', 70000);

-- 5. Insert Orders (Pending Order)
DECLARE @PromotionId1 BIGINT = (SELECT TOP 1 id FROM PROMOTIONS WHERE code = 'WELCOME20');

INSERT INTO Orders (user_id, promotion_id, order_code, total_amount, shipping_address, status, payment_status, note, created_at, updated_at)
VALUES (@UserId1, @PromotionId1, 'ORD_001', 56000, N'123 Đường B, Quận 1, TP HCM', N'PENDING', N'UNPAID', N'Giao giờ hành chính', GETDATE(), GETDATE());

DECLARE @OrderId1 BIGINT = SCOPE_IDENTITY();

-- 6. Insert ORDER_ITEMS for Order 1
INSERT INTO ORDER_ITEMS (order_id, product_id, product_name, quantity, price, options_snapshot)
VALUES (@OrderId1, @ProductId1, N'Cà Phê Đen Đá', 2, 35000, N'Size: M, Đá: Ít đá');

-- 7. Insert Orders (Completed Order)
INSERT INTO Orders (user_id, promotion_id, order_code, total_amount, shipping_address, status, payment_status, note, created_at, updated_at)
VALUES (@UserId1, NULL, 'ORD_002', 150000, N'123 Đường B, Quận 1, TP HCM', N'COMPLETED', N'PAID', N'', GETDATE(), GETDATE());

DECLARE @OrderId2 BIGINT = SCOPE_IDENTITY();

-- Insert ORDER_ITEMS for Order 2
INSERT INTO ORDER_ITEMS (order_id, product_id, product_name, quantity, price, options_snapshot)
VALUES (@OrderId2, @ProductId2, N'Trà Sữa Truyền Thống', 3, 50000, N'Size: L, Topping: Trân châu trắng');

-- 8. Insert PAYMENTS for Order 2
INSERT INTO PAYMENTS (order_id, payment_method, transaction_id, amount, payment_date)
VALUES (@OrderId2, N'VNPay', 'VNPAY_123456789', 150000, GETDATE());
