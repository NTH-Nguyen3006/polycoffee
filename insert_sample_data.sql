-- Sample Data for Polycoffee

USE polycoffee;
GO

-- 1. Insert Categories (>= 6)
SET IDENTITY_INSERT Categories ON;
INSERT INTO Categories (id, name, description) VALUES 
(1, N'Coffee', N'Cà phê nguyên chất, thơm ngon từ hạt Robusta và Arabica.'),
(2, N'Tea', N'Trà thảo mộc, trà trái cây thanh mát.'),
(3, N'Juice', N'Nước ép trái cây tươi nguyên chất, giàu vitamin.'),
(4, N'Milk Tea', N'Trà sữa béo ngậy với nhiều loại topping hấp dẫn.'),
(5, N'Smoothies', N'Sinh tố trái cây tươi mát lạnh, bổ dưỡng.'),
(6, N'Snacks', N'Các món ăn vặt đi kèm tuyệt vời.');
SET IDENTITY_INSERT Categories OFF;

-- 2. Insert Users (>= 3)
-- Role: 0=ADMIN, 1=USER, 2=EMPLOYEE (Hibernate ORDINAL)
INSERT INTO Users (id, username, fullname, email, password, phone, role, active, created_at) VALUES 
(NEWID(), 'admin', N'Quản Trị Viên', 'admin@polycoffee.com', '123', '987654321', 0, 1, GETDATE()),
(NEWID(), 'user1', N'Nguyễn Văn A', 'user1@gmail.com', '123', '912345678', 1, 1, GETDATE()),
(NEWID(), 'employee1', N'Trần Thị B', 'emp1@polycoffee.com', '123', '944556677', 2, 1, GETDATE());

