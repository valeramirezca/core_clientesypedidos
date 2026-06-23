SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema clientesYPedidos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `clientesYPedidos` DEFAULT CHARACTER SET utf8 ;
USE `clientesYPedidos` ;

-- -----------------------------------------------------
-- Table `clientesYPedidos`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clientesYPedidos`.`clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clientesYPedidos`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clientesYPedidos`.`pedidos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cliente_id` INT NOT NULL,
  `fecha` DATE NOT NULL,
  `total` FLOAT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pedidos_clientes1_idx` (`cliente_id` ASC) VISIBLE,
  CONSTRAINT `fk_pedidos_clientes1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `clientesYPedidos`.`clientes` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO `clientesYPedidos`.`clientes` (`nombre`, `direccion`, `telefono`) VALUES
('Ana Torres',      'Av. Providencia 123', '+56911111111'),
('Bruno Lara',       'Calle Los Aromos 45', '+56922222222'),
('Carla Núñez',     'Pasaje Las Flores 8',  '+56933333333'),
('Diego Fuentes',   'Av. Libertad 200',     '+56944444444'),
('Elena Rojas',     'Camino Real 77',       '+56955555555');

INSERT INTO `clientesYPedidos`.`pedidos` (`cliente_id`, `fecha`, `total`) VALUES
(1, '2026-01-05', 15000),
(1, '2026-02-10', 8200),
(2, '2026-01-12', 22000),
(2, '2026-03-01', 5400),
(3, '2026-01-20', 13750),
(3, '2026-02-14', 9900),
(3, '2026-04-02', 17000),
(4, '2026-01-25', 6500),
(5, '2026-02-05', 30000),
(5, '2026-03-18', 12300);

SELECT
    c.id          AS cliente_id,
    c.nombre,
    p.id          AS pedido_id,
    p.fecha,
    p.total
FROM clientes c
LEFT JOIN pedidos p ON p.cliente_id = c.id
ORDER BY c.id, p.id;

SELECT
    p.id          AS pedido_id,
    p.fecha,
    p.total,
    c.nombre
FROM pedidos p
JOIN clientes c ON c.id = p.cliente_id
WHERE c.id = 3;


SELECT
    c.id          AS cliente_id,
    c.nombre,
    SUM(p.total)  AS total_gastado
FROM clientes c
LEFT JOIN pedidos p ON p.cliente_id = c.id
GROUP BY c.id, c.nombre
ORDER BY c.id;


DELETE FROM clientes WHERE id = 4;


SELECT
    c.id          AS cliente_id,
    c.nombre,
    COUNT(p.id)   AS cantidad_pedidos
FROM clientes c
JOIN pedidos p ON p.cliente_id = c.id
GROUP BY c.id, c.nombre
ORDER BY cantidad_pedidos DESC
LIMIT 3;
