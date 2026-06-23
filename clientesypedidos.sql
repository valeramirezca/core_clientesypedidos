CREATE DATABASE clientesypedidos2026;
USE clientesypedidos2026;

CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    direccion VARCHAR(45),
    telefono VARCHAR(20)
);

CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    fecha DATE,
    total FLOAT,
    FOREIGN KEY (cliente_id) REFERENCES clientes (id)
);

INSERT INTO clientes (nombre, direccion, telefono) VALUES ("Ana Torres", "Av. Providencia 123", "+56911111111");
INSERT INTO clientes (nombre, direccion, telefono) VALUES ("Bruno Lara", "Calle Los Aromos 45", "+56922222222");
INSERT INTO clientes (nombre, direccion, telefono) VALUES ("Carla Núñez", "Pasaje Las Flores 8", "+56933333333");
INSERT INTO clientes (nombre, direccion, telefono) VALUES ("Diego Fuentes", "Av. Libertad 200", "+56944444444");
INSERT INTO clientes (nombre, direccion, telefono) VALUES ("Elena Rojas", "Camino Real 77", "+56955555555");

INSERT INTO pedidos (cliente_id, fecha, total) VALUES (1, "2026-01-05", 15000);
INSERT INTO pedidos (cliente_id, fecha, total) VALUES (1, "2026-02-10", 8200);
INSERT INTO pedidos (cliente_id, fecha, total) VALUES (2, "2026-01-12", 22000);
INSERT INTO pedidos (cliente_id, fecha, total) VALUES (2, "2026-03-01", 5400);
INSERT INTO pedidos (cliente_id, fecha, total) VALUES (3, "2026-01-20", 13750);
INSERT INTO pedidos (cliente_id, fecha, total) VALUES (3, "2026-02-14", 9900);
INSERT INTO pedidos (cliente_id, fecha, total) VALUES (3, "2026-04-02", 17000);
INSERT INTO pedidos (cliente_id, fecha, total) VALUES (4, "2026-01-25", 6500);
INSERT INTO pedidos (cliente_id, fecha, total) VALUES (5, "2026-02-05", 30000);
INSERT INTO pedidos (cliente_id, fecha, total) VALUES (5, "2026-03-18", 12300);

SELECT
    c.id AS cliente_id,
    c.nombre,
    p.id AS pedido_id,
    p.fecha,
    p.total
FROM clientes c
    LEFT JOIN pedidos p ON p.cliente_id = c.id
ORDER BY c.id, p.id;

SELECT
    p.id AS pedido_id,
    p.fecha,
    p.total,
    c.nombre
FROM pedidos p
    JOIN clientes c ON c.id = p.cliente_id
WHERE
    c.id = 3;

SELECT
    c.id AS cliente_id,
    c.nombre,
    sum(p.total) AS total_gastado
FROM clientes c
    LEFT JOIN pedidos p ON p.cliente_id = c.id
GROUP BY c.id, c.nombre
ORDER BY c.id;

DELETE FROM pedidos WHERE cliente_id = 4;
DELETE FROM clientes WHERE id = 4;

SELECT
    c.id AS cliente_id,
    c.nombre,
    count(p.id) AS cantidad_pedidos
FROM clientes c
    JOIN pedidos p ON p.cliente_id = c.id
GROUP BY c.id, c.nombre
ORDER BY cantidad_pedidos DESC
LIMIT 3;
