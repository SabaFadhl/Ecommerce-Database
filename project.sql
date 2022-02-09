-- Data base--
DROP DATABASE IF EXISTS saba;
CREATE DATABASE saba;
USE saba;
-- tables---------------------------------------------
DROP TABLE IF EXISTS addresses;
CREATE TABLE IF NOT EXISTS addresses (
  id int(11) NOT NULL AUTO_INCREMENT,
  first_name varchar(45) NOT NULL,
  last_name varchar(45) NOT NULL,
  phone varchar(9) NOT NULL,
  type tinyint(1) DEFAULT '1',
  location_map text,
  locations_id int(11) NOT NULL,
  users_id int(11) NOT NULL,
  description text NOT NULL,
  PRIMARY KEY (id)
) ;

DROP TABLE IF EXISTS categories;
CREATE TABLE IF NOT EXISTS categories (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(45) DEFAULT NULL,
  add_date date DEFAULT NULL,
  activation tinyint(4) DEFAULT '0',
  PRIMARY KEY (id)
) ;


DROP TABLE IF EXISTS comments;
CREATE TABLE IF NOT EXISTS comments (
  id int(11) NOT NULL AUTO_INCREMENT,
  products_id int(11) NOT NULL,
  users_id int(11) NOT NULL,
  comment text,
  add_date date DEFAULT NULL,
  activation tinyint(4) DEFAULT '1',
  PRIMARY KEY (id)
) ;

DROP TABLE IF EXISTS evaluations;
CREATE TABLE IF NOT EXISTS evaluations (
  products_id int(11) NOT NULL,
  users_id int(11) NOT NULL,
  evaluation float DEFAULT '0',
  PRIMARY KEY (products_id,users_id)
) ;

DROP TABLE IF EXISTS images;
CREATE TABLE IF NOT EXISTS images (
  id int(11) NOT NULL AUTO_INCREMENT,
  image_name varchar(255) NOT NULL,
  products_id int(11) NOT NULL,
  PRIMARY KEY (id)
) ;

DROP TABLE IF EXISTS locations;
CREATE TABLE IF NOT EXISTS locations (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(45) DEFAULT NULL,
  level tinyint(1) DEFAULT NULL,
  parent int(11) DEFAULT NULL,
  PRIMARY KEY (id)
) ;

