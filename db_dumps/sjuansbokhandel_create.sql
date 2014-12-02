
-- SCHEMA: sjuansbokhandel
CREATE SCHEMA sjuansbokhandel ;


-- ---------------------------------------------------------------------------------------------------------
-- TABLES

-- Table: authors
CREATE TABLE authors (
    author_id int NOT NULL AUTO_INCREMENT,
    first_name varchar(255) NOT NULL,
    last_name varchar(255)    NOT NULL ,
    CONSTRAINT authors_pk PRIMARY KEY (author_id)
);

-- Table: shelves
CREATE TABLE shelves (
    shelf_id int NOT NULL AUTO_INCREMENT,
    code varchar(4) NOT NULL,
    CONSTRAINT shelves_pk PRIMARY KEY (shelf_id)
);

-- Table: books
CREATE TABLE books (
    isbn bigint(13) NOT NULL,
    title varchar(255) NOT NULL,
    description text NULL,
    author_id int NOT NULL,
    shelf_id int NOT NULL,
    CONSTRAINT books_pk PRIMARY KEY (isbn)
);

-- Table: books_prices
CREATE TABLE books_prices (
    price_id int NOT NULL AUTO_INCREMENT,
    price decimal(10,2) NOT NULL,
    date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    isbn bigint(13) NOT NULL,
    CONSTRAINT books_prices_pk PRIMARY KEY (price_id)
);

-- Table: deliveries
CREATE TABLE deliveries (
    delivery_id int NOT NULL AUTO_INCREMENT,
    f_price decimal(10,2) NOT NULL,
    quantity int NOT NULL,
    date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP  ON UPDATE CURRENT_TIMESTAMP,
    isbn bigint(13) NOT NULL,
    CONSTRAINT deliveries_pk PRIMARY KEY (delivery_id)
);

-- Table: sales
CREATE TABLE sales (
    sale_id int NOT NULL AUTO_INCREMENT,
    quantity int NOT NULL,
    date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP  ON UPDATE CURRENT_TIMESTAMP,
    isbn bigint(13)    NOT NULL ,
    CONSTRAINT sales_pk PRIMARY KEY (sale_id)
);


-- ---------------------------------------------------------------------------------------------------------
-- FOREIGN KEYS

-- Reference:  books_authors (table: books)
ALTER TABLE books ADD CONSTRAINT books_authors FOREIGN KEY books_authors (author_id)
    REFERENCES authors (author_id);

-- Reference:  books_prices_books (table: books_prices)
ALTER TABLE books_prices ADD CONSTRAINT books_prices_books FOREIGN KEY books_prices_books (isbn)
    REFERENCES books (isbn);

-- Reference:  books_shelfs (table: books)
ALTER TABLE books ADD CONSTRAINT books_shelfs FOREIGN KEY books_shelfs (shelf_id)
    REFERENCES shelves (shelf_id);

-- Reference:  delivery_books (table: deliveries)
ALTER TABLE deliveries ADD CONSTRAINT delivery_books FOREIGN KEY delivery_books (isbn)
    REFERENCES books (isbn);

-- Reference:  sales_books (table: sales)
ALTER TABLE sales ADD CONSTRAINT sales_books FOREIGN KEY sales_books (isbn)
    REFERENCES books (isbn);
