# connection
# hostname: 127.0.0.1
# username: root
# password: mysql
# database: bookstore7

# register delivery
INSERT INTO delivery (isbn, quantity, delivery_date, f_price)
VALUES ({isbn}, {quantity}, {delivery_date}, {f_price});

# register books
INSERT INTO books (isbn, title, description, shelf_id, book_author_id)
VALUES ({isbn}, {quantity}, {delivery_date}, {f_price}, {shelf_id}, {book_author_id});

# register authors
INSERT INTO authors (firstname, lastname)
VALUES ({firstname}, {lastname});

# register shelf
INSERT INTO shelves (shelf_id)
VALUES ({shelf_id});

# select authors
SELECT author_id FROM authors WHERE firstname = {firstname} AND lastname = {lastname};

# select isbn
SELECT * FROM books WHERE isbn = {isbn};

# select shelves
SELECT shelf_id FROM shelves WHERE shelf_id = {shelf_id};




# select f_price
SELECT f_price FROM deliveries WHERE f_price = {f_price};

# register sale_price
INSERT INTO books (sale_price) VALUES ({sale_price});

# select f_price and set to sale_price
UPDATE books SET sale_price = f_price * 1.8 WHERE sale_price = {sale_price};