DROP TABLE IF EXISTS messages;
CREATE TABLE IF NOT EXISTS messages (
  id int(11) NOT NULL AUTO_INCREMENT,
  message varchar(45) DEFAULT NULL,
  users_id int(11) NOT NULL,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS offers;
CREATE TABLE IF NOT EXISTS offers (
  id int(11) NOT NULL AUTO_INCREMENT,
  products_id int(11) NOT NULL,
  start_date date NOT NULL,
  end_date date NOT NULL,
  new_price float NOT NULL,
  PRIMARY KEY (id)
) ;


DROP TABLE IF EXISTS orders;
CREATE TABLE IF NOT EXISTS orders (
  id int(11) NOT NULL AUTO_INCREMENT,
  users_id int(11) NOT NULL,
  products_id int(11) NOT NULL,
  add_date date NOT NULL,
  date_deliver date DEFAULT NULL,
  amount int(11) NOT NULL,
  description text,
  role tinyint(1) NOT NULL DEFAULT '1',
  sale_date date DEFAULT NULL,
  PRIMARY KEY (id)
) ;

DROP TABLE IF EXISTS products;
CREATE TABLE IF NOT EXISTS products (
  id int(11) NOT NULL AUTO_INCREMENT,
  users_id int(11) NOT NULL,
  categories_id int(11) NOT NULL,
  name varchar(45) NOT NULL,
  description text,
  activation tinyint(4) DEFAULT NULL,
  price float NOT NULL,
  add_date date NOT NULL,
  period int(11) NOT NULL,
  PRIMARY KEY (id) USING BTREE
) ;

DROP TABLE IF EXISTS properties;
CREATE TABLE IF NOT EXISTS properties (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(45) NOT NULL,
  value varchar(45) NOT NULL,
  type tinyint(1) NOT NULL,
  new tinyint(1) DEFAULT '1',
  PRIMARY KEY (id),
  UNIQUE KEY value_UNIQUE (value)
) ;

DROP TABLE IF EXISTS used_properties;
CREATE TABLE IF NOT EXISTS used_properties (
  properties_id int(11) NOT NULL,
  products_id int(11) NOT NULL,
  default_prop tinyint(1) DEFAULT NULL
) ;

DROP TABLE IF EXISTS users;
CREATE TABLE IF NOT EXISTS users (
  id int(11) NOT NULL AUTO_INCREMENT,
  first_name varchar(45) NOT NULL,
  last_name varchar(45) NOT NULL,
  email varchar(255) NOT NULL,
  image_name varchar(255) DEFAULT 'profile',
  password text NOT NULL,
  reset varchar(10) DEFAULT NULL,
  role tinyint(1) NOT NULL,
  activation tinyint(4) DEFAULT '0',
  add_date date DEFAULT NULL,
  phone varchar(9) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY email_UNIQUE (email),
  UNIQUE KEY phone_UNIQUE (phone)
);
-- ----------------------------------------------------------------
-- Constraint ---------------------------------------------------------------------

ALTER TABLE addresses
  ADD CONSTRAINT fk_addresses_locations1 FOREIGN KEY (locations_id) REFERENCES locations (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_addresses_users1 FOREIGN KEY (users_id) REFERENCES users (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE comments
  ADD CONSTRAINT fk_comments_products1 FOREIGN KEY (products_id) REFERENCES products (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_comments_users1 FOREIGN KEY (users_id) REFERENCES users (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE evaluations
  ADD CONSTRAINT fk_products_has_users_products1 FOREIGN KEY (products_id) REFERENCES products (id) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT fk_products_has_users_users1 FOREIGN KEY (users_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE images
  ADD CONSTRAINT fk_images_products1 FOREIGN KEY (products_id) REFERENCES products (id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE locations
  ADD CONSTRAINT fk_locations_locations1 FOREIGN KEY (parent) REFERENCES locations (id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE messages
  ADD CONSTRAINT fk_messages_users1 FOREIGN KEY (users_id) REFERENCES users (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE offers
  ADD CONSTRAINT offers_ibfk_1 FOREIGN KEY (products_id) REFERENCES products (id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE orders
  ADD CONSTRAINT fk_users_has_products_products2 FOREIGN KEY (products_id) REFERENCES products (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_users_has_products_users1 FOREIGN KEY (users_id) REFERENCES users (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE products
  ADD CONSTRAINT fk_products_users1 FOREIGN KEY (users_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT products_ibfk_1 FOREIGN KEY (categories_id) REFERENCES categories (id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE used_properties
  ADD CONSTRAINT fk_properties_has_products_products1 FOREIGN KEY (products_id) REFERENCES products (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_properties_has_products_properties1 FOREIGN KEY (properties_id) REFERENCES properties (id) ON DELETE NO ACTION ON UPDATE NO ACTION;
 -- ------------------------------------------------------------------------------
--  insert ----------------------------------------------------------

INSERT INTO categories (id, name, add_date, activation) VALUES
(1, 'address', '2020-01-01', 0),
(2, 'glassess', '2020-01-01', 0),
(3, 'rings', '2020-01-01', 0);


INSERT INTO users (id, first_name, last_name, email, image_name, password, reset, role, activation, add_date, phone) VALUES
(1, 'Maher', 'Mohammed', 'Maher@gmail.com', 'a.jpg','123', NULL, 3, 1, '2020-05-17', '76876678'),
(2, 'saba', 'fadl', 'saba@gmail.com', 'b.png','123',NULL, 1, 0, '2020-08-10', '771771771'),
(3, 'reem', 'Ali', 'reem@gmail.com', 'c.png','123', NULL, 1, 0, '2020-08-10', '7717717');

INSERT INTO products (id, users_id, categories_id, name, description, activation, price, add_date, period) VALUES
(1, 1, 1, 'p1', 'ccccccccc ccccccccc ccccccccc ccccccccc ccccccccc cccccccccccccccccc ccccccccc', 1, 111, '2020-01-01', 2),
(2, 1, 1, 'p2', 'asas asaasaaasas asaasaaasas asaasaaasas asaasaa', 1, 111, '2020-01-01', 3),
(3, 1, 3, 'p3', 'ver rrryver rrryver rrryver rrry', 0, 111, '2020-02-02', 4);

INSERT INTO comments (id, products_id, users_id, comment,add_date, activation) VALUES
(1, 3, 3, 'nice', '2020-01-01', 0),
(2, 2, 2, 'wooooooe', '2020-01-01', 0),
(3, 3, 1, 'greet', '2020-08-05', 1);

INSERT INTO evaluations (products_id, users_id, evaluation) VALUES
(1, 2, 5),
(2, 3, 4),
(2, 2, 4);

INSERT INTO images (id, image_name, products_id) VALUES
(1, 'a.jpg', 1),
(2, 'c.jpg',2),
(3, 'b.png',3);

INSERT INTO locations (id, name, level, parent) VALUES
(1, 'yemen', 1, NULL),
(2, 'Sana', 2, 1),
(3, 'HAddah', 3, 2);

INSERT INTO messages (id, message, users_id) VALUES
(1, 'hellooo', 1),
(2, 'salam ', 1),
(3, ' alikom ', 2);

INSERT INTO offers (id, products_id, start_date, end_date, new_price) VALUES
(1, 2, '2020-09-01', '2020-10-12', 100),
(2, 1, '2020-09-01', '2020-09-01', 99),
(3, 3, '2020-09-01', '2020-10-12', 2);

INSERT INTO orders (id, users_id, products_id, add_date, date_deliver, amount, description, role, sale_date) VALUES
(1, 2, 3, '2020-08-25', '2020-08-25', 1, 'desc 1', 1, '2020-08-25'),
(2, 1, 1, '2020-08-25', '2020-08-25', 1, 'desc 2', 2, '2020-08-25'),
(3, 1, 2, '2020-01-01', '2020-07-07', 3, 'desc 3', 2, '2020-01-01');


INSERT INTO properties (id, name, value, type, new) VALUES
(1, 'colors', 'red', 1, 0),
(2, 'colors', 'blue', 1, 1),
(3, 'size', 'sm', 0, 0);

INSERT INTO used_properties (properties_id, products_id, default_prop) VALUES
(1, 3, 1),
(1, 2, 2),
(2, 1, 3);


-- ----------------------------------------------------------------------------


