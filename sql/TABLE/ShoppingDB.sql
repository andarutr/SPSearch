-- Shopping Database - 134 Tables with 3 Records Each
-- ROWID as PK, dex_row_id as unique identifier, full FK relationships

CREATE DATABASE ShoppingDB;
GO
USE ShoppingDB;
GO

-- ============================================================
-- TIER 0: No FK dependencies
-- ============================================================

-- TBL001 - Countries
CREATE TABLE Countries (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    country_code VARCHAR(10) UNIQUE NOT NULL,
    country_name NVARCHAR(100) NOT NULL,
    phone_code VARCHAR(5),
    currency_code VARCHAR(10),
    is_active BIT DEFAULT 1
);
GO

INSERT INTO Countries (dex_row_id, country_code, country_name, phone_code, currency_code) VALUES
('DEX001', 'ID', N'Indonesia', '62', 'IDR'),
('DEX002', 'US', 'United States', '1', 'USD'),
('DEX003', 'SG', N'Singapore', '65', 'SGD');
GO

-- TBL002 - Currencies
CREATE TABLE Currencies (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    currency_code VARCHAR(10) UNIQUE NOT NULL,
    currency_name NVARCHAR(50) NOT NULL,
    symbol VARCHAR(5),
    exchange_rate DECIMAL(18,6) DEFAULT 1,
    is_base BIT DEFAULT 0
);
GO

INSERT INTO Currencies (dex_row_id, currency_code, currency_name, symbol, exchange_rate, is_base) VALUES
('DEX004', 'IDR', 'Indonesian Rupiah', 'Rp', 1, 1),
('DEX005', 'USD', 'US Dollar', '$', 16000, 0),
('DEX006', 'SGD', 'Singapore Dollar', 'S$', 12000, 0);
GO

-- TBL003 - UserRoles
CREATE TABLE UserRoles (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    role_code VARCHAR(20) UNIQUE NOT NULL,
    role_name NVARCHAR(50) NOT NULL,
    description NVARCHAR(200)
);
GO

INSERT INTO UserRoles (dex_row_id, role_code, role_name, description) VALUES
('DEX007', 'ADMIN', 'Administrator', N'Akses penuh ke sistem'),
('DEX008', 'SELLER', 'Seller', N'Penjual / merchant'),
('DEX009', 'CUSTOMER', 'Customer', N'Pembeli / pelanggan');
GO

-- TBL004 - Permissions
CREATE TABLE Permissions (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    permission_code VARCHAR(50) UNIQUE NOT NULL,
    permission_name NVARCHAR(100) NOT NULL,
    module_name NVARCHAR(50)
);
GO

INSERT INTO Permissions (dex_row_id, permission_code, permission_name, module_name) VALUES
('DEX010', 'PRODUCT_READ', 'Read Products', 'Catalog'),
('DEX011', 'PRODUCT_WRITE', 'Create/Edit Products', 'Catalog'),
('DEX012', 'ORDER_MANAGE', 'Manage Orders', 'Sales');
GO

-- TBL005 - NotificationTypes
CREATE TABLE NotificationTypes (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    type_code VARCHAR(20) UNIQUE NOT NULL,
    type_name NVARCHAR(50) NOT NULL,
    template_text NVARCHAR(MAX)
);
GO

INSERT INTO NotificationTypes (dex_row_id, type_code, type_name, template_text) VALUES
('DEX013', 'ORDER_CONFIRM', N'Order Confirmation', 'Your order #{{order_no}} has been confirmed.'),
('DEX014', 'SHIPPED', N'Shipping Update', 'Your order #{{order_no}} has been shipped.'),
('DEX015', 'PROMO', N'Promotional', 'Check out our latest deals!');
GO

-- TBL006 - DiscountTypes
CREATE TABLE DiscountTypes (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    type_code VARCHAR(20) UNIQUE NOT NULL,
    type_name NVARCHAR(50) NOT NULL,
    calculation_method VARCHAR(20) CHECK (calculation_method IN ('PERCENTAGE', 'FIXED'))
);
GO

INSERT INTO DiscountTypes (dex_row_id, type_code, type_name, calculation_method) VALUES
('DEX016', 'PERCENT', N'Percentage Discount', 'PERCENTAGE'),
('DEX017', 'FIXED', N'Fixed Amount', 'FIXED'),
('DEX018', 'FREE_SHIPPING', N'Free Shipping', 'FIXED');
GO

-- TBL007 - CouponTypes
CREATE TABLE CouponTypes (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    type_code VARCHAR(20) UNIQUE NOT NULL,
    type_name NVARCHAR(50) NOT NULL
);
GO

INSERT INTO CouponTypes (dex_row_id, type_code, type_name) VALUES
('DEX019', 'PUBLIC', 'Public Coupon'),
('DEX020', 'PRIVATE', 'Private Coupon'),
('DEX021', 'WELCOME', 'Welcome New User');
GO

-- TBL008 - OrderStatuses
CREATE TABLE OrderStatuses (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    status_code VARCHAR(20) UNIQUE NOT NULL,
    status_name NVARCHAR(50) NOT NULL,
    sort_order INT DEFAULT 0
);
GO

INSERT INTO OrderStatuses (dex_row_id, status_code, status_name, sort_order) VALUES
('DEX022', 'PENDING', 'Pending', 1),
('DEX023', 'CONFIRMED', 'Confirmed', 2),
('DEX024', 'SHIPPED', 'Shipped', 3);
GO

-- TBL009 - ReturnStatuses
CREATE TABLE ReturnStatuses (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    status_code VARCHAR(20) UNIQUE NOT NULL,
    status_name NVARCHAR(50) NOT NULL
);
GO

INSERT INTO ReturnStatuses (dex_row_id, status_code, status_name) VALUES
('DEX025', 'REQUESTED', 'Return Requested'),
('DEX026', 'APPROVED', 'Approved'),
('DEX027', 'COMPLETED', 'Completed');
GO

-- TBL010 - ReviewStatuses
CREATE TABLE ReviewStatuses (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    status_code VARCHAR(20) UNIQUE NOT NULL,
    status_name NVARCHAR(50) NOT NULL
);
GO

INSERT INTO ReviewStatuses (dex_row_id, status_code, status_name) VALUES
('DEX028', 'PENDING', 'Pending Moderation'),
('DEX029', 'APPROVED', 'Approved'),
('DEX030', 'REJECTED', 'Rejected');
GO

-- TBL011 - ShippingMethods
CREATE TABLE ShippingMethods (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    method_code VARCHAR(20) UNIQUE NOT NULL,
    method_name NVARCHAR(50) NOT NULL,
    base_cost DECIMAL(12,2) DEFAULT 0,
    estimated_days_min INT,
    estimated_days_max INT
);
GO

INSERT INTO ShippingMethods (dex_row_id, method_code, method_name, base_cost, estimated_days_min, estimated_days_max) VALUES
('DEX031', 'JNE_REG', 'JNE Reguler', 15000, 2, 5),
('DEX032', 'JNE_YES', 'JNE YES', 30000, 1, 2),
('DEX033', 'GOSEND', 'GoSend Instant', 50000, 0, 1);
GO

-- TBL012 - PaymentMethods
CREATE TABLE PaymentMethods (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    method_code VARCHAR(20) UNIQUE NOT NULL,
    method_name NVARCHAR(50) NOT NULL,
    processing_fee_percent DECIMAL(5,2) DEFAULT 0
);
GO

INSERT INTO PaymentMethods (dex_row_id, method_code, method_name, processing_fee_percent) VALUES
('DEX034', 'BCA_VA', 'BCA Virtual Account', 0.50),
('DEX035', 'GOPAY', 'GoPay', 0.75),
('DEX036', 'COD', 'Cash on Delivery', 0);
GO

-- TBL013 - PaymentGateways
CREATE TABLE PaymentGateways (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    gateway_code VARCHAR(20) UNIQUE NOT NULL,
    gateway_name NVARCHAR(50) NOT NULL,
    api_endpoint VARCHAR(200),
    is_active BIT DEFAULT 1
);
GO

INSERT INTO PaymentGateways (dex_row_id, gateway_code, gateway_name, api_endpoint) VALUES
('DEX037', 'MIDTRANS', 'Midtrans', 'https://api.midtrans.com/v2'),
('DEX038', 'XENDIT', 'Xendit', 'https://api.xendit.co'),
('DEX039', 'DOKU', 'Doku', 'https://api.doku.com');
GO

-- TBL014 - ProductCategories
CREATE TABLE ProductCategories (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    category_code VARCHAR(20) UNIQUE NOT NULL,
    category_name NVARCHAR(100) NOT NULL,
    description NVARCHAR(200),
    icon_url VARCHAR(200)
);
GO

INSERT INTO ProductCategories (dex_row_id, category_code, category_name, description) VALUES
('DEX040', 'ELEC', N'Electronics', N'Gadgets, computers, phones'),
('DEX041', 'FASHION', N'Fashion', N'Clothing, accessories'),
('DEX042', 'HOME', N'Home & Living', N'Furniture, decor, kitchen');
GO

-- TBL015 - Brands
CREATE TABLE Brands (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    brand_code VARCHAR(20) UNIQUE NOT NULL,
    brand_name NVARCHAR(100) NOT NULL,
    description NVARCHAR(200),
    website_url VARCHAR(200)
);
GO

INSERT INTO Brands (dex_row_id, brand_code, brand_name, website_url) VALUES
('DEX043', 'SAMSUNG', 'Samsung', 'https://samsung.com'),
('DEX044', 'NIKE', 'Nike', 'https://nike.com'),
('DEX045', 'IKEA', 'IKEA', 'https://ikea.com');
GO

-- TBL016 - ProductTags
CREATE TABLE ProductTags (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    tag_code VARCHAR(20) UNIQUE NOT NULL,
    tag_name NVARCHAR(50) NOT NULL
);
GO

INSERT INTO ProductTags (dex_row_id, tag_code, tag_name) VALUES
('DEX046', 'BESTSELLER', 'Best Seller'),
('DEX047', 'NEWARRIVAL', 'New Arrival'),
('DEX048', 'DISCOUNTED', 'Discounted');
GO

-- TBL017 - ProductAttributes
CREATE TABLE ProductAttributes (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    attribute_code VARCHAR(20) UNIQUE NOT NULL,
    attribute_name NVARCHAR(50) NOT NULL,
    attribute_type VARCHAR(20) CHECK (attribute_type IN ('TEXT', 'COLOR', 'SIZE', 'NUMBER'))
);
GO

INSERT INTO ProductAttributes (dex_row_id, attribute_code, attribute_name, attribute_type) VALUES
('DEX049', 'COLOR', 'Color', 'COLOR'),
('DEX050', 'SIZE', 'Size', 'SIZE'),
('DEX051', 'STORAGE', 'Storage Capacity', 'TEXT');
GO

-- TBL018 - SupplierStatuses
CREATE TABLE SupplierStatuses (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    status_code VARCHAR(20) UNIQUE NOT NULL,
    status_name NVARCHAR(50) NOT NULL
);
GO

INSERT INTO SupplierStatuses (dex_row_id, status_code, status_name) VALUES
('DEX052', 'ACTIVE', 'Active'),
('DEX053', 'INACTIVE', 'Inactive'),
('DEX054', 'BLACKLISTED', 'Blacklisted');
GO

-- TBL019 - CampaignTypes
CREATE TABLE CampaignTypes (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    type_code VARCHAR(20) UNIQUE NOT NULL,
    type_name NVARCHAR(50) NOT NULL
);
GO

INSERT INTO CampaignTypes (dex_row_id, type_code, type_name) VALUES
('DEX055', 'SEASONAL', 'Seasonal Sale'),
('DEX056', 'FLASH', N'Flash Sale'),
('DEX057', 'LOYALTY', 'Loyalty Program');
GO

-- TBL020 - TicketCategories
CREATE TABLE TicketCategories (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    category_code VARCHAR(20) UNIQUE NOT NULL,
    category_name NVARCHAR(50) NOT NULL
);
GO

INSERT INTO TicketCategories (dex_row_id, category_code, category_name) VALUES
('DEX058', 'ORDER_ISSUE', N'Order Issue'),
('DEX059', 'PAYMENT', N'Payment Problem'),
('DEX060', 'PRODUCT', N'Product Inquiry');
GO

-- TBL021 - FAQCategories
CREATE TABLE FAQCategories (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    category_code VARCHAR(20) UNIQUE NOT NULL,
    category_name NVARCHAR(50) NOT NULL
);
GO

INSERT INTO FAQCategories (dex_row_id, category_code, category_name) VALUES
('DEX061', 'SHIPPING', 'Shipping'),
('DEX062', 'RETURNS', 'Returns & Refunds'),
('DEX063', 'PAYMENT', 'Payment');
GO

-- TBL022 - BannerTypes
CREATE TABLE BannerTypes (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    type_code VARCHAR(20) UNIQUE NOT NULL,
    type_name NVARCHAR(50) NOT NULL,
    width INT,
    height INT
);
GO

INSERT INTO BannerTypes (dex_row_id, type_code, type_name, width, height) VALUES
('DEX064', 'HERO', 'Hero Banner', 1920, 600),
('DEX065', 'SIDEBAR', 'Sidebar Banner', 300, 250),
('DEX066', 'MOBILE', 'Mobile Banner', 720, 300);
GO

-- TBL023 - MediaTypes
CREATE TABLE MediaTypes (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    type_code VARCHAR(20) UNIQUE NOT NULL,
    type_name NVARCHAR(50) NOT NULL,
    extension VARCHAR(10)
);
GO

INSERT INTO MediaTypes (dex_row_id, type_code, type_name, extension) VALUES
('DEX067', 'IMAGE', 'Image', '.jpg'),
('DEX068', 'VIDEO', 'Video', '.mp4'),
('DEX069', 'DOCUMENT', 'Document', '.pdf');
GO

-- TBL024 - SubscriptionPlanTypes
CREATE TABLE SubscriptionPlanTypes (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    plan_code VARCHAR(20) UNIQUE NOT NULL,
    plan_name NVARCHAR(50) NOT NULL,
    duration_days INT,
    price DECIMAL(12,2)
);
GO

INSERT INTO SubscriptionPlanTypes (dex_row_id, plan_code, plan_name, duration_days, price) VALUES
('DEX070', 'BASIC', 'Basic Plan', 30, 50000),
('DEX071', 'PREMIUM', 'Premium Plan', 30, 150000),
('DEX072', 'VIP', 'VIP Plan', 365, 1500000);
GO

