USE auto_company;

-- 1. brand (20개)
INSERT INTO brand (name) VALUES 
('Toyota'), ('Ford'), ('Honda'), ('Chevrolet'), ('Nissan'), 
('BMW'), ('Mercedes-Benz'), ('Audi'), ('Hyundai'), ('Kia'), 
('Volkswagen'), ('Subaru'), ('Mazda'), ('Lexus'), ('Volvo'), 
('Porsche'), ('Jeep'), ('Tesla'), ('Albatross Motors'), ('Sogang Auto');

-- 2. model (20개)
INSERT INTO model (name, year, base_price, brand_id) VALUES 
('Camry', 2025, 25000.00, 1), ('Mustang', 2025, 30000.00, 2), 
('Civic', 2025, 22000.00, 3), ('Malibu', 2024, 23000.00, 4), 
('Altima', 2024, 24000.00, 5), ('X5', 2026, 60000.00, 6), 
('C-Class', 2025, 45000.00, 7), ('A4', 2026, 40000.00, 8), 
('Sonata', 2025, 24000.00, 9), ('K5', 2025, 24500.00, 10), 
('Golf', 2024, 23000.00, 11), ('Outback', 2025, 28000.00, 12), 
('CX-5', 2025, 27000.00, 13), ('RX', 2026, 50000.00, 14), 
('XC90', 2025, 55000.00, 15), ('911 Carrera', 2026, 105000.00, 16), 
('Wrangler', 2025, 35000.00, 17), ('Model 3', 2025, 40000.00, 18), 
('Nova', 2026, 52000.00, 19), ('T-Express', 2026, 38000.00, 20);

-- 3. model_body_style (20개) - Query 5 테스트를 위해 convertible 포함
INSERT INTO model_body_style (model_id, body_style) VALUES 
(1, 'Sedan'), (2, 'Coupe'), (2, 'convertible'), (3, 'Sedan'), (4, 'Sedan'), 
(5, 'Sedan'), (6, 'SUV'), (7, 'Sedan'), (7, 'convertible'), (8, 'Sedan'), 
(9, 'Sedan'), (10, 'Sedan'), (11, 'Hatchback'), (12, 'Wagon'), (13, 'SUV'), 
(14, 'SUV'), (15, 'SUV'), (16, 'Coupe'), (16, 'convertible'), (17, 'SUV');

-- 4. option (20개)
INSERT INTO `option` (color, engine_type, transmission_type) VALUES 
('Red', 'V6', 'Auto'), ('Blue', 'V4', 'Manual'), ('Black', 'V8', 'Auto'), 
('White', 'Electric', '1-Speed'), ('Silver', 'V4', 'Auto'), ('Grey', 'V6', 'Manual'), 
('Yellow', 'V8', 'Auto'), ('Green', 'Hybrid', 'CVT'), ('Red', 'V4', 'Auto'), 
('Blue', 'V6', 'Auto'), ('Black', 'Electric', '1-Speed'), ('White', 'V8', 'Manual'), 
('Silver', 'Hybrid', 'CVT'), ('Grey', 'V4', 'Manual'), ('Red', 'V6', 'Auto'), 
('Blue', 'V8', 'Auto'), ('Black', 'V4', 'CVT'), ('White', 'V6', 'Manual'), 
('Silver', 'V8', 'Auto'), ('Grey', 'Electric', '1-Speed');

-- 5. plant (20개)
INSERT INTO plant (name, location) VALUES 
('Seoul Plant 1', 'Mapo-gu, Seoul'), ('Seoul Plant 2', 'Gangnam-gu, Seoul'), 
('Busan Plant', 'Busan'), ('Incheon Plant', 'Incheon'), ('Daegu Plant', 'Daegu'),
('Gwangju Plant', 'Gwangju'), ('Daejeon Plant', 'Daejeon'), ('Ulsan Plant', 'Ulsan'), 
('Sejong Plant', 'Sejong'), ('Suwon Plant', 'Suwon'), ('Changwon Plant', 'Changwon'), 
('Goyang Plant', 'Goyang'), ('Yongin Plant', 'Yongin'), ('Cheongju Plant', 'Cheongju'), 
('Jeonju Plant', 'Jeonju'), ('Cheonan Plant', 'Cheonan'), ('Gimhae Plant', 'Gimhae'), 
('Pohang Plant', 'Pohang'), ('Jinju Plant', 'Jinju'), ('Jeju Plant', 'Jeju');

