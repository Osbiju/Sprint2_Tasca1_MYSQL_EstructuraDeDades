DROP DATABASE IF EXISTS pizzeria;

CREATE DATABASE pizzeria;

USE pizzeria;

-- OJOOO!! si no posu provincia i localitat aqui a dalt, no em crea be la tabla de clients
CREATE TABLE provincies(
id_provincia INT NOT NULL AUTO_INCREMENT,
nom_provincia VARCHAR(40) NOT NULL,

PRIMARY KEY (id_provincia)
);

CREATE TABLE localitats(
id_localitat INT NOT NULL AUTO_INCREMENT,
nom_localitat VARCHAR(40) NOT NULL,
id_provincia INT NOT NULL,

FOREIGN KEY (id_provincia) REFERENCES provincies(id_provincia),
PRIMARY KEY (id_localitat)
);

CREATE TABLE clients(
id_client INT NOT NULL AUTO_INCREMENT,
nom VARCHAR(20) NOT NULL,
cognoms VARCHAR(50) NOT NULL,
adreça VARCHAR(50) NOT NULL,
codi_postal INT(5) NOT NULL,
telefon INT(20) NOT NULL,
id_localitat INT NOT NULL,
id_provincia INT NOT NULL,

FOREIGN KEY (id_localitat) REFERENCES localitats(id_localitat),
FOREIGN KEY (id_provincia) REFERENCES provincies(id_provincia),
PRIMARY KEY (id_client)
);

CREATE TABLE categories_pizza(
id_categoria_pizza INT NOT NULL AUTO_INCREMENT,
nom VARCHAR(45) NOT NULL,

PRIMARY KEY (id_categoria_pizza)
);

CREATE TABLE pizzes(
id_producte INT NOT NULL AUTO_INCREMENT,
nom VARCHAR(40) NOT NULL,
descripcio VARCHAR(150) NOT NULL,
preu DECIMAL(4) NOT NULL,
id_categoria_pizza INT NOT NULL,

FOREIGN KEY (id_categoria_pizza) REFERENCES categories_pizza(id_categoria_pizza),
PRIMARY KEY (id_producte)
);

CREATE TABLE begudes(
id_beguda INT NOT NULL AUTO_INCREMENT,
nom VARCHAR(20) NOT NULL,
descripcio VARCHAR(150) NOT NULL,
preu DECIMAL(4) NOT NULL,

PRIMARY KEY (id_beguda)
);

CREATE TABLE hamburgueses(
id_hamburguesa INT NOT NULL AUTO_INCREMENT,
nom VARCHAR(40) NOT NULL,
descripcio VARCHAR(150) NOT NULL,
preu DECIMAL(4) NOT NULL,

PRIMARY KEY (id_hamburguesa)
);

CREATE TABLE botigues(
id_botiga INT NOT NULL AUTO_INCREMENT,
adreça VARCHAR(150) NOT NULL,
codi_postal VARCHAR(10) NOT NULL,
localitat VARCHAR(40) NOT NULL,
provincia VARCHAR(40) NOT NULL,

PRIMARY KEY (id_botiga)
);

CREATE TABLE empleats(
id_empleat INT NOT NULL AUTO_INCREMENT,
nom VARCHAR(20) NOT NULL,
cognoms VARCHAR(50) NOT NULL,
NIF VARCHAR(12) NOT NULL UNIQUE,
telefon VARCHAR(50) NOT NULL,
feina ENUM('Cuiner', 'Repartidor') NOT NULL,
id_botiga INT NOT NULL,

FOREIGN KEY (id_botiga) REFERENCES botigues(id_botiga),
PRIMARY KEY (id_empleat)
);

CREATE TABLE comandes(
id_comanda INT NOT NULL AUTO_INCREMENT,
id_client INT NOT NULL,
data_comanda TIMESTAMP NOT NULL DEFAULT (NOW()),
domicili_botiga ENUM ('Domicili', 'Botiga') NOT NULL,
num_pizzes INT NOT NULL,
id_pizza INT,
num_begudes INT NOT NULL,
id_beguda INT,
num_hamburgueses INT NOT NULL,
id_hamburguesa INT,
preu_total DECIMAL(4) NOT NULL,
id_botiga INT NOT NULL,
id_repartidor INT NOT NULL,
data_entrega DATETIME NULL DEFAULT CURRENT_TIMESTAMP,

-- hauria de posar id_pizza/beg/hamb amb FK??
-- hauria de posar in id_localitat/id_provincia amb FK?
-- FOREIGN KEY (id_client) REFERENCES clients(id_client),
-- FOREIGN KEY (num_pizzes) REFERENCES pizzes(id_producte),
FOREIGN KEY (id_beguda) REFERENCES begudes(id_beguda),
FOREIGN KEY (id_hamburguesa) REFERENCES hamburgueses(id_hamburguesa),
FOREIGN KEY (id_botiga) REFERENCES botigues(id_botiga),
FOREIGN KEY (id_repartidor) REFERENCES empleats(id_empleat),
PRIMARY KEY (id_comanda)
);

-- AFEGIR DADES:
INSERT INTO provincies (nom_provincia) 
VALUES 
('Barcelona'),
('Girona'),
('Lleida'),
('Tarragona');

INSERT INTO localitats (nom_localitat, id_provincia)
VALUES
('Badalona', 1),
('Mataró', 1), 
('Girona', 2),
('Figueres', 2),
('Lleida', 3),
('Balaguer', 3),
('Tarragona', 4),
('Reus', 4);

