CREATE DATABASE IF NOT EXISTS auto_company;
USE auto_company;

-- 1. brand
CREATE TABLE brand (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- 2. model
CREATE TABLE model (
    model_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    year INT NOT NULL,
    base_price DECIMAL(10,2) NOT NULL CHECK (base_price >= 0),
    brand_id INT NOT NULL,
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id)
);

-- 3. model_body_style
CREATE TABLE model_body_style (
    model_id INT NOT NULL,
    body_style VARCHAR(30) NOT NULL,
    PRIMARY KEY (model_id, body_style),
    FOREIGN KEY (model_id) REFERENCES model(model_id)
);

-- 4. option
CREATE TABLE `option` (
    option_id INT AUTO_INCREMENT PRIMARY KEY,
    color VARCHAR(30) NOT NULL,
    engine_type VARCHAR(50) NOT NULL,
    transmission_type VARCHAR(50) NOT NULL
);

-- 5. plant
CREATE TABLE plant (
    plant_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    location VARCHAR(100) NOT NULL
);

-- 6. dealer
CREATE TABLE dealer (
    dealer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(100) NOT NULL
);

-- 7. vehicle
CREATE TABLE vehicle (
    VIN VARCHAR(17) PRIMARY KEY, -- 국제 표준 차대번호 길이는 17자리
    manufacturing_date DATE NOT NULL,
    current_status VARCHAR(20) DEFAULT 'Inventory', -- 상태 기본값
    model_id INT NOT NULL,
    plant_id INT,
    assemble_date DATE,
    dealer_id INT,
    arrival_date DATE,
    FOREIGN KEY (model_id) REFERENCES model(model_id),
    FOREIGN KEY (plant_id) REFERENCES plant(plant_id),
    FOREIGN KEY (dealer_id) REFERENCES dealer(dealer_id)
);

-- 8. vehicle_option
CREATE TABLE vehicle_option (
    VIN VARCHAR(17) NOT NULL,
    option_id INT NOT NULL,
    PRIMARY KEY (VIN, option_id),
    FOREIGN KEY (VIN) REFERENCES vehicle(VIN),
    FOREIGN KEY (option_id) REFERENCES `option`(option_id)
);

-- 9. customer
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(100),
    phone VARCHAR(20),
    gender ENUM('Male', 'Female', 'Other'), -- ENUM을 통한 제약
    annual_income DECIMAL(12,2) CHECK (annual_income >= 0)
);

-- 10. sales
CREATE TABLE sales (
    sales_id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    sale_price DECIMAL(12,2) NOT NULL CHECK (sale_price >= 0),
    payment_method VARCHAR(30),
    VIN VARCHAR(17) NOT NULL UNIQUE, -- 차량 1대는 1번만 팔릴 수 있으므로 UNIQUE
    dealer_id INT NOT NULL,
    customer_id INT NOT NULL,
    FOREIGN KEY (VIN) REFERENCES vehicle(VIN),
    FOREIGN KEY (dealer_id) REFERENCES dealer(dealer_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- 11. supplier
CREATE TABLE supplier (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    contact_information VARCHAR(100)
);

-- 12. supplier_plant
CREATE TABLE supplier_plant (
    supplier_id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    location VARCHAR(100),
    PRIMARY KEY (supplier_id, name),
    FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id) ON DELETE CASCADE
);

-- 13. part
CREATE TABLE part (
    part_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- 14. produces_part (내부 생산)
CREATE TABLE produces_part (
    model_id INT NOT NULL,
    plant_id INT NOT NULL,
    part_id INT NOT NULL,
    produce_date DATE NOT NULL,
    PRIMARY KEY (model_id, plant_id, part_id),
    FOREIGN KEY (model_id) REFERENCES model(model_id),
    FOREIGN KEY (plant_id) REFERENCES plant(plant_id),
    FOREIGN KEY (part_id) REFERENCES part(part_id)
);

-- 15. supplies (외부 조달)
CREATE TABLE supplies (
    model_id INT NOT NULL,
    supplier_id INT NOT NULL,
    supplier_plant_name VARCHAR(50) NOT NULL,
    part_id INT NOT NULL,
    supply_date DATE NOT NULL,
    PRIMARY KEY (model_id, supplier_id, supplier_plant_name, part_id),
    FOREIGN KEY (model_id) REFERENCES model(model_id),
    FOREIGN KEY (supplier_id, supplier_plant_name) REFERENCES supplier_plant(supplier_id, name),
    FOREIGN KEY (part_id) REFERENCES part(part_id)
);

-- Query 1, 3, 4: 기간별(Date) 매출 조회를 위한 인덱스
CREATE INDEX idx_sales_date ON sales(date);

-- Query 2: 특정 기간의 부품 공급 기록 조회를 위한 인덱스
CREATE INDEX idx_supplies_date ON supplies(supply_date);

-- Query 5: 특정 바디 스타일(ex: convertible) 검색을 위한 인덱스
CREATE INDEX idx_body_style ON model_body_style(body_style);

DELIMITER //

CREATE TRIGGER after_sales_insert
AFTER INSERT ON sales
FOR EACH ROW
BEGIN
    -- 차량이 판매되면 vehicle 테이블의 current_status를 자동으로 'Sold'로 업데이트
    UPDATE vehicle 
    SET current_status = 'Sold' 
    WHERE VIN = NEW.VIN;
END; //

DELIMITER ;