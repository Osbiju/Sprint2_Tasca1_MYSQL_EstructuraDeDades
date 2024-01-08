DROP DATABASE IF EXISTS youtube;

CREATE DATABASE youtube;

USE youtube;

CREATE TABLE usuaris(
id_usuari INT NOT NULL AUTO_INCREMENT,
email VARCHAR(40) NOT NULL UNIQUE,
contrasenya VARCHAR(30) NOT NULL,
nom_usuari VARCHAR(20) NOT NULL,
data_naixement TIMESTAMP NOT NULL DEFAULT (NOW()),
sexe ENUM('Home', 'Dona') NOT NULL,
pais VARCHAR(30) NOT NULL,
codi_postal INT(10) NOT NULL,

PRIMARY KEY (id_usuari)
);

CREATE TABLE videosPublicats(
id_videoPublicat INT NOT NULL AUTO_INCREMENT,
id_usuari INT NOT NULL,
titol VARCHAR(50) NOT NULL,
descripcio VARCHAR(100) NOT NULL,
pes_archiu FLOAT,
durada_video FLOAT,
thumbnail BLOB NULL,
num_reproduccions INT NOT NULL,

FOREIGN KEY (id_usuari) REFERENCES usuaris(id_usuari),
PRIMARY KEY (id_videoPublicat)
);
