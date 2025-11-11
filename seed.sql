CREATE DATABASE pizzaria;
\c pizzaria

CREATE TABLE usuarios (
id SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
senha VARCHAR(100) NOT NULL,
tipo VARCHAR(50) DEFAULT 'comum'
);

CREATE TABLE pizzas (
id SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
preco DECIMAL(10,2) NOT NULL,
estoque INT NOT NULL
);

CREATE TABLE vendas (
id SERIAL PRIMARY KEY,
usuario_id INT REFERENCES usuarios(id),
pizza_id INT REFERENCES pizzas(id),
quantidade INT NOT NULL,
data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO usuarios (nome, email, senha, tipo) VALUES
('Admin', 'adm_pizzaria@pizzaria.com', 'admin123', 'admin'),
('João Silva', 'joao_silva@pizzaria.com', 'joao123', 'comum'),
('Maria Oliveira', 'maria_oliveira@gmail.com', 'maria123', 'comum');

INSERT INTO pizzas (nome, preco, estoque) VALUES
('Margherita', 25.00, 50),
('Pepperoni', 30.00, 40),
('Quatro Queijos', 35.00, 30),
('Frango com Catupiry', 32.00, 20),
('Calabresa', 28.00, 25);

INSERT INTO vendas (usuario_id, pizza_id, quantidade) VALUES
(2, 1, 2),
(2, 3, 1),
(3, 2, 1),
(3, 4, 2),
(2, 5, 1);

UPDATE pizzas SET estoque = estoque - 2 WHERE id = 1;
UPDATE pizzas SET estoque = estoque - 1 WHERE id = 3;
UPDATE pizzas SET estoque = estoque - (SELECT SUM(quantidade) FROM vendas WHERE vendas.pizza_id = pizzas.id);