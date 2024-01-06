DROP DATABASE IF EXISTS pizzeria_PROBA;

CREATE DATABASE pizzeria_PROBA;

USE pizzeria_PROBA;

CREATE TABLE provincies (
id_provincia INT NOT NULL AUTO_INCREMENT,  
nom VARCHAR(100) NOT NULL,
PRIMARY KEY (id_provincia)
);

CREATE TABLE localitats (
id_localitat INT NOT NULL AUTO_INCREMENT,
nom VARCHAR(100) NOT NULL,  
id_provincia INT NOT NULL,
FOREIGN KEY (id_provincia) REFERENCES provincies(id_provincia),
PRIMARY KEY (id_localitat)
);

CREATE TABLE clients (
id_client INT NOT NULL AUTO_INCREMENT,
nom VARCHAR(100) NOT NULL,
cognoms VARCHAR(200) NOT NULL, 
adreca VARCHAR(200) NOT NULL,
codi_postal VARCHAR(10) NOT NULL,
id_localitat INT NOT NULL,
FOREIGN KEY (id_localitat) REFERENCES localitats(id_localitat),
PRIMARY KEY (id_client)
);

CREATE TABLE botigues (
id_botiga INT NOT NULL AUTO_INCREMENT,
adreca VARCHAR(200) NOT NULL,
codi_postal VARCHAR(10) NOT NULL,
id_localitat INT NOT NULL,  
FOREIGN KEY (id_localitat) REFERENCES localitats(id_localitat),
PRIMARY KEY (id_botiga)
);

CREATE TABLE empleats (
id_empleat INT NOT NULL AUTO_INCREMENT, 
nom VARCHAR(100) NOT NULL,
cognoms VARCHAR(200) NOT NULL,
nif VARCHAR(20) NOT NULL,
telefon VARCHAR(20) NOT NULL,
feina ENUM('cuiner', 'repartidor') NOT NULL,  
id_botiga INT NOT NULL,
FOREIGN KEY (id_botiga) REFERENCES botigues(id_botiga),  
PRIMARY KEY (id_empleat)
);

CREATE TABLE categories (
id_categoria INT NOT NULL AUTO_INCREMENT, 
nom VARCHAR(100) NOT NULL,
PRIMARY KEY (id_categoria)
);

CREATE TABLE productes (
id_producte INT NOT NULL AUTO_INCREMENT, 
nom VARCHAR(100) NOT NULL,
descripcio TEXT NOT NULL,
imatge BLOB,
preu DECIMAL(10,2) NOT NULL,
tipus ENUM('pizza', 'hamburguesa', 'beguda') NOT NULL,
PRIMARY KEY (id_producte)
);

CREATE TABLE productes_categories (
id_producte INT NOT NULL,
id_categoria INT NOT NULL,
FOREIGN KEY (id_producte) REFERENCES productes(id_producte),  
FOREIGN KEY (id_categoria) REFERENCES categories(id_categoria),
PRIMARY KEY (id_producte, id_categoria)
);

CREATE TABLE comandes (
id_comanda INT NOT NULL AUTO_INCREMENT,
id_client INT NOT NULL,  
data_hora DATETIME NOT NULL,
tipus ENUM('domicili', 'botiga') NOT NULL,
id_botiga INT NOT NULL,
id_repartidor INT,
data_hora_lliurament DATETIME,
preu_total DECIMAL(10,2) NOT NULL,
FOREIGN KEY (id_client) REFERENCES clients(id_client),
FOREIGN KEY (id_botiga) REFERENCES botigues(id_botiga), 
FOREIGN KEY (id_repartidor) REFERENCES empleats(id_empleat),
PRIMARY KEY (id_comanda)  
);

CREATE TABLE comandes_productes (
id_comanda INT NOT NULL,
id_producte INT NOT NULL, 
quantitat INT NOT NULL,
FOREIGN KEY (id_comanda) REFERENCES comandes(id_comanda),
FOREIGN KEY (id_producte) REFERENCES productes(id_producte),
PRIMARY KEY (id_comanda, id_producte)
);

INSERT INTO provincies (nom)
VALUES
('Barcelona'),
('Girona'),
('Lleida'),
('Tarragona');