-- 3. Insert Products (>= 50)
-- category_id references Categories(id)
-- thumbnail_url: placeholder image URLs
INSERT INTO PRODUCTS (id, category_id, name, base_price, description, thumbnail_url, is_available, is_featured, created_at, updated_at) VALUES 
-- Category 1: Coffee (10 items)
(NEWID(), 1, N'Cà Phê Đen Đá', 25000, N'Cà phê phin đậm đà truyền thống.', '', 1, 1, GETDATE(), GETDATE()),
(NEWID(), 1, N'Cà Phê Sữa Đá', 29000, N'Cà phê pha phin với sữa đặc béo ngậy.', '', 1, 1, GETDATE(), GETDATE()),
(NEWID(), 1, N'Bạc Xỉu', 35000, N'Sữa tươi pha cùng cà phê đậm chất Sài Gòn.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 1, N'Capuchino', 45000, N'Hương vị Ý nhẹ nhàng, lớp bọt mịn màng.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 1, N'Latte', 45000, N'Sự kết hợp hoàn hảo giữa Espresso và sữa nóng.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 1, N'Americano', 35000, N'Cà phê đen pha loãng phong cách Mỹ.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 1, N'Mocha', 49000, N'Sự hòa quyện giữa cà phê và socola.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 1, N'Caramel Macchiato', 55000, N'Vị ngọt caramel quyện trong lớp sữa xốp.', '', 1, 1, GETDATE(), GETDATE()),
(NEWID(), 1, N'Espresso', 30000, N'Cà phê nguyên chất đậm đặc.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 1, N'Cold Brew', 45000, N'Cà phê ủ lạnh 16 giờ thanh tao.', '', 1, 0, GETDATE(), GETDATE()),

-- Category 2: Tea (8 items)
(NEWID(), 2, N'Trà Đào Cam Sả', 39000, N'Trà đào tươi mát kết hợp cam và sả thơm nồng.', '', 1, 1, GETDATE(), GETDATE()),
(NEWID(), 2, N'Trà Vải Khiếm Thực', 39000, N'Vị vải ngọt thanh kết hợp trà quyến rũ.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 2, N'Trà Sen Vàng', 45000, N'Trà sen thơm dịu, hạt sen bùi ngậy.', '', 1, 1, GETDATE(), GETDATE()),
(NEWID(), 2, N'Trà Thảo Mộc', 35000, N'Thanh nhiệt cơ thể, tốt cho sức khỏe.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 2, N'Trà Nhài', 30000, N'Hương hoa nhài thơm ngát.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 2, N'Trà Atiso', 35000, N'Vị đắng nhẹ, thanh lọc gan.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 2, N'Trà Ô Long', 35000, N'Trà ô long thượng hạng.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 2, N'Trà Táo Bạc Hà', 42000, N'Trà táo xanh giòn tan, bạc hà mát lạnh.', '', 1, 0, GETDATE(), GETDATE()),

-- Category 3: Juice (8 items)
(NEWID(), 3, N'Nước Cam Ép', 45000, N'Cam tươi vắt giàu Vitamin C.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 3, N'Nước Ép Dưa Hấu', 40000, N'Dưa hấu chín mọng, giải nhiệt cực đã.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 3, N'Nước Ép Thơm', 40000, N'Thơm (Dứa) tươi chua ngọt hài hòa.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 3, N'Nước Ép Ổi', 40000, N'Nước ép ổi tươi giàu chất xơ.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 3, N'Nước Ép Táo', 45000, N'Táo đỏ nhập khẩu thơm ngọt.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 3, N'Nước Ép Cà Rốt', 40000, N'Cà rốt tươi, tốt cho mắt.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 3, N'Nước Ép Hỗn Hợp', 50000, N'Mix nhiều loại trái cây theo yêu cầu.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 3, N'Nước Chanh Đá', 25000, N'Chanh tươi truyền thống.', '', 1, 0, GETDATE(), GETDATE()),

-- Category 4: Milk Tea (10 items)
(NEWID(), 4, N'Trà Sữa Truyền Thống', 35000, N'Vị trà sữa đậm đà, thơm lừng.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 4, N'Trà Sữa Thái Xanh', 35000, N'Trà thái xanh thơm dịu.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 4, N'Trà Sữa Thái Đỏ', 35000, N'Trà thái đỏ đậm vị.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 4, N'Trà Sữa Trân Châu Đường Đen', 49000, N'Cực phẩm trân châu dai giòn, đường đen ngọt lịm.', '', 1, 1, GETDATE(), GETDATE()),
(NEWID(), 4, N'Trà Sữa Matcha', 45000, N'Matcha Nhật Bản nguyên chất.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 4, N'Trà Sữa Socola', 45000, N'Hương vị socola đậm đà.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 4, N'Trà Sữa Khoai Môn', 45000, N'Bùi thơm vị khoai môn.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 4, N'Trà Sữa Bạc Hà', 45000, N'Thanh mát vị bạc hà.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 4, N'Trà Sữa Việt Quất', 45000, N'Vị việt quất chua ngọt.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 4, N'Trà Sữa Sương Sáo', 39000, N'Kết hợp sương sáo thanh mát.', '', 1, 0, GETDATE(), GETDATE()),

-- Category 5: Smoothies (8 items)
(NEWID(), 5, N'Sinh Tố Bơ', 55000, N'Bơ sáp béo ngậy, giàu dinh dưỡng.', '', 1, 1, GETDATE(), GETDATE()),
(NEWID(), 5, N'Sinh Tố Xoài', 45000, N'Xoài chín vàng thơm ngọt.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 5, N'Sinh Tố Dâu', 50000, N'Dâu tây tươi chua ngọt.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 5, N'Sinh Tố Mãng Cầu', 45000, N'Mãng cầu xiêm đặc trưng.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 5, N'Sinh Tố Sapoche', 45000, N'Lòng mứt ngọt lịm bổ dưỡng.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 5, N'Sinh Tố Việt Quất', 55000, N'Quả việt quất tươi ngon.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 5, N'Sinh Tố Chuối', 40000, N'Chuối sứ thơm dẻo.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 5, N'Sinh Tố Sầu Riêng', 65000, N'Hương vị sầu riêng đặc biệt.', '', 1, 1, GETDATE(), GETDATE()),

-- Category 6: Snacks (6 items)
(NEWID(), 6, N'Bánh Tiramisu', 45000, N'Bánh ngọt Ý trứ danh.', '', 1, 1, GETDATE(), GETDATE()),
(NEWID(), 6, N'Bánh Mì Tỏi', 35000, N'Bánh mì nướng bơ tỏi thơm lừng.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 6, N'Khoai Tây Chiên', 30000, N'Khoai tây vàng giòn, sốt mặn ngọt.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 6, N'Phô Mai Que', 35000, N'Phô mai kéo sợi hấp dẫn.', '', 1, 0, GETDATE(), GETDATE()),
(NEWID(), 6, N'Gà Lắc Phô Mai', 45000, N'Gà viên chiên giòn rắc bột phô mai.', '', 1, 1, GETDATE(), GETDATE()),
(NEWID(), 6, N'Hướng Dương', 15000, N'Món nhâm nhi cùng trà tuyệt vời.', '', 1, 0, GETDATE(), GETDATE());