-- 6. dealer (20개)
INSERT INTO dealer (name, address) VALUES 
('Sinchon Motors', 'Sinchon-ro, Seoul'), ('Gangnam Auto', 'Gangnam-daero, Seoul'), 
('Busan Dealership', 'Haeundae, Busan'), ('Incheon Cars', 'Bupyeong, Incheon'), 
('Daegu Auto', 'Jung-gu, Daegu'), ('Gwangju Motors', 'Seo-gu, Gwangju'), 
('Daejeon Dealership', 'Yuseong-gu, Daejeon'), ('Ulsan Cars', 'Nam-gu, Ulsan'), 
('Sejong Auto', 'Sejong-si'), ('Suwon Motors', 'Paldal-gu, Suwon'), 
('Changwon Dealership', 'Seongsan-gu, Changwon'), ('Goyang Cars', 'Ilsan, Goyang'), 
('Yongin Auto', 'Giheung-gu, Yongin'), ('Cheongju Motors', 'Heungdeok-gu, Cheongju'), 
('Jeonju Dealership', 'Wansan-gu, Jeonju'), ('Cheonan Cars', 'Dongnam-gu, Cheonan'), 
('Gimhae Auto', 'Gimhae-si'), ('Pohang Motors', 'Nam-gu, Pohang'), 
('Jinju Dealership', 'Jinju-si'), ('Jeju Cars', 'Jeju-si');

-- 7. vehicle (20개) - VIN은 반드시 17자리
INSERT INTO vehicle (VIN, manufacturing_date, current_status, model_id, plant_id, assemble_date, dealer_id, arrival_date) VALUES 
('VIN00000000000001', '2024-01-10', 'Inventory', 1, 1, '2024-01-15', 1, '2024-01-20'),
('VIN00000000000002', '2024-02-11', 'Inventory', 2, 2, '2024-02-16', 2, '2024-02-21'),
('VIN00000000000003', '2024-03-12', 'Inventory', 3, 3, '2024-03-17', 3, '2024-03-22'),
('VIN00000000000004', '2024-04-13', 'Inventory', 4, 4, '2024-04-18', 4, '2024-04-23'),
('VIN00000000000005', '2024-05-14', 'Inventory', 5, 5, '2024-05-19', 5, '2024-05-24'),
('VIN00000000000006', '2024-06-15', 'Inventory', 6, 6, '2024-06-20', 6, '2024-06-25'),
('VIN00000000000007', '2024-07-16', 'Inventory', 7, 7, '2024-07-21', 7, '2024-07-26'),
('VIN00000000000008', '2024-08-17', 'Inventory', 8, 8, '2024-08-22', 8, '2024-08-27'),
('VIN00000000000009', '2024-09-18', 'Inventory', 9, 9, '2024-09-23', 9, '2024-09-28'),
('VIN00000000000010', '2024-10-19', 'Inventory', 10, 10, '2024-10-24', 10, '2024-10-29'),
('VIN00000000000011', '2025-01-20', 'Inventory', 11, 11, '2025-01-25', 11, '2025-01-30'),
('VIN00000000000012', '2025-02-21', 'Inventory', 12, 12, '2025-02-26', 12, '2025-03-02'),
('VIN00000000000013', '2025-03-22', 'Inventory', 13, 13, '2025-03-27', 13, '2025-04-01'),
('VIN00000000000014', '2025-04-23', 'Inventory', 14, 14, '2025-04-28', 14, '2025-05-03'),
('VIN00000000000015', '2025-05-24', 'Inventory', 15, 15, '2025-05-29', 15, '2025-06-03'),
('VIN00000000000016', '2025-06-25', 'Inventory', 16, 16, '2025-06-30', 16, '2025-07-05'),
('VIN00000000000017', '2025-07-26', 'Inventory', 17, 1, '2025-07-31', 17, '2025-08-05'),
('VIN00000000000018', '2026-01-27', 'Inventory', 18, 2, '2026-02-01', 18, '2026-02-06'),
('VIN00000000000019', '2026-02-28', 'Inventory', 19, 3, '2026-03-05', 19, '2026-03-10'),
('VIN00000000000020', '2026-03-01', 'Inventory', 20, 4, '2026-03-06', 20, '2026-03-11');

