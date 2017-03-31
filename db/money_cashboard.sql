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
  merchant_id INT2 REFERENCES merchants(id),
  tag_id INT2 REFERENCES tags(id),
  value NUMERIC,
  description VARCHAR(255)
);