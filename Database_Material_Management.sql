-- Tạo database và chọn sử dụng
CREATE DATABASE IF NOT EXISTS material_management;
USE material_management;

-- 1. Bảng roles (phân quyền người dùng)
CREATE TABLE roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
);

-- 2. Bảng users (người dùng)
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255),
    role_id INT,
    status ENUM('active', 'inactive') DEFAULT 'active',
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

-- 3. Bảng categories (danh mục vật tư, có phân cấp)
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    parent_id INT DEFAULT NULL,
    FOREIGN KEY (parent_id) REFERENCES categories(category_id)
);

-- 4. Bảng materials (vật tư)
CREATE TABLE materials (
    material_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    category_id INT,
    image_url VARCHAR(255),
    material_condition VARCHAR(50),
    price DECIMAL(12,2),
    description TEXT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- 5. Bảng inventory (kho vật tư hiện tại)
CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    material_id INT,
    quantity INT,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (material_id) REFERENCES materials(material_id)
);

-- 6. Bảng import_forms (phiếu nhập kho)
CREATE TABLE import_forms (
    import_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    import_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    note TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 7. Bảng export_forms (phiếu xuất kho)
CREATE TABLE export_forms (
    export_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    export_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    recipient VARCHAR(100),
    note TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 8. Bảng material_history (lịch sử nhập/xuất vật tư)
CREATE TABLE material_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    material_id INT,
    quantity INT,
    action_type ENUM('import', 'export'),
    reference_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (material_id) REFERENCES materials(material_id)
);

-- 9. Bảng request_types (loại yêu cầu)
CREATE TABLE request_types (
    request_type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(100) -- ví dụ: Xuất kho, Mua vật tư, Sửa chữa
);

-- 10. Bảng requests (yêu cầu xuất/mua/sửa vật tư)
CREATE TABLE requests (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    requester_id INT,
    request_type_id INT,
    material_id INT,
    quantity INT,
    reason TEXT,
    status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    response_note TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    responded_by INT DEFAULT NULL,
    responded_at DATETIME DEFAULT NULL,
    FOREIGN KEY (requester_id) REFERENCES users(user_id),
    FOREIGN KEY (responded_by) REFERENCES users(user_id),
    FOREIGN KEY (material_id) REFERENCES materials(material_id),
    FOREIGN KEY (request_type_id) REFERENCES request_types(request_type_id)
);

-- 11. Bảng material_images (ảnh vật tư, dùng BLOB để lưu nhị phân)
CREATE TABLE material_images (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    material_id INT,
    image_url VARCHAR(255),
    image_name VARCHAR(255),
    uploaded_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (material_id) REFERENCES materials(material_id)
);



DROP TABLE IF EXISTS material_images;
DROP TABLE IF EXISTS requests;
DROP TABLE IF EXISTS request_types;
DROP TABLE IF EXISTS material_history;
DROP TABLE IF EXISTS export_forms;
DROP TABLE IF EXISTS import_forms;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS materials;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS roles;