-- 8. vehicle_option (20개)
INSERT INTO vehicle_option (VIN, option_id) VALUES 
('VIN00000000000001', 1), ('VIN00000000000002', 2), ('VIN00000000000003', 3), 
('VIN00000000000004', 4), ('VIN00000000000005', 5), ('VIN00000000000006', 6), 
('VIN00000000000007', 7), ('VIN00000000000008', 8), ('VIN00000000000009', 9), 
('VIN00000000000010', 10), ('VIN00000000000011', 11), ('VIN00000000000012', 12), 
('VIN00000000000013', 13), ('VIN00000000000014', 14), ('VIN00000000000015', 15), 
('VIN00000000000016', 16), ('VIN00000000000017', 17), ('VIN00000000000018', 18), 
('VIN00000000000019', 19), ('VIN00000000000020', 20);

-- 9. customer (20개)
INSERT INTO customer (name, address, phone, gender, annual_income) VALUES 
('Yubin Jang', 'Mapo-gu, Seoul', '010-1234-5678', 'Female', 45000.00), 
('Seongwon Jeong', 'Gangnam-gu, Seoul', '010-2345-6789', 'Male', 120000.00), 
('Alice Smith', 'Busan', '010-3456-7890', 'Female', 35000.00), 
('Bob Johnson', 'Incheon', '010-4567-8901', 'Male', 55000.00), 
('Charlie Brown', 'Daegu', '010-5678-9012', 'Male', 42000.00), 
('Diana Prince', 'Gwangju', '010-6789-0123', 'Female', 85000.00), 
('Evan Wright', 'Daejeon', '010-7890-1234', 'Male', 28000.00), 
('Fiona Gallagher', 'Ulsan', '010-8901-2345', 'Female', 31000.00), 
('George Miller', 'Sejong', '010-9012-3456', 'Male', 95000.00), 
('Hannah Abbott', 'Suwon', '010-0123-4567', 'Female', 48000.00), 
('Ian Malcolm', 'Changwon', '010-1111-2222', 'Male', 72000.00), 
('Julia Roberts', 'Goyang', '010-2222-3333', 'Female', 61000.00), 
('Kevin Hart', 'Yongin', '010-3333-4444', 'Male', 39000.00), 
('Laura Dern', 'Cheongju', '010-4444-5555', 'Female', 53000.00), 
('Michael Scott', 'Jeonju', '010-5555-6666', 'Male', 46000.00), 
('Nancy Drew', 'Cheonan', '010-6666-7777', 'Female', 34000.00), 
('Oscar Isaac', 'Gimhae', '010-7777-8888', 'Male', 67000.00), 
('Pam Beesly', 'Pohang', '010-8888-9999', 'Female', 29000.00), 
('Quinn Fabray', 'Jinju', '010-9999-0000', 'Female', 78000.00), 
('Ryan Gosling', 'Jeju', '010-0000-1111', 'Male', 88000.00);

