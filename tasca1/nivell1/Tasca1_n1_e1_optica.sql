DROP DATABASE IF EXISTS optica;

CREATE DATABASE optica;

USE optica;

-- DROP TABLE IF EXISTS proveidor;
CREATE TABLE proveidor(
id_proveidor INT NOT NULL AUTO_INCREMENT,
nom VARCHAR(50) NOT NULL UNIQUE,
adreça VARCHAR(100) NOT NULL UNIQUE,
telefon INT(20) NOT NULL UNIQUE,
fax INT(20) UNIQUE,
NIF INT(9),
data_creacio TIMESTAMP NOT NULL DEFAULT (NOW()), -- es podria posar una data de creacio del proveidor amb un timestamp default

PRIMARY KEY (id_proveidor)
);

-- DROP TABLE IF EXISTS ulleres;
CREATE TABLE ulleres (
id_ullera INT NOT NULL AUTO_INCREMENT, -- per relacionar la taula amb id_proveidor
marca VARCHAR(35) NOT NULL,
graduacio_vidres TINYINT DEFAULT 0,
tipus_de_montura VARCHAR(10) NOT NULL,
color_montura VARCHAR(20) NOT NULL,
color_vidre VARCHAR(20) NOT NULL,
preu INT(10) NOT NULL,
id_proveidor INT NOT NULL,
data_creacio TIMESTAMP NOT NULL DEFAULT (NOW()),

FOREIGN KEY (id_proveidor) REFERENCES proveidor(id_proveidor),
PRIMARY KEY (id_ullera)
);

-- es podria fer una tabla per el tipus_de_montura. tipus_de_montura: 1- Flotant. 2- Pasta. 3- metalica
-- es podria fer una tabla per el color_montura, color_vidre

-- DROP TABLE IF EXISTS clients;
CREATE TABLE clients(
id_client INT NOT NULL AUTO_INCREMENT,
nom VARCHAR(50) NOT NULL UNIQUE,
adreça_postal INT(10) NOT NULL UNIQUE,
telefon INT(20) NOT NULL UNIQUE,
correu_electronic VARCHAR(50),
data_registre TIMESTAMP NOT NULL DEFAULT (NOW()),
recomenat_per INT,

FOREIGN KEY (recomenat_per) REFERENCES clients(id_client),
PRIMARY KEY (id_client)
);

-- DROP TABLE IF EXISTS empleats;
CREATE TABLE empleats(
id_empleat INT NOT NULL AUTO_INCREMENT,
nom VARCHAR(50) NOT NULL UNIQUE,

PRIMARY KEY (id_empleat)
);

-- DROP TABLE IF EXISTS venta;
CREATE TABLE venta(
id_venta INT NOT NULL AUTO_INCREMENT,
data_venta TIMESTAMP NOT NULL DEFAULT (NOW()),
id_empleat INT NOT NULL,
id_ullera INT NOT NULL,
id_client INT NOT NULL,

FOREIGN KEY (id_empleat) REFERENCES empleats(id_empleat),
FOREIGN KEY (id_ullera) REFERENCES ulleres(id_ullera),
FOREIGN KEY (id_client) REFERENCES clients(id_client),
PRIMARY KEY (id_venta)
);

-- INSERTAR DADES:
INSERT INTO proveidor (nom, adreça, telefon, fax, NIF)
VALUES
('Proveidor1', 'Adreça1', 611111111, 987654321, 111111111),
('Proveidor2', 'Adreça2', 622222222, NULL, 222222222);

INSERT INTO ulleres (marca, graduacio_vidres, tipus_de_montura, color_montura, color_vidre, preu, id_proveidor)
VALUES
('Marca1', 2, 'Tipus1', 'Blanc', 'Transparent', 100, 1),
('Marca1', 1, 'Tipus2', 'Blanc', 'Transparent', 100, 1),
('Marca2', 0, 'Tipus3', 'Negre', 'Fumat', 150, 2),
('Marca2', 0, 'Tipus2', 'Negre', 'Fumat', 150, 2);

INSERT INTO clients (nom, adreça_postal, telefon, correu_electronic, recomenat_per)
VALUES
('Client1', 08021, 699999999, 'client1@exemple.com', NULL),
('Client2', 08022, 699999998, 'client2@exemple.com', 1),
('Client3', 080213, 699999997, 'client3@exemple.com', 2),
('Client4', 08024, 699999996, 'client4@exemple.com', 1),
('Client5', 08025, 699999995, 'client5@exemple.com', 3),
('Client6', 08026, 699999994, 'client6@exemple.com', 3),
('Client7', 08027, 699999993, 'client7@exemple.com', 2),
('Client8', 08028, 699999992, 'client8@exemple.com', 1),
('Client9', 08029, 699999991, 'client9@exemple.com', NULL),
('Client10', 08030, 699999990, 'client10@exemple.com', NULL);

INSERT INTO empleats (nom)
VALUES
('Pepito De Los Palotes'),
('Margarita Flores Delrio');

INSERT INTO venta (id_empleat, id_ullera, id_client)
VALUES
(1, 1, 1),
(2, 3, 2),
(2, 2, 3),
(2, 2, 1),
(1, 4, 4),
(1, 2, 5),
(1, 4, 6),
(1, 3, 7),
(2, 1, 8),
(1, 2, 9);


-- CONSULTAS:
-- 1: Llista el total de factures d'un client/a en un període determinat.
/*
SELECT COUNT(v.id_venta) AS total_facturas
FROM venta v
WHERE v.id_client = 1
AND v.data_venta BETWEEN '2024-01-01' AND '2024-01-05';
*/
/*
SELECT COUNT(v.id_venta) AS total_facturas
FROM venta v
INNER JOIN clients c ON v.id_client = c.id_client
WHERE c.id_client = 2
AND v.data_venta BETWEEN '2023-01-03' AND '2024-01-05';
*/

-- 2: Llista els diferents models d'ulleres que ha venut un empleat/da durant un any.
/*
SELECT DISTINCT u.marca, u.tipus_de_montura
FROM venta v 
INNER JOIN ulleres u ON v.id_ullera = u.id_ullera
WHERE v.id_empleat = 2
AND YEAR(v.data_venta) = 2024;
*/
/*
SELECT u.marca, u.tipus_de_montura, COUNT(u.id_ullera) AS cantidad 
FROM venta v
INNER JOIN ulleres u ON v.id_ullera = u.id_ullera
WHERE v.id_empleat = 1
AND YEAR(v.data_venta) = 2024
GROUP BY u.marca, u.tipus_de_montura;
*/

-- 3:Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica.
/*
SELECT p.nom, COUNT(v.id_ullera) AS gafas_vendidas 
FROM proveidor p
LEFT JOIN ulleres u ON u.id_proveidor = p.id_proveidor
LEFT JOIN venta v ON v.id_ullera = u.id_ullera
GROUP BY p.nom;
*/


