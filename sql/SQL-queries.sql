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