-- 10. sales (20개) - 데이터 삽입 시 트리거 작동(vehicle 상태 'Sold'로 변경)
INSERT INTO sales (date, sale_price, payment_method, VIN, dealer_id, customer_id) VALUES 
('2024-02-15', 26000.00, 'Credit', 'VIN00000000000001', 1, 1),
('2024-03-20', 31000.00, 'Cash', 'VIN00000000000002', 2, 2),
('2024-04-10', 23000.00, 'Lease', 'VIN00000000000003', 3, 3),
('2024-05-05', 24000.00, 'Credit', 'VIN00000000000004', 4, 4),
('2024-06-18', 25000.00, 'Cash', 'VIN00000000000005', 5, 5),
('2024-07-22', 62000.00, 'Credit', 'VIN00000000000006', 6, 6),
('2024-08-30', 46000.00, 'Lease', 'VIN00000000000007', 7, 7),
('2024-09-15', 41000.00, 'Credit', 'VIN00000000000008', 8, 8),
('2024-10-10', 25000.00, 'Cash', 'VIN00000000000009', 9, 9),
('2024-11-05', 25500.00, 'Credit', 'VIN00000000000010', 10, 10),
('2025-02-15', 24000.00, 'Lease', 'VIN00000000000011', 11, 11),
('2025-03-20', 29000.00, 'Credit', 'VIN00000000000012', 12, 12),
('2025-04-10', 28000.00, 'Cash', 'VIN00000000000013', 13, 13),
('2025-05-05', 52000.00, 'Credit', 'VIN00000000000014', 14, 14),
('2025-06-18', 56000.00, 'Lease', 'VIN00000000000015', 15, 15),
('2025-08-22', 106000.00, 'Credit', 'VIN00000000000016', 16, 16),
('2025-09-15', 36000.00, 'Cash', 'VIN00000000000017', 17, 17),
('2026-03-01', 41000.00, 'Credit', 'VIN00000000000018', 18, 18),
('2026-04-10', 53000.00, 'Lease', 'VIN00000000000019', 19, 19),
('2026-05-05', 39000.00, 'Credit', 'VIN00000000000020', 20, 20);

-- 11. supplier (20개) - Query 2 테스트를 위해 Getrag 포함
INSERT INTO supplier (name, contact_information) VALUES 
('Getrag', 'contact@getrag.com'), ('Bosch', 'bosch@bosch.com'), 
('Denso', 'denso@denso.com'), ('Magna', 'info@magna.com'), 
('Aisin', 'contact@aisin.com'), ('Continental', 'info@continental.com'), 
('ZF Friedrichshafen', 'zf@zf.com'), ('Valeo', 'valeo@valeo.com'), 
('Lear', 'lear@lear.com'), ('Faurecia', 'faurecia@faurecia.com'), 
('Hyundai Mobis', 'mobis@mobis.com'), ('Mando', 'mando@mando.com'), 
('HL Klemove', 'klemove@hl.com'), ('LG Innotek', 'innotek@lg.com'), 
('Samsung SDI', 'sdi@samsung.com'), ('SK On', 'skon@sk.com'), 
('Pirelli', 'pirelli@pirelli.com'), ('Michelin', 'michelin@michelin.com'), 
('Bridgestone', 'bridgestone@bridgestone.com'), ('Hankook', 'hankook@hankook.com');

-- 12. supplier_plant (20개) - Query 2 테스트를 위해 Getrag_Plant_1 포함
INSERT INTO supplier_plant (supplier_id, name, location) VALUES 
(1, 'Getrag_Plant_1', 'Germany'), (1, 'Getrag_Plant_2', 'USA'), 
(2, 'Bosch_Plant_A', 'Germany'), (3, 'Denso_Plant_1', 'Japan'), 
(4, 'Magna_Plant_1', 'Canada'), (5, 'Aisin_Plant_A', 'Japan'), 
(6, 'Conti_Plant', 'Germany'), (7, 'ZF_Plant_1', 'Germany'), 
(8, 'Valeo_Plant', 'France'), (9, 'Lear_Plant', 'USA'), 
(10, 'Faurecia_Plant', 'France'), (11, 'Mobis_Ulsan', 'Ulsan, Korea'), 
(12, 'Mando_Pyeongtaek', 'Pyeongtaek, Korea'), (13, 'HL_Plant', 'Korea'), 
(14, 'LG_Plant', 'Gumi, Korea'), (15, 'SDI_Plant', 'Cheonan, Korea'), 
(16, 'SK_Plant', 'Seosan, Korea'), (17, 'Pirelli_Plant', 'Italy'), 
(18, 'Michelin_Plant', 'France'), (19, 'Bridgestone_Plant', 'Japan');

