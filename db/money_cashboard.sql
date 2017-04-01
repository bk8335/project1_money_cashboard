DROP TABLE total
DROP TABLE transactions;
DROP TABLE merchants;
DROP TABLE tags;

CREATE TABLE tags (
  id SERIAL2 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE merchants (
  id SERIAL2 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE transactions (
  id SERIAL2 PRIMARY KEY,
  merchant_id INT2 REFERENCES merchants(id) ON DELETE CASCADE,
  tag_id INT2 REFERENCES tags(id) ON DELETE CASCADE,
  value NUMERIC,
  description VARCHAR(255)
);

CREATE TABLE total (
  id SERIAL2 PRIMARY KEY,
  transaction_id INT2 REFERENCES transactions(id) ON DELETE CASCADE,
);