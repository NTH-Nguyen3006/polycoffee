-- Migration: Thêm cột created_at cho bảng Orders (nếu chưa có)
-- Chạy script này trong SQL Server Management Studio

USE PolyCoffee;
GO

-- Thêm cột created_at nếu chưa tồn tại
IF NOT EXISTS (
    SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'Orders' AND COLUMN_NAME = 'created_at'
)
BEGIN
    ALTER TABLE Orders
    ADD created_at DATETIME DEFAULT GETDATE();
    PRINT 'Đã thêm cột created_at vào bảng Orders';
END
ELSE
BEGIN
    PRINT 'Cột created_at đã tồn tại trong bảng Orders';
END
GO

-- Thêm cột updated_at nếu chưa tồn tại
IF NOT EXISTS (
    SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'Orders' AND COLUMN_NAME = 'updated_at'
)
BEGIN
    ALTER TABLE Orders
    ADD updated_at DATETIME DEFAULT GETDATE();
    PRINT 'Đã thêm cột updated_at vào bảng Orders';
END
GO

-- Cập nhật dữ liệu cũ (đặt created_at = GETDATE() cho các record rỗng)
UPDATE Orders
SET created_at = GETDATE()
WHERE created_at IS NULL;
GO

PRINT 'Migration hoàn thành!';