-- 13. part (20개) - Query 2 테스트를 위해 transmission 포함
INSERT INTO part (name) VALUES 
('transmission'), ('Engine Block'), ('Brake Caliper'), ('Suspension Spring'), 
('Exhaust Pipe'), ('Battery Pack'), ('Alternator'), ('Radiator'), 
('Clutch Kit'), ('Drive Axle'), ('Steering Wheel'), ('Airbag Module'), 
('Leather Seat'), ('Windshield Glass'), ('LED Headlight'), ('Taillight Assembly'), 
('Front Bumper'), ('Rearview Mirror'), ('All-Season Tire'), ('Alloy Wheel');

-- 14. produces_part (20개)
INSERT INTO produces_part (model_id, plant_id, part_id, produce_date) VALUES 
(1, 1, 2, '2023-11-01'), (2, 2, 3, '2023-11-02'), (3, 3, 4, '2023-11-03'), 
(4, 4, 5, '2023-11-04'), (5, 5, 6, '2023-11-05'), (6, 6, 7, '2023-11-06'), 
(7, 7, 8, '2023-11-07'), (8, 8, 9, '2023-11-08'), (9, 9, 10, '2023-11-09'), 
(10, 10, 11, '2023-11-10'), (11, 11, 12, '2023-11-11'), (12, 12, 13, '2023-11-12'), 
(13, 13, 14, '2023-11-13'), (14, 14, 15, '2023-11-14'), (15, 15, 16, '2023-11-15'), 
(16, 16, 17, '2023-11-16'), (17, 17, 18, '2023-11-17'), (18, 18, 19, '2023-11-18'), 
(19, 19, 20, '2023-11-19'), (20, 20, 1, '2023-11-20');

-- 15. supplies (20개) - Query 2 로직 검증(Getrag_Plant_1에서 2023~2024 사이 공급)
INSERT INTO supplies (model_id, supplier_id, supplier_plant_name, part_id, supply_date) VALUES 
(1, 1, 'Getrag_Plant_1', 1, '2023-12-01'), 
(2, 1, 'Getrag_Plant_1', 1, '2024-01-15'), 
(3, 2, 'Bosch_Plant_A', 3, '2023-12-03'), 
(4, 3, 'Denso_Plant_1', 7, '2023-12-04'), 
(5, 4, 'Magna_Plant_1', 18, '2023-12-05'), 
(6, 5, 'Aisin_Plant_A', 1, '2023-12-06'), 
(7, 6, 'Conti_Plant', 19, '2023-12-07'), 
(8, 7, 'ZF_Plant_1', 1, '2023-12-08'), 
(9, 8, 'Valeo_Plant', 15, '2023-12-09'), 
(10, 9, 'Lear_Plant', 13, '2023-12-10'), 
(11, 10, 'Faurecia_Plant', 5, '2023-12-11'), 
(12, 11, 'Mobis_Ulsan', 12, '2023-12-12'), 
(13, 12, 'Mando_Pyeongtaek', 3, '2023-12-13'), 
(14, 13, 'HL_Plant', 11, '2023-12-14'), 
(15, 14, 'LG_Plant', 15, '2023-12-15'), 
(16, 15, 'SDI_Plant', 6, '2023-12-16'), 
(17, 16, 'SK_Plant', 6, '2023-12-17'), 
(18, 17, 'Pirelli_Plant', 19, '2023-12-18'), 
(19, 18, 'Michelin_Plant', 19, '2023-12-19'), 
(20, 19, 'Bridgestone_Plant', 19, '2023-12-20');