CREATE TABLE IF NOT EXISTS customers(
    id INT AUTO_INVREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

INSERT INTO customers (name, email) VALUES
('ABC', 'abc@gmail.com'), ('IJK', 'ijk@gmail.com');