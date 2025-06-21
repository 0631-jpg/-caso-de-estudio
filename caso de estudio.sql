-- Base de Datos
CREATE DATABASE coleccion_musical;
USE coleccion_musical;

-- Tabla Usuarios
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(50) UNIQUE NOT NULL,
    contraseña VARCHAR(255) NOT NULL
);

-- Tabla Artistas
CREATE TABLE artistas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Tabla Álbumes
CREATE TABLE albumes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    titulo VARCHAR(100),
    año YEAR,
    descripcion TEXT,
    medio ENUM('CD', 'Cassette', 'Vinilo', 'Digital'),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- Tabla Canciones
CREATE TABLE canciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    album_id INT,
    titulo VARCHAR(100),
    duracion_min INT,
    duracion_seg INT,
    artista_id INT,
    FOREIGN KEY (album_id) REFERENCES albumes(id),
    FOREIGN KEY (artista_id) REFERENCES artistas(id)
);

-- Insertar usuarios
INSERT INTO usuarios (nombre_usuario, contraseña)
VALUES 
('lorenzo', '1234'),
('marcela', '4567'),
('bryan', '7890');

-- Insertar artistas
INSERT INTO artistas (nombre)
VALUES 
('The Beatles'),
('Queen'),
('Luis Miguel'),
('Shakira'),
('Carlos Vives');

-- Insertar álbumes
INSERT INTO albumes (usuario_id, titulo, año, descripcion, medio)
VALUES 
(1, 'Abbey Road', 1969, 'Álbum icónico de The Beatles', 'Vinilo'),
(1, 'Bohemian Rhapsody - OST', 2018, 'Banda sonora de la película', 'CD'),
(2, 'Romances', 1997, 'Grandes éxitos románticos de Luis Miguel', 'Cassette'),
(3, 'Dónde Están los Ladrones', 1998, 'Uno de los álbumes más famosos de Shakira', 'CD'),
(1, 'Clásicos de la Provincia', 1993, 'Famoso álbum de Carlos Vives', 'Digital');

-- Insertar canciones
INSERT INTO canciones (album_id, titulo, duracion_min, duracion_seg, artista_id)
VALUES 
(1, 'Come Together', 4, 20, 1),
(1, 'Something', 3, 03, 1),
(2, 'Bohemian Rhapsody', 5, 55, 2),
(2, 'We Will Rock You', 2, 02, 2),
(3, 'La Media Vuelta', 3, 36, 3),
(3, 'Por Debajo de la Mesa', 3, 45, 3),
(4, 'Ciega, Sordomuda', 4, 26, 4),
(4, 'Tú', 4, 30, 4),
(5, 'La Tierra del Olvido', 4, 35, 5),
(5, 'Pa Mayté', 3, 59, 5);

SELECT id, nombre
FROM artistas;

SELECT id, nombre_usuario
FROM usuarios
WHERE nombre_usuario = 'lorenzo' AND contraseña = '1234';

SELECT A.id, A.titulo, A.año, A.descripcion, A.medio,
U.nombre_usuario AS registrado_por
FROM albumes A
JOIN usuarios U ON A.usuario_id = U.id;

SELECT C.id, C.titulo, C.duracion_min, C.duracion_seg,
A.titulo AS album_titulo,
Art.nombre AS artista_nombre
FROM canciones C
JOIN albumes A ON C.album_id = A.id
JOIN artistas Art ON C.artista_id = Art.id;

SELECT A.titulo, A.año, A.medio,
U.nombre_usuario AS registrado_por
FROM albumes A
JOIN usuarios U ON A.usuario_id = U.id
WHERE A.medio = 'CD';

SELECT A.titulo, A.año, A.medio,
U.nombre_usuario AS registrado_por
FROM albumes A
JOIN usuarios U ON A.usuario_id = U.id
WHERE A.medio = 'Vinilo';

SELECT 'Álbum' AS Tipo, titulo AS Titulo, año AS Detalle
FROM albumes
WHERE titulo LIKE '%Bohemian%';

SELECT 'Canción' AS Tipo, titulo AS Titulo, CONCAT(duracion_min, 'm ', duracion_seg, 's') AS Detalle
FROM canciones
WHERE titulo LIKE '%Together%';


