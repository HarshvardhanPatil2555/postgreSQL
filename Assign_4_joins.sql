===========================================================================================================================================
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

Q4: FULL OUTER JOIN
Show all suppliers and all warehouses together. Include suppliers without warehouses and warehouses without
suppliers.
-->
SELECT s.supplier_name,warehouse_name
FROM suppliers AS s
FULL OUTER JOIN warehouses AS w
ON s.supplier_id = w.warehouse_id
;

Q9: LEFT JOIN
Show all suppliers and the purchase orders linked to them. Include suppliers with no purchase orders.
-->
SELECT s.supplier_name,po_id,status
FROM suppliers AS s
LEFT JOIN purchase_orders AS po
ON s.supplier_id  = po.supplier_id
;

SELECT * FROM suppliers;
===========================================================================================================================================
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

Q6: LEFT JOIN
Show all warehouses and the inventory stored in them. Include warehouses with no inventory.
-->
SELECT w.warehouse_name,product_id,quantity_on_hand
FROM warehouses AS w
LEFT JOIN inventory AS i
ON w.warehouse_id = i.warehouse_id
;

Q10: RIGHT JOIN
Show all warehouses and any inventory linked to them. Include warehouses even if inventory is missing.
-->
SELECT w.warehouse_name,product_id
FROM warehouses AS w
RIGHT JOIN inventory AS i
ON w.warehouse_id = i.warehouse_id
;

Q18: RIGHT JOIN
Show all warehouses and the shipment status of orders shipped from them. Include warehouses with no shipments
-->
SELECT w.warehouse_name,sh.shipment_status
FROM warehouses AS w
RIGHT JOIN shipments AS sh
ON w.warehouse_id = sh.warehouse_id
;

SELECT * FROM warehouses;
===========================================================================================================================================
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

Q2: LEFT JOIN
Show all customers and any sales orders they have placed. Include customers who have not placed any orders.
-->
SELECT c.customer_name,sales_order_id,order_date
FROM customers AS c
LEFT JOIN sales_orders AS so
ON c.customer_id = so.customer_id
;

Q8: INNER JOIN
Show each customer along with the products they ordered and the quantity.
-->
SELECT c.customer_name,product_id,quantity
FROM customers AS c
INNER JOIN purchase_order_items AS poi
ON c.customer_id = c.customer_id
;

Q11: FULL OUTER JOIN
Show all customers and all suppliers together. Include unmatched rows from both sides
-->
SELECT c.customer_name,supplier_name
FROM customers AS c
FULL OUTER JOIN suppliers AS s
ON c.customer_id = s.supplier_id
;

Q17: LEFT JOIN
Show all customers and the shipment status of their orders. Include customers without shipments.
-->
SELECT c.customer_name,sh.shipment_status
FROM customers AS c
LEFT JOIN shipments AS sh
ON c.customer_id = sh.sales_order_id
;

SELECT * FROM customers;
===========================================================================================================================================
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

Q1: INNER JOIN
Show all purchase orders along with the supplier name who provided them.
-->
SELECT p.po_id,p.po_date,p.status,supplier_name
FROM purchase_orders AS p
INNER JOIN suppliers AS s
ON p.supplier_id = s.supplier_id
;

Q7: FULL OUTER JOIN
Show all purchase orders and all purchase order items together. Include orders without items and items without
orders.
-->
SELECT po.po_id,po_item_id
FROM purchase_orders AS po
FULL OUTER JOIN purchase_order_items AS poi
ON po.po_id = poi.po_id
;

Q14: RIGHT JOIN
Show all purchase orders and the supplier names. Include orders even if supplier info is missing
-->
SELECT po.po_id,supplier_name
FROM purchase_orders AS po
RIGHT JOIN suppliers AS s
ON po.supplier_id = s.supplier_id
;

SELECT * FROM purchase_orders;
===========================================================================================================================================
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

Q20: INNER JOIN
Show all purchase order items along with the purchase order details (order date and status)
-->
SELECT poi.po_item_id,po.po_id,po.po_date,po.status
FROM purchase_order_items AS poi
INNER JOIN purchase_orders AS po
ON poi.po_id = po.po_id
;

SELECT * FROM purchase_order_items;
===========================================================================================================================================
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

Q16: INNER JOIN
Show inventory details along with the purchase order item price for the same product
-->
SELECT i.product_id,unit_price
FROM inventory AS i
INNER JOIN purchase_order_items AS poi
ON i.product_id = poi.product_id
;

Q19: FULL OUTER JOIN
Show all inventory items and all sales order items together. Include unmatched rows from both sides
-->
SELECT i.product_id,soi.quantity
FROM inventory AS i
FULL OUTER JOIN sales_order_items AS soi
ON i.product_id = soi.product_id
;

SELECT * FROM inventory;
===========================================================================================================================================
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

Q3: RIGHT JOIN
Show all sales orders and the name of the customer who placed them. Include orders even if customer info is
missing.
-->
SELECT so.sales_order_id,so.order_date,customer_name
FROM sales_orders AS so
RIGHT JOIN customers AS c
ON so.customer_id = c.customer_id
;

Q5: INNER JOIN
Show each sales order along with its shipment details (shipment date and status)
-->
SELECT so.sales_order_id,so.order_date,shipment_date,shipment_status
FROM sales_orders AS so
INNER JOIN shipments AS sh
ON so.sales_order_id = sh.sales_order_id 
;

Q13: LEFT JOIN
Show all sales orders and their shipment dates. Include orders that have not been shipped yet.
-->
SELECT so.sales_order_id,shipment_date
FROM sales_orders AS so
LEFT JOIN shipments AS sh
ON so.sales_order_id = sh.sales_order_id
;

Q15: FULL OUTER JOIN
Show all sales orders and all purchase orders together. Include unmatched rows from both sides
-->
SELECT so.sales_order_id,po_id
FROM sales_orders AS so
FULL OUTER JOIN purchase_orders AS po
ON so.sales_order_id = po.po_id
;

SELECT * FROM sales_orders;
===========================================================================================================================================
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
===========================================================================================================================================
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

Q12: INNER JOIN
Show all shipments along with the warehouse name from which they were shipped
-->
SELECT sh.shipment_id,warehouse_name,sh.shipment_status
FROM shipments AS sh
INNER JOIN warehouses AS w
ON sh.warehouse_id = w.warehouse_id
;

SELECT * FROM shipments;
===========================================================================================================================================