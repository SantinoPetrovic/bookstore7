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
VALUES ({isbn}, {title}, {description}, {shelf_id}, {book_author_id});

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

# select shelf
SELECT shelf_id FROM shelves WHERE shelf_id = {shelf_id};

# register price
INSERT INTO price_history (price, isbn) VALUES ({price}, {isbn});













