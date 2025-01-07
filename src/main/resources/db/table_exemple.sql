create database if not exists management_exp;
USE management_exp;
-- Création de la table FEEDBACKCATEGORY
CREATE TABLE IF NOT EXISTS FeedbackCategory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    value VARCHAR(255) NOT NULL UNIQUE
);

-- Création de la table MEMORYCATEGORY
CREATE TABLE IF NOT EXISTS MemoryCategory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    value VARCHAR(255) NOT NULL UNIQUE
);

-- Création de la table SHARE
CREATE TABLE IF NOT EXISTS Share (
    id INT AUTO_INCREMENT PRIMARY KEY,
    value VARCHAR(255) NOT NULL UNIQUE
);

-- Création de la table REVIEW
CREATE TABLE IF NOT EXISTS Review (
    id INT AUTO_INCREMENT PRIMARY KEY,
    value TEXT NOT NULL
);

-- Création de la table FeedbackModel
CREATE TABLE IF NOT EXISTS FeedbackModel (
    idFeedback INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    creationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    review INT, -- Relation avec la table Review
    image VARCHAR(255) CHECK (image LIKE '%.png' OR image LIKE '%.jpeg'),
    category INT, -- Relation avec FeedbackCategory
    views INT DEFAULT 0,
    updateDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    idUser INT NOT NULL,
    idOrder INT,
    isDeleted BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (review) REFERENCES Review(id) ON DELETE SET NULL,
    FOREIGN KEY (category) REFERENCES FeedbackCategory(id) ON DELETE SET NULL
);

-- Création de la table MemoryModel
CREATE TABLE IF NOT EXISTS MemoryModel (
    idMemory INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publicationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    category INT, -- Relation avec MemoryCategory
    views INT DEFAULT 0,
    image VARCHAR(255) CHECK (image LIKE '%.png' OR image LIKE '%.jpeg'),
    description TEXT,
    place VARCHAR(255),
    share INT, -- Relation avec Share
    hashtag VARCHAR(255),
    tag VARCHAR(255),
    idTransaction INT,
    idUser INT NOT NULL,
    isDeleted BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (category) REFERENCES MemoryCategory(id) ON DELETE SET NULL,
    FOREIGN KEY (share) REFERENCES Share(id) ON DELETE SET NULL
);

-- Insertion des valeurs initiales pour FeedbackCategory
INSERT INTO FeedbackCategory (value) VALUES 
('EXPERIENCE'), 
('WELCOMING'), 
('WEALTH'), 
('TRANSPORTATION');

-- Insertion des valeurs initiales pour MemoryCategory
INSERT INTO MemoryCategory (value) VALUES 
('BUSINESS_TRAVEL'), 
('PARTY'), 
('HOBBY'), 
('WORK');

-- Insertion des valeurs initiales pour Share
INSERT INTO Share (value) VALUES 
('PRIVATE'), 
('PUBLIC');

INSERT INTO Review (value) VALUES 
('Excellent service'), 
('Very friendly staff'), 
('Luxurious amenities'), 
('Fast and efficient transport');


-- Exemple d'insertion dans la table FeedbackModel
INSERT INTO FeedbackModel (title, review, image, category, views, idUser, idOrder) VALUES
('Great Experience', 1, 'service.png', 1, 150, 1, 101),
('Friendly Staff', 2, 'staff.jpeg', 2, 85, 2, 102),
('Luxurious Stay', 3, 'luxury.png', 3, 200, 3, 103),
('Efficient Transport', 4, 'transport.jpeg', 4, 120, 4, 104);

-- Exemple d'insertion dans la table MemoryModel
INSERT INTO MemoryModel (title, category, image, description, place, share, hashtag, tag, idUser, idTransaction) VALUES
('Corporate Meeting', 1, 'meeting.png', 'A productive business trip.', 'New York', 2, 'corporate networking', 'work', 1, 201),
('Birthday Celebration', 2, 'birthday.png', 'A fun and memorable party.', 'Los Angeles', 1, 'birthday fun', 'friends', 2, 202);

