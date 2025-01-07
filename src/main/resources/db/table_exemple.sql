create database if not exists management_exp;
USE management_exp;

drop user if exists admin@localhost;
flush privileges;

-- Créer un utilisateur avec un mot de passe
CREATE USER 'admin'@'localhost' IDENTIFIED BY '1234';
-- Accorder tous les privilèges à cet utilisateur sur la base de données
GRANT ALL PRIVILEGES ON management_exp.* TO 'admin'@'localhost';

-- Appliquer les changements
FLUSH PRIVILEGES;

-- Table pour les catégories de feedback
CREATE TABLE FEEDBACKCATEGORY (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Table pour les catégories de mémoire
CREATE TABLE MEMORYCATEGORY (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Table pour les types de partage
CREATE TABLE SHARE (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Table pour les retours utilisateurs (FeedbackModel)
CREATE TABLE FeedbackModel (
    idFeedback VARCHAR(36) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    dateCreated DATE NOT NULL,
    review TEXT,
    image VARCHAR(255),
    category INT,
    views INT DEFAULT 0,
    dateUpdated DATE,
    idUser VARCHAR(36) NOT NULL,
    idOrder VARCHAR(36),
    bDelete BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (category) REFERENCES FEEDBACKCATEGORY(id)
);

-- Table pour les mémoires (MemoryModel)
CREATE TABLE MemoryModel (
    idMemory VARCHAR(36) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publicationDate DATE NOT NULL,
    category INT,
    views INT DEFAULT 0,
    image VARCHAR(255),
    description TEXT,
    place VARCHAR(255),
    hashtag VARCHAR(255),
    share INT,
    tag VARCHAR(255),
    idOrder VARCHAR(36),
    idUser VARCHAR(36) NOT NULL,
    bDelete BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (category) REFERENCES MEMORYCATEGORY(id),
    FOREIGN KEY (share) REFERENCES SHARE(id)
);

-- Table pour les utilisateurs
CREATE TABLE Users (
    idUser VARCHAR(36) PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- Ajout de catégories de feedback
INSERT INTO FEEDBACKCATEGORY (name) VALUES
('Product Feedback'),
('Service Feedback'),
('Website Feedback'),
('Other');

-- Ajout de catégories de mémoire
INSERT INTO MEMORYCATEGORY (name) VALUES
('Personal'),
('Work'),
('Travel'),
('Event');

-- Ajout de types de partage
INSERT INTO SHARE (name) VALUES
('Public'),
('Private'),
('Friends Only');



-- Ajout d'exemples de retours utilisateurs (FeedbackModel)
INSERT INTO FeedbackModel (idFeedback, title, dateCreated, review, image, category, views, dateUpdated, idUser, idOrder, bDelete) VALUES
(UUID(), 'Great Service', '2025-01-01', 'The service was excellent.', 'image1.jpg', 1, 100, '2025-01-02', 'user1', 'order1', FALSE),
(UUID(), 'Website Issue', '2025-01-03', 'The website is slow.', 'image2.jpg', 3, 50, '2025-01-04', 'user2', 'order2', FALSE),
(UUID(), 'Product Feedback', '2025-01-05', 'The product quality is great.', 'image3.jpg', 1, 30, '2025-01-06', 'user3', 'order3', FALSE),
(UUID(), 'Delivery Delay', '2025-01-07', 'Delivery took longer than expected.', 'image4.jpg', 2, 80, '2025-01-08', 'user4', 'order4', FALSE),
(UUID(), 'Amazing Support', '2025-01-09', 'Customer support was very helpful.', 'image5.jpg', 1, 120, '2025-01-10', 'user5', 'order5', FALSE),
(UUID(), 'Poor Packaging', '2025-01-11', 'The packaging was damaged.', 'image6.jpg', 2, 40, '2025-01-12', 'user6', 'order6', FALSE),
(UUID(), 'Excellent App', '2025-01-13', 'The app is user-friendly and intuitive.', 'image7.jpg', 3, 200, '2025-01-14', 'user7', 'order7', FALSE),
(UUID(), 'Refund Issue', '2025-01-15', 'Refund process was complicated.', 'image8.jpg', 4, 30, '2025-01-16', 'user8', 'order8', FALSE),
(UUID(), 'Quick Delivery', '2025-01-17', 'The order was delivered quickly.', 'image9.jpg', 1, 150, '2025-01-18', 'user9', 'order9', FALSE),
(UUID(), 'Misleading Product', '2025-01-19', 'The product was not as described.', 'image10.jpg', 2, 25, '2025-01-20', 'user10', 'order10', FALSE);

-- Ajout d'exemples de mémoires (MemoryModel)
INSERT INTO MemoryModel (idMemory, title, publicationDate, category, views, image, description, place, hashtag, share, tag, idOrder, idUser, bDelete) VALUES
(UUID(), 'Vacation in Paris', '2024-12-25', 3, 200, 'paris.jpg', 'Visited the Eiffel Tower and Louvre.', 'Paris', '#travel', 1, 'vacation,paris', 'order4', 'user1', FALSE),
(UUID(), 'Office Party', '2024-12-20', 2, 150, 'office.jpg', 'End-of-year celebration at the office.', 'Office', '#work', 2, 'party,office', 'order5', 'user2', FALSE),
(UUID(), 'Wedding Event', '2024-12-15', 4, 300, 'wedding.jpg', 'My best friend’s wedding.', 'Venue XYZ', '#wedding', 1, 'event,wedding', 'order6', 'user3', FALSE),
(UUID(), 'Mountain Hiking', '2024-12-10', 3, 180, 'hiking.jpg', 'Reached the summit after a long hike.', 'Mount Everest', '#adventure', 1, 'hiking,mountain', 'order7', 'user4', FALSE),
(UUID(), 'Family Reunion', '2024-12-05', 1, 100, 'family.jpg', 'A wonderful time with family.', 'Home', '#family', 2, 'reunion,family', 'order8', 'user5', FALSE),
(UUID(), 'Beach Party', '2024-11-30', 3, 220, 'beach.jpg', 'Enjoyed the sunshine and waves.', 'Malibu', '#beach', 1, 'party,beach', 'order9', 'user6', FALSE),
(UUID(), 'Conference Talk', '2024-11-25', 2, 160, 'conference.jpg', 'Gave a talk on technology trends.', 'Convention Center', '#conference', 2, 'talk,conference', 'order10', 'user7', FALSE),
(UUID(), 'Birthday Celebration', '2024-11-20', 4, 140, 'birthday.jpg', 'Celebrated my 30th birthday.', 'Banquet Hall', '#birthday', 1, 'celebration,birthday', 'order11', 'user8', FALSE),
(UUID(), 'Camping Trip', '2024-11-15', 3, 190, 'camping.jpg', 'Stayed under the stars.', 'National Park', '#camping', 1, 'trip,camping', 'order12', 'user9', FALSE),
(UUID(), 'Art Exhibition', '2024-11-10', 4, 110, 'art.jpg', 'Visited an inspiring art exhibition.', 'City Gallery', '#art', 2, 'exhibition,art', 'order13', 'user10', FALSE);


