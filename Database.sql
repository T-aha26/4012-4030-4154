CREATE DATABASE takalo_takalo;
USE takalo_takalo;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE objects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    price DECIMAL(10,2),
    category_id INT,
    owner_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (category_id) REFERENCES categories(id),
    FOREIGN KEY (owner_id) REFERENCES users(id)
);


CREATE TABLE object_images (
    id INT AUTO_INCREMENT PRIMARY KEY,
    object_id INT,
    image_path VARCHAR(255),

    FOREIGN KEY (object_id) REFERENCES objects(id)
);



CREATE TABLE exchanges (
    id INT AUTO_INCREMENT PRIMARY KEY,
    object_offered_id INT,
    object_requested_id INT,
    status ENUM('pending', 'accepted', 'refused') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (object_offered_id) REFERENCES objects(id),
    FOREIGN KEY (object_requested_id) REFERENCES objects(id)
);


CREATE TABLE object_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    object_id INT,
    user_id INT,
    date_from DATETIME DEFAULT CURRENT_TIMESTAMP,
    date_to DATETIME NULL,

    FOREIGN KEY (object_id) REFERENCES objects(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);


CREATE TABLE admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    login VARCHAR(50),
    password VARCHAR(255)
);

-- Catégories
INSERT INTO categories(name) VALUES
('Livre'),
('Vêtement'),
('DVD'),
('Électronique');

-- Utilisateurs
INSERT INTO users(email,password) VALUES
('user1@gmail.com', MD5('1234')),
('user2@gmail.com', MD5('1234'));

-- Admin
INSERT INTO admins(login,password) VALUES
('admin', MD5('admin123'));


INSERT INTO objects(title, description, price, category_id, owner_id) VALUES
('Livre Java', 'Livre programmation', 20, 1, 1),
('T-shirt Nike', 'Taille M', 15, 2, 2),
('DVD Naruto', 'Anime', 10, 3, 1);


INSERT INTO exchanges(object_offered_id, object_requested_id)
VALUES (1, 2);


-- changer propriétaire
UPDATE objects SET owner_id = 2 WHERE id = 1;
UPDATE objects SET owner_id = 1 WHERE id = 2;

-- historique
INSERT INTO object_history(object_id, user_id) VALUES (1,2),(2,1);

-- changer status
UPDATE exchanges SET status='accepted' WHERE id=1;
SELECT COUNT(*) FROM users;
SELECT COUNT(*) FROM exchanges WHERE status='accepted';