INSERT INTO categories_pizza (nom)
VALUES
('Vegetariana'),
('Carnívora'),
('Peix'),
('Americana');

INSERT INTO pizzes (nom, descripcio, preu, id_categoria_pizza)
VALUES
('4 Estacions', 'Mozzarella, pernil dolç, xampinyons, albergínia', 8.5, 1), 
('Pepperoni', 'Mozzarella i pepperoni picant', 9.2, 2),
('Tonyina', 'Tonyina, ceba i olives negres', 8.9, 3),
('Barbacoa', 'Salsa barbacoa, pollastre i formatge', 10.4, 4);

INSERT INTO begudes (nom, descripcio, preu)
VALUES
('Coca Cola', 'Refresc de cola', 1.5),
('Fanta Taronja', 'Refresc de taronja', 1.5),
('Aquarius', 'Beguda isotònica de llimona', 1.2),
('Aigua mineral', 'Aigua mineral sense gas', 1),  
('Cervesa', 'Cervesa rossa', 2),
('Vi negre', 'Vi negre de la casa', 2.5),
('Vi blanc', 'Vi blanc de la casa', 2.5),
('Nestea', 'Te fred de llimona', 1.8),
('Red Bull', 'Beguda energètica', 2.5),
('Suc de taronja', 'Suc natural de taronja', 2);


INSERT INTO hamburgueses (nom, descripcio, preu)
VALUES
('Cheeseburger', 'Carn de vedella amb formatge cheddar', 5.2),
('Amb pernil', 'Carn de vedella amb pernil i formatge', 6),
('Doble carn', 'Amb doble carn de vedella', 6.5);

INSERT INTO botigues (adreça, codi_postal, localitat, provincia)
VALUES
('C/ Jaume I, 35', '08240', 'Manresa', 'Barcelona'),
('Plaça Espanya, 2', '17001', 'Girona', 'Girona');

INSERT INTO empleats (nom, cognoms, NIF, telefon, feina, id_botiga)
VALUES
('Margarita', 'Flores del Campo', '11111111A', '666111222', 'Cuiner', 1),
('Jonni', 'Melavo', '22222222B', '666222333', 'Repartidor', 1),
('Pol', 'Vaso', '33333333C', '666333444', 'Cuiner', 2);

INSERT INTO clients (nom, cognoms, adreça, codi_postal, telefon, id_localitat, id_provincia)
VALUES
('Marta', 'Garcia Lopez', 'C/Major, 15', 08912, 666555123, 1, 1),
('Jordi', 'Martínez Pou', 'C/Pau Casals, 55', 17001, 666000111, 3, 2),
('Anna', 'Soler Vendrell', 'C/Pins, 27', 25600, 666222333, 5, 3),
('Pere', 'Sanz Blanch', 'C/Mar, 25', 17600, 666777123, 4, 2),
('Clara', 'Roca Gutiérrez', 'Av. Catalunya, 75', 25620, 666333222, 6, 3), 
('Oriol', 'Prades Boyer', 'C/Sol, 55', 43890, 666555444, 7, 4),
('Carla', 'Ventura Mur', 'C/Llibertat, 35', 43202, 666777888, 8, 4);

INSERT INTO comandes (id_client, domicili_botiga, num_pizzes, num_begudes, num_hamburgueses, preu_total, id_botiga, id_repartidor)
VALUES
(1, 'Domicili', 0, 1, 0, 19.7, 1, 1),
(2, 'Botiga', 0, 2, 0, 16.1, 2, 2),
(3, 'Domicili', 0, 1, 0, 14.2, 1, 3),
(4, 'Botiga', 0, 0, 0, 25.5, 2, 1),  
(5, 'Domicili', 0, 1, 0, 18.6, 1, 1),
(6, 'Botiga', 0, 2, 0, 27.9, 2, 2),
(7, 'Domicili', 0, 0, 1, 14.5, 1, 3),
(8, 'Botiga', 1, 0, 0, 18.7, 2, 2);


-- CONSULTES:
/*
SELECT * FROM pizzeria.comandes; -- MOSTRA TOTES LES COMANDES

SELECT * FROM pizzeria.comandes
WHERE num_begudes >= 1
ORDER BY id_botiga; -- MOSTRA LES COMANDES AMB MINIM 1 BEGUDA

SELECT * FROM pizzeria.comandes
WHERE num_begudes >= 1 AND id_botiga = 1; -- MOSTRA LES COMANDES AMB MINIM 1 BEGUDA I EN LA BOTGA 1

SELECT COUNT(num_begudes) FROM pizzeria.comandes
WHERE num_begudes >= 1
ORDER BY id_botiga; -- MOSTRA CUANTES COMANDES AMB BEGUDA

SELECT SUM(num_begudes) FROM pizzeria.comandes
WHERE num_begudes >= 1
ORDER BY id_botiga; -- MOSTRA LA SUMA DE BEGUDES DE LES COMANDES

SELECT * FROM pizzeria.comandes
WHERE id_repartidor = 1; -- MOSTRA CUANTES COMANDES HA EFECTUAT EL EMPLEAT AMB ID 1


SELECT COUNT(id_repartidor) FROM pizzeria.comandes
WHERE id_repartidor = 1
ORDER BY id_repartidor; -- MOSTRA LA SUMA DE COMANDES EFECTUADES PER EL EMPLEAT AMB ID 1


SELECT * FROM pizzeria.clients
WHERE id_provincia = 2; -- MOSTRA ELS CLIENTS DE LA BOTIGA 2
*/