-- TBL025 - ShippingZoneTypes
CREATE TABLE ShippingZoneTypes (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    zone_code VARCHAR(20) UNIQUE NOT NULL,
    zone_name NVARCHAR(50) NOT NULL
);
GO

INSERT INTO ShippingZoneTypes (dex_row_id, zone_code, zone_name) VALUES
('DEX073', 'LOCAL', 'Local City'),
('DEX074', 'DOMESTIC', 'Domestic'),
('DEX075', 'INTERNATIONAL', 'International');
GO

-- TBL026 - SettlementStatuses
CREATE TABLE SettlementStatuses (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    status_code VARCHAR(20) UNIQUE NOT NULL,
    status_name NVARCHAR(50) NOT NULL
);
GO

INSERT INTO SettlementStatuses (dex_row_id, status_code, status_name) VALUES
('DEX076', 'PENDING', 'Pending Settlement'),
('DEX077', 'SETTLED', 'Settled'),
('DEX078', 'DISPUTED', 'Disputed');
GO

-- TBL027 - PayoutStatuses
CREATE TABLE PayoutStatuses (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    status_code VARCHAR(20) UNIQUE NOT NULL,
    status_name NVARCHAR(50) NOT NULL
);
GO

INSERT INTO PayoutStatuses (dex_row_id, status_code, status_name) VALUES
('DEX079', 'SCHEDULED', 'Scheduled'),
('DEX080', 'PROCESSING', 'Processing'),
('DEX081', 'COMPLETED', 'Completed');
GO

-- TBL028 - InvoiceStatuses
CREATE TABLE InvoiceStatuses (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    status_code VARCHAR(20) UNIQUE NOT NULL,
    status_name NVARCHAR(50) NOT NULL
);
GO

INSERT INTO InvoiceStatuses (dex_row_id, status_code, status_name) VALUES
('DEX082', 'UNPAID', 'Unpaid'),
('DEX083', 'PAID', 'Paid'),
('DEX084', 'OVERDUE', 'Overdue');
GO

-- TBL029 - EmailTemplateTypes
CREATE TABLE EmailTemplateTypes (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    type_code VARCHAR(20) UNIQUE NOT NULL,
    type_name NVARCHAR(50) NOT NULL
);
GO

INSERT INTO EmailTemplateTypes (dex_row_id, type_code, type_name) VALUES
('DEX085', 'WELCOME', 'Welcome Email'),
('DEX086', 'ORDER_CONFIRM', 'Order Confirmation'),
('DEX087', 'RESET_PWD', 'Password Reset');
GO

-- TBL030 - SupportTicketPriorities
CREATE TABLE SupportTicketPriorities (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    priority_code VARCHAR(20) UNIQUE NOT NULL,
    priority_name NVARCHAR(50) NOT NULL,
    sla_hours INT
);
GO

INSERT INTO SupportTicketPriorities (dex_row_id, priority_code, priority_name, sla_hours) VALUES
('DEX088', 'LOW', 'Low', 72),
('DEX089', 'MEDIUM', 'Medium', 24),
('DEX090', 'HIGH', 'High', 4);
GO
-- ============================================================
-- TIER 1: Depends on Tier 0
-- ============================================================

-- TBL031 - RolePermissions (FK: Roles, Permissions)
CREATE TABLE RolePermissions (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    role_rowid INT NOT NULL,
    permission_rowid INT NOT NULL
);
GO

INSERT INTO RolePermissions (dex_row_id, role_rowid, permission_rowid) VALUES
('DEX091', 1, 1),
('DEX092', 1, 2),
('DEX093', 1, 3);
GO

ALTER TABLE RolePermissions ADD CONSTRAINT FK_RolePerm_Roles FOREIGN KEY (role_rowid) REFERENCES UserRoles(ROWID);
ALTER TABLE RolePermissions ADD CONSTRAINT FK_RolePerm_Permissions FOREIGN KEY (permission_rowid) REFERENCES Permissions(ROWID);
GO

