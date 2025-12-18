-----------------------------------------------------------------------------
1st create_table suppliers :-

CREATE TABLE suppliers(
supplier_id SERIAL,
supplier_name VARCHAR(150),
contact_person VARCHAR(100),
phone_number VARCHAR(20),
email VARCHAR(150),
country VARCHAR(100),
created_at TIMESTAMP
);

SELECT * FROM suppliers;
-------------------------------------------------------------------------------
2nd create_table warehouses :-

CREATE TABLE warehouses(
warehouse_id SERIAL,
warehouse_name VARCHAR(150),
city VARCHAR(100),
state VARCHAR(100),
country VARCHAR(100),
capacity_units INT,
created_at TIMESTAMP
);

SELECT * FROM warehouses;
-----------------------------------------------------------------------------
3nd create_table customers :-

CREATE TABLE customers(
customer_id SERIAL,
customer_name VARCHAR(150),
phone_number VARCHAR(20),
email VARCHAR(150),
city VARCHAR(100),
country VARCHAR(100),
created_at TIMESTAMP
);

SELECT * FROM customers;
-----------------------------------------------------------------------------
4th create_table purchase_orders :-

CREATE TABLE purchase_orders(
po_id SERIAL,
supplier_id INT,
po_date DATE,
expected_date DATE,
status VARCHAR(50),
total_amount NUMERIC(12,2),
created_at TIMESTAMP
);

SELECT * FROM purchase_orders;
-----------------------------------------------------------------------------
5th create_table purchase_order_items :-

CREATE TABLE purchase_order_items(
po_item_id SERIAL,
po_id INT,
product_id INT,
quantity INT,
unit_price NUMERIC(10,2),
created_at TIMESTAMP
);

SELECT * FROM purchase_order_items;
-----------------------------------------------------------------------------
6th create_table inventory :-

CREATE TABLE inventory(
nventory_id SERIAL,
warehouse_id INT,
product_id INT,
quantity_on_hand INT,
reorder_level INT,
last_updated TIMESTAMP
);

SELECT * FROM inventory;
-----------------------------------------------------------------------------
7th create_table sales_orders :-

CREATE TABLE sales_orders(
sales_order_id SERIAL,
customer_id INT,
order_date DATE,
status VARCHAR(50),
total_amount NUMERIC(12,2),
created_at TIMESTAMP
);

SELECT * FROM sales_orders;
-----------------------------------------------------------------------------
8th create_table sales_order_items :-

CREATE TABLE sales_order_items(
so_item_id SERIAL,
sales_order_id INT,
product_id INT,
quantity INT,
unit_price NUMERIC(10,2),
created_at TIMESTAMP
);

SELECT * FROM sales_order_items;
-----------------------------------------------------------------------------
9th create_table shipments:-

CREATE TABLE shipments(
shipment_id SERIAL,
sales_order_id INT,
warehouse_id INT,
shipment_date DATE,
delivery_date DATE,
shipment_status VARCHAR(50),
tracking_number VARCHAR(100),
created_at TIMESTAMP
);

SELECT * FROM shipments;