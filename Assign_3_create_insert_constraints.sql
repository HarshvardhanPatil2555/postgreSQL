-----------------------------------------------------------------------------
1st create_table suppliers :-

CREATE TABLE suppliers(
supplier_id SERIAL PRIMARY KEY,
supplier_name VARCHAR(150)NOT NULL,
contact_person VARCHAR(100)NOT NULL,
phone_number VARCHAR(20) NOT NULL,
email VARCHAR(150) UNIQUE NOT NULL,
country VARCHAR(100) NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO suppliers(supplier_name,contact_person,phone_number,email,country) VALUES
('Supplier 1', 'Contact 1', '+91-9619-216739', 'supplier1@example.com', 'India'),
('Supplier 5', 'Contact 5', '+91-7122-198246', 'supplier5@example.com', 'India'),
('Supplier 2', 'Contact 2', '+91-8003-334053', 'supplier2@example.com', 'India'),
('Supplier 3', 'Contact 3', '+91-9771-876646', 'supplier3@example.com', 'India'),
('Supplier 4', 'Contact 4', '+91-7356-719176', 'supplier4@example.com', 'India');

SELECT * FROM suppliers;
-------------------------------------------------------------------------------
2nd create_table warehouses :-

CREATE TABLE warehouses(
warehouse_id SERIAL PRIMARY KEY,
warehouse_name VARCHAR(150) NOT NULL,
city VARCHAR(100) NOT NULL,
state VARCHAR(100),
country VARCHAR(100) NOT NULL,
capacity_units INT NOT NULL CHECK(capacity_units>= 0),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO warehouses
(warehouse_name, city, state, country, capacity_units)
VALUES
('Warehouse 1', 'Pune', 'Maharashtra', 'India', 1000),
('Warehouse 2', 'Mumbai', 'Maharashtra', 'India', 1500),
('Warehouse 3', 'Nashik', 'Maharashtra', 'India', 1200),
('Warehouse 4', 'Nagpur', 'Maharashtra', 'India', 1800),
('Warehouse 5', 'Aurangabad', 'Maharashtra', 'India', 2000);

SELECT * FROM warehouses;
-----------------------------------------------------------------------------
3nd create_table customers :-

CREATE TABLE customers(
customer_id SERIAL PRIMARY KEY,
customer_name VARCHAR(150) NOT NULL,
phone_number VARCHAR(20),
email VARCHAR(150) NOT NULL UNIQUE,
city VARCHAR(100),
country VARCHAR(100) NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO customers
(customer_name, phone_number, email, city, country)
VALUES
('Customer 1', '+91-8839-717889', 'customer1@example.com', 'Pune', 'India'),
('Customer 2', '+91-7653-832052', 'customer2@example.com', 'Mumbai', 'India'),
('Customer 3', '+91-8138-263032', 'customer3@example.com', 'Thane', 'India'),
('Customer 4', '+91-7418-197251', 'customer4@example.com', 'Satara', 'India'),
('Customer 5', '+91-8470-988662', 'customer5@example.com', 'Kolhapur', 'India');

SELECT * FROM customers;
-----------------------------------------------------------------------------
4th create_table purchase_orders :-

CREATE TABLE purchase_orders(
po_id SERIAL PRIMARY KEY,
supplier_id INT NOT NULL,
po_date DATE NOT NULL,
expected_date DATE CHECK (expected_date IS NULL OR expected_date >= po_date),
status VARCHAR(50) NOT NULL DEFAULT 'PENDING',
total_amount NUMERIC(12,2) NOT NULL DEFAULT 0.00  CHECK (total_amount >= 0),
FOREIGN KEY (supplier_id)
REFERENCES suppliers(supplier_id),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO purchase_orders
(po_id,supplier_id, po_date, expected_date, status, total_amount)
VALUES
(1,1, '2025-11-18', '2025-11-21', 'Open', 12500.00),
(2,2, '2025-11-09', '2025-11-13', 'Approved', 8900.50),
(3,3, '2025-11-09', '2025-11-16', 'Received', 15420.75),
(4,4, '2025-11-15', '2025-11-27', 'Closed', 6100.00),
(5,5, '2025-11-25', '2025-12-08', 'Cancelled', 3000.25);

SELECT * FROM purchase_orders;
-----------------------------------------------------------------------------
5th create_table purchase_order_items :-

CREATE TABLE purchase_order_items(
po_item_id SERIAL PRIMARY KEY,
po_id INT NOT NULL,
product_id INT NOT NULL,
quantity INT NOT NULL DEFAULT 1 CHECK (quantity > 0),
unit_price NUMERIC(10,2) NOT NULL CHECK(unit_price >= 0),
CONSTRAINT uq_po_product UNIQUE (po_id, product_id),
FOREIGN KEY (po_id)
	REFERENCES purchase_orders(po_id),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO purchase_order_items
(po_id,product_id, quantity, unit_price)
VALUES
(1, 101, 10, 250.00),
(1, 102, 5, 500.00),
(2, 101, 12, 200.00),
(3, 103, 7, 350.00),
(4, 104, 3, 1000.00);

SELECT * FROM purchase_order_items;
-----------------------------------------------------------------------------
6th create_table inventory :-

CREATE TABLE inventory(
nventory_id SERIAL PRIMARY KEY,
warehouse_id INT NOT NULL,
product_id INT NOT NULL,
quantity_on_hand INT NOT NULL DEFAULT'0' CHECK( quantity_on_hand >= 0),
reorder_level INT NOT NULL DEFAULT'10' CHECK( reorder_level >= 0),
CONSTRAINT uq_inventory UNIQUE (warehouse_id, product_id),
FOREIGN KEY (warehouse_id)
		REFERENCES warehouses(warehouse_id),
last_updated TIMESTAMP
);

INSERT INTO inventory
(warehouse_id, product_id, quantity_on_hand, reorder_level, last_updated)
VALUES
(1, 101, 50, 20, '2025-12-06 01:34:22'),
(2, 102, 30, 15, '2025-12-06 09:36:23'),
(3, 103, 70, 25, '2025-12-09 11:01:22'),
(4, 104, 20, 10, '2025-12-08 13:45:12'),
(5, 105, 90, 30, '2025-12-08 03:15:05');

SELECT * FROM inventory;
-----------------------------------------------------------------------------
7th create_table sales_orders :-

CREATE TABLE sales_orders(
sales_order_id SERIAL PRIMARY KEY,
customer_id INT NOT NULL,
order_date DATE NOT NULL,
status VARCHAR(50)NOT NULL DEFAULT 'PENDING',
total_amount NUMERIC(12,2) NOT NULL DEFAULT '0.00' CHECK( total_amount >= 0),
FOREIGN KEY  (customer_id)
	REFERENCES customers(customer_id),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO sales_orders
(customer_id, order_date, status, total_amount)
VALUES
(1, '2025-12-04', 'Pending',   3200.50),
(2, '2025-12-01', 'Confirmed', 4500.00),
(3, '2025-12-01', 'Shipped',   2100.75),
(4, '2025-12-08', 'Delivered',  980.00),
(5, '2025-12-05', 'Cancelled', 1500.00);

SELECT * FROM sales_orders;
-----------------------------------------------------------------------------
8th create_table sales_order_items :-

CREATE TABLE sales_order_items(
so_item_id SERIAL PRIMARY KEY,
sales_order_id INT NOT NULL,
product_id INT NOT NULL,
quantity INT NOT NULL CHECK (quantity > 0),
unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0),
CONSTRAINT uq_sales UNIQUE (sales_order_id, product_id),
FOREIGN KEY ( sales_order_id )
	REFERENCES sales_orders(sales_order_id),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO sales_order_items
(sales_order_id, product_id, quantity, unit_price)
VALUES
(1, 101, 2, 1600.00),
(1, 102, 1, 4500.00),
(2, 103, 3, 700.25),
(3, 104, 4, 245.00),
(4, 105, 5, 300.00);

SELECT * FROM sales_order_items;
-----------------------------------------------------------------------------
9th create_table shipments:-

CREATE TABLE shipments(
shipment_id SERIAL PRIMARY KEY,
sales_order_id INT NOT NULL,
warehouse_id INT NOT NULL,
shipment_date DATE NOT NULL,
delivery_date DATE CHECK( delivery_date IS NULL OR delivery_date >= shipment_date),
shipment_status VARCHAR(50) NOT NULL DEFAULT 'CREATED',
tracking_number VARCHAR(100) UNIQUE,
FOREIGN KEY ( sales_order_id )
	REFERENCES sales_orders(sales_order_id),
FOREIGN KEY ( warehouse_id )
	REFERENCES warehouses(warehouse_id),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO shipments
(sales_order_id, warehouse_id, shipment_date, delivery_date, shipment_status, tracking_number)
VALUES
(1, 1, '2025-12-07', '2025-12-10', 'Processing', 'TRK10001'),
(2, 2, '2025-12-06', '2025-12-11', 'In Transit', 'TRK10002'),
(3, 2, '2025-12-06', '2025-12-13', 'Delivered',  'TRK10003'),
(4, 3, '2025-12-10', '2025-12-19', 'Delayed',    'TRK10004'),
(5, 4, '2025-12-12', '2025-12-13', 'Returned',   'TRK10005');

SELECT * FROM shipments;