INSERT INTO localitats (nom, id_provincia)
VALUES
('Badalona', 1), 
('Mataró', 1),
('Girona', 2),  
('Figueres', 2),
('Lleida', 3),
('Balaguer', 3),
('Tarragona', 4),
('Reus', 4);

INSERT INTO clients (nom, cognoms, adreca, codi_postal, id_localitat)
VALUES
('Marta Garcia', 'Lopez', 'C/ Major 15', '08912', 1),
('Jordi', 'Martínez Pou', 'C/ Pau Casals 55', '17001', 3),
('Anna', 'Soler Vendrell', 'C/ Pins 27','25600', 5),
('Pere', 'Sanz Blanch', 'C/ Mar 25','17600', 4), 
('Clara', 'Roca Gutiérrez', 'Av. Catalunya 75','25620', 6),
('Oriol', 'Prades Boyer', 'C/ Sol 55','43890', 7),
('Carla', 'Ventura Mur', 'C/ Llibertat 35','43202', 8);

INSERT INTO botigues (adreca, codi_postal, id_localitat)
VALUES 
('C/ Jaume I 35','08240', 1),
('Plaça Espanya 2','17001', 3);

INSERT INTO categories (nom)  
VALUES
('Vegetariana'),
('Carnívora'), 
('Peix'),
('Americana');

INSERT INTO productes (nom, descripcio, preu, tipus)
VALUES
('Pizza 4 Estacions', 'Mozzarella, pernil dolç, xampinyons, albergínia', 8.50, 'pizza'),
('Pizza Pepperoni', 'Mozzarella i pepperoni picant', 9.20, 'pizza'),
('Pizza Tonyina', 'Tonyina, ceba i olives negres', 8.90, 'pizza'),
('Pizza Barbacoa','Salsa barbacoa, pollastre i formatge', 10.40, 'pizza'),
('Hamburguesa Cheeseburger', 'Carn de vedella amb formatge cheddar', 5.20, 'hamburguesa'),  
('Hamburguesa amb Pernil', 'Carn de vedella amb pernil i formatge', 6.00, 'hamburguesa'),
('Hamburguesa Doble Carn', 'Amb doble carn de vedella', 6.50, 'hamburguesa'),
('Coca Cola', 'Refresc de cola', 1.50, 'beguda'),
('Fanta Taronja', 'Refresc de taronja', 1.50, 'beguda');

INSERT INTO productes_categories (id_producte, id_categoria) 
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

INSERT INTO empleats (nom, cognoms, nif, telefon, feina, id_botiga)
VALUES 
('Margarita', 'Flores del Campo', '11111111A', '666111222', 'cuiner', 1),
('Jonni', 'Melavo','22222222B', '666222333', 'repartidor', 1), 
('Pol', 'Vaso','33333333C', '666333444', 'cuiner', 2);

INSERT INTO comandes (id_client, data_hora, tipus, id_botiga, preu_total)
VALUES
(5, '2023-01-06 09:15:00', 'domicili', 1, 32.50),
(6, '2023-01-06 11:30:45', 'botiga', 2, 18.90),
(7, '2023-01-06 14:55:22', 'domicili', 1, 24.80),
(8, '2023-01-06 17:10:10', 'botiga', 2, 14.70),
(9, '2023-01-06 19:45:30', 'domicili', 1, 21.60),
(10, '2023-01-06 21:20:18', 'botiga', 2, 27.30),
(11, '2023-01-07 10:05:55', 'domicili', 1, 12.40),
(12, '2023-01-07 13:40:40', 'botiga', 2, 16.80),
(13, '2023-01-07 16:25:12', 'domicili', 1, 29.90),
(14, '2023-01-07 19:55:30', 'botiga', 2, 22.10),
(15, '2023-01-07 22:30:18', 'domicili', 1, 19.20);

INSERT INTO comandes_productes (id_comanda, id_producte, quantitat)
VALUES  
(5, 8, 2),
(5, 9, 1),
(6, 6, 2),
(6, 7, 1),
(7, 8, 3),
(8, 9, 1),
(9, 6, 1),
(10, 7, 2),
(11, 8, 2),
(11, 9, 1),
(12, 6, 1),
(13, 8, 3),
(13, 9, 2),
(14, 6, 1),
(15, 7, 2);