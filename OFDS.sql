#0.
drop database if exists online_food ;
create database if not exists online_food ;
use online_food ; 

#1.
CREATE TABLE IF NOT EXISTS orders (
order_id int PRIMARY KEY,
Date DATE NOT NULL);



#2.
CREATE TABLE IF NOT EXISTS items (
item_id int PRIMARY KEY,
restaurant_id int NOT NULL,
restaurant_loc VARCHAR(100) NOT NULL,
food_price int NOT NULL,
item_ordered VARCHAR(100) NOT NULL,
time TIME NOT NULL );



#3.
CREATE TABLE IF NOT EXISTS partner_delivery (
delivery_partner CHAR(50) NOT NULL,
partner_id VARCHAR(20) PRIMARY KEY);
#FOREIGN KEY (partner_id) REFERENCES order_items (partner_id));



#4.
CREATE TABLE IF NOT EXISTS order_items (
order_id int NOT NULL,
item_id int NOT NULL,
partner_id VARCHAR(20) NOT NULL,
customer_id VARCHAR(20) NOT NULL,
FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
FOREIGN KEY (partner_id) REFERENCES partner_delivery (partner_id),
FOREIGN KEY (item_id) REFERENCES items (item_id),
FOREIGN KEY (order_id) REFERENCES orders (order_id),
PRIMARY KEY (order_id, item_id) );



#5.
CREATE TABLE IF NOT EXISTS customers (
customer_id VARCHAR(20) PRIMARY KEY,
customer_name CHAR(50) NOT NULL,
phone int NOT NULL );



show tables ;
###########################################
#Roles:
# dba: Yog Raj Singh 	
# admin: Yogesh Sachdeva								c
# restaurant: Akhil Khosla							
# customer: Manyata Manocha
# delivery_partner: Dhruv Sharma

#Users Creation
CREATE USER 'yograj'@'localhost' IDENTIFIED BY 'yograj' ;
CREATE USER 'yogesh'@'localhost' IDENTIFIED BY 'yogesh' ;
CREATE USER 'manyata'@'localhost' IDENTIFIED BY 'manyata' ;
CREATE USER 'dhruv'@'localhost' IDENTIFIED BY 'dhruv' ;
CREATE USER 'akhil'@'localhost' IDENTIFIED BY 'akhil' ;

# delivery_partner
grant  select  on  online_food.partner_delivery  to  'dhruv'@'localhost'  ;
grant  select  on  online_food.items to 'dhruv'@'localhost'  ;


#dba
GRANT create,drop, select ON online_food.*  TO 'yograj'@'localhost' with grant option ;

#admin
GRANT select, insert, update, delete ON online_food.*  TO 'yogesh'@'localhost' ;

#restaurant
GRANT select ON online_food.order_items TO 'akhil'@'localhost' ;
GRANT insert, update, delete ON online_food.items TO 'akhil'@'localhost' ;

#customer
GRANT select ON online_food.customers TO 'manyata'@'localhost' ;
GRANT select ON online_food.orders TO 'manyata'@'localhost' ;
GRANT select ON online_food.order_items TO 'manyata'@'localhost' ;
GRANT select ON online_food.items TO 'manyata'@'localhost' ;