-- TBL032 - Users (FK: Country, Currency, Role)
CREATE TABLE Users (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    user_code VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(200) NOT NULL,
    full_name NVARCHAR(100) NOT NULL,
    phone_number VARCHAR(20),
    country_rowid INT,
    currency_rowid INT,
    role_rowid INT NOT NULL,
    is_verified BIT DEFAULT 0,
    is_active BIT DEFAULT 1,
    registered_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO Users (dex_row_id, user_code, email, password_hash, full_name, phone_number, country_rowid, currency_rowid, role_rowid) VALUES
('DEX094', 'USR001', 'admin@shop.com', 'hash_admin_123', N'Admin Utama', '081234567890', 1, 1, 1),
('DEX095', 'USR002', 'seller@shop.com', 'hash_seller_123', N'Toko Makmur', '081234567891', 1, 1, 2),
('DEX096', 'USR003', 'customer@shop.com', 'hash_cust_123', N'Budi Pembeli', '081234567892', 1, 1, 3);
GO

ALTER TABLE Users ADD CONSTRAINT FK_Users_Country FOREIGN KEY (country_rowid) REFERENCES Countries(ROWID);
ALTER TABLE Users ADD CONSTRAINT FK_Users_Currency FOREIGN KEY (currency_rowid) REFERENCES Currencies(ROWID);
ALTER TABLE Users ADD CONSTRAINT FK_Users_Role FOREIGN KEY (role_rowid) REFERENCES UserRoles(ROWID);
GO

-- TBL033 - UserDevices (FK: User)
CREATE TABLE UserDevices (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    user_rowid INT NOT NULL,
    device_token VARCHAR(200),
    device_type VARCHAR(20),
    last_login_at DATETIME
);
GO

INSERT INTO UserDevices (dex_row_id, user_rowid, device_token, device_type) VALUES
('DEX097', 1, 'token_admin_001', 'Web'),
('DEX098', 2, 'token_seller_001', 'Mobile'),
('DEX099', 3, 'token_cust_001', 'Mobile');
GO

ALTER TABLE UserDevices ADD CONSTRAINT FK_UserDevices_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
GO

-- TBL034 - UserAddresses (FK: User, Country)
CREATE TABLE UserAddresses (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    user_rowid INT NOT NULL,
    country_rowid INT NOT NULL,
    label NVARCHAR(50),
    street_address NVARCHAR(200) NOT NULL,
    city NVARCHAR(50),
    state NVARCHAR(50),
    postal_code VARCHAR(20),
    is_default BIT DEFAULT 0,
    latitude DECIMAL(10,7),
    longitude DECIMAL(10,7)
);
GO

INSERT INTO UserAddresses (dex_row_id, user_rowid, country_rowid, label, street_address, city, state, postal_code, is_default) VALUES
('DEX100', 1, 1, 'Office', N'Jl. Sudirman No. 1', N'Jakarta', 'DKI Jakarta', '10210', 1),
('DEX101', 3, 1, 'Home', N'Jl. Merdeka No. 45', N'Bandung', 'West Java', '40111', 1),
('DEX102', 3, 1, 'Office', N'Jl. Gatot Subroto No. 88', N'Jakarta', 'DKI Jakarta', '10230', 0);
GO

ALTER TABLE UserAddresses ADD CONSTRAINT FK_UserAddr_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
ALTER TABLE UserAddresses ADD CONSTRAINT FK_UserAddr_Country FOREIGN KEY (country_rowid) REFERENCES Countries(ROWID);
GO

-- TBL035 - UserPaymentMethods (FK: User, PaymentMethod)
CREATE TABLE UserPaymentMethods (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    user_rowid INT NOT NULL,
    payment_method_rowid INT NOT NULL,
    account_number VARCHAR(100),
    account_name NVARCHAR(100),
    is_default BIT DEFAULT 0
);
GO

INSERT INTO UserPaymentMethods (dex_row_id, user_rowid, payment_method_rowid, account_number, account_name, is_default) VALUES
('DEX103', 2, 1, '1234567890', N'Toko Makmur', 1),
('DEX104', 3, 2, '081234567892', N'Budi Pembeli', 1),
('DEX105', 1, 1, '0987654321', N'Admin Shop', 0);
GO

ALTER TABLE UserPaymentMethods ADD CONSTRAINT FK_UserPay_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
ALTER TABLE UserPaymentMethods ADD CONSTRAINT FK_UserPay_Method FOREIGN KEY (payment_method_rowid) REFERENCES PaymentMethods(ROWID);
GO

-- TBL036 - UserPreferences (FK: User)
CREATE TABLE UserPreferences (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    user_rowid INT NOT NULL,
    language VARCHAR(10) DEFAULT 'id',
    theme VARCHAR(20) DEFAULT 'light',
    items_per_page INT DEFAULT 24,
    email_notifications BIT DEFAULT 1,
    push_notifications BIT DEFAULT 1
);
GO

INSERT INTO UserPreferences (dex_row_id, user_rowid, language, theme) VALUES
('DEX106', 1, 'id', 'dark'),
('DEX107', 2, 'id', 'light'),
('DEX108', 3, 'en', 'light');
GO

ALTER TABLE UserPreferences ADD CONSTRAINT FK_UserPref_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
GO

-- TBL037 - UserNotifications (FK: User, NotificationType)
CREATE TABLE UserNotifications (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    user_rowid INT NOT NULL,
    notification_type_rowid INT NOT NULL,
    title NVARCHAR(200),
    message NVARCHAR(MAX),
    is_read BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO UserNotifications (dex_row_id, user_rowid, notification_type_rowid, title, message) VALUES
('DEX109', 3, 1, N'Order Confirmed', 'Your order #ORD001 has been confirmed.'),
('DEX110', 3, 2, N'Order Shipped', 'Your order #ORD002 is on the way!'),
('DEX111', 2, 3, N'Promo Alert', 'Flash sale starts tomorrow!');
GO

ALTER TABLE UserNotifications ADD CONSTRAINT FK_UserNotif_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
ALTER TABLE UserNotifications ADD CONSTRAINT FK_UserNotif_Type FOREIGN KEY (notification_type_rowid) REFERENCES NotificationTypes(ROWID);
GO

-- TBL038 - Suppliers (FK: SupplierStatus, Country)
CREATE TABLE Suppliers (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    supplier_code VARCHAR(20) UNIQUE NOT NULL,
    supplier_name NVARCHAR(100) NOT NULL,
    status_rowid INT NOT NULL,
    country_rowid INT NOT NULL,
    contact_person NVARCHAR(100),
    phone_number VARCHAR(20),
    email VARCHAR(100),
    payment_terms_days INT DEFAULT 30
);
GO

INSERT INTO Suppliers (dex_row_id, supplier_code, supplier_name, status_rowid, country_rowid, contact_person, phone_number) VALUES
('DEX112', 'SUP001', N'PT Elektronik Jaya', 1, 1, N'Andi Susilo', '021-5550101'),
('DEX113', 'SUP002', N'CV Fashion Indah', 1, 1, N'Sari Dewi', '021-5550102'),
('DEX114', 'SUP003', N'PT Home Living', 2, 2, 'John Smith', '+1-555-0103');
GO

ALTER TABLE Suppliers ADD CONSTRAINT FK_Suppliers_Status FOREIGN KEY (status_rowid) REFERENCES SupplierStatuses(ROWID);
ALTER TABLE Suppliers ADD CONSTRAINT FK_Suppliers_Country FOREIGN KEY (country_rowid) REFERENCES Countries(ROWID);
GO

-- TBL039 - Warehouses (FK: Country)
CREATE TABLE Warehouses (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    warehouse_code VARCHAR(20) UNIQUE NOT NULL,
    warehouse_name NVARCHAR(100) NOT NULL,
    country_rowid INT NOT NULL,
    city NVARCHAR(50),
    address NVARCHAR(200),
    capacity_cubic_meters DECIMAL(10,2),
    is_active BIT DEFAULT 1
);
GO

INSERT INTO Warehouses (dex_row_id, warehouse_code, warehouse_name, country_rowid, city, capacity_cubic_meters) VALUES
('DEX115', 'WH_JKT', N'Jakarta Main Warehouse', 1, N'Jakarta', 5000),
('DEX116', 'WH_BDG', N'Bandung Fulfillment Center', 1, N'Bandung', 3000),
('DEX117', 'WH_SGP', 'Singapore Hub', 3, 'Singapore', 2000);
GO

ALTER TABLE Warehouses ADD CONSTRAINT FK_Warehouses_Country FOREIGN KEY (country_rowid) REFERENCES Countries(ROWID);
GO

-- TBL040 - WarehouseZones (FK: Warehouse)
CREATE TABLE WarehouseZones (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    zone_code VARCHAR(20) UNIQUE NOT NULL,
    zone_name NVARCHAR(50) NOT NULL,
    warehouse_rowid INT NOT NULL,
    zone_type VARCHAR(20) CHECK (zone_type IN ('STORAGE', 'PICKING', 'SHIPPING', 'RETURN'))
);
GO

INSERT INTO WarehouseZones (dex_row_id, zone_code, zone_name, warehouse_rowid, zone_type) VALUES
('DEX118', 'ZN_JKT_A', 'Storage A', 1, 'STORAGE'),
('DEX119', 'ZN_JKT_B', 'Picking Zone', 1, 'PICKING'),
('DEX120', 'ZN_BDG_A', 'Storage A', 2, 'STORAGE');
GO

ALTER TABLE WarehouseZones ADD CONSTRAINT FK_WarehouseZones_Warehouse FOREIGN KEY (warehouse_rowid) REFERENCES Warehouses(ROWID);
GO

-- TBL041 - Subcategories (FK: ProductCategories)
CREATE TABLE Subcategories (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    subcategory_code VARCHAR(20) UNIQUE NOT NULL,
    subcategory_name NVARCHAR(100) NOT NULL,
    category_rowid INT NOT NULL
);
GO

INSERT INTO Subcategories (dex_row_id, subcategory_code, subcategory_name, category_rowid) VALUES
('DEX121', 'PHONE', N'Smartphones', 1),
('DEX122', 'LAPTOP', N'Laptops', 1),
('DEX123', 'MEN_CLOTHING', N'Men''s Clothing', 2);
GO

ALTER TABLE Subcategories ADD CONSTRAINT FK_Subcategories_Category FOREIGN KEY (category_rowid) REFERENCES ProductCategories(ROWID);
GO

-- TBL042 - CMSBlogCategories
CREATE TABLE CMSBlogCategories (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    category_code VARCHAR(20) UNIQUE NOT NULL,
    category_name NVARCHAR(50) NOT NULL
);
GO

INSERT INTO CMSBlogCategories (dex_row_id, category_code, category_name) VALUES
('DEX124', 'TIPS', 'Shopping Tips'),
('DEX125', 'REVIEW', 'Product Reviews'),
('DEX126', 'NEWS', 'Company News');
GO

-- TBL043 - CMSPages
CREATE TABLE CMSPages (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    page_code VARCHAR(20) UNIQUE NOT NULL,
    title NVARCHAR(200) NOT NULL,
    slug VARCHAR(200) UNIQUE NOT NULL,
    content NVARCHAR(MAX),
    is_published BIT DEFAULT 1,
    published_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO CMSPages (dex_row_id, page_code, title, slug, content) VALUES
('DEX127', 'ABOUT', 'About Us', 'about-us', N'We are the best online store.'),
('DEX128', 'TNC', 'Terms & Conditions', 'terms-and-conditions', N'Please read these terms carefully.'),
('DEX129', 'PRIVACY', 'Privacy Policy', 'privacy-policy', N'We protect your data.');
GO

-- TBL044 - Products (FK: Brand, Subcategory)
CREATE TABLE Products (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    product_code VARCHAR(20) UNIQUE NOT NULL,
    product_name NVARCHAR(200) NOT NULL,
    brand_rowid INT NOT NULL,
    subcategory_rowid INT NOT NULL,
    description NVARCHAR(MAX),
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO Products (dex_row_id, product_code, product_name, brand_rowid, subcategory_rowid, description) VALUES
('DEX130', 'PRD001', 'Samsung Galaxy S25', 1, 1, N'Flagship smartphone with AI features'),
('DEX131', 'PRD002', 'Nike Air Max 270', 2, 3, N'Comfortable running shoes'),
('DEX132', 'PRD003', 'IKEA KALLAX Shelf', 3, 3, N'Versatile shelving unit');
GO

ALTER TABLE Products ADD CONSTRAINT FK_Products_Brand FOREIGN KEY (brand_rowid) REFERENCES Brands(ROWID);
ALTER TABLE Products ADD CONSTRAINT FK_Products_Subcategory FOREIGN KEY (subcategory_rowid) REFERENCES Subcategories(ROWID);
GO

-- TBL045 - ProductSKUs (FK: Product)
CREATE TABLE ProductSKUs (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    sku_code VARCHAR(50) UNIQUE NOT NULL,
    product_rowid INT NOT NULL,
    price DECIMAL(12,2) NOT NULL,
    cost_price DECIMAL(12,2),
    stock INT DEFAULT 0,
    weight_grams DECIMAL(10,2),
    is_active BIT DEFAULT 1
);
GO

INSERT INTO ProductSKUs (dex_row_id, sku_code, product_rowid, price, cost_price, stock, weight_grams) VALUES
('DEX133', 'S25-BLK-256', 1, 15000000, 12000000, 50, 200),
('DEX134', 'AM270-BLK-42', 2, 2500000, 1800000, 100, 350),
('DEX135', 'KALLAX-WHT', 3, 1200000, 800000, 30, 15000);
GO

ALTER TABLE ProductSKUs ADD CONSTRAINT FK_SKU_Product FOREIGN KEY (product_rowid) REFERENCES Products(ROWID);
GO

-- TBL046 - ProductImages (FK: Product)
CREATE TABLE ProductImages (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    product_rowid INT NOT NULL,
    image_url VARCHAR(500) NOT NULL,
    alt_text NVARCHAR(200),
    sort_order INT DEFAULT 0,
    is_primary BIT DEFAULT 0
);
GO

INSERT INTO ProductImages (dex_row_id, product_rowid, image_url, alt_text, is_primary) VALUES
('DEX136', 1, 'https://img.shop.com/s25-black-1.jpg', 'Samsung Galaxy S25 Black', 1),
('DEX137', 2, 'https://img.shop.com/am270-black.jpg', 'Nike Air Max 270 Black', 1),
('DEX138', 3, 'https://img.shop.com/kallax-white.jpg', 'IKEA KALLAX White', 1);
GO

ALTER TABLE ProductImages ADD CONSTRAINT FK_ProdImg_Product FOREIGN KEY (product_rowid) REFERENCES Products(ROWID);
GO

-- TBL047 - ProductAttributeValues (FK: Product, Attribute)
CREATE TABLE ProductAttributeValues (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    product_rowid INT NOT NULL,
    attribute_rowid INT NOT NULL,
    value NVARCHAR(100) NOT NULL
);
GO

INSERT INTO ProductAttributeValues (dex_row_id, product_rowid, attribute_rowid, value) VALUES
('DEX139', 1, 1, 'Black'),
('DEX140', 1, 3, '256GB'),
('DEX141', 2, 2, '42');
GO

ALTER TABLE ProductAttributeValues ADD CONSTRAINT FK_AttrVal_Product FOREIGN KEY (product_rowid) REFERENCES Products(ROWID);
ALTER TABLE ProductAttributeValues ADD CONSTRAINT FK_AttrVal_Attribute FOREIGN KEY (attribute_rowid) REFERENCES ProductAttributes(ROWID);
GO

-- TBL048 - ProductPricing (FK: ProductSKU, Currency)
CREATE TABLE ProductPricing (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    sku_rowid INT NOT NULL,
    currency_rowid INT NOT NULL,
    price DECIMAL(12,2) NOT NULL,
    effective_from DATETIME DEFAULT GETDATE(),
    effective_to DATETIME
);
GO

INSERT INTO ProductPricing (dex_row_id, sku_rowid, currency_rowid, price) VALUES
('DEX142', 1, 1, 15000000),
('DEX143', 1, 2, 937.50),
('DEX144', 2, 1, 2500000);
GO

ALTER TABLE ProductPricing ADD CONSTRAINT FK_ProdPrice_SKU FOREIGN KEY (sku_rowid) REFERENCES ProductSKUs(ROWID);
ALTER TABLE ProductPricing ADD CONSTRAINT FK_ProdPrice_Currency FOREIGN KEY (currency_rowid) REFERENCES Currencies(ROWID);
GO

-- TBL049 - ProductDiscounts (FK: Product, DiscountType)
CREATE TABLE ProductDiscounts (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    product_rowid INT NOT NULL,
    discount_type_rowid INT NOT NULL,
    value DECIMAL(12,2) NOT NULL,
    valid_from DATETIME,
    valid_to DATETIME
);
GO

INSERT INTO ProductDiscounts (dex_row_id, product_rowid, discount_type_rowid, value) VALUES
('DEX145', 1, 1, 10.00),
('DEX146', 2, 2, 200000),
('DEX147', 3, 1, 5.00);
GO

ALTER TABLE ProductDiscounts ADD CONSTRAINT FK_ProdDisc_Product FOREIGN KEY (product_rowid) REFERENCES Products(ROWID);
ALTER TABLE ProductDiscounts ADD CONSTRAINT FK_ProdDisc_DiscountType FOREIGN KEY (discount_type_rowid) REFERENCES DiscountTypes(ROWID);
GO

-- TBL050 - RelatedProducts (FK: Product, Related Product)
CREATE TABLE RelatedProducts (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    product_rowid INT NOT NULL,
    related_product_rowid INT NOT NULL,
    relation_type VARCHAR(20) CHECK (relation_type IN ('UPSELL', 'CROSS_SELL', 'ACCESSORY'))
);
GO

INSERT INTO RelatedProducts (dex_row_id, product_rowid, related_product_rowid, relation_type) VALUES
('DEX148', 1, 2, 'CROSS_SELL'),
('DEX149', 1, 3, 'ACCESSORY'),
('DEX150', 2, 1, 'UPSELL');
GO

ALTER TABLE RelatedProducts ADD CONSTRAINT FK_RelProd_Product FOREIGN KEY (product_rowid) REFERENCES Products(ROWID);
ALTER TABLE RelatedProducts ADD CONSTRAINT FK_RelProd_Related FOREIGN KEY (related_product_rowid) REFERENCES Products(ROWID);
GO

-- TBL051 - ProductTagsMap (FK: Product, ProductTag)
CREATE TABLE ProductTagsMap (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    product_rowid INT NOT NULL,
    tag_rowid INT NOT NULL
);
GO

INSERT INTO ProductTagsMap (dex_row_id, product_rowid, tag_rowid) VALUES
('DEX151', 1, 2),
('DEX152', 2, 1),
('DEX153', 3, 2);
GO

ALTER TABLE ProductTagsMap ADD CONSTRAINT FK_ProdTag_Product FOREIGN KEY (product_rowid) REFERENCES Products(ROWID);
ALTER TABLE ProductTagsMap ADD CONSTRAINT FK_ProdTag_Tag FOREIGN KEY (tag_rowid) REFERENCES ProductTags(ROWID);
GO

-- TBL052 - ProductVariants (FK: Product)
CREATE TABLE ProductVariants (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    product_rowid INT NOT NULL,
    variant_name NVARCHAR(100) NOT NULL,
    price_adjustment DECIMAL(12,2) DEFAULT 0,
    stock INT DEFAULT 0
);
GO

INSERT INTO ProductVariants (dex_row_id, product_rowid, variant_name, price_adjustment) VALUES
('DEX154', 1, '256GB', 0),
('DEX155', 1, '512GB', 2000000),
('DEX156', 2, 'Size 42', 0);
GO

ALTER TABLE ProductVariants ADD CONSTRAINT FK_ProdVar_Product FOREIGN KEY (product_rowid) REFERENCES Products(ROWID);
GO

-- TBL053 - GiftCards (FK: Product)
CREATE TABLE GiftCards (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    card_code VARCHAR(50) UNIQUE NOT NULL,
    product_rowid INT,
    initial_balance DECIMAL(12,2) NOT NULL,
    current_balance DECIMAL(12,2) NOT NULL,
    expires_at DATE,
    is_active BIT DEFAULT 1
);
GO

INSERT INTO GiftCards (dex_row_id, card_code, product_rowid, initial_balance, current_balance) VALUES
('DEX157', 'GIFT-001', 1, 500000, 500000),
('DEX158', 'GIFT-002', 2, 250000, 150000),
('DEX159', 'GIFT-003', 3, 1000000, 1000000);
GO

ALTER TABLE GiftCards ADD CONSTRAINT FK_GiftCard_Product FOREIGN KEY (product_rowid) REFERENCES Products(ROWID);
GO

-- TBL054 - Subscriptions (FK: User, SubscriptionPlanType)
CREATE TABLE Subscriptions (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    subscription_code VARCHAR(20) UNIQUE NOT NULL,
    user_rowid INT NOT NULL,
    plan_type_rowid INT NOT NULL,
    start_date DATETIME DEFAULT GETDATE(),
    end_date DATETIME,
    is_active BIT DEFAULT 1
);
GO

INSERT INTO Subscriptions (dex_row_id, subscription_code, user_rowid, plan_type_rowid) VALUES
('DEX160', 'SUB001', 3, 2),
('DEX161', 'SUB002', 1, 3),
('DEX162', 'SUB003', 2, 1);
GO

ALTER TABLE Subscriptions ADD CONSTRAINT FK_Subs_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
ALTER TABLE Subscriptions ADD CONSTRAINT FK_Subs_PlanType FOREIGN KEY (plan_type_rowid) REFERENCES SubscriptionPlanTypes(ROWID);
GO

-- TBL055 - Coupons (FK: CouponType, DiscountType)
CREATE TABLE Coupons (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    coupon_code VARCHAR(50) UNIQUE NOT NULL,
    coupon_type_rowid INT NOT NULL,
    discount_type_rowid INT NOT NULL,
    value DECIMAL(12,2) NOT NULL,
    min_order DECIMAL(12,2) DEFAULT 0,
    max_usage INT DEFAULT 1,
    valid_from DATETIME,
    valid_to DATETIME,
    is_active BIT DEFAULT 1
);
GO

INSERT INTO Coupons (dex_row_id, coupon_code, coupon_type_rowid, discount_type_rowid, value, min_order) VALUES
('DEX163', 'WELCOME10', 3, 1, 10.00, 100000),
('DEX164', 'FLASH50', 1, 2, 50000, 200000),
('DEX165', 'VIP30', 2, 1, 30.00, 500000);
GO

ALTER TABLE Coupons ADD CONSTRAINT FK_Coupons_Type FOREIGN KEY (coupon_type_rowid) REFERENCES CouponTypes(ROWID);
ALTER TABLE Coupons ADD CONSTRAINT FK_Coupons_DiscountType FOREIGN KEY (discount_type_rowid) REFERENCES DiscountTypes(ROWID);
GO

-- TBL056 - Promotions (FK: DiscountType)
CREATE TABLE Promotions (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    promo_code VARCHAR(20) UNIQUE NOT NULL,
    promo_name NVARCHAR(100) NOT NULL,
    discount_type_rowid INT NOT NULL,
    value DECIMAL(12,2) NOT NULL,
    valid_from DATETIME,
    valid_to DATETIME
);
GO

INSERT INTO Promotions (dex_row_id, promo_code, promo_name, discount_type_rowid, value) VALUES
('DEX166', 'HARBOLNAS', N'Harbolnas Sale', 1, 20.00),
('DEX167', '12-12', N'12.12 Flash Sale', 2, 100000),
('DEX168', 'FREESHIP', N'Free Shipping', 3, 0);
GO

ALTER TABLE Promotions ADD CONSTRAINT FK_Promos_DiscountType FOREIGN KEY (discount_type_rowid) REFERENCES DiscountTypes(ROWID);
GO

-- TBL057 - Campaigns (FK: CampaignType)
CREATE TABLE Campaigns (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    campaign_code VARCHAR(20) UNIQUE NOT NULL,
    campaign_name NVARCHAR(100) NOT NULL,
    campaign_type_rowid INT NOT NULL,
    budget DECIMAL(12,2),
    start_date DATETIME,
    end_date DATETIME
);
GO

INSERT INTO Campaigns (dex_row_id, campaign_code, campaign_name, campaign_type_rowid, budget) VALUES
('DEX169', 'RAMADHAN25', N'Ramadhan Sale 2025', 1, 50000000),
('DEX170', 'FLASH_JUN', N'June Flash Sale', 2, 25000000),
('DEX171', 'LOYAL_Q2', N'Q2 Loyalty Rewards', 3, 30000000);
GO

ALTER TABLE Campaigns ADD CONSTRAINT FK_Campaigns_Type FOREIGN KEY (campaign_type_rowid) REFERENCES CampaignTypes(ROWID);
GO

-- TBL058 - EmailTemplates (FK: EmailTemplateType)
CREATE TABLE EmailTemplates (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    template_code VARCHAR(50) UNIQUE NOT NULL,
    template_type_rowid INT NOT NULL,
    subject NVARCHAR(200) NOT NULL,
    body_html NVARCHAR(MAX),
    body_text NVARCHAR(MAX)
);
GO

INSERT INTO EmailTemplates (dex_row_id, template_code, template_type_rowid, subject) VALUES
('DEX172', 'WELCOME_01', 1, 'Welcome to Shop!'),
('DEX173', 'ORDER_CONFIRM_01', 2, 'Your Order #{{order_no}} is Confirmed'),
('DEX174', 'RESET_01', 3, 'Password Reset Instructions');
GO

ALTER TABLE EmailTemplates ADD CONSTRAINT FK_EmailTpl_Type FOREIGN KEY (template_type_rowid) REFERENCES EmailTemplateTypes(ROWID);
GO

-- TBL059 - ShippingZones (FK: ShippingZoneType, Country)
CREATE TABLE ShippingZones (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    zone_type_rowid INT NOT NULL,
    country_rowid INT NOT NULL,
    rate_multiplier DECIMAL(5,2) DEFAULT 1.00
);
GO

INSERT INTO ShippingZones (dex_row_id, zone_type_rowid, country_rowid, rate_multiplier) VALUES
('DEX175', 1, 1, 1.00),
('DEX176', 2, 1, 1.50),
('DEX177', 3, 2, 5.00);
GO

ALTER TABLE ShippingZones ADD CONSTRAINT FK_ShippingZones_Type FOREIGN KEY (zone_type_rowid) REFERENCES ShippingZoneTypes(ROWID);
ALTER TABLE ShippingZones ADD CONSTRAINT FK_ShippingZones_Country FOREIGN KEY (country_rowid) REFERENCES Countries(ROWID);
GO

-- TBL060 - SupportTickets (FK: User, TicketCategory, Priority)
CREATE TABLE SupportTickets (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    ticket_code VARCHAR(20) UNIQUE NOT NULL,
    user_rowid INT NOT NULL,
    category_rowid INT NOT NULL,
    priority_rowid INT NOT NULL,
    subject NVARCHAR(200) NOT NULL,
    description NVARCHAR(MAX),
    status VARCHAR(20) DEFAULT 'OPEN',
    created_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO SupportTickets (dex_row_id, ticket_code, user_rowid, category_rowid, priority_rowid, subject) VALUES
('DEX178', 'TCK001', 3, 1, 2, N'Order not received'),
('DEX179', 'TCK002', 3, 2, 1, N'Payment deducted but order pending'),
('DEX180', 'TCK003', 2, 3, 1, N'Product information update');
GO

ALTER TABLE SupportTickets ADD CONSTRAINT FK_Tickets_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
ALTER TABLE SupportTickets ADD CONSTRAINT FK_Tickets_Category FOREIGN KEY (category_rowid) REFERENCES TicketCategories(ROWID);
ALTER TABLE SupportTickets ADD CONSTRAINT FK_Tickets_Priority FOREIGN KEY (priority_rowid) REFERENCES SupportTicketPriorities(ROWID);
GO

-- TBL061 - MediaFiles (FK: MediaType, User)
CREATE TABLE MediaFiles (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    file_code VARCHAR(20) UNIQUE NOT NULL,
    media_type_rowid INT NOT NULL,
    uploaded_by_rowid INT NOT NULL,
    file_name VARCHAR(200) NOT NULL,
    file_path VARCHAR(500) NOT NULL,
    file_size_bytes BIGINT,
    uploaded_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO MediaFiles (dex_row_id, file_code, media_type_rowid, uploaded_by_rowid, file_name, file_path, file_size_bytes) VALUES
('DEX181', 'FILE001', 1, 1, 'logo.png', '/uploads/logo.png', 50000),
('DEX182', 'FILE002', 1, 2, 'product-1.jpg', '/uploads/products/product-1.jpg', 250000),
('DEX183', 'FILE003', 2, 2, 'promo-video.mp4', '/uploads/videos/promo-video.mp4', 5000000);
GO

ALTER TABLE MediaFiles ADD CONSTRAINT FK_MediaFiles_Type FOREIGN KEY (media_type_rowid) REFERENCES MediaTypes(ROWID);
ALTER TABLE MediaFiles ADD CONSTRAINT FK_MediaFiles_User FOREIGN KEY (uploaded_by_rowid) REFERENCES Users(ROWID);
GO

-- TBL062 - SiteSettings
CREATE TABLE SiteSettings (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    setting_key VARCHAR(100) UNIQUE NOT NULL,
    setting_value NVARCHAR(MAX) NOT NULL,
    description NVARCHAR(200)
);
GO

INSERT INTO SiteSettings (dex_row_id, setting_key, setting_value, description) VALUES
('DEX184', 'SITE_NAME', 'Shop Online', N'Nama website'),
('DEX185', 'CURRENCY_DEFAULT', 'IDR', 'Default currency'),
('DEX186', 'TAX_PERCENT', '11', 'PPN percentage');
GO

-- TBL063 - SEORedirects
CREATE TABLE SEORedirects (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    redirect_code VARCHAR(20) UNIQUE NOT NULL,
    url_from VARCHAR(500) NOT NULL,
    url_to VARCHAR(500) NOT NULL,
    http_status INT DEFAULT 301,
    is_active BIT DEFAULT 1
);
GO

INSERT INTO SEORedirects (dex_row_id, redirect_code, url_from, url_to) VALUES
('DEX187', 'RDR001', '/old-products', '/products'),
('DEX188', 'RDR002', '/promo-2024', '/promo-2025'),
('DEX189', 'RDR003', '/shop', '/store');
GO

-- TBL064 - FAQItems (FK: FAQCategory)
CREATE TABLE FAQItems (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    category_rowid INT NOT NULL,
    question NVARCHAR(500) NOT NULL,
    answer NVARCHAR(MAX) NOT NULL,
    sort_order INT DEFAULT 0
);
GO

INSERT INTO FAQItems (dex_row_id, category_rowid, question, answer, sort_order) VALUES
('DEX190', 1, 'How long does shipping take?', '2-5 business days for domestic.', 1),
('DEX191', 2, 'Can I return an item?', 'Yes, within 14 days of delivery.', 1),
('DEX192', 3, 'What payment methods do you accept?', 'BCA VA, GoPay, COD, and more.', 1);
GO

ALTER TABLE FAQItems ADD CONSTRAINT FK_FAQ_Category FOREIGN KEY (category_rowid) REFERENCES FAQCategories(ROWID);
GO

-- TBL065 - PricingTiers
CREATE TABLE PricingTiers (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    tier_code VARCHAR(20) UNIQUE NOT NULL,
    tier_name NVARCHAR(50) NOT NULL,
    min_spend DECIMAL(12,2),
    discount_percent DECIMAL(5,2) DEFAULT 0
);
GO

INSERT INTO PricingTiers (dex_row_id, tier_code, tier_name, min_spend, discount_percent) VALUES
('DEX193', 'SILVER', 'Silver', 0, 0),
('DEX194', 'GOLD', 'Gold', 5000000, 5),
('DEX195', 'PLATINUM', 'Platinum', 20000000, 10);
GO
-- ============================================================
-- TIER 2: Depends on Tier 0-1
-- ============================================================

-- TBL066 - ShoppingSessions (FK: User)
CREATE TABLE ShoppingSessions (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    session_id VARCHAR(100) UNIQUE NOT NULL,
    user_rowid INT,
    started_at DATETIME DEFAULT GETDATE(),
    ended_at DATETIME,
    is_active BIT DEFAULT 1
);
GO

INSERT INTO ShoppingSessions (dex_row_id, session_id, user_rowid) VALUES
('DEX196', 'SESS-001', 3),
('DEX197', 'SESS-002', 3),
('DEX198', 'SESS-003', 1);
GO

ALTER TABLE ShoppingSessions ADD CONSTRAINT FK_Sessions_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
GO

-- TBL067 - CartItems (FK: ShoppingSession, ProductSKU)
CREATE TABLE CartItems (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    session_rowid INT NOT NULL,
    sku_rowid INT NOT NULL,
    quantity INT NOT NULL,
    added_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO CartItems (dex_row_id, session_rowid, sku_rowid, quantity) VALUES
('DEX199', 1, 1, 1),
('DEX200', 1, 2, 2),
('DEX201', 2, 3, 1);
GO

ALTER TABLE CartItems ADD CONSTRAINT FK_CartItems_Session FOREIGN KEY (session_rowid) REFERENCES ShoppingSessions(ROWID);
ALTER TABLE CartItems ADD CONSTRAINT FK_CartItems_SKU FOREIGN KEY (sku_rowid) REFERENCES ProductSKUs(ROWID);
GO

-- TBL068 - SavedForLater (FK: User, ProductSKU)
CREATE TABLE SavedForLater (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    user_rowid INT NOT NULL,
    sku_rowid INT NOT NULL,
    saved_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO SavedForLater (dex_row_id, user_rowid, sku_rowid) VALUES
('DEX202', 3, 3),
('DEX203', 3, 1),
('DEX204', 2, 2);
GO

ALTER TABLE SavedForLater ADD CONSTRAINT FK_Saved_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
ALTER TABLE SavedForLater ADD CONSTRAINT FK_Saved_SKU FOREIGN KEY (sku_rowid) REFERENCES ProductSKUs(ROWID);
GO

-- TBL069 - Wishlists (FK: User)
CREATE TABLE Wishlists (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    wishlist_code VARCHAR(20) UNIQUE NOT NULL,
    user_rowid INT NOT NULL,
    name NVARCHAR(100) DEFAULT 'My Wishlist',
    is_public BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO Wishlists (dex_row_id, wishlist_code, user_rowid, name) VALUES
('DEX205', 'WISH001', 3, N'Birthday Wishes'),
('DEX206', 'WISH002', 3, N'Gadget Dreams'),
('DEX207', 'WISH003', 1, N'Home Decor Ideas');
GO

ALTER TABLE Wishlists ADD CONSTRAINT FK_Wishlists_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
GO

-- TBL070 - WishlistItems (FK: Wishlist, Product)
CREATE TABLE WishlistItems (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    wishlist_rowid INT NOT NULL,
    product_rowid INT NOT NULL,
    added_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO WishlistItems (dex_row_id, wishlist_rowid, product_rowid) VALUES
('DEX208', 1, 1),
('DEX209', 1, 2),
('DEX210', 3, 3);
GO

ALTER TABLE WishlistItems ADD CONSTRAINT FK_WishlistItems_Wishlist FOREIGN KEY (wishlist_rowid) REFERENCES Wishlists(ROWID);
ALTER TABLE WishlistItems ADD CONSTRAINT FK_WishlistItems_Product FOREIGN KEY (product_rowid) REFERENCES Products(ROWID);
GO

-- TBL071 - CompareProducts (FK: User, Product)
CREATE TABLE CompareProducts (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    user_rowid INT NOT NULL,
    product_rowid INT NOT NULL,
    added_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO CompareProducts (dex_row_id, user_rowid, product_rowid) VALUES
('DEX211', 3, 1),
('DEX212', 3, 2),
('DEX213', 1, 3);
GO

ALTER TABLE CompareProducts ADD CONSTRAINT FK_Compare_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
ALTER TABLE CompareProducts ADD CONSTRAINT FK_Compare_Product FOREIGN KEY (product_rowid) REFERENCES Products(ROWID);
GO

-- TBL072 - ProductViews (FK: User, Product)
CREATE TABLE ProductViews (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    user_rowid INT,
    product_rowid INT NOT NULL,
    viewed_at DATETIME DEFAULT GETDATE(),
    session_id VARCHAR(100)
);
GO

INSERT INTO ProductViews (dex_row_id, user_rowid, product_rowid) VALUES
('DEX214', 3, 1),
('DEX215', 3, 2),
('DEX216', 1, 3);
GO

ALTER TABLE ProductViews ADD CONSTRAINT FK_ProdView_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
ALTER TABLE ProductViews ADD CONSTRAINT FK_ProdView_Product FOREIGN KEY (product_rowid) REFERENCES Products(ROWID);
GO

-- TBL073 - AbandonedCarts (FK: ShoppingSession)
CREATE TABLE AbandonedCarts (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    session_rowid INT NOT NULL,
    cart_total DECIMAL(12,2),
    items_count INT,
    abandoned_at DATETIME DEFAULT GETDATE(),
    reminder_sent BIT DEFAULT 0
);
GO

INSERT INTO AbandonedCarts (dex_row_id, session_rowid, cart_total, items_count) VALUES
('DEX217', 2, 1200000, 1),
('DEX218', 1, 20000000, 3),
('DEX219', 3, 2500000, 2);
GO

ALTER TABLE AbandonedCarts ADD CONSTRAINT FK_Abandoned_Session FOREIGN KEY (session_rowid) REFERENCES ShoppingSessions(ROWID);
GO

-- TBL074 - Orders (FK: User, Address, OrderStatus, ShippingMethod, Coupon)
CREATE TABLE Orders (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    order_number VARCHAR(50) UNIQUE NOT NULL,
    user_rowid INT NOT NULL,
    address_rowid INT NOT NULL,
    status_rowid INT NOT NULL,
    shipping_method_rowid INT NOT NULL,
    coupon_rowid INT,
    subtotal DECIMAL(12,2) NOT NULL,
    shipping_cost DECIMAL(12,2) DEFAULT 0,
    tax_amount DECIMAL(12,2) DEFAULT 0,
    discount_amount DECIMAL(12,2) DEFAULT 0,
    grand_total DECIMAL(12,2) NOT NULL,
    notes NVARCHAR(500),
    ordered_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO Orders (dex_row_id, order_number, user_rowid, address_rowid, status_rowid, shipping_method_rowid, subtotal, shipping_cost, tax_amount, grand_total) VALUES
('DEX220', 'ORD001', 3, 2, 2, 1, 17500000, 15000, 1925000, 19415000),
('DEX221', 'ORD002', 3, 2, 1, 1, 2500000, 15000, 275000, 2775000),
('DEX222', 'ORD003', 1, 1, 3, 2, 1200000, 30000, 132000, 1233000);
GO

ALTER TABLE Orders ADD CONSTRAINT FK_Orders_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Address FOREIGN KEY (address_rowid) REFERENCES UserAddresses(ROWID);
ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Status FOREIGN KEY (status_rowid) REFERENCES OrderStatuses(ROWID);
ALTER TABLE Orders ADD CONSTRAINT FK_Orders_ShippingMethod FOREIGN KEY (shipping_method_rowid) REFERENCES ShippingMethods(ROWID);
ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Coupon FOREIGN KEY (coupon_rowid) REFERENCES Coupons(ROWID);
GO

-- TBL075 - OrderItems (FK: Order, ProductSKU)
CREATE TABLE OrderItems (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    order_rowid INT NOT NULL,
    sku_rowid INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(12,2) NOT NULL,
    total_price DECIMAL(12,2) NOT NULL
);
GO

INSERT INTO OrderItems (dex_row_id, order_rowid, sku_rowid, quantity, unit_price, total_price) VALUES
('DEX223', 1, 1, 1, 15000000, 15000000),
('DEX224', 1, 2, 1, 2500000, 2500000),
('DEX225', 2, 2, 1, 2500000, 2500000);
GO

ALTER TABLE OrderItems ADD CONSTRAINT FK_OrderItems_Order FOREIGN KEY (order_rowid) REFERENCES Orders(ROWID);
ALTER TABLE OrderItems ADD CONSTRAINT FK_OrderItems_SKU FOREIGN KEY (sku_rowid) REFERENCES ProductSKUs(ROWID);
GO

-- TBL076 - OrderStatusHistory (FK: Order, OrderStatus, User)
CREATE TABLE OrderStatusHistory (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    order_rowid INT NOT NULL,
    status_rowid INT NOT NULL,
    changed_by_rowid INT,
    changed_at DATETIME DEFAULT GETDATE(),
    notes NVARCHAR(500)
);
GO

INSERT INTO OrderStatusHistory (dex_row_id, order_rowid, status_rowid, changed_by_rowid) VALUES
('DEX226', 1, 1, 3),
('DEX227', 1, 2, 2),
('DEX228', 2, 1, 3);
GO

ALTER TABLE OrderStatusHistory ADD CONSTRAINT FK_StatusHist_Order FOREIGN KEY (order_rowid) REFERENCES Orders(ROWID);
ALTER TABLE OrderStatusHistory ADD CONSTRAINT FK_StatusHist_Status FOREIGN KEY (status_rowid) REFERENCES OrderStatuses(ROWID);
ALTER TABLE OrderStatusHistory ADD CONSTRAINT FK_StatusHist_User FOREIGN KEY (changed_by_rowid) REFERENCES Users(ROWID);
GO

-- TBL077 - OrderCancellations (FK: Order, User)
CREATE TABLE OrderCancellations (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    order_rowid INT NOT NULL,
    cancelled_by_rowid INT NOT NULL,
    reason NVARCHAR(MAX),
    cancelled_at DATETIME DEFAULT GETDATE(),
    refunded BIT DEFAULT 0
);
GO

INSERT INTO OrderCancellations (dex_row_id, order_rowid, cancelled_by_rowid, reason) VALUES
('DEX229', 2, 3, N'Changed my mind'),
('DEX230', 3, 1, N'Out of stock'),
('DEX231', 1, 2, N'Payment issue');
GO

ALTER TABLE OrderCancellations ADD CONSTRAINT FK_Cancel_Order FOREIGN KEY (order_rowid) REFERENCES Orders(ROWID);
ALTER TABLE OrderCancellations ADD CONSTRAINT FK_Cancel_User FOREIGN KEY (cancelled_by_rowid) REFERENCES Users(ROWID);
GO

-- TBL078 - Shipments (FK: Order, Address, ShippingMethod)
CREATE TABLE Shipments (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    shipment_code VARCHAR(50) UNIQUE NOT NULL,
    order_rowid INT NOT NULL,
    address_rowid INT NOT NULL,
    shipping_method_rowid INT NOT NULL,
    tracking_number VARCHAR(100),
    shipped_at DATETIME,
    estimated_arrival DATE,
    status VARCHAR(20) DEFAULT 'PENDING'
);
GO

INSERT INTO Shipments (dex_row_id, shipment_code, order_rowid, address_rowid, shipping_method_rowid, tracking_number, status) VALUES
('DEX232', 'SHIP001', 1, 2, 1, 'JNE-1234567890', 'SHIPPED'),
('DEX233', 'SHIP002', 2, 2, 1, 'JNE-1234567891', 'PENDING'),
('DEX234', 'SHIP003', 3, 1, 2, 'JNE-1234567892', 'DELIVERED');
GO

ALTER TABLE Shipments ADD CONSTRAINT FK_Shipments_Order FOREIGN KEY (order_rowid) REFERENCES Orders(ROWID);
ALTER TABLE Shipments ADD CONSTRAINT FK_Shipments_Address FOREIGN KEY (address_rowid) REFERENCES UserAddresses(ROWID);
ALTER TABLE Shipments ADD CONSTRAINT FK_Shipments_ShippingMethod FOREIGN KEY (shipping_method_rowid) REFERENCES ShippingMethods(ROWID);
GO

-- TBL079 - ShipmentItems (FK: Shipment, OrderItem)
CREATE TABLE ShipmentItems (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    shipment_rowid INT NOT NULL,
    order_item_rowid INT NOT NULL,
    quantity INT NOT NULL
);
GO

INSERT INTO ShipmentItems (dex_row_id, shipment_rowid, order_item_rowid, quantity) VALUES
('DEX235', 1, 1, 1),
('DEX236', 1, 2, 1),
('DEX237', 2, 3, 1);
GO

ALTER TABLE ShipmentItems ADD CONSTRAINT FK_ShipItems_Shipment FOREIGN KEY (shipment_rowid) REFERENCES Shipments(ROWID);
ALTER TABLE ShipmentItems ADD CONSTRAINT FK_ShipItems_OrderItem FOREIGN KEY (order_item_rowid) REFERENCES OrderItems(ROWID);
GO

-- TBL080 - DeliveryTracking (FK: Shipment)
CREATE TABLE DeliveryTracking (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    shipment_rowid INT NOT NULL,
    location NVARCHAR(200),
    status_description NVARCHAR(200),
    tracking_time DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO DeliveryTracking (dex_row_id, shipment_rowid, location, status_description) VALUES
('DEX238', 1, N'Jakarta Hub', 'Package received at sorting center'),
('DEX239', 1, N'Bandung Hub', 'Package in transit to destination'),
('DEX240', 2, N'Jakarta Warehouse', 'Package ready for pickup');
GO

ALTER TABLE DeliveryTracking ADD CONSTRAINT FK_Tracking_Shipment FOREIGN KEY (shipment_rowid) REFERENCES Shipments(ROWID);
GO

-- TBL081 - Returns (FK: Order, User, ReturnStatus)
CREATE TABLE Returns (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    return_code VARCHAR(20) UNIQUE NOT NULL,
    order_rowid INT NOT NULL,
    user_rowid INT NOT NULL,
    status_rowid INT NOT NULL,
    reason NVARCHAR(MAX),
    requested_at DATETIME DEFAULT GETDATE(),
    approved_at DATETIME
);
GO

INSERT INTO Returns (dex_row_id, return_code, order_rowid, user_rowid, status_rowid, reason) VALUES
('DEX241', 'RTR001', 1, 3, 3, N'Product defective'),
('DEX242', 'RTR002', 2, 3, 1, N'Wrong size'),
('DEX243', 'RTR003', 3, 1, 2, N'Damaged during shipping');
GO

ALTER TABLE Returns ADD CONSTRAINT FK_Returns_Order FOREIGN KEY (order_rowid) REFERENCES Orders(ROWID);
ALTER TABLE Returns ADD CONSTRAINT FK_Returns_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
ALTER TABLE Returns ADD CONSTRAINT FK_Returns_Status FOREIGN KEY (status_rowid) REFERENCES ReturnStatuses(ROWID);
GO

-- TBL082 - ReturnItems (FK: Return, OrderItem)
CREATE TABLE ReturnItems (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    return_rowid INT NOT NULL,
    order_item_rowid INT NOT NULL,
    quantity INT NOT NULL
);
GO

INSERT INTO ReturnItems (dex_row_id, return_rowid, order_item_rowid, quantity) VALUES
('DEX244', 1, 1, 1),
('DEX245', 2, 3, 1),
('DEX246', 3, 2, 1);
GO

ALTER TABLE ReturnItems ADD CONSTRAINT FK_RetItems_Return FOREIGN KEY (return_rowid) REFERENCES Returns(ROWID);
ALTER TABLE ReturnItems ADD CONSTRAINT FK_RetItems_OrderItem FOREIGN KEY (order_item_rowid) REFERENCES OrderItems(ROWID);
GO

-- TBL083 - Refunds (FK: Return)
CREATE TABLE Refunds (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    refund_code VARCHAR(20) UNIQUE NOT NULL,
    return_rowid INT NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    refund_method VARCHAR(20),
    processed_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO Refunds (dex_row_id, refund_code, return_rowid, amount, refund_method) VALUES
('DEX247', 'RFD001', 1, 15000000, 'BCA_VA'),
('DEX248', 'RFD002', 2, 2500000, 'GOPAY'),
('DEX249', 'RFD003', 3, 2500000, 'BCA_VA');
GO

ALTER TABLE Refunds ADD CONSTRAINT FK_Refunds_Return FOREIGN KEY (return_rowid) REFERENCES Returns(ROWID);
GO

-- TBL084 - OrderNotes (FK: Order, User)
CREATE TABLE OrderNotes (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    order_rowid INT NOT NULL,
    user_rowid INT NOT NULL,
    note_text NVARCHAR(MAX) NOT NULL,
    is_internal BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO OrderNotes (dex_row_id, order_rowid, user_rowid, note_text, is_internal) VALUES
('DEX250', 1, 2, N'High value order, handle with care', 1),
('DEX251', 1, 3, N'Please include gift wrapping', 0),
('DEX252', 2, 2, N'Customer called to expedite', 1);
GO

ALTER TABLE OrderNotes ADD CONSTRAINT FK_OrderNotes_Order FOREIGN KEY (order_rowid) REFERENCES Orders(ROWID);
ALTER TABLE OrderNotes ADD CONSTRAINT FK_OrderNotes_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
GO

-- TBL085 - PaymentGatewayConfigs (FK: PaymentGateway)
CREATE TABLE PaymentGatewayConfigs (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    gateway_rowid INT NOT NULL,
    config_key VARCHAR(100) NOT NULL,
    config_value NVARCHAR(MAX) NOT NULL,
    is_sensitive BIT DEFAULT 0
);
GO

INSERT INTO PaymentGatewayConfigs (dex_row_id, gateway_rowid, config_key, config_value) VALUES
('DEX253', 1, 'MERCHANT_ID', 'M-ID-12345'),
('DEX254', 1, 'SERVER_KEY', 'SB-Mid-server-xxxxx'),
('DEX255', 2, 'API_KEY', 'xendit-api-key-xxxxx');
GO

ALTER TABLE PaymentGatewayConfigs ADD CONSTRAINT FK_GatewayConfig_Gateway FOREIGN KEY (gateway_rowid) REFERENCES PaymentGateways(ROWID);
GO

-- TBL086 - PaymentTransactions (FK: Order, User, PaymentMethod, PaymentGateway)
CREATE TABLE PaymentTransactions (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    transaction_code VARCHAR(50) UNIQUE NOT NULL,
    order_rowid INT NOT NULL,
    user_rowid INT NOT NULL,
    payment_method_rowid INT NOT NULL,
    gateway_rowid INT NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'PENDING',
    gateway_transaction_id VARCHAR(200),
    paid_at DATETIME
);
GO

INSERT INTO PaymentTransactions (dex_row_id, transaction_code, order_rowid, user_rowid, payment_method_rowid, gateway_rowid, amount, status) VALUES
('DEX256', 'TXN001', 1, 3, 1, 1, 19415000, 'SETTLED'),
('DEX257', 'TXN002', 2, 3, 2, 2, 2775000, 'PENDING'),
('DEX258', 'TXN003', 3, 1, 1, 1, 1233000, 'SETTLED');
GO

ALTER TABLE PaymentTransactions ADD CONSTRAINT FK_PayTxn_Order FOREIGN KEY (order_rowid) REFERENCES Orders(ROWID);
ALTER TABLE PaymentTransactions ADD CONSTRAINT FK_PayTxn_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
ALTER TABLE PaymentTransactions ADD CONSTRAINT FK_PayTxn_Method FOREIGN KEY (payment_method_rowid) REFERENCES PaymentMethods(ROWID);
ALTER TABLE PaymentTransactions ADD CONSTRAINT FK_PayTxn_Gateway FOREIGN KEY (gateway_rowid) REFERENCES PaymentGateways(ROWID);
GO

-- TBL087 - PaymentFees (FK: PaymentTransaction)
CREATE TABLE PaymentFees (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    transaction_rowid INT NOT NULL,
    fee_type VARCHAR(50),
    fee_amount DECIMAL(12,2) NOT NULL,
    fee_percent DECIMAL(5,2)
);
GO

INSERT INTO PaymentFees (dex_row_id, transaction_rowid, fee_type, fee_amount, fee_percent) VALUES
('DEX259', 1, 'Processing Fee', 97075, 0.50),
('DEX260', 2, 'Processing Fee', 20812, 0.75),
('DEX261', 3, 'Processing Fee', 6165, 0.50);
GO

ALTER TABLE PaymentFees ADD CONSTRAINT FK_PayFees_Txn FOREIGN KEY (transaction_rowid) REFERENCES PaymentTransactions(ROWID);
GO

-- TBL088 - Payouts (FK: PayoutStatus)
CREATE TABLE Payouts (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    payout_code VARCHAR(50) UNIQUE NOT NULL,
    seller_rowid INT NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    status_rowid INT NOT NULL,
    bank_account VARCHAR(100),
    requested_at DATETIME DEFAULT GETDATE(),
    processed_at DATETIME
);
GO

INSERT INTO Payouts (dex_row_id, payout_code, seller_rowid, amount, status_rowid, bank_account) VALUES
('DEX262', 'PO001', 2, 15000000, 3, 'BCA-1234567890'),
('DEX263', 'PO002', 2, 5000000, 2, 'BCA-1234567890'),
('DEX264', 'PO003', 1, 25000000, 1, 'BNI-0987654321');
GO

ALTER TABLE Payouts ADD CONSTRAINT FK_Payouts_User FOREIGN KEY (seller_rowid) REFERENCES Users(ROWID);
ALTER TABLE Payouts ADD CONSTRAINT FK_Payouts_Status FOREIGN KEY (status_rowid) REFERENCES PayoutStatuses(ROWID);
GO

-- TBL089 - PayoutItems (FK: Payout)
CREATE TABLE PayoutItems (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    payout_rowid INT NOT NULL,
    order_rowid INT NOT NULL,
    amount DECIMAL(12,2) NOT NULL
);
GO

INSERT INTO PayoutItems (dex_row_id, payout_rowid, order_rowid, amount) VALUES
('DEX265', 1, 1, 15000000),
('DEX266', 2, 2, 2500000),
('DEX267', 2, 3, 2500000);
GO

ALTER TABLE PayoutItems ADD CONSTRAINT FK_PayItems_Payout FOREIGN KEY (payout_rowid) REFERENCES Payouts(ROWID);
ALTER TABLE PayoutItems ADD CONSTRAINT FK_PayItems_Order FOREIGN KEY (order_rowid) REFERENCES Orders(ROWID);
GO

-- TBL090 - SettlementReports (FK: SettlementStatus)
CREATE TABLE SettlementReports (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    report_code VARCHAR(50) UNIQUE NOT NULL,
    period_start DATE NOT NULL,
    period_end DATE NOT NULL,
    total_transactions INT DEFAULT 0,
    total_amount DECIMAL(12,2) DEFAULT 0,
    status_rowid INT NOT NULL,
    generated_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO SettlementReports (dex_row_id, report_code, period_start, period_end, total_transactions, total_amount, status_rowid) VALUES
('DEX268', 'STL-2025-Q1', '2025-01-01', '2025-03-31', 1500, 500000000, 2),
('DEX269', 'STL-2025-Q2', '2025-04-01', '2025-06-30', 1800, 650000000, 1),
('DEX270', 'STL-2025-JUN', '2025-06-01', '2025-06-30', 600, 200000000, 1);
GO

ALTER TABLE SettlementReports ADD CONSTRAINT FK_StlReports_Status FOREIGN KEY (status_rowid) REFERENCES SettlementStatuses(ROWID);
GO

-- TBL091 - Chargebacks (FK: PaymentTransaction)
CREATE TABLE Chargebacks (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    chargeback_code VARCHAR(50) UNIQUE NOT NULL,
    transaction_rowid INT NOT NULL,
    reason NVARCHAR(MAX),
    amount DECIMAL(12,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'DISPUTED',
    filed_at DATETIME DEFAULT GETDATE(),
    resolved_at DATETIME
);
GO

INSERT INTO Chargebacks (dex_row_id, chargeback_code, transaction_rowid, reason, amount) VALUES
('DEX271', 'CHG001', 1, 'Customer claims fraud', 19415000),
('DEX272', 'CHG002', 2, 'Product not received', 2775000),
('DEX273', 'CHG003', 3, 'Duplicate transaction', 1233000);
GO

ALTER TABLE Chargebacks ADD CONSTRAINT FK_Chargebacks_Txn FOREIGN KEY (transaction_rowid) REFERENCES PaymentTransactions(ROWID);
GO

-- TBL092 - Invoices (FK: Order, InvoiceStatus)
CREATE TABLE Invoices (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    invoice_number VARCHAR(50) UNIQUE NOT NULL,
    order_rowid INT NOT NULL,
    status_rowid INT NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,
    tax_amount DECIMAL(12,2) DEFAULT 0,
    total_amount DECIMAL(12,2) NOT NULL,
    due_date DATE,
    issued_at DATETIME DEFAULT GETDATE(),
    paid_at DATETIME
);
GO

INSERT INTO Invoices (dex_row_id, invoice_number, order_rowid, status_rowid, subtotal, tax_amount, total_amount) VALUES
('DEX274', 'INV-001', 1, 2, 17500000, 1925000, 19415000),
('DEX275', 'INV-002', 2, 1, 2500000, 275000, 2775000),
('DEX276', 'INV-003', 3, 2, 1200000, 132000, 1233000);
GO

ALTER TABLE Invoices ADD CONSTRAINT FK_Invoices_Order FOREIGN KEY (order_rowid) REFERENCES Orders(ROWID);
ALTER TABLE Invoices ADD CONSTRAINT FK_Invoices_Status FOREIGN KEY (status_rowid) REFERENCES InvoiceStatuses(ROWID);
GO

-- TBL093 - InvoiceItems (FK: Invoice, OrderItem)
CREATE TABLE InvoiceItems (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    invoice_rowid INT NOT NULL,
    order_item_rowid INT NOT NULL,
    unit_price DECIMAL(12,2) NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL(12,2) NOT NULL
);
GO

INSERT INTO InvoiceItems (dex_row_id, invoice_rowid, order_item_rowid, unit_price, quantity, total_price) VALUES
('DEX277', 1, 1, 15000000, 1, 15000000),
('DEX278', 1, 2, 2500000, 1, 2500000),
('DEX279', 2, 3, 2500000, 1, 2500000);
GO

ALTER TABLE InvoiceItems ADD CONSTRAINT FK_InvItems_Invoice FOREIGN KEY (invoice_rowid) REFERENCES Invoices(ROWID);
ALTER TABLE InvoiceItems ADD CONSTRAINT FK_InvItems_OrderItem FOREIGN KEY (order_item_rowid) REFERENCES OrderItems(ROWID);
GO

-- TBL094 - CreditMemos (FK: Invoice)
CREATE TABLE CreditMemos (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    memo_code VARCHAR(50) UNIQUE NOT NULL,
    invoice_rowid INT NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    reason NVARCHAR(MAX),
    issued_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO CreditMemos (dex_row_id, memo_code, invoice_rowid, amount, reason) VALUES
('DEX280', 'CM-001', 1, 15000000, N'Product returned defective'),
('DEX281', 'CM-002', 2, 2500000, N'Wrong item shipped'),
('DEX282', 'CM-003', 3, 1233000, N'Customer goodwill refund');
GO

ALTER TABLE CreditMemos ADD CONSTRAINT FK_CreditMemos_Invoice FOREIGN KEY (invoice_rowid) REFERENCES Invoices(ROWID);
GO

-- TBL095 - CouponUsage (FK: Coupon, Order, User)
CREATE TABLE CouponUsage (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    coupon_rowid INT NOT NULL,
    order_rowid INT NOT NULL,
    user_rowid INT NOT NULL,
    discount_amount DECIMAL(12,2) NOT NULL,
    used_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO CouponUsage (dex_row_id, coupon_rowid, order_rowid, user_rowid, discount_amount) VALUES
('DEX283', 1, 1, 3, 50000),
('DEX284', 2, 2, 3, 50000),
('DEX285', 3, 3, 1, 150000);
GO

ALTER TABLE CouponUsage ADD CONSTRAINT FK_CoupUsage_Coupon FOREIGN KEY (coupon_rowid) REFERENCES Coupons(ROWID);
ALTER TABLE CouponUsage ADD CONSTRAINT FK_CoupUsage_Order FOREIGN KEY (order_rowid) REFERENCES Orders(ROWID);
ALTER TABLE CouponUsage ADD CONSTRAINT FK_CoupUsage_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
GO

-- TBL096 - PromotionRules (FK: Promotion)
CREATE TABLE PromotionRules (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    promotion_rowid INT NOT NULL,
    rule_type VARCHAR(50) NOT NULL,
    rule_value NVARCHAR(MAX) NOT NULL
);
GO

INSERT INTO PromotionRules (dex_row_id, promotion_rowid, rule_type, rule_value) VALUES
('DEX286', 1, 'MIN_ORDER', '100000'),
('DEX287', 1, 'CATEGORY', '1'),
('DEX288', 2, 'MAX_DISCOUNT', '50000');
GO

ALTER TABLE PromotionRules ADD CONSTRAINT FK_PromoRules_Promotion FOREIGN KEY (promotion_rowid) REFERENCES Promotions(ROWID);
GO

-- TBL097 - CampaignTargets (FK: Campaign)
CREATE TABLE CampaignTargets (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    campaign_rowid INT NOT NULL,
    target_type VARCHAR(50) NOT NULL,
    target_rowid INT
);
GO

INSERT INTO CampaignTargets (dex_row_id, campaign_rowid, target_type, target_rowid) VALUES
('DEX289', 1, 'CATEGORY', 1),
('DEX290', 1, 'CATEGORY', 2),
('DEX291', 2, 'ROLE', 3);
GO

ALTER TABLE CampaignTargets ADD CONSTRAINT FK_CampTargets_Campaign FOREIGN KEY (campaign_rowid) REFERENCES Campaigns(ROWID);
GO

-- TBL098 - EmailCampaigns (FK: Campaign, EmailTemplate)
CREATE TABLE EmailCampaigns (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    campaign_rowid INT NOT NULL,
    template_rowid INT NOT NULL,
    sent_count INT DEFAULT 0,
    open_count INT DEFAULT 0,
    click_count INT DEFAULT 0
);
GO

INSERT INTO EmailCampaigns (dex_row_id, campaign_rowid, template_rowid) VALUES
('DEX292', 1, 1),
('DEX293', 2, 2),
('DEX294', 3, 1);
GO

ALTER TABLE EmailCampaigns ADD CONSTRAINT FK_EmailCamp_Campaign FOREIGN KEY (campaign_rowid) REFERENCES Campaigns(ROWID);
ALTER TABLE EmailCampaigns ADD CONSTRAINT FK_EmailCamp_Template FOREIGN KEY (template_rowid) REFERENCES EmailTemplates(ROWID);
GO

-- TBL099 - EmailLogs (FK: EmailCampaign, User)
CREATE TABLE EmailLogs (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    campaign_rowid INT,
    user_rowid INT NOT NULL,
    email_to VARCHAR(100) NOT NULL,
    subject NVARCHAR(200),
    status VARCHAR(20) DEFAULT 'SENT',
    sent_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO EmailLogs (dex_row_id, campaign_rowid, user_rowid, email_to, subject) VALUES
('DEX295', 1, 3, 'customer@shop.com', 'Welcome to Shop!'),
('DEX296', 2, 3, 'customer@shop.com', 'Flash Sale is Live!'),
('DEX297', 3, 2, 'seller@shop.com', 'Quarterly Performance Update');
GO

ALTER TABLE EmailLogs ADD CONSTRAINT FK_EmailLogs_Campaign FOREIGN KEY (campaign_rowid) REFERENCES EmailCampaigns(ROWID);
ALTER TABLE EmailLogs ADD CONSTRAINT FK_EmailLogs_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
GO

-- TBL100 - NewsletterSubscribers
CREATE TABLE NewsletterSubscribers (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    email VARCHAR(100) UNIQUE NOT NULL,
    is_active BIT DEFAULT 1,
    subscribed_at DATETIME DEFAULT GETDATE(),
    unsubscribed_at DATETIME
);
GO

INSERT INTO NewsletterSubscribers (dex_row_id, email) VALUES
('DEX298', 'budi@email.com'),
('DEX299', 'siti@email.com'),
('DEX300', 'agus@email.com');
GO

-- TBL101 - ReferralPrograms
CREATE TABLE ReferralPrograms (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    program_code VARCHAR(20) UNIQUE NOT NULL,
    program_name NVARCHAR(100) NOT NULL,
    reward_amount DECIMAL(12,2),
    reward_type VARCHAR(20) CHECK (reward_type IN ('POINTS', 'DISCOUNT', 'CASH'))
);
GO

INSERT INTO ReferralPrograms (dex_row_id, program_code, program_name, reward_amount, reward_type) VALUES
('DEX301', 'REFER10', N'Refer a Friend', 50000, 'DISCOUNT'),
('DEX302', 'REFER20', N'Refer 10 Friends', 500000, 'CASH'),
('DEX303', 'REWARD05', N'Birthday Bonus', 100000, 'DISCOUNT');
GO

-- TBL102 - ReferralRewards (FK: ReferralProgram, User)
CREATE TABLE ReferralRewards (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    program_rowid INT NOT NULL,
    referrer_user_rowid INT NOT NULL,
    referred_user_rowid INT NOT NULL,
    order_rowid INT,
    reward_amount DECIMAL(12,2) NOT NULL,
    is_claimed BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO ReferralRewards (dex_row_id, program_rowid, referrer_user_rowid, referred_user_rowid, reward_amount) VALUES
('DEX304', 1, 3, 2, 50000),
('DEX305', 1, 2, 1, 50000),
('DEX306', 2, 3, 1, 500000);
GO

ALTER TABLE ReferralRewards ADD CONSTRAINT FK_RefRewards_Program FOREIGN KEY (program_rowid) REFERENCES ReferralPrograms(ROWID);
ALTER TABLE ReferralRewards ADD CONSTRAINT FK_RefRewards_Referrer FOREIGN KEY (referrer_user_rowid) REFERENCES Users(ROWID);
ALTER TABLE ReferralRewards ADD CONSTRAINT FK_RefRewards_Referred FOREIGN KEY (referred_user_rowid) REFERENCES Users(ROWID);
ALTER TABLE ReferralRewards ADD CONSTRAINT FK_RefRewards_Order FOREIGN KEY (order_rowid) REFERENCES Orders(ROWID);
GO

-- TBL103 - LoyaltyPoints (FK: User, PricingTier)
CREATE TABLE LoyaltyPoints (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    user_rowid INT NOT NULL,
    points_earned INT DEFAULT 0,
    points_spent INT DEFAULT 0,
    points_balance INT DEFAULT 0,
    tier_rowid INT,
    last_updated DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO LoyaltyPoints (dex_row_id, user_rowid, points_earned, points_spent, points_balance) VALUES
('DEX307', 3, 10000, 2000, 8000),
('DEX308', 2, 50000, 10000, 40000),
('DEX309', 1, 250000, 50000, 200000);
GO

ALTER TABLE LoyaltyPoints ADD CONSTRAINT FK_Loyalty_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
ALTER TABLE LoyaltyPoints ADD CONSTRAINT FK_Loyalty_Tier FOREIGN KEY (tier_rowid) REFERENCES PricingTiers(ROWID);
GO
-- ============================================================
-- TIER 3: Depends on Tier 2
-- ============================================================

-- TBL104 - SupplierProducts (FK: Supplier, Product)
CREATE TABLE SupplierProducts (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    supplier_rowid INT NOT NULL,
    product_rowid INT NOT NULL,
    unit_cost DECIMAL(12,2) NOT NULL,
    lead_time_days INT,
    is_preferred BIT DEFAULT 0
);
GO

INSERT INTO SupplierProducts (dex_row_id, supplier_rowid, product_rowid, unit_cost) VALUES
('DEX310', 1, 1, 12000000),
('DEX311', 2, 2, 1800000),
('DEX312', 3, 3, 800000);
GO

ALTER TABLE SupplierProducts ADD CONSTRAINT FK_SupProd_Supplier FOREIGN KEY (supplier_rowid) REFERENCES Suppliers(ROWID);
ALTER TABLE SupplierProducts ADD CONSTRAINT FK_SupProd_Product FOREIGN KEY (product_rowid) REFERENCES Products(ROWID);
GO

-- TBL105 - WarehouseInventory (FK: Warehouse, ProductSKU)
CREATE TABLE WarehouseInventory (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    warehouse_rowid INT NOT NULL,
    sku_rowid INT NOT NULL,
    quantity INT DEFAULT 0,
    reserved_quantity INT DEFAULT 0,
    bin_location VARCHAR(50)
);
GO

INSERT INTO WarehouseInventory (dex_row_id, warehouse_rowid, sku_rowid, quantity, bin_location) VALUES
('DEX313', 1, 1, 50, 'A-01-01'),
('DEX314', 1, 2, 100, 'B-02-03'),
('DEX315', 2, 3, 30, 'A-05-02');
GO

ALTER TABLE WarehouseInventory ADD CONSTRAINT FK_WareInv_Warehouse FOREIGN KEY (warehouse_rowid) REFERENCES Warehouses(ROWID);
ALTER TABLE WarehouseInventory ADD CONSTRAINT FK_WareInv_SKU FOREIGN KEY (sku_rowid) REFERENCES ProductSKUs(ROWID);
GO

-- TBL106 - StockMovements (FK: Warehouse, ProductSKU, User)
CREATE TABLE StockMovements (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    warehouse_rowid INT NOT NULL,
    sku_rowid INT NOT NULL,
    user_rowid INT,
    movement_type VARCHAR(20) CHECK (movement_type IN ('IN', 'OUT', 'TRANSFER', 'ADJUSTMENT')),
    quantity INT NOT NULL,
    reference_type VARCHAR(50),
    reference_rowid INT,
    notes NVARCHAR(500),
    moved_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO StockMovements (dex_row_id, warehouse_rowid, sku_rowid, user_rowid, movement_type, quantity, reference_type, notes) VALUES
('DEX316', 1, 1, 1, 'IN', 50, 'PURCHASE_ORDER', N'Initial stock'),
('DEX317', 1, 2, 1, 'IN', 100, 'PURCHASE_ORDER', N'Supplier delivery'),
('DEX318', 2, 1, 2, 'OUT', 1, 'ORDER', N'Sold to customer');
GO

ALTER TABLE StockMovements ADD CONSTRAINT FK_StockMov_Warehouse FOREIGN KEY (warehouse_rowid) REFERENCES Warehouses(ROWID);
ALTER TABLE StockMovements ADD CONSTRAINT FK_StockMov_SKU FOREIGN KEY (sku_rowid) REFERENCES ProductSKUs(ROWID);
ALTER TABLE StockMovements ADD CONSTRAINT FK_StockMov_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
GO

-- TBL107 - PurchaseOrders (FK: Supplier, User)
CREATE TABLE PurchaseOrders (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    po_number VARCHAR(50) UNIQUE NOT NULL,
    supplier_rowid INT NOT NULL,
    ordered_by_rowid INT NOT NULL,
    status VARCHAR(20) DEFAULT 'DRAFT',
    total_amount DECIMAL(12,2),
    expected_date DATE,
    ordered_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO PurchaseOrders (dex_row_id, po_number, supplier_rowid, ordered_by_rowid, status, total_amount) VALUES
('DEX319', 'PO-2025-001', 1, 1, 'APPROVED', 60000000),
('DEX320', 'PO-2025-002', 2, 1, 'SENT', 18000000),
('DEX321', 'PO-2025-003', 3, 1, 'DRAFT', 4000000);
GO

ALTER TABLE PurchaseOrders ADD CONSTRAINT FK_PO_Supplier FOREIGN KEY (supplier_rowid) REFERENCES Suppliers(ROWID);
ALTER TABLE PurchaseOrders ADD CONSTRAINT FK_PO_User FOREIGN KEY (ordered_by_rowid) REFERENCES Users(ROWID);
GO

-- TBL108 - PurchaseOrderItems (FK: PurchaseOrder, Product)
CREATE TABLE PurchaseOrderItems (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    po_rowid INT NOT NULL,
    product_rowid INT NOT NULL,
    quantity INT NOT NULL,
    unit_cost DECIMAL(12,2) NOT NULL,
    total_cost DECIMAL(12,2) NOT NULL
);
GO

INSERT INTO PurchaseOrderItems (dex_row_id, po_rowid, product_rowid, quantity, unit_cost, total_cost) VALUES
('DEX322', 1, 1, 5, 12000000, 60000000),
('DEX323', 2, 2, 10, 1800000, 18000000),
('DEX324', 3, 3, 5, 800000, 4000000);
GO

ALTER TABLE PurchaseOrderItems ADD CONSTRAINT FK_POItems_PO FOREIGN KEY (po_rowid) REFERENCES PurchaseOrders(ROWID);
ALTER TABLE PurchaseOrderItems ADD CONSTRAINT FK_POItems_Product FOREIGN KEY (product_rowid) REFERENCES Products(ROWID);
GO

-- TBL109 - GoodsReceipts (FK: PurchaseOrder, Warehouse, User)
CREATE TABLE GoodsReceipts (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    receipt_code VARCHAR(50) UNIQUE NOT NULL,
    po_rowid INT NOT NULL,
    warehouse_rowid INT NOT NULL,
    received_by_rowid INT NOT NULL,
    received_at DATETIME DEFAULT GETDATE(),
    notes NVARCHAR(500)
);
GO

INSERT INTO GoodsReceipts (dex_row_id, receipt_code, po_rowid, warehouse_rowid, received_by_rowid) VALUES
('DEX325', 'GR-001', 1, 1, 1),
('DEX326', 'GR-002', 2, 1, 1),
('DEX327', 'GR-003', 3, 2, 2);
GO

ALTER TABLE GoodsReceipts ADD CONSTRAINT FK_GR_PO FOREIGN KEY (po_rowid) REFERENCES PurchaseOrders(ROWID);
ALTER TABLE GoodsReceipts ADD CONSTRAINT FK_GR_Warehouse FOREIGN KEY (warehouse_rowid) REFERENCES Warehouses(ROWID);
ALTER TABLE GoodsReceipts ADD CONSTRAINT FK_GR_User FOREIGN KEY (received_by_rowid) REFERENCES Users(ROWID);
GO

-- TBL110 - InventoryCounts (FK: Warehouse, ProductSKU, User)
CREATE TABLE InventoryCounts (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    warehouse_rowid INT NOT NULL,
    sku_rowid INT NOT NULL,
    counted_by_rowid INT NOT NULL,
    system_quantity INT NOT NULL,
    physical_quantity INT NOT NULL,
    discrepancy INT,
    counted_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO InventoryCounts (dex_row_id, warehouse_rowid, sku_rowid, counted_by_rowid, system_quantity, physical_quantity) VALUES
('DEX328', 1, 1, 1, 50, 49),
('DEX329', 1, 2, 1, 100, 100),
('DEX330', 2, 3, 2, 30, 30);
GO

ALTER TABLE InventoryCounts ADD CONSTRAINT FK_InvCount_Warehouse FOREIGN KEY (warehouse_rowid) REFERENCES Warehouses(ROWID);
ALTER TABLE InventoryCounts ADD CONSTRAINT FK_InvCount_SKU FOREIGN KEY (sku_rowid) REFERENCES ProductSKUs(ROWID);
ALTER TABLE InventoryCounts ADD CONSTRAINT FK_InvCount_User FOREIGN KEY (counted_by_rowid) REFERENCES Users(ROWID);
GO

-- TBL111 - StockAlerts (FK: ProductSKU)
CREATE TABLE StockAlerts (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    sku_rowid INT NOT NULL,
    alert_type VARCHAR(20) CHECK (alert_type IN ('LOW_STOCK', 'OUT_OF_STOCK', 'OVERSTOCK')),
    threshold INT NOT NULL,
    current_stock INT NOT NULL,
    is_resolved BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO StockAlerts (dex_row_id, sku_rowid, alert_type, threshold, current_stock) VALUES
('DEX331', 1, 'LOW_STOCK', 10, 49),
('DEX332', 2, 'LOW_STOCK', 20, 100),
('DEX333', 3, 'OUT_OF_STOCK', 5, 30);
GO

ALTER TABLE StockAlerts ADD CONSTRAINT FK_StockAlerts_SKU FOREIGN KEY (sku_rowid) REFERENCES ProductSKUs(ROWID);
GO

-- TBL112 - ProductReviews (FK: Product, User, ReviewStatus)
CREATE TABLE ProductReviews (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    product_rowid INT NOT NULL,
    user_rowid INT NOT NULL,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    title NVARCHAR(200),
    review_text NVARCHAR(MAX),
    status_rowid INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO ProductReviews (dex_row_id, product_rowid, user_rowid, rating, title, review_text, status_rowid) VALUES
('DEX334', 1, 3, 5, N'Amazing phone!', N'Best phone I have ever used.', 2),
('DEX335', 2, 3, 4, N'Comfortable shoes', N'Very comfortable for running.', 2),
('DEX336', 3, 2, 3, N'Decent shelf', N'Good value for the price.', 1);
GO

ALTER TABLE ProductReviews ADD CONSTRAINT FK_Reviews_Product FOREIGN KEY (product_rowid) REFERENCES Products(ROWID);
ALTER TABLE ProductReviews ADD CONSTRAINT FK_Reviews_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
ALTER TABLE ProductReviews ADD CONSTRAINT FK_Reviews_Status FOREIGN KEY (status_rowid) REFERENCES ReviewStatuses(ROWID);
GO

-- TBL113 - ReviewVotes (FK: ProductReview, User)
CREATE TABLE ReviewVotes (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    review_rowid INT NOT NULL,
    user_rowid INT NOT NULL,
    vote_type VARCHAR(10) CHECK (vote_type IN ('HELPFUL', 'UNHELPFUL'))
);
GO

INSERT INTO ReviewVotes (dex_row_id, review_rowid, user_rowid, vote_type) VALUES
('DEX337', 1, 2, 'HELPFUL'),
('DEX338', 1, 3, 'HELPFUL'),
('DEX339', 2, 1, 'HELPFUL');
GO

ALTER TABLE ReviewVotes ADD CONSTRAINT FK_ReviewVotes_Review FOREIGN KEY (review_rowid) REFERENCES ProductReviews(ROWID);
ALTER TABLE ReviewVotes ADD CONSTRAINT FK_ReviewVotes_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
GO

-- TBL114 - ReviewImages (FK: ProductReview)
CREATE TABLE ReviewImages (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    review_rowid INT NOT NULL,
    image_url VARCHAR(500) NOT NULL
);
GO

INSERT INTO ReviewImages (dex_row_id, review_rowid, image_url) VALUES
('DEX340', 1, 'https://img.shop.com/review/s25-customer.jpg'),
('DEX341', 2, 'https://img.shop.com/review/nike-customer.jpg'),
('DEX342', 3, 'https://img.shop.com/review/kallax-customer.jpg');
GO

ALTER TABLE ReviewImages ADD CONSTRAINT FK_ReviewImg_Review FOREIGN KEY (review_rowid) REFERENCES ProductReviews(ROWID);
GO

-- TBL115 - ProductQA (FK: Product, User)
CREATE TABLE ProductQA (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    product_rowid INT NOT NULL,
    user_rowid INT NOT NULL,
    question_text NVARCHAR(MAX) NOT NULL,
    asked_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO ProductQA (dex_row_id, product_rowid, user_rowid, question_text) VALUES
('DEX343', 1, 3, 'Does this support 5G?'),
('DEX344', 2, 3, 'Is this true to size?'),
('DEX345', 3, 1, 'What is the weight capacity?');
GO

ALTER TABLE ProductQA ADD CONSTRAINT FK_QA_Product FOREIGN KEY (product_rowid) REFERENCES Products(ROWID);
ALTER TABLE ProductQA ADD CONSTRAINT FK_QA_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
GO

-- TBL116 - QAAnswers (FK: ProductQA, User)
CREATE TABLE QAAnswers (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    qa_rowid INT NOT NULL,
    user_rowid INT NOT NULL,
    answer_text NVARCHAR(MAX) NOT NULL,
    is_official BIT DEFAULT 0,
    answered_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO QAAnswers (dex_row_id, qa_rowid, user_rowid, answer_text, is_official) VALUES
('DEX346', 1, 2, 'Yes, it supports 5G.', 1),
('DEX347', 2, 3, 'I would recommend going half size up.', 0),
('DEX348', 3, 2, 'The weight capacity is 50kg per shelf.', 1);
GO

ALTER TABLE QAAnswers ADD CONSTRAINT FK_QAAns_QA FOREIGN KEY (qa_rowid) REFERENCES ProductQA(ROWID);
ALTER TABLE QAAnswers ADD CONSTRAINT FK_QAAns_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
GO

-- TBL117 - SellerRatings (FK: User)
CREATE TABLE SellerRatings (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    seller_rowid INT NOT NULL,
    buyer_rowid INT NOT NULL,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    review_text NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO SellerRatings (dex_row_id, seller_rowid, buyer_rowid, rating, review_text) VALUES
('DEX349', 2, 3, 5, N'Fast shipping and good packaging.'),
('DEX350', 2, 1, 4, N'Responsive seller.'),
('DEX351', 1, 3, 5, N'Excellent service!');
GO

ALTER TABLE SellerRatings ADD CONSTRAINT FK_SellerRat_Seller FOREIGN KEY (seller_rowid) REFERENCES Users(ROWID);
ALTER TABLE SellerRatings ADD CONSTRAINT FK_SellerRat_Buyer FOREIGN KEY (buyer_rowid) REFERENCES Users(ROWID);
GO

-- TBL118 - ReviewModerationLogs (FK: ProductReview, User)
CREATE TABLE ReviewModerationLogs (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    review_rowid INT NOT NULL,
    moderated_by_rowid INT NOT NULL,
    old_status_rowid INT,
    new_status_rowid INT,
    reason NVARCHAR(MAX),
    moderated_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO ReviewModerationLogs (dex_row_id, review_rowid, moderated_by_rowid, new_status_rowid, reason) VALUES
('DEX352', 3, 1, 2, N'Approved after review'),
('DEX353', 1, 1, 2, N'Auto-approved'),
('DEX354', 2, 1, 2, N'Verified purchase review');
GO

ALTER TABLE ReviewModerationLogs ADD CONSTRAINT FK_ModLog_Review FOREIGN KEY (review_rowid) REFERENCES ProductReviews(ROWID);
ALTER TABLE ReviewModerationLogs ADD CONSTRAINT FK_ModLog_User FOREIGN KEY (moderated_by_rowid) REFERENCES Users(ROWID);
GO

-- TBL119 - SupportTicketMessages (FK: SupportTicket, User)
CREATE TABLE SupportTicketMessages (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    ticket_rowid INT NOT NULL,
    user_rowid INT NOT NULL,
    message_text NVARCHAR(MAX) NOT NULL,
    is_staff_reply BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO SupportTicketMessages (dex_row_id, ticket_rowid, user_rowid, message_text, is_staff_reply) VALUES
('DEX355', 1, 3, N'I have not received my order yet.', 0),
('DEX356', 1, 1, N'We are checking with the courier.', 1),
('DEX357', 2, 3, N'Payment was deducted but status is pending.', 0);
GO

ALTER TABLE SupportTicketMessages ADD CONSTRAINT FK_TicketMsg_Ticket FOREIGN KEY (ticket_rowid) REFERENCES SupportTickets(ROWID);
ALTER TABLE SupportTicketMessages ADD CONSTRAINT FK_TicketMsg_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
GO

-- TBL120 - LiveChatSessions (FK: User)
CREATE TABLE LiveChatSessions (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    session_code VARCHAR(50) UNIQUE NOT NULL,
    user_rowid INT NOT NULL,
    agent_rowid INT,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    started_at DATETIME DEFAULT GETDATE(),
    ended_at DATETIME
);
GO

INSERT INTO LiveChatSessions (dex_row_id, session_code, user_rowid, status) VALUES
('DEX358', 'CHAT-001', 3, 'ACTIVE'),
('DEX359', 'CHAT-002', 3, 'CLOSED'),
('DEX360', 'CHAT-003', 2, 'ACTIVE');
GO

ALTER TABLE LiveChatSessions ADD CONSTRAINT FK_ChatSess_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
ALTER TABLE LiveChatSessions ADD CONSTRAINT FK_ChatSess_Agent FOREIGN KEY (agent_rowid) REFERENCES Users(ROWID);
GO

-- TBL121 - ChatMessages (FK: LiveChatSession, User)
CREATE TABLE ChatMessages (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    session_rowid INT NOT NULL,
    user_rowid INT NOT NULL,
    message_text NVARCHAR(MAX) NOT NULL,
    sent_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO ChatMessages (dex_row_id, session_rowid, user_rowid, message_text) VALUES
('DEX361', 1, 3, 'Hello, I need help with my order.'),
('DEX362', 1, 1, 'Hello! How can I help you today?'),
('DEX363', 2, 3, 'Thanks for resolving my issue!');
GO

ALTER TABLE ChatMessages ADD CONSTRAINT FK_ChatMsg_Session FOREIGN KEY (session_rowid) REFERENCES LiveChatSessions(ROWID);
ALTER TABLE ChatMessages ADD CONSTRAINT FK_ChatMsg_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
GO

-- TBL122 - FeedbackForms (FK: User)
CREATE TABLE FeedbackForms (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    user_rowid INT,
    subject NVARCHAR(200) NOT NULL,
    message NVARCHAR(MAX) NOT NULL,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    submitted_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO FeedbackForms (dex_row_id, user_rowid, subject, message, rating) VALUES
('DEX364', 3, N'Great shopping experience', N'Fast delivery and good quality products.', 5),
('DEX365', 2, N'Portal improvement', N'The seller dashboard could be improved.', 4),
('DEX366', 1, N'Excellent platform', N'Best e-commerce platform for sellers.', 5);
GO

ALTER TABLE FeedbackForms ADD CONSTRAINT FK_Feedback_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
GO

-- ============================================================
-- TIER 4: Analytics & Monitoring
-- ============================================================

-- TBL123 - PageViews (FK: User)
CREATE TABLE PageViews (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    user_rowid INT,
    page_url VARCHAR(500) NOT NULL,
    page_title NVARCHAR(200),
    referrer_url VARCHAR(500),
    session_id VARCHAR(100),
    ip_address VARCHAR(50),
    user_agent VARCHAR(500),
    viewed_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO PageViews (dex_row_id, user_rowid, page_url, page_title) VALUES
('DEX367', 3, '/products/samsung-galaxy-s25', 'Samsung Galaxy S25'),
('DEX368', 3, '/cart', 'Shopping Cart'),
('DEX369', 1, '/admin/dashboard', 'Admin Dashboard');
GO

ALTER TABLE PageViews ADD CONSTRAINT FK_PageView_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
GO

-- TBL124 - SearchQueries (FK: User)
CREATE TABLE SearchQueries (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    user_rowid INT,
    query_text NVARCHAR(200) NOT NULL,
    result_count INT,
    session_id VARCHAR(100),
    searched_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO SearchQueries (dex_row_id, user_rowid, query_text, result_count) VALUES
('DEX370', 3, 'samsung galaxy', 25),
('DEX371', 3, 'running shoes', 42),
('DEX372', 1, 'sales report', 8);
GO

ALTER TABLE SearchQueries ADD CONSTRAINT FK_Search_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
GO

-- TBL125 - ClickTracking (FK: User)
CREATE TABLE ClickTracking (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    user_rowid INT,
    element_id VARCHAR(100),
    element_type VARCHAR(50),
    page_url VARCHAR(500),
    session_id VARCHAR(100),
    clicked_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO ClickTracking (dex_row_id, user_rowid, element_id, element_type, page_url) VALUES
('DEX373', 3, 'btn-add-to-cart', 'button', '/products/samsung-galaxy-s25'),
('DEX374', 3, 'checkout-btn', 'button', '/cart'),
('DEX375', 1, 'nav-orders', 'link', '/admin/dashboard');
GO

ALTER TABLE ClickTracking ADD CONSTRAINT FK_ClickTrack_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
GO

-- TBL126 - ConversionTracking (FK: User, Order)
CREATE TABLE ConversionTracking (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    user_rowid INT NOT NULL,
    order_rowid INT,
    source VARCHAR(50),
    medium VARCHAR(50),
    campaign_name NVARCHAR(100),
    converted_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO ConversionTracking (dex_row_id, user_rowid, order_rowid, source, medium, campaign_name) VALUES
('DEX376', 3, 1, 'google', 'organic', ''),
('DEX377', 3, 2, 'email', 'newsletter', 'Flash Sale'),
('DEX378', 1, 3, 'direct', 'none', '');
GO

ALTER TABLE ConversionTracking ADD CONSTRAINT FK_ConvTrack_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
ALTER TABLE ConversionTracking ADD CONSTRAINT FK_ConvTrack_Order FOREIGN KEY (order_rowid) REFERENCES Orders(ROWID);
GO

-- TBL127 - UserBehaviorLogs (FK: User)
CREATE TABLE UserBehaviorLogs (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    user_rowid INT,
    event_type VARCHAR(50) NOT NULL,
    event_data NVARCHAR(MAX),
    session_id VARCHAR(100),
    logged_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO UserBehaviorLogs (dex_row_id, user_rowid, event_type, event_data) VALUES
('DEX379', 3, 'ADD_TO_CART', '{"product":"Samsung Galaxy S25","qty":1}'),
('DEX380', 3, 'VIEW_PRODUCT', '{"product":"Nike Air Max 270"}'),
('DEX381', 1, 'LOGIN', '{"ip":"192.168.1.1"}');
GO

ALTER TABLE UserBehaviorLogs ADD CONSTRAINT FK_BehaviorLog_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
GO

-- TBL128 - APILogs (FK: User)
CREATE TABLE APILogs (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    user_rowid INT,
    endpoint VARCHAR(200) NOT NULL,
    http_method VARCHAR(10),
    request_body NVARCHAR(MAX),
    response_status INT,
    response_time_ms INT,
    ip_address VARCHAR(50),
    logged_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO APILogs (dex_row_id, user_rowid, endpoint, http_method, response_status) VALUES
('DEX382', 3, '/api/products', 'GET', 200),
('DEX383', 3, '/api/orders', 'POST', 201),
('DEX384', 1, '/api/admin/users', 'GET', 200);
GO

ALTER TABLE APILogs ADD CONSTRAINT FK_APILog_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
GO

-- TBL129 - ErrorLogs (FK: User)
CREATE TABLE ErrorLogs (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    user_rowid INT,
    error_code VARCHAR(50),
    error_message NVARCHAR(MAX),
    stack_trace NVARCHAR(MAX),
    request_url VARCHAR(500),
    logged_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO ErrorLogs (dex_row_id, user_rowid, error_code, error_message, request_url) VALUES
('DEX385', 3, 'PAYMENT_FAILED', 'Insufficient balance', '/api/payments'),
('DEX386', 3, 'CART_TIMEOUT', 'Session expired', '/api/cart/checkout'),
('DEX387', 1, 'DB_TIMEOUT', 'Database connection timeout', '/api/admin/report');
GO

ALTER TABLE ErrorLogs ADD CONSTRAINT FK_ErrorLog_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
GO

-- TBL130 - PerformanceMetrics
CREATE TABLE PerformanceMetrics (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    metric_name VARCHAR(100) NOT NULL,
    metric_value DECIMAL(18,4) NOT NULL,
    unit VARCHAR(20),
    recorded_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO PerformanceMetrics (dex_row_id, metric_name, metric_value, unit) VALUES
('DEX388', 'avg_response_time', 245.50, 'ms'),
('DEX389', 'requests_per_minute', 1250.00, 'req/min'),
('DEX390', 'error_rate', 0.50, 'percent');
GO

-- TBL131 - DailySalesReports
CREATE TABLE DailySalesReports (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    report_date DATE NOT NULL,
    total_orders INT DEFAULT 0,
    total_revenue DECIMAL(12,2) DEFAULT 0,
    total_items_sold INT DEFAULT 0,
    average_order_value DECIMAL(12,2) DEFAULT 0,
    generated_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO DailySalesReports (dex_row_id, report_date, total_orders, total_revenue, total_items_sold) VALUES
('DEX391', '2025-06-01', 45, 67500000, 78),
('DEX392', '2025-06-02', 52, 78000000, 92),
('DEX393', '2025-06-03', 38, 57000000, 65);
GO

-- TBL132 - ProductPerformance (FK: Product)
CREATE TABLE ProductPerformance (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    product_rowid INT NOT NULL,
    report_date DATE NOT NULL,
    total_views INT DEFAULT 0,
    total_add_to_cart INT DEFAULT 0,
    total_orders INT DEFAULT 0,
    total_revenue DECIMAL(12,2) DEFAULT 0,
    conversion_rate DECIMAL(5,2) DEFAULT 0
);
GO

INSERT INTO ProductPerformance (dex_row_id, product_rowid, report_date, total_views, total_add_to_cart, total_orders, total_revenue) VALUES
('DEX394', 1, '2025-06-01', 250, 30, 5, 75000000),
('DEX395', 2, '2025-06-01', 180, 25, 8, 20000000),
('DEX396', 3, '2025-06-01', 90, 10, 3, 3600000);
GO

ALTER TABLE ProductPerformance ADD CONSTRAINT FK_ProdPerf_Product FOREIGN KEY (product_rowid) REFERENCES Products(ROWID);
GO

-- TBL133 - CartAbandonmentAnalytics
CREATE TABLE CartAbandonmentAnalytics (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    report_date DATE NOT NULL,
    total_carts_created INT DEFAULT 0,
    total_carts_abandoned INT DEFAULT 0,
    abandonment_rate DECIMAL(5,2) DEFAULT 0,
    recovered_carts INT DEFAULT 0,
    revenue_lost DECIMAL(12,2) DEFAULT 0
);
GO

INSERT INTO CartAbandonmentAnalytics (dex_row_id, report_date, total_carts_created, total_carts_abandoned, abandonment_rate) VALUES
('DEX397', '2025-06-01', 200, 140, 70.00),
('DEX398', '2025-06-02', 220, 150, 68.18),
('DEX399', '2025-06-03', 180, 120, 66.67);
GO

-- TBL134 - UserSessionAnalytics
CREATE TABLE UserSessionAnalytics (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    user_rowid INT,
    session_id VARCHAR(100) NOT NULL,
    session_start DATETIME NOT NULL,
    session_end DATETIME,
    duration_seconds INT,
    pages_viewed INT DEFAULT 0,
    is_converted BIT DEFAULT 0,
    source VARCHAR(50),
    medium VARCHAR(50)
);
GO

INSERT INTO UserSessionAnalytics (dex_row_id, user_rowid, session_id, session_start, pages_viewed) VALUES
('DEX400', 3, 'SESS-001', '2025-06-01 10:00:00', 8),
('DEX401', 3, 'SESS-002', '2025-06-02 14:30:00', 5),
('DEX402', 1, 'SESS-003', '2025-06-03 09:00:00', 12);
GO

ALTER TABLE UserSessionAnalytics ADD CONSTRAINT FK_UserSess_User FOREIGN KEY (user_rowid) REFERENCES Users(ROWID);
GO

PRINT 'ShoppingDB created successfully with 134 tables and 3 records each.';
GO
