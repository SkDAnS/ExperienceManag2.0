CREATE DATABASE IF NOT EXISTS projet;

USE projet;

-- Apartments & Availability

CREATE TABLE IF NOT EXISTS apartment(
    id VARCHAR(36) PRIMARY KEY,
    nb_piece INT NOT NULL,
    price INT NOT NULL,
    area INT NOT NULL,
    nb_people INT NOT NULL,
    adress VARCHAR(255),
    owner_id INT,
    availability_id INT,
    INDEX idx_owner_id (owner_id),
    INDEX idx_availability_id (availability_id)
);


CREATE TABLE IF NOT EXISTS owner(
    id INT AUTO_INCREMENT PRIMARY KEY,
    lastname VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    contact VARCHAR(255),
    adress VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS apartmentavailability(
    id INT AUTO_INCREMENT PRIMARY KEY,
    availability ENUM('free','occupied','underConstruction'),
    week INT NOT NULL,
    year INT NOT NULL
);

INSERT INTO apartment (id, nb_piece, price, area, nb_people, adress, owner_id, availability_id) VALUES
('e6c8d15a-3cda-4ef3-99d4-bbb7e0e1e23f', 3, 1200, 75, 4, '123 Main Street', 1, 2),
('88a10707-3d37-4f2b-b57b-5d93db7d3073', 2, 900, 50, 2, '456 Elm Street', 2, 3),
('5f0be6be-56a1-4d96-8bbd-05354a9d84c2', 4, 1500, 90, 5, '789 Oak Avenue', 3, 1),
('dcd079ea-9a3e-41f5-9a8d-1200c24a0149', 1, 600, 30, 1, '321 Pine Road', 4, 4),
('0777b23b-2e2a-44fc-a953-dac8d06f400a', 5, 2000, 120, 6, '654 Maple Boulevard', 5, 5);

INSERT INTO owner (lastname, surname, contact, adress) VALUES
('Smith', 'John', 'smith@example.com', '123 Main Street'),
('Johnson', 'Emily', 'johnson@example.com', '456 Elm Street'),
('Williams', 'Michael', 'williams@example.com', '789 Oak Avenue'),
('Brown', 'Sarah', 'brown@example.com', '321 Pine Road'),
('Jones', 'Robert', 'jones@example.com', '654 Maple Boulevard');

INSERT INTO apartmentavailability (availability, week, year) VALUES
('free', 3, 2024),
('occupied', 19, 2024),
('underConstruction', 5, 2024),
('free', 12, 2024),
('occupied', 46, 2024);


-- Products & Availability
CREATE TABLE IF NOT EXISTS `category` (
  `id_category` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `bDelete` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id_category`)
);

INSERT INTO `category` (`id_category`, `name`, `description`, `date_created`, `bDelete`) VALUES
	(1, 'Électronique', 'Produits électroniques tels que téléphones, ordina', '2024-01-02 10:30:00', 0),
	(2, 'Vêtements', 'Articles vestimentaires pour hommes, femmes et enf', '2024-01-05 12:15:00', 0),
	(3, 'Mobilier', 'Mobilier pour la maison et le bureau, y compris ch', '2024-01-10 08:45:00', 0),
	(4, 'Jouets', 'Jouets pour enfants, y compris jeux éducatifs et d', '2024-01-12 09:00:00', 0),
	(5, 'Cuisine', 'Ustensiles et appareils électroménagers pour la cu', '2024-01-15 11:20:00', 0),
	(6, 'Livres', 'Livres de fiction, manuels éducatifs, et ouvrages ', '2024-01-20 14:05:00', 0),
	(7, 'Audio', 'Équipements audio tels que casques, enceintes et m', '2024-02-01 16:50:00', 0),
	(8, 'Jardinage', 'Outils et accessoires pour entretenir les jardins ', '2024-02-05 10:25:00', 0),
	(9, 'Sport', 'Équipements et vêtements pour diverses activités s', '2024-02-10 15:40:00', 0),
	(10, 'Beauté', 'Produits cosmétiques, soins corporels et accessoir', '2024-02-12 13:10:00', 0);

CREATE TABLE IF NOT EXISTS `product` (
  `id_product` varchar(16) NOT NULL DEFAULT 'AUTO_INCREMENT',
  `name` varchar(50) DEFAULT NULL,
  `unit_price` float DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `id_subcategory` int(11) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `id_provider` varchar(30) DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `bDelete` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id_product`)
);

INSERT INTO `product` (`id_product`, `name`, `unit_price`, `status`, `id_subcategory`, `stock`, `id_provider`, `date_updated`, `date_created`, `bDelete`) VALUES
	('P001', 'iPhone 14', 999.99, 'Disponible', 1, 50, 'PR001', '2024-01-15 14:30:00', '2024-01-01 10:00:00', 0),
	('P002', 'MacBook Pro 16"', 2499.99, 'Disponible', 2, 20, 'PR002', '2024-01-16 11:20:00', '2024-01-02 11:00:00', 0),
	('P003', 'Samsung Galaxy S23', 799.99, 'Disponible', 1, 35, 'PR003', '2024-01-20 13:45:00', '2024-01-05 09:30:00', 0),
	('P004', 'Casque Sony WH-1000XM5', 399.99, 'Disponible', 1, 40, 'PR004', '2024-01-22 15:00:00', '2024-01-10 10:15:00', 0),
	('P005', 'Chaise ergonomique', 199.99, 'Disponible', 7, 60, 'PR005', '2024-01-25 10:45:00', '2024-01-12 14:00:00', 0),
	('P006', 'Livre "1984" de George Orwell', 14.99, 'Disponible', 6, 100, 'PR006', '2024-02-01 12:30:00', '2024-01-15 16:30:00', 0),
	('P007', 'Jeu Monopoly', 29.99, 'Disponible', 8, 75, 'PR007', '2024-02-05 14:50:00', '2024-01-20 09:15:00', 0),
	('P008', 'Mixeur Philips', 49.99, 'En rupture', 5, 0, 'PR008', '2024-02-10 11:10:00', '2024-01-22 13:40:00', 0),
	('P009', 'Haut-parleurs JBL Charge 5', 149.99, 'Disponible', 10, 30, 'PR009', '2024-02-12 17:25:00', '2024-01-25 08:00:00', 0),
	('P010', 'Tondeuse électrique Bosch', 299.99, 'Disponible', 9, 15, 'PR010', '2024-02-15 19:00:00', '2024-01-30 12:00:00', 0);


CREATE TABLE IF NOT EXISTS `subcategory` (
  `id_subcategory` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  `id_category` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime DEFAULT NULL,
  PRIMARY KEY (`id_subcategory`)
);

INSERT INTO `subcategory` (`id_subcategory`, `name`, `active`, `id_category`, `date_created`) VALUES
	(1, 'Smartphones', 1, 1, '2024-01-02 10:45:00'),
	(2, 'Ordinateurs portables', 1, 1, '2024-01-05 11:30:00'),
	(3, 'Téléviseurs', 1, 1, '2024-01-10 14:20:00'),
	(4, 'Vêtements décontractés', 1, 2, '2024-01-12 09:15:00'),
	(5, 'Vêtements de sport', 1, 2, '2024-01-15 13:45:00'),
	(6, 'Canapés', 1, 3, '2024-01-20 10:00:00'),
	(7, 'Chaises de bureau', 1, 3, '2024-01-25 14:30:00'),
	(8, 'Jeux de société', 1, 4, '2024-02-01 16:10:00'),
	(9, 'Ustensiles de cuisine', 1, 5, '2024-02-10 15:20:00'),
	(10, 'Outils de jardin', 1, 8, '2024-02-15 17:40:00');


-- Contacts & Adresses
CREATE TABLE IF NOT EXISTS `contact_model` (
  `uuid` VARCHAR(1024),
  `id_address` VARCHAR(1024),
  `name` VARCHAR(1024),
  `first_name` VARCHAR(1024),
  `email` VARCHAR(1024),
  `personal_phone` BIGINT,
  `function` VARCHAR(1024),
  `work_phone` BIGINT
);

INSERT INTO `contact_model` (`uuid`,`id_address`,`name`,`first_name`,`email`,`personal_phone`,`function`,`work_phone`)
VALUES
('a8dff5c7-8d88-4fcb-jklo-e4a09de05e36','a8dff5c7-8d88-4fcb-8d24-e4a09de05e36','Dupont','Jean','jean.dupont@example.com',601020304,'Développeur',140234567),
('ecb9d879-9a9b-4d85-jklo-5867e827efb9','ecb9d879-9a9b-4d85-b0b2-5867e827efb9','Martin','Sophie','sophie.martin@example.com',612345678,'Responsable RH',148765432),
('c3f207fa-6327-4d62-jklo-7ac621af68f9','c3f207fa-6327-4d62-9d56-7ac621af68f9','Lemoine','Pierre','pierre.lemoine@example.com',634567890,'Chef de projet',132456789),
('b4c8a9c2-e524-4f59-jklo-054b73057465','b4c8a9c2-e524-4f59-9f91-054b73057465','Leblanc','Claire','claire.leblanc@example.com',622334455,'Marketing Manager',145667788),
('a1b08f23-84b9-4eac-jklo-97c7cd1fd0c1','a1b08f23-84b9-4eac-9483-97c7cd1fd0c1','Pires','Lucas','lucas.pires@example.com',701020304,'Développeur Backend',150234567),
('b4f9a7da-0b09-4e42-jklo-06be4327f1e4','b4f9a7da-0b09-4e42-81c4-06be4327f1e4','Tremblay','Alice','alice.tremblay@example.com',712345678,'Chef de produit',178765432),
('c8bb4f84-d394-40c9-jklo-9b292f27f4ff','c8bb4f84-d394-40c9-b215-9b292f27f4ff','Fournier','Éric','eric.fournier@example.com',722334455,'Directeur technique',132345678);

CREATE TABLE IF NOT EXISTS `address_model` (
  `uuid` VARCHAR(1024),
  `number` BIGINT,
  `street` VARCHAR(1024),
  `postal_code` BIGINT,
  `city` VARCHAR(1024),
  `country` VARCHAR(1024),
  `address_complement` VARCHAR(1024),
  `additional_information` VARCHAR(1024)
);

INSERT INTO `address_model` (`uuid`,`number`,`street`,`postal_code`,`city`,`country`,`address_complement`,`additional_information`)
VALUES
('a8dff5c7-8d88-4fcb-8d24-e4a09de05e36',10,'Rue des Acacias',75001,'Paris','France','Appartement 12','Résidence sécurisée'),
('ecb9d879-9a9b-4d85-b0b2-5867e827efb9',25,'Avenue de la République',69001,'Lyon','France','Bâtiment B','Près du parc'),
('c3f207fa-6327-4d62-9d56-7ac621af68f9',45,'Boulevard de la Liberté',13001,'Marseille','France','Escalier A','Immeuble ancien'),
('b4c8a9c2-e524-4f59-9f91-054b73057465',3,'Place des Vosges',75003,'Paris','France','Rez-de-chaussée','Boutique en façade'),
('a1b08f23-84b9-4eac-9483-97c7cd1fd0c1',15,'Avenue des Champs-Élysées',75008,'Paris','France','Appartement 5','Immeuble moderne'),
('b4f9a7da-0b09-4e42-81c4-06be4327f1e4',100,'Rue de la Paix',69002,'Lyon','France','Bâtiment A','Près du centre commercial'),
('c8bb4f84-d394-40c9-b215-9b292f27f4ff',75,'Boulevard Haussmann',75009,'Paris','France','3ème étage','Immeuble bien situé');


-- User & Group
drop user if exists admin@localhost;
flush privileges;
 
-- Créer un utilisateur avec un mot de passe
CREATE USER 'admin'@'localhost' IDENTIFIED BY '1234';
 
-- Accorder tous les privilèges à cet utilisateur sur la base de données
GRANT ALL PRIVILEGES ON projet.* TO 'admin'@'localhost';
 
-- Appliquer les changements
FLUSH PRIVILEGES;

CREATE TABLE IF NOT EXISTS user_profile (
	profile_id VARCHAR(16) PRIMARY KEY,
	`description` VARCHAR(500),
	access_level TINYINT DEFAULT '3'
);

CREATE TABLE IF NOT EXISTS token (
    token_id VARCHAR(16) NOT NULL PRIMARY KEY,
    date_created DATETIME DEFAULT CURRENT_TIMESTAMP,
    date_expiration DATETIME NOT NULL,
    status_token BOOL NOT NULL
);
 
 CREATE TABLE IF NOT EXISTS membership (
	membership_id VARCHAR(16) PRIMARY KEY,
    address_id VARCHAR(16) DEFAULT NULL,
    profile_id VARCHAR(16) DEFAULT NULL,
    token_id VARCHAR(16) DEFAULT NULL,
    username VARCHAR(50) NOT NULL,
    passwd VARCHAR(255) NOT NULL,
    date_created DATETIME DEFAULT CURRENT_TIMESTAMP,
    date_last_connection DATETIME,
    status_user BOOL NOT NULL
);

INSERT INTO token (token_id, date_created, date_expiration, status_token) VALUES
('T1', '2025-01-01 10:00:00', '2025-01-15 10:00:00', TRUE),
('T2', '2025-01-02 11:00:00', '2025-01-16 11:00:00', FALSE),
('T3', '2025-01-03 12:00:00', '2025-01-17 12:00:00', TRUE),
('T4', '2025-01-04 13:00:00', '2025-01-18 13:00:00', FALSE),
('T5', '2025-01-05 14:00:00', '2025-01-19 14:00:00', TRUE),
('T6', '2025-01-06 15:00:00', '2025-01-20 15:00:00', FALSE),
('T7', '2025-01-07 16:00:00', '2025-01-21 16:00:00', TRUE),
('T8', '2025-01-08 17:00:00', '2025-01-22 17:00:00', FALSE),
('T9', '2025-01-09 18:00:00', '2025-01-23 18:00:00', TRUE),
('T10', '2025-01-10 19:00:00', '2025-01-24 19:00:00', TRUE);

INSERT INTO user_profile (profile_id, `description`, access_level) 
VALUES 
    ('admin', 'Administrators with full access', '1'),
    ('CE', 'Comité d\'entreprise with limited management rights', '2'),
    ('member', 'Regular members with basic access rights', '3');

INSERT INTO membership (membership_id, address_id, profile_id, token_id, username, passwd, date_created, date_last_connection, status_user) VALUES
('U1', '21f677b9208f4267', 'admin', 'T1', 'JohnDoe', 'password123', '2025-01-01 10:00:00', '2025-01-05 12:00:00', TRUE),
('U2', '98a93e53af4d4e73', 'CE', 'T2', 'JaneSmith', 'securePwd!', '2025-01-02 11:00:00', '2025-01-06 13:00:00', FALSE),
('U3', 'c9da74b4866e4887', 'member', 'T3', 'AliceBrown', 'mypassword', '2025-01-03 12:00:00', '2025-01-07 14:00:00', TRUE),
('U4', '30ed287364034a96', 'member', 'T4', 'BobJohnson', '12345secure', '2025-01-04 13:00:00', '2025-01-08 15:00:00', FALSE),
('U5', 'd1a3cca12d644e2f', 'admin', 'T5', 'CharlieGreen', 'topSecret', '2025-01-05 14:00:00', '2025-01-09 16:00:00', TRUE),
('U6', '0cfb42171c144c0c', 'CE', 'T6', 'DianaWhite', 'password!', '2025-01-06 15:00:00', '2025-01-10 17:00:00', FALSE),
('U7', '4054becb441d4d6a', 'member',  'T7', 'EvanBlue', '123Secure!', '2025-01-07 16:00:00', '2025-01-11 18:00:00', TRUE),
('U8', '91ec6421a9494ab3', 'CE','T8', 'FionaRed', 'mySuperPass', '2025-01-08 17:00:00', '2025-01-12 19:00:00', FALSE),
('U9', '9a39e3bc67c44c6a', 'member', 'T9', 'GeorgeBlack', 'password#1', '2025-01-09 18:00:00', '2025-01-13 20:00:00', TRUE),
('U10', '21ad8e6bf14643ea', 'member', 'T10', 'HannahYellow', 'Yellow@123', '2025-01-10 19:00:00', '2025-01-14 21:00:00', TRUE);


-- CRM
CREATE TABLE IF NOT EXISTS `tickets` (
  `uuid_ticket` varchar(255) NOT NULL,
  `uuid_client` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_update` datetime DEFAULT NULL,
  `status` enum('UNSTARTED','IN_PROGRESS','ENDED','CANCELLED') NOT NULL,
  `priority` enum('LOW','NORMAL','HIGH') NOT NULL,
  `request_type` enum('SUPPORT','FEATURE_REQUEST','BUG_REPORT') NOT NULL,
  `source` enum('EMAIL','PHONE','VISIT','WEB_FORM') NOT NULL,
  `comments` varchar(255) NOT NULL
);

INSERT INTO `tickets` (`uuid_ticket`, `uuid_client`, `title`, `description`, `date_created`, `date_update`, `status`, `priority`, `request_type`, `source`, `comments`) VALUES
('0f8289bc-b47f-45ba-90cc-ea65c88ea537', 'adff7b9d-b45f-450d-9245-e70c943d238b', 'Feature Request: Multi-Language Support', 'Add multi-language support to the platform for better accessibility across regions.', '2025-01-07 12:00:00', '2025-01-07 12:10:00', 'UNSTARTED', 'NORMAL', 'FEATURE_REQUEST', 'WEB_FORM', 'Clients from different regions requesting language support.'),
('6c6d5e7e-40a9-456d-b8a1-bd6b11525d32', 'a132d27e-0df9-4268-9cb6-c798df55f9c4', 'Bug Report: Form Submission Error', 'There is a bug when submitting forms on the website, it throws a 500 error.', '2025-01-07 11:00:00', '2025-01-07 11:05:00', 'IN_PROGRESS', 'NORMAL', 'BUG_REPORT', 'WEB_FORM', 'Issue reported after form submission, blocking users from completing their actions.'),
('7da01685-c09b-4ec5-a37e-07b773748f19', 'd02c10fd-3cd1-4d93-bef1-520f14a983ac', 'Bug Report: Login Failure', 'Unable to log in to the platform after resetting the password, it still says invalid credentials.', '2025-01-07 12:30:00', '2025-01-07 12:40:00', 'IN_PROGRESS', 'HIGH', 'BUG_REPORT', 'PHONE', 'Critical issue, preventing users from accessing their accounts.'),
('a7f0b0d0-b16f-40e5-888f-bfbe52ff6298', '4fd627aa-07f9-48c2-a477-d56b2513b8bb', 'Technical Support Request', 'I am unable to connect to the internet through the company network.', '2025-01-07 08:15:00', '2025-01-07 08:20:00', 'IN_PROGRESS', 'HIGH', 'SUPPORT', 'PHONE', 'Urgent issue due to network downtime.'),
('b6ad6b56-6747-4f6f-8cc4-1b80c77c8391', '7f4f0eac-d8d1-47ef-9bda-531052303d39', 'Bug Report: Login Page Issue', 'There seems to be an issue with logging in via the mobile app, it crashes the app every time.', '2025-01-07 09:30:00', '2025-01-07 09:45:00', 'IN_PROGRESS', 'LOW', 'BUG_REPORT', 'PHONE', 'User experiencing crashes during login on mobile app.'),
('cdb95ab1-6125-4a0a-8b1e-9ea5575c76f5', 'e5877f57-2be0-4e5d-bc30-fb7422c3c6ac', 'Support: Account Verification Issue', 'I am unable to verify my account using the provided code.', '2025-01-07 11:30:00', '2025-01-07 11:40:00', 'UNSTARTED', 'LOW', 'SUPPORT', 'PHONE', 'Customer unable to verify account due to incorrect code.'),
('e2f25d5b-d5a9-4664-9789-b2d383fc9d72', '2f5f10be-3777-44f5-91c3-e1d6720a59bc', 'Feature Request for New Dashboard', 'Please add a customizable dashboard for users to manage their tasks more efficiently.', '2025-01-07 09:00:00', '2025-01-07 09:15:00', 'UNSTARTED', 'NORMAL', 'FEATURE_REQUEST', 'WEB_FORM', 'Client is requesting a feature to improve workflow.'),
('e3a2a9d3-b081-4714-b287-d3545b059697', 'f38c40f8-1d47-4c3b-b6d5-37d7d82d4163', 'Feature Request: Custom Reports', 'A request for a custom reporting feature that allows users to generate reports based on various criteria.', '2025-01-07 10:15:00', '2025-01-07 10:30:00', 'IN_PROGRESS', 'HIGH', 'FEATURE_REQUEST', 'WEB_FORM', 'High demand from users for advanced reporting functionality.'),
('fbc2de19-73b5-44f2-8ad7-7f42453eaee8', 'd2dced8d-5f56-4e5d-bd8f-209a61ac0100', 'Support Request: Password Reset', 'I forgot my password and need to reset it to access my account.', '2025-01-07 10:00:00', '2025-01-07 10:05:00', 'UNSTARTED', 'NORMAL', 'SUPPORT', 'EMAIL', 'Client is unable to access their account due to a forgotten password.');

CREATE TABLE IF NOT EXISTS `ticket_actions` (
  `uuid_action` varchar(255) NOT NULL,
  `ticket` varchar(255) NOT NULL,
  `date_action` datetime DEFAULT NULL,
  `action_type` enum('CREATION','UPDATE','DELETION') NOT NULL,
  `description` text DEFAULT NULL,
  `uuid_user` varchar(255) NOT NULL
);

INSERT INTO `ticket_actions` (`uuid_action`, `ticket`, `date_action`, `action_type`, `description`, `uuid_user`) VALUES
('14cdda53-c4de-4b14-8e52-f346afc9d9ea', 'b6ad6b56-6747-4f6f-8cc4-1b80c77c8391', '2025-01-07 10:00:00', 'DELETION', 'Ticket deleted due to duplicate entry.', 'user-003'),
('30de9c7d-9dfd-4f8b-bc03-0dc8b6e8e2b5', 'e3a2a9d3-b081-4714-b287-d3545b059697', '2025-01-07 11:45:00', 'CREATION', 'Created feature request for advanced reporting functionality.', 'user-005'),
('7ab907d6-f38b-45f4-8c12-0736b0c4b1fc', 'e2f25d5b-d5a9-4664-9789-b2d383fc9d72', '2025-01-07 11:15:00', 'UPDATE', 'Added a comment: Client requested faster response time.', 'user-004'),
('8de56f1e-b0e6-4a32-9b7a-c79d1f42c5e4', 'cdb95ab1-6125-4a0a-8b1e-9ea5575c76f5', '2025-01-07 13:00:00', 'DELETION', 'Deleted ticket due to customer request.', 'user-008'),
('ac8d3f1a-23e4-4829-99b4-650db5db4cb1', 'a7f0b0d0-b16f-40e5-888f-bfbe52ff6298', '2025-01-07 08:15:00', 'CREATION', 'Ticket created for network issue resolution.', 'user-001'),
('d6c43b1c-9e2a-4e62-859f-fd4b45c7d8f9', '0f8289bc-b47f-45ba-90cc-ea65c88ea537', '2025-01-07 14:00:00', 'UPDATE', 'Status changed from UNSTARTED to IN_PROGRESS.', 'user-009'),
('e4d6f92c-98c3-4dfb-85b3-7c83b2e7c85d', '7da01685-c09b-4ec5-a37e-07b773748f19', '2025-01-07 12:30:00', 'CREATION', 'Bug reported: Unable to log in with reset password.', 'user-007'),
('e9d6f7c1-8835-4411-8b6d-7c435a7c7913', 'a7f0b0d0-b16f-40e5-888f-bfbe52ff6298', '2025-01-07 09:00:00', 'UPDATE', 'Priority updated to HIGH due to user escalation.', 'user-002'),
('f5d45b1b-e237-49c4-8db4-17c5f70dc2fa', 'b6ad6b56-6747-4f6f-8cc4-1b80c77c8391', '2025-01-07 12:00:00', 'UPDATE', 'Corrected description: Removed duplicate information.', 'user-006'),
('f9d84e6d-8b1a-4cfc-91c3-d82f9b3c7e54', 'fbc2de19-73b5-44f2-8ad7-7f42453eaee8', '2025-01-07 14:30:00', 'CREATION', 'Created support ticket for password reset.', 'user-010');

CREATE TABLE IF NOT EXISTS `ticket_tasks` (
  `uuid_task` varchar(255) NOT NULL,
  `ticket` varchar(255) NOT NULL,
  `date_reminder` datetime DEFAULT NULL,
  `description` text DEFAULT NULL,
  `uuid_user` varchar(255) NOT NULL
);

INSERT INTO `ticket_tasks` (`uuid_task`, `ticket`, `date_reminder`, `description`, `uuid_user`) VALUES
('task-001', 'ticket-001', '2025-01-08 10:00:00', 'Check the status of the ticket and update the client.', 'user-001'),
('task-002', 'ticket-002', '2025-01-08 14:00:00', 'Call the client to gather additional information on the issue.', 'user-002'),
('task-003', 'ticket-003', '2025-01-09 09:30:00', 'Test the fix applied to the reported bug.', 'user-003'),
('task-004', 'ticket-004', '2025-01-09 11:00:00', 'Schedule a team meeting to discuss the feature request.', 'user-004'),
('task-005', 'ticket-005', '2025-01-09 16:00:00', 'Document the resolution steps taken for future reference.', 'user-005'),
('task-006', 'ticket-006', '2025-01-10 10:00:00', 'Send a follow-up email to the client for feedback on the resolved ticket.', 'user-006'),
('task-007', 'ticket-007', '2025-01-10 15:00:00', 'Check the server logs for additional details related to the reported issue.', 'user-007'),
('task-008', 'ticket-008', '2025-01-11 08:30:00', 'Reassign the ticket to a more experienced support agent.', 'user-008'),
('task-009', 'ticket-009', '2025-01-11 13:00:00', 'Prepare a root cause analysis report for the incident.', 'user-009'),
('task-010', 'ticket-010', '2025-01-11 17:00:00', 'Update the client on the progress of their feature request.', 'user-010');


ALTER TABLE `tickets`
  ADD PRIMARY KEY (`uuid_ticket`);
  
ALTER TABLE `ticket_actions`
  ADD PRIMARY KEY (`uuid_action`);

ALTER TABLE `ticket_tasks`
  ADD PRIMARY KEY (`uuid_task`);
COMMIT;


-- Order & Transaction
CREATE TABLE IF NOT EXISTS `order` (
  `id_order` int NOT NULL AUTO_INCREMENT,
  `uuid_order` varchar(255) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_update` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `total_amount` float DEFAULT NULL,
  `id_item` int DEFAULT NULL,
  `uuid_item` varchar(255) DEFAULT NULL,
  `item_type` varchar(50) DEFAULT NULL,
  `id_user` int DEFAULT NULL,
  `uuid_user` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id_order`)
);

INSERT INTO `order` VALUES (1,'ef4f7b2e-cce3-11ef-b916-b48c9d6df3cd','2025-01-01 00:00:00','2025-01-02 00:00:00','PENDING',100.5,1,'4b357396-cce4-11ef-b916-b48c9d6df3cd','PRODUCT',1,'45e2ef5e-cce4-11ef-b916-b48c9d6df3cd','First order description'),(2,'ef4f8184-cce3-11ef-b916-b48c9d6df3cd','2025-01-03 00:00:00','2025-01-04 00:00:00','FINISHED',250,2,'4b3579db-cce4-11ef-b916-b48c9d6df3cd','APPARTMENT',2,'45e2f5ae-cce4-11ef-b916-b48c9d6df3cd','Second order description'),(3,'ef4f8326-cce3-11ef-b916-b48c9d6df3cd','2025-01-05 00:00:00','2025-01-06 00:00:00','CANCELLED',75.75,3,'4b357b93-cce4-11ef-b916-b48c9d6df3cd','PRODUCT',3,'45e2f864-cce4-11ef-b916-b48c9d6df3cd','Third order description');

CREATE TABLE IF NOT EXISTS `transaction` (
  `id_transaction` int NOT NULL AUTO_INCREMENT,
  `uuid_transaction` varchar(255) DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `id_order` int DEFAULT NULL,
  `transaction_status` varchar(50) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_update` datetime DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id_transaction`)
);

INSERT INTO `transaction` VALUES (1,'f1714d93-cce3-11ef-b916-b48c9d6df3cd',100.5,'CARD',1,'SUCCESS','2025-01-01 00:00:00','2025-01-02 00:00:00','Transaction for the first order'),(2,'f17152ea-cce3-11ef-b916-b48c9d6df3cd',250,'PAYPAL',2,'FAILED','2025-01-03 00:00:00','2025-01-04 00:00:00','Transaction for the second order'),(3,'f1715454-cce3-11ef-b916-b48c9d6df3cd',75.75,'CASH',3,'PENDING','2025-01-05 00:00:00','2025-01-06 00:00:00','Transaction for the third order');


-- Experience Management
drop user if exists admin@localhost;
flush privileges;

-- Créer un utilisateur avec un mot de passe
CREATE USER 'admin'@'localhost' IDENTIFIED BY '1234';
-- Accorder tous les privilèges à cet utilisateur sur la base de données
GRANT ALL PRIVILEGES ON projet.* TO 'admin'@'localhost';

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
    image VARCHAR(1000),
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
    image VARCHAR(1000),
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
(UUID(), 'Great Service', '2025-01-01', 'The service was excellent.', 'https://s1.qwant.com/thumbr/474x276/9/8/c42c230a8bc020f6310ae4b71c4c42022da991609537a1becc97473f58b9f2/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JBgkfc58cJpGJH5q4IJykwHaEU%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x289/6/e/e25850329c7b4278eed1d4cc58a85426d9871067537241e63027680c04e37a/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.NXaAFLYF5XF8b7z5t_FlTAHaEh%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 100, '2025-01-02', '517516e7-4e8a-4765-91d5-ec87012e227d', 'order1', FALSE),
(UUID(), 'Website Issue', '2025-01-03', 'The website is slow.', 'https://s2.qwant.com/thumbr/474x320/c/f/492094b9800aadbb702e7141b3b2bd9ac895335fdecd85886c262cd8895697/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.8WATDTFnBgfmtq_UW8ETYwHaFA%26pid%3DApi&q=0&b=1&p=0&a=0', 3, 50, '2025-01-04', '90ec858e-9537-484a-8bac-9f6b261964b6', 'order2', FALSE),
(UUID(), 'Product Feedback', '2025-01-05', 'The product quality is great.', 'https://s1.qwant.com/thumbr/474x231/9/1/8db3257d1994550b4bc14c7dc351c9f528b873c528dea9e9daf3f168673a74/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.VfbXmyDPxrOphpKFAA6ffQHaDn%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 30, '2025-01-06', 'e1edf453-3921-43c3-bccc-ded818a79fdc', 'order3', FALSE),
(UUID(), 'Delivery Delay', '2025-01-07', 'Delivery took longer than expected.', 'https://s1.qwant.com/thumbr/474x474/1/b/834f8d5dc554a0709a3f70e7cad34f1e558cc8d1f77013cae6c0e299d47128/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.k-AT3sq6P5ypGdIemTXt0wHaHa%26pid%3DApi&q=0&b=1&p=0&a=0', 2, 80, '2025-01-08', 'ac715e9b-07df-45d4-9a78-e544348a6341', 'order4', FALSE),
(UUID(), 'Amazing Support', '2025-01-09', 'Customer support was very helpful.', 'https://s2.qwant.com/thumbr/474x341/7/2/b7edd8f78ecec8c89c2cd0c19a32705c2c1bd51677573f0649d0979d930222/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.oiw7JubpqPk1edbTbUHp5gHaFV%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x252/f/c/cddbc80f7d93e3cdd3d8f3985249028886064b638f856da42caa850f44482d/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.mmp1qvh2tivUtaX5TdIMgQHaD8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x316/b/4/b5a50410c5341f73ca5a18ab9254b3d167eda3c310c9b63f906450bd79ad96/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqMaXZwODC-ut6CID30aJwHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 120, '2025-01-10', '88a90300-a0e6-41b9-be12-1ba08b1580ba', 'order5', FALSE),
(UUID(), 'Poor Packaging', '2025-01-11', 'The packaging was damaged.', 'https://s2.qwant.com/thumbr/474x247/f/5/3da5c73521335607a3b8065126ecc48ff5f83cdf9c8a43dfd217bf0cb24f35/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.ByJeIa8hbgdnPl60XKNBvAHaD3%26pid%3DApi&q=0&b=1&p=0&a=0', 2, 40, '2025-01-12', '8382ffbd-4e4e-4ad4-b013-7839df25e5c5', 'order6', FALSE),
(UUID(), 'Excellent App', '2025-01-13', 'The app is user-friendly and intuitive.', 'https://s2.qwant.com/thumbr/474x474/6/4/7645c36f1e457c51dcb1a730633ce0486e7a2b67dd4801962db912c17218f0/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.hBkVif1WxxOO-qENcTrSjwAAAA%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x355/b/9/606896385399da416f2ed29fa5205e5c5127f21d04a51d885570bbc835b16f/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JV8GEmzenqLIo4VIi2oW_gHaFj%26pid%3DApi&q=0&b=1&p=0&a=0', 3, 200, '2025-01-14', '4407f89a-753c-4238-ac4b-f94a3bbc9b1c', 'order7', FALSE),
(UUID(), 'Refund Issue', '2025-01-15', 'Refund process was complicated.', 'https://s2.qwant.com/thumbr/474x315/e/c/048b161a6243703307038f4c643af1a086e50cefc533065f9b23ab17ff35f7/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.jdDkMquF46Bd9LLubksm_QHaE7%26pid%3DApi&q=0&b=1&p=0&a=0', 4, 30, '2025-01-16', '65b48d47-c060-4023-882f-89074e921ee6', 'order8', FALSE),
(UUID(), 'Quick Delivery', '2025-01-17', 'The order was delivered quickly.', 'https://s2.qwant.com/thumbr/474x199/7/7/5f58be9f92a81e0abe7c45746311023fa7381532ff20820080ad20c0758e3c/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP._CILpCrsaVEtArQLFz9XWgHaDH%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 150, '2025-01-18', 'ca46107a-e113-41e2-a523-0dac4a6d8aee', 'order9', FALSE),
(UUID(), 'Misleading Product', '2025-01-19', 'The product was not as described.', 'https://s1.qwant.com/thumbr/474x276/9/8/c42c230a8bc020f6310ae4b71c4c42022da991609537a1becc97473f58b9f2/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JBgkfc58cJpGJH5q4IJykwHaEU%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x289/6/e/e25850329c7b4278eed1d4cc58a85426d9871067537241e63027680c04e37a/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.NXaAFLYF5XF8b7z5t_FlTAHaEh%26pid%3DApi&q=0&b=1&p=0&a=0', 2, 25, '2025-01-20', '3e75fda5-df43-4d84-93f5-d590cd9830a0', 'order10', FALSE),
(UUID(), 'Easy Return Process', '2025-01-21', 'Returning the product was hassle-free.', 'https://s2.qwant.com/thumbr/474x320/c/f/492094b9800aadbb702e7141b3b2bd9ac895335fdecd85886c262cd8895697/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.8WATDTFnBgfmtq_UW8ETYwHaFA%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 70, '2025-01-22', '78f125b1-29c9-453c-98e3-ec2ead9bd314', 'order11', FALSE),
(UUID(), 'High Price', '2025-01-23', 'The product is overpriced.', 'https://s2.qwant.com/thumbr/474x320/c/f/492094b9800aadbb702e7141b3b2bd9ac895335fdecd85886c262cd8895697/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.8WATDTFnBgfmtq_UW8ETYwHaFA%26pid%3DApi&q=0&b=1&p=0&a=0', 3, 60, '2025-01-24', 'd1b5007c-a1bf-4afa-a46d-5d5fdb7c79cd', 'order12', FALSE),
(UUID(), 'Good Quality', '2025-01-25', 'The product is of high quality.', 'https://s2.qwant.com/thumbr/474x320/c/f/492094b9800aadbb702e7141b3b2bd9ac895335fdecd85886c262cd8895697/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.8WATDTFnBgfmtq_UW8ETYwHaFA%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 90, '2025-01-26', '887ffa4f-63a2-41f1-b0e8-45857bf366ed', 'order13', FALSE),
(UUID(), 'Bad Experience', '2025-01-27', 'The overall experience was disappointing.', 'https://s2.qwant.com/thumbr/474x320/c/f/492094b9800aadbb702e7141b3b2bd9ac895335fdecd85886c262cd8895697/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.8WATDTFnBgfmtq_UW8ETYwHaFA%26pid%3DApi&q=0&b=1&p=0&a=0', 4, 20, '2025-01-28', '8fae166d-33b9-4bf8-97e8-0eb6ddb0955b', 'order14', FALSE),
(UUID(), 'Fast Shipping', '2025-01-29', 'The shipping was very fast.', 'https://s2.qwant.com/thumbr/474x320/c/f/492094b9800aadbb702e7141b3b2bd9ac895335fdecd85886c262cd8895697/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.8WATDTFnBgfmtq_UW8ETYwHaFA%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 110, '2025-01-30', '14e2d59e-32d6-40a8-b1f1-bfbd93931020', 'order15', FALSE),
(UUID(), 'Poor Service', '2025-01-31', 'The service was not up to the mark.', 'https://s2.qwant.com/thumbr/474x320/c/f/492094b9800aadbb702e7141b3b2bd9ac895335fdecd85886c262cd8895697/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.8WATDTFnBgfmtq_UW8ETYwHaFA%26pid%3DApi&q=0&b=1&p=0&a=0', 2, 55, '2025-02-01', 'ac5ccd32-a1da-4960-b2db-4996bf8d71b9', 'order16', FALSE),
(UUID(), 'Great Deal', '2025-02-02', 'Got a great deal on the product.', 'https://s2.qwant.com/thumbr/474x320/c/f/492094b9800aadbb702e7141b3b2bd9ac895335fdecd85886c262cd8895697/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.8WATDTFnBgfmtq_UW8ETYwHaFA%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 130, '2025-02-03', 'e8735c6d-19ba-4f3b-850b-cdab28e58c58', 'order17', FALSE),
(UUID(), 'Incorrect Order', '2025-02-04', 'Received the wrong product.', 'https://s1.qwant.com/thumbr/474x276/9/8/c42c230a8bc020f6310ae4b71c4c42022da991609537a1becc97473f58b9f2/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JBgkfc58cJpGJH5q4IJykwHaEU%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x289/6/e/e25850329c7b4278eed1d4cc58a85426d9871067537241e63027680c04e37a/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.NXaAFLYF5XF8b7z5t_FlTAHaEh%26pid%3DApi&q=0&b=1&p=0&a=0', 3, 45, '2025-02-05', '4fb60321-b245-4199-a273-d864ed4e8780', 'order18', FALSE),
(UUID(), 'Excellent Quality', '2025-02-06', 'The product quality is excellent.', 'https://s1.qwant.com/thumbr/474x231/9/1/8db3257d1994550b4bc14c7dc351c9f528b873c528dea9e9daf3f168673a74/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.VfbXmyDPxrOphpKFAA6ffQHaDn%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 140, '2025-02-07', '7d3ccf83-edc1-4d77-870a-20d15b553e60', 'order19', FALSE),
(UUID(), 'Delayed Response', '2025-02-08', 'Customer support response was delayed.', 'https://s1.qwant.com/thumbr/474x231/9/1/8db3257d1994550b4bc14c7dc351c9f528b873c528dea9e9daf3f168673a74/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.VfbXmyDPxrOphpKFAA6ffQHaDn%26pid%3DApi&q=0&b=1&p=0&a=0', 2, 75, '2025-02-09', 'f125a170-b480-415d-9c32-e9ffaa3cf043', 'order20', FALSE),
(UUID(), 'Easy to Use', '2025-02-10', 'The product is very easy to use.', 'https://s1.qwant.com/thumbr/474x231/9/1/8db3257d1994550b4bc14c7dc351c9f528b873c528dea9e9daf3f168673a74/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.VfbXmyDPxrOphpKFAA6ffQHaDn%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 105, '2025-02-11', '806bf56d-10f5-40ce-839c-1da507089623', 'order21', FALSE),
(UUID(), 'Damaged Item', '2025-02-12', 'The product arrived damaged.', 'https://s1.qwant.com/thumbr/474x231/9/1/8db3257d1994550b4bc14c7dc351c9f528b873c528dea9e9daf3f168673a74/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.VfbXmyDPxrOphpKFAA6ffQHaDn%26pid%3DApi&q=0&b=1&p=0&a=0', 4, 35, '2025-02-13', 'a2ae6969-8dba-464a-aff0-d1d037374c0f', 'order22', FALSE),
(UUID(), 'Quick Resolution', '2025-02-14', 'The issue was resolved quickly.', 'https://s1.qwant.com/thumbr/474x231/9/1/8db3257d1994550b4bc14c7dc351c9f528b873c528dea9e9daf3f168673a74/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.VfbXmyDPxrOphpKFAA6ffQHaDn%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 125, '2025-02-15', '6e18a343-baa2-4400-a48a-bd695105ab7f', 'order23', FALSE),
(UUID(), 'Out of Stock', '2025-02-16', 'The product was out of stock.', 'https://s1.qwant.com/thumbr/474x231/9/1/8db3257d1994550b4bc14c7dc351c9f528b873c528dea9e9daf3f168673a74/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.VfbXmyDPxrOphpKFAA6ffQHaDn%26pid%3DApi&q=0&b=1&p=0&a=0', 3, 50, '2025-02-17', '87694617-325d-4620-b40e-dc5581c399c5', 'order24', FALSE),
(UUID(), 'Helpful Staff', '2025-02-18', 'The staff was very helpful.', 'https://s1.qwant.com/thumbr/474x231/9/1/8db3257d1994550b4bc14c7dc351c9f528b873c528dea9e9daf3f168673a74/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.VfbXmyDPxrOphpKFAA6ffQHaDn%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 135, '2025-02-19', 'f7b26b88-9bae-4a6f-8021-64efb6d1d45b', 'order25', FALSE),
(UUID(), 'Incomplete Order', '2025-02-20', 'The order was incomplete.', 'https://s1.qwant.com/thumbr/474x276/9/8/c42c230a8bc020f6310ae4b71c4c42022da991609537a1becc97473f58b9f2/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JBgkfc58cJpGJH5q4IJykwHaEU%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x289/6/e/e25850329c7b4278eed1d4cc58a85426d9871067537241e63027680c04e37a/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.NXaAFLYF5XF8b7z5t_FlTAHaEh%26pid%3DApi&q=0&b=1&p=0&a=0', 2, 65, '2025-02-21', '037e545a-273e-4a65-9519-8dac591ca05e', 'order26', FALSE),
(UUID(), 'Great Features', '2025-02-22', 'The product has great features.', 'https://s1.qwant.com/thumbr/474x231/9/1/8db3257d1994550b4bc14c7dc351c9f528b873c528dea9e9daf3f168673a74/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.VfbXmyDPxrOphpKFAA6ffQHaDn%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 145, '2025-02-23', '635626c0-2c94-4abf-b6fa-19fe7acf6a42', 'order27', FALSE),
(UUID(), 'Long Wait', '2025-02-24', 'Had to wait a long time for support.', 'https://s1.qwant.com/thumbr/474x231/9/1/8db3257d1994550b4bc14c7dc351c9f528b873c528dea9e9daf3f168673a74/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.VfbXmyDPxrOphpKFAA6ffQHaDn%26pid%3DApi&q=0&b=1&p=0&a=0', 3, 40, '2025-02-25', 'c2c5f835-bede-4de2-a5ae-94f0ee6c3407', 'order28', FALSE),
(UUID(), 'Satisfied Customer', '2025-02-26', 'Very satisfied with the purchase.', 'https://s1.qwant.com/thumbr/474x231/9/1/8db3257d1994550b4bc14c7dc351c9f528b873c528dea9e9daf3f168673a74/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.VfbXmyDPxrOphpKFAA6ffQHaDn%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 155, '2025-02-27', '4f8682d5-f44a-468b-8b83-78b6416c4f2b', 'order29', FALSE),
(UUID(), 'Product Defect', '2025-02-28', 'The product had a manufacturing defect.', 'https://s1.qwant.com/thumbr/474x231/9/1/8db3257d1994550b4bc14c7dc351c9f528b873c528dea9e9daf3f168673a74/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.VfbXmyDPxrOphpKFAA6ffQHaDn%26pid%3DApi&q=0&b=1&p=0&a=0', 4, 25, '2025-03-01', 'cff54bd7-e83b-490e-aba8-7d6330c137b7', 'order30', FALSE),
(UUID(), 'Prompt Service', '2025-03-02', 'The service was prompt and efficient.', 'https://s1.qwant.com/thumbr/474x231/9/1/8db3257d1994550b4bc14c7dc351c9f528b873c528dea9e9daf3f168673a74/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.VfbXmyDPxrOphpKFAA6ffQHaDn%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 165, '2025-03-03', 'da0f9809-71cf-4913-bce9-6d7f5b2d6d44', 'order31', FALSE),
(UUID(), 'Complex Setup', '2025-03-04', 'The product setup was too complex.', 'https://s1.qwant.com/thumbr/474x231/9/1/8db3257d1994550b4bc14c7dc351c9f528b873c528dea9e9daf3f168673a74/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.VfbXmyDPxrOphpKFAA6ffQHaDn%26pid%3DApi&q=0&b=1&p=0&a=0', 3, 55, '2025-03-05', '446de252-5d4a-407e-8bb7-481a26c11e21', 'order32', FALSE),
(UUID(), 'Great Value', '2025-03-06', 'The product offers great value for money.', 'https://s1.qwant.com/thumbr/474x231/9/1/8db3257d1994550b4bc14c7dc351c9f528b873c528dea9e9daf3f168673a74/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.VfbXmyDPxrOphpKFAA6ffQHaDn%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 175, '2025-03-07', '526f6e2d-8d05-4f66-b149-17f109660cb6', 'order33', FALSE),
(UUID(), 'Slow Response', '2025-03-08', 'Customer support was slow to respond.', 'https://s1.qwant.com/thumbr/474x276/9/8/c42c230a8bc020f6310ae4b71c4c42022da991609537a1becc97473f58b9f2/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JBgkfc58cJpGJH5q4IJykwHaEU%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x289/6/e/e25850329c7b4278eed1d4cc58a85426d9871067537241e63027680c04e37a/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.NXaAFLYF5XF8b7z5t_FlTAHaEh%26pid%3DApi&q=0&b=1&p=0&a=0', 2, 65, '2025-03-09', 'b0da8980-cf8b-4a55-a692-4f4ae45e6e92', 'order34', FALSE),
(UUID(), 'Amazing Support', '2025-01-09', 'Customer support was very helpful.', 'https://s2.qwant.com/thumbr/474x341/7/2/b7edd8f78ecec8c89c2cd0c19a32705c2c1bd51677573f0649d0979d930222/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.oiw7JubpqPk1edbTbUHp5gHaFV%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x252/f/c/cddbc80f7d93e3cdd3d8f3985249028886064b638f856da42caa850f44482d/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.mmp1qvh2tivUtaX5TdIMgQHaD8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x316/b/4/b5a50410c5341f73ca5a18ab9254b3d167eda3c310c9b63f906450bd79ad96/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqMaXZwODC-ut6CID30aJwHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 185, '2025-03-11', '022d22a1-ad43-4684-8272-d558100f6d5f', 'order35', FALSE),
(UUID(), 'Amazing Support', '2025-01-09', 'Customer support was very helpful.', 'https://s2.qwant.com/thumbr/474x341/7/2/b7edd8f78ecec8c89c2cd0c19a32705c2c1bd51677573f0649d0979d930222/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.oiw7JubpqPk1edbTbUHp5gHaFV%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x252/f/c/cddbc80f7d93e3cdd3d8f3985249028886064b638f856da42caa850f44482d/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.mmp1qvh2tivUtaX5TdIMgQHaD8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x316/b/4/b5a50410c5341f73ca5a18ab9254b3d167eda3c310c9b63f906450bd79ad96/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqMaXZwODC-ut6CID30aJwHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 4, 30, '2025-03-13', 'ce216c39-0275-4d0c-9203-d3a09e7ade51', 'order36', FALSE),
(UUID(), 'Amazing Support', '2025-01-09', 'Customer support was very helpful.', 'https://s2.qwant.com/thumbr/474x341/7/2/b7edd8f78ecec8c89c2cd0c19a32705c2c1bd51677573f0649d0979d930222/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.oiw7JubpqPk1edbTbUHp5gHaFV%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x252/f/c/cddbc80f7d93e3cdd3d8f3985249028886064b638f856da42caa850f44482d/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.mmp1qvh2tivUtaX5TdIMgQHaD8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x316/b/4/b5a50410c5341f73ca5a18ab9254b3d167eda3c310c9b63f906450bd79ad96/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqMaXZwODC-ut6CID30aJwHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 195, '2025-03-15', '7fa9b68b-80ce-4f5e-8a90-d4e4db57cbb8', 'order37', FALSE),
(UUID(), 'Amazing Support', '2025-01-09', 'Customer support was very helpful.', 'https://s2.qwant.com/thumbr/474x341/7/2/b7edd8f78ecec8c89c2cd0c19a32705c2c1bd51677573f0649d0979d930222/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.oiw7JubpqPk1edbTbUHp5gHaFV%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x252/f/c/cddbc80f7d93e3cdd3d8f3985249028886064b638f856da42caa850f44482d/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.mmp1qvh2tivUtaX5TdIMgQHaD8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x316/b/4/b5a50410c5341f73ca5a18ab9254b3d167eda3c310c9b63f906450bd79ad96/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqMaXZwODC-ut6CID30aJwHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 3, 45, '2025-03-17', 'fd8c1b82-9fd1-47fb-ae98-f3f0e8762a27', 'order38', FALSE),
(UUID(), 'Amazing Support', '2025-01-09', 'Customer support was very helpful.', 'https://s2.qwant.com/thumbr/474x341/7/2/b7edd8f78ecec8c89c2cd0c19a32705c2c1bd51677573f0649d0979d930222/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.oiw7JubpqPk1edbTbUHp5gHaFV%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x252/f/c/cddbc80f7d93e3cdd3d8f3985249028886064b638f856da42caa850f44482d/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.mmp1qvh2tivUtaX5TdIMgQHaD8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x316/b/4/b5a50410c5341f73ca5a18ab9254b3d167eda3c310c9b63f906450bd79ad96/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqMaXZwODC-ut6CID30aJwHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 205, '2025-03-19', '9c548d22-7a2d-4c9c-b25a-aa9f6c77d549', 'order39', FALSE),
(UUID(), 'Amazing Support', '2025-01-09', 'Customer support was very helpful.', 'https://s2.qwant.com/thumbr/474x341/7/2/b7edd8f78ecec8c89c2cd0c19a32705c2c1bd51677573f0649d0979d930222/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.oiw7JubpqPk1edbTbUHp5gHaFV%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x252/f/c/cddbc80f7d93e3cdd3d8f3985249028886064b638f856da42caa850f44482d/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.mmp1qvh2tivUtaX5TdIMgQHaD8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x316/b/4/b5a50410c5341f73ca5a18ab9254b3d167eda3c310c9b63f906450bd79ad96/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqMaXZwODC-ut6CID30aJwHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 2, 70, '2025-03-21', '81e426fe-aca1-4941-9936-e3a31ec567f8', 'order40', FALSE),
(UUID(), 'Amazing Support', '2025-01-09', 'Customer support was very helpful.', 'https://s2.qwant.com/thumbr/474x341/7/2/b7edd8f78ecec8c89c2cd0c19a32705c2c1bd51677573f0649d0979d930222/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.oiw7JubpqPk1edbTbUHp5gHaFV%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x252/f/c/cddbc80f7d93e3cdd3d8f3985249028886064b638f856da42caa850f44482d/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.mmp1qvh2tivUtaX5TdIMgQHaD8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x316/b/4/b5a50410c5341f73ca5a18ab9254b3d167eda3c310c9b63f906450bd79ad96/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqMaXZwODC-ut6CID30aJwHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 215, '2025-03-23', 'd78fbf55-a771-4e8d-b8f9-7eb1af8d1c80', 'order41', FALSE),
(UUID(), 'Missing Parts', '2025-03-24', 'Some parts were missing from the order.', 'https://s1.qwant.com/thumbr/474x276/9/8/c42c230a8bc020f6310ae4b71c4c42022da991609537a1becc97473f58b9f2/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JBgkfc58cJpGJH5q4IJykwHaEU%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x289/6/e/e25850329c7b4278eed1d4cc58a85426d9871067537241e63027680c04e37a/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.NXaAFLYF5XF8b7z5t_FlTAHaEh%26pid%3DApi&q=0&b=1&p=0&a=0', 4, 20, '2025-03-25', '61c24e4a-4486-4e7c-bae4-9ceae7aa668a', 'order42', FALSE),
(UUID(), 'Great Experience', '2025-03-26', 'Overall, a great experience.', 'https://s2.qwant.com/thumbr/474x199/7/7/5f58be9f92a81e0abe7c45746311023fa7381532ff20820080ad20c0758e3c/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP._CILpCrsaVEtArQLFz9XWgHaDH%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 225, '2025-03-27', '27d4dce5-42db-4405-8025-5c23b9a67a2d', 'order43', FALSE),
(UUID(), 'Poor Instructions', '2025-03-28', 'The instructions were poor.', 'https://s2.qwant.com/thumbr/474x199/7/7/5f58be9f92a81e0abe7c45746311023fa7381532ff20820080ad20c0758e3c/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP._CILpCrsaVEtArQLFz9XWgHaDH%26pid%3DApi&q=0&b=1&p=0&a=0', 3, 50, '2025-03-29', '4f468dba-2506-44f7-a27a-4d825349d738', 'order44', FALSE),
(UUID(), 'Fast Delivery', '2025-03-30', 'The delivery was very fast.', 'https://s2.qwant.com/thumbr/474x199/7/7/5f58be9f92a81e0abe7c45746311023fa7381532ff20820080ad20c0758e3c/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP._CILpCrsaVEtArQLFz9XWgHaDH%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 235, '2025-03-31', '88a4e4f3-1622-4dda-a8c0-efc421ae9dfa', 'order45', FALSE),
(UUID(), 'Excellent Product', '2025-04-01', 'The product is excellent.', 'https://s2.qwant.com/thumbr/474x199/7/7/5f58be9f92a81e0abe7c45746311023fa7381532ff20820080ad20c0758e3c/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP._CILpCrsaVEtArQLFz9XWgHaDH%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 245, '2025-04-02', '9f0c6aa9-5632-49a2-8c6d-bfe94f04224e', 'order46', FALSE),
(UUID(), 'Difficult Return', '2025-04-03', 'The return process was difficult.', 'https://s2.qwant.com/thumbr/474x199/7/7/5f58be9f92a81e0abe7c45746311023fa7381532ff20820080ad20c0758e3c/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP._CILpCrsaVEtArQLFz9XWgHaDH%26pid%3DApi&q=0&b=1&p=0&a=0', 2, 60, '2025-04-04', 'afa77a96-2166-4db4-b327-3fe9f9cf5d7c', 'order47', FALSE),
(UUID(), 'Great Support', '2025-04-05', 'Customer support was very helpful.', 'https://s2.qwant.com/thumbr/474x199/7/7/5f58be9f92a81e0abe7c45746311023fa7381532ff20820080ad20c0758e3c/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP._CILpCrsaVEtArQLFz9XWgHaDH%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 255, '2025-04-06', 'b89df274-0451-4638-be76-cfd65a0a021e', 'order48', FALSE),
(UUID(), 'Damaged Package', '2025-04-07', 'The package arrived damaged.', 'https://s2.qwant.com/thumbr/474x199/7/7/5f58be9f92a81e0abe7c45746311023fa7381532ff20820080ad20c0758e3c/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP._CILpCrsaVEtArQLFz9XWgHaDH%26pid%3DApi&q=0&b=1&p=0&a=0', 4, 35, '2025-04-08', 'bc68f758-fc66-4b01-85b5-9da9e8953e44', 'order49', FALSE),
(UUID(), 'Quick Service', '2025-04-09', 'The service was quick and efficient.', 'https://s2.qwant.com/thumbr/474x199/7/7/5f58be9f92a81e0abe7c45746311023fa7381532ff20820080ad20c0758e3c/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP._CILpCrsaVEtArQLFz9XWgHaDH%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 265, '2025-04-10', 'aa0aceaa-57c5-4496-9c38-d404b13a40b1', 'order50', FALSE),
(UUID(), 'Great Service', '2025-04-11', 'The service was excellent.', 'https://s2.qwant.com/thumbr/474x315/e/f/7395098a929792583a78feb22e554f9ba3208d73a21c900bce5a3477b0844a/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.xFUf7lgBibAAH3AGhubkgwHaE7%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 100, '2025-04-12', '55668095-f677-4e21-83b7-ce8784946247', 'order51', FALSE),
(UUID(), 'Website Issue', '2025-04-13', 'The website is slow.', 'https://s2.qwant.com/thumbr/474x314/c/4/707e0fee791269ef2e681dab3d74cb76e4d49678a7ea0530262ad1e1c25b65/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.T6Ussg3u2Suxc2OBhY0UEQAAAA%26pid%3DApi&q=0&b=1&p=0&a=0', 3, 50, '2025-04-14', '66ed8a89-c823-4821-9589-859c7ebe8ad2', 'order52', FALSE),
(UUID(), 'Product Feedback', '2025-04-15', 'The product quality is great.', 'https://s2.qwant.com/thumbr/474x270/c/3/e2497aad76637bd0e10564e4725468eb97acde531cbeb1f91e3f27505236d4/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.8XHRGkRx1xfyl65sJNU_FQHaEO%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 30, '2025-04-16', 'f972326e-401c-44ce-bf20-346fbd96222f', 'order53', FALSE),
(UUID(), 'Delivery Delay', '2025-04-17', 'Delivery took longer than expected.', 'https://s2.qwant.com/thumbr/474x284/e/a/508ab393b97f57ae9633c97c9479913a2f7908c3c6dca265edcc97759e24e9/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JN28QxJvYaV58MyP9M1aoAHaEc%26pid%3DApi&q=0&b=1&p=0&a=0', 2, 80, '2025-04-18', 'ae512b71-e1a3-4b40-bf92-917801b3e902', 'order54', FALSE),
(UUID(), 'Amazing Support', '2025-04-19', 'Customer support was very helpful.', 'https://s2.qwant.com/thumbr/474x341/7/2/b7edd8f78ecec8c89c2cd0c19a32705c2c1bd51677573f0649d0979d930222/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.oiw7JubpqPk1edbTbUHp5gHaFV%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x252/f/c/cddbc80f7d93e3cdd3d8f3985249028886064b638f856da42caa850f44482d/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.mmp1qvh2tivUtaX5TdIMgQHaD8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x316/b/4/b5a50410c5341f73ca5a18ab9254b3d167eda3c310c9b63f906450bd79ad96/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqMaXZwODC-ut6CID30aJwHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 120, '2025-04-20', 'adf11883-da54-4ddf-a548-4ba12604033b', 'ef4f7b2e-cce3-11ef-b916-b48c9d6df3cd', FALSE),
(UUID(), 'Poor Packaging', '2025-04-21', 'The packaging was damaged.', 'https://s2.qwant.com/thumbr/474x247/f/5/3da5c73521335607a3b8065126ecc48ff5f83cdf9c8a43dfd217bf0cb24f35/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.ByJeIa8hbgdnPl60XKNBvAHaD3%26pid%3DApi&q=0&b=1&p=0&a=0', 2, 40, '2025-04-22', '1f152489-da9b-4832-80b2-7c6329be6303', 'ef4f8184-cce3-11ef-b916-b48c9d6df3cd', FALSE),
(UUID(), 'Excellent App', '2025-04-23', 'The app is user-friendly and intuitive.', 'https://s2.qwant.com/thumbr/474x474/6/4/7645c36f1e457c51dcb1a730633ce0486e7a2b67dd4801962db912c17218f0/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.hBkVif1WxxOO-qENcTrSjwAAAA%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x355/b/9/606896385399da416f2ed29fa5205e5c5127f21d04a51d885570bbc835b16f/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JV8GEmzenqLIo4VIi2oW_gHaFj%26pid%3DApi&q=0&b=1&p=0&a=0', 3, 200, '2025-04-24', 'cd74daea-7c0e-4e41-bb8f-b49ade29bec3', 'ef4f8326-cce3-11ef-b916-b48c9d6df3cd', FALSE),
(UUID(), 'Refund Issue', '2025-04-25', 'Refund process was complicated.', 'https://s2.qwant.com/thumbr/474x315/e/c/048b161a6243703307038f4c643af1a086e50cefc533065f9b23ab17ff35f7/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.jdDkMquF46Bd9LLubksm_QHaE7%26pid%3DApi&q=0&b=1&p=0&a=0', 4, 30, '2025-04-26', '2e93b113-45b7-48e9-b565-1609aa963305', 'ef4f8568-cce3-11ef-b916-b48c9d6df3cd', FALSE),
(UUID(), 'Quick Delivery', '2025-04-27', 'The order was delivered quickly.', 'https://s2.qwant.com/thumbr/474x199/7/7/5f58be9f92a81e0abe7c45746311023fa7381532ff20820080ad20c0758e3c/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP._CILpCrsaVEtArQLFz9XWgHaDH%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 150, '2025-04-28', 'd41b60e4-2bc0-4eeb-b132-3f958a9c2330', 'ef4f879e-cce3-11ef-b916-b48c9d6df3cd', FALSE),
(UUID(), 'Misleading Product', '2025-04-29', 'The product was not as described.', 'https://s1.qwant.com/thumbr/474x276/9/8/c42c230a8bc020f6310ae4b71c4c42022da991609537a1becc97473f58b9f2/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JBgkfc58cJpGJH5q4IJykwHaEU%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x289/6/e/e25850329c7b4278eed1d4cc58a85426d9871067537241e63027680c04e37a/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.NXaAFLYF5XF8b7z5t_FlTAHaEh%26pid%3DApi&q=0&b=1&p=0&a=0', 2, 25, '2025-04-30', '9e27ba0d-6006-4489-b40a-16fb8ac36ae6', 'ef4f8ae2-cce3-11ef-b916-b48c9d6df3cd', FALSE),
(UUID(), 'Easy Return Process', '2025-05-01', 'Returning the product was hassle-free.', 'https://s2.qwant.com/thumbr/474x315/e/c/048b161a6243703307038f4c643af1a086e50cefc533065f9b23ab17ff35f7/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.jdDkMquF46Bd9LLubksm_QHaE7%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 70, '2025-05-02', 'c8185919-219a-48ea-854e-8db9d4e92a88', 'ef4f8d28-cce3-11ef-b916-b48c9d6df3cd', FALSE),
(UUID(), 'High Price', '2025-05-03', 'The product is overpriced.', 'https://s2.qwant.com/thumbr/474x315/e/c/048b161a6243703307038f4c643af1a086e50cefc533065f9b23ab17ff35f7/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.jdDkMquF46Bd9LLubksm_QHaE7%26pid%3DApi&q=0&b=1&p=0&a=0', 3, 60, '2025-05-04', '6f53dac5-e547-48d4-932c-2efb9770746e', 'ef4f8f6a-cce3-11ef-b916-b48c9d6df3cd', FALSE),
(UUID(), 'Good Quality', '2025-05-05', 'The product is of high quality.', 'https://s2.qwant.com/thumbr/474x315/e/c/048b161a6243703307038f4c643af1a086e50cefc533065f9b23ab17ff35f7/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.jdDkMquF46Bd9LLubksm_QHaE7%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 90, '2025-05-06', 'a33ab7e9-961a-46c2-b832-26225c393335', 'ef4f91c4-cce3-11ef-b916-b48c9d6df3cd', FALSE),
(UUID(), 'Bad Experience', '2025-05-07', 'The overall experience was disappointing.', 'https://s2.qwant.com/thumbr/474x315/e/c/048b161a6243703307038f4c643af1a086e50cefc533065f9b23ab17ff35f7/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.jdDkMquF46Bd9LLubksm_QHaE7%26pid%3DApi&q=0&b=1&p=0&a=0', 4, 20, '2025-05-08', 'e4b4c683-c067-4fa7-82f1-60e448d59afe', 'ef4f93fe-cce3-11ef-b916-b48c9d6df3cd', FALSE),
(UUID(), 'Fast Shipping', '2025-05-09', 'The shipping was very fast.', 'https://s2.qwant.com/thumbr/474x315/e/c/048b161a6243703307038f4c643af1a086e50cefc533065f9b23ab17ff35f7/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.jdDkMquF46Bd9LLubksm_QHaE7%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 110, '2025-05-10', '594a8d3f-53a4-4c1f-a514-71422b837b5b', 'dfc1fd09-0b7a-45bd-9f50-d353ea2e8652', FALSE),
(UUID(), 'Poor Service', '2025-05-11', 'The service was not up to the mark.', 'https://s2.qwant.com/thumbr/474x315/e/c/048b161a6243703307038f4c643af1a086e50cefc533065f9b23ab17ff35f7/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.jdDkMquF46Bd9LLubksm_QHaE7%26pid%3DApi&q=0&b=1&p=0&a=0', 2, 55, '2025-05-12', '2b224bde-1d85-4f2b-9aea-6092ba676f77', 'a43443be-eccb-477c-81b4-a79b07c6a22b', FALSE),
(UUID(), 'Great Deal', '2025-05-13', 'Got a great deal on the product.', 'https://s1.qwant.com/thumbr/474x276/9/8/c42c230a8bc020f6310ae4b71c4c42022da991609537a1becc97473f58b9f2/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JBgkfc58cJpGJH5q4IJykwHaEU%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x289/6/e/e25850329c7b4278eed1d4cc58a85426d9871067537241e63027680c04e37a/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.NXaAFLYF5XF8b7z5t_FlTAHaEh%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 130, '2025-05-14', 'f06c7141-c628-406a-b9f2-ff022831e2a6', '915e4b91-f60d-4980-8f38-4e02d0e02d78', FALSE),
(UUID(), 'Incorrect Order', '2025-05-15', 'Received the wrong product.', 'https://s1.qwant.com/thumbr/474x276/9/8/c42c230a8bc020f6310ae4b71c4c42022da991609537a1becc97473f58b9f2/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JBgkfc58cJpGJH5q4IJykwHaEU%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x289/6/e/e25850329c7b4278eed1d4cc58a85426d9871067537241e63027680c04e37a/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.NXaAFLYF5XF8b7z5t_FlTAHaEh%26pid%3DApi&q=0&b=1&p=0&a=0', 3, 45, '2025-05-16', '2e7311b6-7d07-4073-bde0-9c40f0fe8557', 'dc725f1d-5242-4e11-9f85-bad4a6f2090f', FALSE),
(UUID(), 'Excellent Quality', '2025-05-17', 'The product quality is excellent.', 'https://s1.qwant.com/thumbr/474x276/9/8/c42c230a8bc020f6310ae4b71c4c42022da991609537a1becc97473f58b9f2/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JBgkfc58cJpGJH5q4IJykwHaEU%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x289/6/e/e25850329c7b4278eed1d4cc58a85426d9871067537241e63027680c04e37a/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.NXaAFLYF5XF8b7z5t_FlTAHaEh%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 140, '2025-05-18', 'f619e28f-a0ed-4849-b389-6ded157ad901', '27117cb9-b482-43ac-9c9f-bc91feef4a63', FALSE),
(UUID(), 'Delayed Response', '2025-05-19', 'Customer support response was delayed.', 'https://s1.qwant.com/thumbr/474x276/9/8/c42c230a8bc020f6310ae4b71c4c42022da991609537a1becc97473f58b9f2/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JBgkfc58cJpGJH5q4IJykwHaEU%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x289/6/e/e25850329c7b4278eed1d4cc58a85426d9871067537241e63027680c04e37a/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.NXaAFLYF5XF8b7z5t_FlTAHaEh%26pid%3DApi&q=0&b=1&p=0&a=0', 2, 75, '2025-05-20', '979535d3-7cac-4827-891d-3357bf3aa6c7', '361f8c50-2b99-4003-8c4b-c97abe830549', FALSE),
(UUID(), 'Easy to Use', '2025-05-21', 'The product is very easy to use.', 'https://s1.qwant.com/thumbr/474x276/9/8/c42c230a8bc020f6310ae4b71c4c42022da991609537a1becc97473f58b9f2/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JBgkfc58cJpGJH5q4IJykwHaEU%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x289/6/e/e25850329c7b4278eed1d4cc58a85426d9871067537241e63027680c04e37a/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.NXaAFLYF5XF8b7z5t_FlTAHaEh%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 105, '2025-05-22', '875886d5-d4eb-4362-96fb-206beec6ddad', '2a12ab01-f358-4258-ab49-77487d1a8303', FALSE),
(UUID(), 'Damaged Item', '2025-05-23', 'The product arrived damaged.', 'https://s1.qwant.com/thumbr/474x276/9/8/c42c230a8bc020f6310ae4b71c4c42022da991609537a1becc97473f58b9f2/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JBgkfc58cJpGJH5q4IJykwHaEU%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x289/6/e/e25850329c7b4278eed1d4cc58a85426d9871067537241e63027680c04e37a/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.NXaAFLYF5XF8b7z5t_FlTAHaEh%26pid%3DApi&q=0&b=1&p=0&a=0', 4, 35, '2025-05-24', '85efc017-adf3-44c8-b4fb-6a5a8e0e72ee', '489f8bcd-7a3f-4ef9-942f-2f8d7b573675', FALSE),
(UUID(), 'Quick Resolution', '2025-05-25', 'The issue was resolved quickly.', 'https://s1.qwant.com/thumbr/474x276/9/8/c42c230a8bc020f6310ae4b71c4c42022da991609537a1becc97473f58b9f2/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JBgkfc58cJpGJH5q4IJykwHaEU%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x289/6/e/e25850329c7b4278eed1d4cc58a85426d9871067537241e63027680c04e37a/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.NXaAFLYF5XF8b7z5t_FlTAHaEh%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 125, '2025-05-26', '2d0bd405-bc58-4e07-a00e-2d15b8920ed6', 'b5c8cf0a-fd59-49cd-a060-1d0727226474', FALSE),
(UUID(), 'Out of Stock', '2025-05-27', 'The product was out of stock.', 'https://s1.qwant.com/thumbr/474x276/9/8/c42c230a8bc020f6310ae4b71c4c42022da991609537a1becc97473f58b9f2/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JBgkfc58cJpGJH5q4IJykwHaEU%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x289/6/e/e25850329c7b4278eed1d4cc58a85426d9871067537241e63027680c04e37a/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.NXaAFLYF5XF8b7z5t_FlTAHaEh%26pid%3DApi&q=0&b=1&p=0&a=0', 3, 50, '2025-05-28', '75a204b0-f9cd-4e3d-a11c-072f5ef5abe5', '28262a7b-42b4-41c9-9610-fa6e5e3c5b1f', FALSE),
(UUID(), 'Helpful Staff', '2025-05-29', 'The staff was very helpful.', 'https://s1.qwant.com/thumbr/474x276/9/8/c42c230a8bc020f6310ae4b71c4c42022da991609537a1becc97473f58b9f2/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JBgkfc58cJpGJH5q4IJykwHaEU%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x289/6/e/e25850329c7b4278eed1d4cc58a85426d9871067537241e63027680c04e37a/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.NXaAFLYF5XF8b7z5t_FlTAHaEh%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 135, '2025-05-30', '1fc55114-62f0-4b1d-8531-abab2ab1759f', '2c6395c9-ad93-45c9-86a9-6f8a1637082a', FALSE),
(UUID(), 'Incomplete Order', '2025-05-31', 'The order was incomplete.', 'https://s1.qwant.com/thumbr/474x231/9/1/8db3257d1994550b4bc14c7dc351c9f528b873c528dea9e9daf3f168673a74/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.VfbXmyDPxrOphpKFAA6ffQHaDn%26pid%3DApi&q=0&b=1&p=0&a=0', 2, 65, '2025-06-01', '52f2a2d1-4d12-4f10-95c1-abda7d5200c6', '4284cb6b-84a2-489a-942a-e2308540e4e4', FALSE),
(UUID(), 'Great Features', '2025-06-02', 'The product has great features.', 'https://s1.qwant.com/thumbr/474x231/9/1/8db3257d1994550b4bc14c7dc351c9f528b873c528dea9e9daf3f168673a74/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.VfbXmyDPxrOphpKFAA6ffQHaDn%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 145, '2025-06-03', '9866c4a1-64e1-45f8-869e-db3e1bee55de', 'a06a8145-63f5-4509-9156-f0afb30dd767', FALSE),
(UUID(), 'Long Wait', '2025-06-04', 'Had to wait a long time for support.', 'https://s1.qwant.com/thumbr/474x231/9/1/8db3257d1994550b4bc14c7dc351c9f528b873c528dea9e9daf3f168673a74/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.VfbXmyDPxrOphpKFAA6ffQHaDn%26pid%3DApi&q=0&b=1&p=0&a=0', 3, 40, '2025-06-05', '9fd3b785-4d45-4e2e-ac46-956c83f3be0e', 'b1a54c96-065b-44ba-b201-715a84c99d1f', FALSE),
(UUID(), 'Satisfied Customer', '2025-06-06', 'Very satisfied with the purchase.', 'https://s1.qwant.com/thumbr/474x231/9/1/8db3257d1994550b4bc14c7dc351c9f528b873c528dea9e9daf3f168673a74/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.VfbXmyDPxrOphpKFAA6ffQHaDn%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 155, '2025-06-07', 'a6315ff5-53a1-4118-b5f6-2d605e3624ae', '3cf09d2a-d82e-4827-9c96-988179c7c39d', FALSE),
(UUID(), 'Product Defect', '2025-06-08', 'The product had a manufacturing defect.', 'https://s1.qwant.com/thumbr/474x231/9/1/8db3257d1994550b4bc14c7dc351c9f528b873c528dea9e9daf3f168673a74/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.VfbXmyDPxrOphpKFAA6ffQHaDn%26pid%3DApi&q=0&b=1&p=0&a=0', 4, 25, '2025-06-09', '4ce9f3a9-6f22-48e2-8faa-2e88f17e9781', '14ff5df9-4353-48e4-82fa-53a74dec71b7', FALSE),
(UUID(), 'Prompt Service', '2025-06-10', 'The service was prompt and efficient.', 'https://s1.qwant.com/thumbr/474x231/9/1/8db3257d1994550b4bc14c7dc351c9f528b873c528dea9e9daf3f168673a74/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.VfbXmyDPxrOphpKFAA6ffQHaDn%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 165, '2025-06-11', '8c6a14b3-5b79-4287-ab85-98ca85876556', '8efceda2-4cd5-44c5-bcef-1ecc3f625e1e', FALSE),
(UUID(), 'Complex Setup', '2025-06-12', 'The product setup was too complex.', 'https://s1.qwant.com/thumbr/474x231/9/1/8db3257d1994550b4bc14c7dc351c9f528b873c528dea9e9daf3f168673a74/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.VfbXmyDPxrOphpKFAA6ffQHaDn%26pid%3DApi&q=0&b=1&p=0&a=0', 3, 55, '2025-06-13', '5678832b-d534-4e1b-8370-a20516a5db08', '6e570750-6ad3-495e-9a07-7b6a35e1d2b0', FALSE),
(UUID(), 'Great Value', '2025-06-14', 'The product offers great value for money.', 'https://s1.qwant.com/thumbr/474x276/9/8/c42c230a8bc020f6310ae4b71c4c42022da991609537a1becc97473f58b9f2/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JBgkfc58cJpGJH5q4IJykwHaEU%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x289/6/e/e25850329c7b4278eed1d4cc58a85426d9871067537241e63027680c04e37a/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.NXaAFLYF5XF8b7z5t_FlTAHaEh%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 175, '2025-06-15', '14c160c9-6cb4-4d85-8a25-b0d92469e550', '9293127c-834c-425e-a265-d147382ea8b8', FALSE),
(UUID(), 'Slow Response', '2025-06-16', 'Customer support was slow to respond.', 'https://s2.qwant.com/thumbr/474x474/6/4/7645c36f1e457c51dcb1a730633ce0486e7a2b67dd4801962db912c17218f0/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.hBkVif1WxxOO-qENcTrSjwAAAA%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x355/b/9/606896385399da416f2ed29fa5205e5c5127f21d04a51d885570bbc835b16f/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JV8GEmzenqLIo4VIi2oW_gHaFj%26pid%3DApi&q=0&b=1&p=0&a=0', 2, 65, '2025-06-17', '36dfc032-f5e8-4ed4-a0e4-802f20a15cf9', 'a1a09f7f-0000-4d02-ac4a-16da6065d923', FALSE),
(UUID(), 'User-Friendly', '2025-06-18', 'The product is very user-friendly.', 'https://s2.qwant.com/thumbr/474x474/6/4/7645c36f1e457c51dcb1a730633ce0486e7a2b67dd4801962db912c17218f0/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.hBkVif1WxxOO-qENcTrSjwAAAA%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x355/b/9/606896385399da416f2ed29fa5205e5c5127f21d04a51d885570bbc835b16f/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JV8GEmzenqLIo4VIi2oW_gHaFj%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 185, '2025-06-19', '4f2d485c-bfeb-4d8f-adc1-c2ea2890b246', '2aee7775-0591-46d3-833b-b8b3d857f79e', FALSE),
(UUID(), 'Faulty Item', '2025-06-20', 'The product was faulty on arrival.', 'https://s2.qwant.com/thumbr/474x474/6/4/7645c36f1e457c51dcb1a730633ce0486e7a2b67dd4801962db912c17218f0/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.hBkVif1WxxOO-qENcTrSjwAAAA%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x355/b/9/606896385399da416f2ed29fa5205e5c5127f21d04a51d885570bbc835b16f/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JV8GEmzenqLIo4VIi2oW_gHaFj%26pid%3DApi&q=0&b=1&p=0&a=0', 4, 30, '2025-06-21', 'cd753433-a574-41bd-a0f1-c8c192f5f300', 'b01f537c-236f-4dfa-bccf-d92b8c17b7ec', FALSE),
(UUID(), 'Excellent Service', '2025-06-22', 'The service was excellent.', 'https://s2.qwant.com/thumbr/474x474/6/4/7645c36f1e457c51dcb1a730633ce0486e7a2b67dd4801962db912c17218f0/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.hBkVif1WxxOO-qENcTrSjwAAAA%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x355/b/9/606896385399da416f2ed29fa5205e5c5127f21d04a51d885570bbc835b16f/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JV8GEmzenqLIo4VIi2oW_gHaFj%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 195, '2025-06-23', 'aa637022-f2a0-48fe-8b8a-e73c36200391', '4b4e336b-4413-4d05-911f-ecb7f1f69b0d', FALSE),
(UUID(), 'Order Cancellation', '2025-06-24', 'Had to cancel the order due to issues.', 'https://s2.qwant.com/thumbr/474x474/6/4/7645c36f1e457c51dcb1a730633ce0486e7a2b67dd4801962db912c17218f0/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.hBkVif1WxxOO-qENcTrSjwAAAA%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x355/b/9/606896385399da416f2ed29fa5205e5c5127f21d04a51d885570bbc835b16f/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JV8GEmzenqLIo4VIi2oW_gHaFj%26pid%3DApi&q=0&b=1&p=0&a=0', 3, 45, '2025-06-25', '827c700d-1bee-4c78-9672-f5955c71176c', 'ab271eb6-b55e-4274-bffc-29d1d5cf5159', FALSE),
(UUID(), 'Highly Recommended', '2025-06-26', 'Highly recommend this product.', 'https://s2.qwant.com/thumbr/474x474/6/4/7645c36f1e457c51dcb1a730633ce0486e7a2b67dd4801962db912c17218f0/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.hBkVif1WxxOO-qENcTrSjwAAAA%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x355/b/9/606896385399da416f2ed29fa5205e5c5127f21d04a51d885570bbc835b16f/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JV8GEmzenqLIo4VIi2oW_gHaFj%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 205, '2025-06-27', '1af2e795-006f-4065-a185-5aa3ab95e975', 'e2cda31e-cfcd-4f85-88df-96663223eb7f', FALSE),
(UUID(), 'Late Delivery', '2025-06-28', 'The delivery was late.', 'https://s2.qwant.com/thumbr/474x474/6/4/7645c36f1e457c51dcb1a730633ce0486e7a2b67dd4801962db912c17218f0/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.hBkVif1WxxOO-qENcTrSjwAAAA%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x355/b/9/606896385399da416f2ed29fa5205e5c5127f21d04a51d885570bbc835b16f/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JV8GEmzenqLIo4VIi2oW_gHaFj%26pid%3DApi&q=0&b=1&p=0&a=0', 2, 70, '2025-06-29', 'ce589280-f0da-4515-8578-2a945da0a1be', '1c985c41-8427-4253-b866-7018d994ce9c', FALSE),
(UUID(), 'Easy Setup', '2025-06-30', 'The product was easy to set up.', 'https://s1.qwant.com/thumbr/474x276/9/8/c42c230a8bc020f6310ae4b71c4c42022da991609537a1becc97473f58b9f2/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JBgkfc58cJpGJH5q4IJykwHaEU%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x289/6/e/e25850329c7b4278eed1d4cc58a85426d9871067537241e63027680c04e37a/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.NXaAFLYF5XF8b7z5t_FlTAHaEh%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 215, '2025-07-01', '984edd9b-094d-4b3a-a6cd-56a1fe77617b', 'b539bfa5-4d15-4785-8a1a-dc31a59f66a3', FALSE),
(UUID(), 'Missing Parts', '2025-07-02', 'Some parts were missing from the order.', 'https://s2.qwant.com/thumbr/474x199/7/7/5f58be9f92a81e0abe7c45746311023fa7381532ff20820080ad20c0758e3c/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP._CILpCrsaVEtArQLFz9XWgHaDH%26pid%3DApi&q=0&b=1&p=0&a=0', 4, 20, '2025-07-03', 'c3633edb-9ddc-417c-aebc-11096fb6a5a6', '9dccceb9-3877-4ea4-bed7-5e8b2e1e7f8b', FALSE),
(UUID(), 'Great Experience', '2025-07-04', 'Overall, a great experience.', 'https://s2.qwant.com/thumbr/474x199/7/7/5f58be9f92a81e0abe7c45746311023fa7381532ff20820080ad20c0758e3c/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP._CILpCrsaVEtArQLFz9XWgHaDH%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 225, '2025-07-05', 'b88964fc-887a-45e8-88cc-86a2e4b7f3b8', '014f5dea-c87c-455a-9a15-8442354be6b3', FALSE),
(UUID(), 'Poor Instructions', '2025-07-06', 'The instructions were poor.', 'https://s2.qwant.com/thumbr/474x199/7/7/5f58be9f92a81e0abe7c45746311023fa7381532ff20820080ad20c0758e3c/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP._CILpCrsaVEtArQLFz9XWgHaDH%26pid%3DApi&q=0&b=1&p=0&a=0', 3, 50, '2025-07-07', '13836555-4836-4604-a2f6-35ed29a9ac09', '6c25255d-2cb6-4b10-8ba9-7c39f77e2df9', FALSE),
(UUID(), 'Fast Delivery', '2025-07-08', 'The delivery was very fast.', 'https://s2.qwant.com/thumbr/474x199/7/7/5f58be9f92a81e0abe7c45746311023fa7381532ff20820080ad20c0758e3c/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP._CILpCrsaVEtArQLFz9XWgHaDH%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 235, '2025-07-09', '87ebdf12-5e8d-4172-aba4-ee88c2251060', '83c11f46-15db-4c92-89bd-ab1e85b8ac7e', FALSE),
(UUID(), 'Excellent Product', '2025-07-10', 'The product is excellent.', 'https://s2.qwant.com/thumbr/474x199/7/7/5f58be9f92a81e0abe7c45746311023fa7381532ff20820080ad20c0758e3c/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP._CILpCrsaVEtArQLFz9XWgHaDH%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 245, '2025-07-11', '53e981f0-9e4d-44d9-837b-77ae0b091faa', 'd8a9f88d-a555-4cdf-90ad-2f2c6d25cc11', FALSE),
(UUID(), 'Difficult Return', '2025-07-12', 'The return process was difficult.', 'https://s2.qwant.com/thumbr/474x199/7/7/5f58be9f92a81e0abe7c45746311023fa7381532ff20820080ad20c0758e3c/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP._CILpCrsaVEtArQLFz9XWgHaDH%26pid%3DApi&q=0&b=1&p=0&a=0', 2, 60, '2025-07-13', '5f86ea7c-1e22-451b-ac36-4d671edda0c2', 'd31fc86e-be22-4907-af6e-ccc9f1a88806', FALSE),
(UUID(), 'Great Support', '2025-07-14', 'Customer support was very helpful.', 'https://s1.qwant.com/thumbr/474x276/9/8/c42c230a8bc020f6310ae4b71c4c42022da991609537a1becc97473f58b9f2/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JBgkfc58cJpGJH5q4IJykwHaEU%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x289/6/e/e25850329c7b4278eed1d4cc58a85426d9871067537241e63027680c04e37a/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.NXaAFLYF5XF8b7z5t_FlTAHaEh%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 255, '2025-07-15', 'f70427c8-feef-4bf7-96bc-02c2aa56f127', '3d55695c-4f72-4cee-a075-ec6ba0579205', FALSE),
(UUID(), 'Damaged Package', '2025-07-16', 'The package arrived damaged.', 'https://s2.qwant.com/thumbr/474x474/6/4/7645c36f1e457c51dcb1a730633ce0486e7a2b67dd4801962db912c17218f0/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.hBkVif1WxxOO-qENcTrSjwAAAA%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x355/b/9/606896385399da416f2ed29fa5205e5c5127f21d04a51d885570bbc835b16f/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JV8GEmzenqLIo4VIi2oW_gHaFj%26pid%3DApi&q=0&b=1&p=0&a=0', 4, 35, '2025-07-17', 'b4c6d13a-0a40-421b-8a36-964b78bc9d0f', '9940866d-431f-4277-8372-572820deb6ce', FALSE),
(UUID(), 'Quick Service', '2025-07-18', 'The service was quick and efficient.', 'https://s2.qwant.com/thumbr/474x474/6/4/7645c36f1e457c51dcb1a730633ce0486e7a2b67dd4801962db912c17218f0/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.hBkVif1WxxOO-qENcTrSjwAAAA%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x355/b/9/606896385399da416f2ed29fa5205e5c5127f21d04a51d885570bbc835b16f/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.JV8GEmzenqLIo4VIi2oW_gHaFj%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 265, '2025-07-19', 'f3a75103-ebff-4866-8361-eaf19a0f5b95', '3a8bf641-c5b1-40af-b605-be79a4050a51', FALSE),
(UUID(), 'Great Service', '2025-07-20', 'The service was excellent.', 'https://s1.qwant.com/thumbr/474x340/1/6/9356c0437b48bad4110ac5b187e3cd109160f264725b43426bb3ca4c5556bb/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df460avkQHOfqwPzAN8-xAHaFU%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x283/c/e/de76f6f8dd38c03cc20fa0ff330bf3a867d4f82330c451b1c85b2355d9067b/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.w-crlNOm-HNFrBPFD9nDMwHaEb%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 100, '2025-07-21', '69ac4bce-b419-4c87-bcfa-5c3c8562bf5f', '2621aeae-48bd-4dee-b98e-f078e71fd813', FALSE),
(UUID(), 'Website Issue', '2025-07-22', 'The website is slow.', 'https://s1.qwant.com/thumbr/474x237/b/c/f34654ac9fc1aeb9a035d868982ac4d444c9545b7ef1f2143259e62fb0ff25/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.jjSndMtdXBls6lXKIPOyugHaDt%26pid%3DApi&q=0&b=1&p=0&a=0', 3, 50, '2025-07-23', '2fd1986f-f32a-4b1a-a095-9afc523d19a0', 'f5481f41-7e3b-41a1-9d94-9137d5653b09', FALSE),
(UUID(), 'Product Feedback', '2025-07-24', 'The product quality is great.', 'https://s2.qwant.com/thumbr/474x258/d/1/ea789e6d17c935ef5cc464d07920465b0020d9f4ff3d9ae746fe080a8c8975/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.XqDT7IoxJfLHG7xH-dTPrAHaEC%26pid%3DApi&q=0&b=1&p=0&a=0', 1, 30, '2025-07-25', '91efddd0-4131-485a-ac14-a113aca48233', 'fcbdc2e9-8ca9-4fef-946b-f5b6318d7f61', FALSE),
(UUID(), 'Delivery Delay', '2025-07-26', 'Delivery took longer than expected.', 'https://s2.qwant.com/thumbr/474x264/e/6/d87b1b4cf1010face8650f75043cf33aee466ff2b2fa04669d249a4dbc7bc5/th.jpg?u=https%3A%2F%2Ftse2.explicit.bing.net%2Fth%3Fid%3DOIP.hvBSz8cPwSn9O1ysRCGd4wHaEI%26pid%3DApi&q=0&b=1&p=0&a=0', 2, 80, '2025-07-27', 'f32059ac-5a63-4f17-b83a-059c3c88eff', '7755971b-e24f-4d0c-9370-1d85f41d52af', FALSE);


-- Ajout d'exemples de mémoires (MemoryModel)
INSERT INTO MemoryModel (idMemory, title, publicationDate, category, views, image, description, place, hashtag, share, tag, idOrder, idUser, bDelete) VALUES
(UUID(), 'Vacation in Paris', '2024-12-25', 3, 200, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Visited the Eiffel Tower and Louvre.', 'Paris', '#travel', 1, 'vacation,paris', 'order4', '517516e7-4e8a-4765-91d5-ec87012e227d', FALSE),
(UUID(), 'Office Party', '2024-12-20', 2, 150, 'https://s2.qwant.com/thumbr/474x338/d/1/d8a55e65944805201cbd80c2de01dd5ea18899f76c85cc9b759ddac34ef6f1/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.9Q11j06j8BPIlYYSGPNdpgHaFS%26pid%3DApi&q=0&b=1&p=0&a=0', 'End-of-year celebration at the office.', 'Office', '#work', 2, 'party,office', 'order5', '90ec858e-9537-484a-8bac-9f6b261964b6', FALSE),
(UUID(), 'Wedding Event', '2024-12-15', 4, 300, 'https://s1.qwant.com/thumbr/474x296/3/3/4a375348c6d25b473ff6824bbf74f83d4459c9925786430ed34b3c0254b37e/th.jpg?u=https%3A%2F%2Ftse3.explicit.bing.net%2Fth%3Fid%3DOIP.y3b-ndE3BWeSl7xjAahD9wHaEo%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x316/c/8/d8012ae05688d210d9b1c5e2fd27b4ccb5baaea7edc85c6b93acf59bf9dd91/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.rhh9E8mtkIRktLihHUZ8pAHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'My best friend’s wedding.', 'Venue XYZ', '#wedding', 1, 'event,wedding', 'order6', 'e1edf453-3921-43c3-bccc-ded818a79fdc', FALSE),
(UUID(), 'Mountain Hiking', '2024-12-10', 3, 180, 'https://s2.qwant.com/thumbr/474x316/f/6/387bd095a2d0f1ccc6f49b7edf93b4930e5910003da49612309b72b64824c8/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.okaEG5SeQWsJBqKw0YdhjQHaE8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x266/d/4/ee17cb5f75dc787b836c251177be18e456abf8e9c599965626b4cd60abc726/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqCIUkZvpCiCDsheaCyCLAHaEK%26pid%3DApi&q=0&b=1&p=0&a=0', 'Reached the summit after a long hike.', 'Mount Everest', '#adventure', 1, 'hiking,mountain', 'order7', 'ac715e9b-07df-45d4-9a78-e544348a6341', FALSE),
(UUID(), 'Family Reunion', '2024-12-05', 1, 100, 'https://s2.qwant.com/thumbr/474x316/6/2/08ebd197e23970a9e412950d3197ce7c90d057d5e408b6a815af0af03f100d/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Dg_Ff0B02hawXT6DJGo6nAHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'A wonderful time with family.', 'Home', '#family', 2, 'reunion,family', 'order8', '88a90300-a0e6-41b9-be12-1ba08b1580ba', FALSE),
(UUID(), 'Beach Party', '2024-11-30', 3, 220, 'https://s2.qwant.com/thumbr/474x315/7/4/06190a5aaf58a106602431c8a78eed6c0aba7ed8089ac99f8bb97f91876557/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.10YryFNgL0dkNu3nBjcnkwHaE7%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x302/0/9/f0c5199baeb87badadfb7d9c6d8c7f02be819ee373c5ca7f5e232fc90aafef/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.e7ShWWBxRBiX57Clc5gHeAHaEu%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x366/d/d/2273121c90aaddb4a6af6c39f44decf7f6578000b73aeb8cb5245bef20bd33/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.4iRn7jTLuL8po20plexDkAHaFu%26pid%3DApi&q=0&b=1&p=0&a=0', 'Enjoyed the sunshine and waves.', 'Malibu', '#beach', 1, 'party,beach', 'order9', '8382ffbd-4e4e-4ad4-b013-7839df25e5c5', FALSE),
(UUID(), 'Conference Talk', '2024-11-25', 2, 160, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Gave a talk on technology trends.', 'Convention Center', '#conference', 2, 'talk,conference', 'order10', '4407f89a-753c-4238-ac4b-f94a3bbc9b1c', FALSE),
(UUID(), 'Birthday Celebration', '2024-11-20', 4, 140, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Celebrated my 30th birthday.', 'Banquet Hall', '#birthday', 1, 'celebration,birthday', 'order11', '65b48d47-c060-4023-882f-89074e921ee6', FALSE),
(UUID(), 'Camping Trip', '2024-11-15', 3, 190, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Stayed under the stars.', 'National Park', '#camping', 1, 'trip,camping', 'order12', 'ca46107a-e113-41e2-a523-0dac4a6d8aee', FALSE),
(UUID(), 'Art Exhibition', '2024-11-10', 4, 110, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Visited an inspiring art exhibition.', 'City Gallery', '#art', 2, 'exhibition,art', 'order13', '3e75fda5-df43-4d84-93f5-d590cd9830a0', FALSE),
(UUID(), 'Cooking Class', '2024-11-05', 2, 130, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Learned to cook Italian cuisine.', 'Culinary School', '#cooking', 1, 'class,cooking', 'order14', '78f125b1-29c9-453c-98e3-ec2ead9bd314', FALSE),
(UUID(), 'Music Festival', '2024-11-01', 4, 250, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Attended a fantastic music festival.', 'Festival Grounds', '#music', 2, 'festival,music', 'order15', 'd1b5007c-a1bf-4afa-a46d-5d5fdb7c79cd', FALSE),
(UUID(), 'Skiing Adventure', '2024-10-25', 3, 170, 'https://s2.qwant.com/thumbr/474x338/d/1/d8a55e65944805201cbd80c2de01dd5ea18899f76c85cc9b759ddac34ef6f1/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.9Q11j06j8BPIlYYSGPNdpgHaFS%26pid%3DApi&q=0&b=1&p=0&a=0', 'Enjoyed skiing in the Alps.', 'Ski Resort', '#skiing', 1, 'adventure,skiing', 'order16', '887ffa4f-63a2-41f1-b0e8-45857bf366ed', FALSE),
(UUID(), 'Book Club Meeting', '2024-10-20', 1, 90, 'https://s2.qwant.com/thumbr/474x338/d/1/d8a55e65944805201cbd80c2de01dd5ea18899f76c85cc9b759ddac34ef6f1/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.9Q11j06j8BPIlYYSGPNdpgHaFS%26pid%3DApi&q=0&b=1&p=0&a=0', 'Discussed the latest bestseller.', 'Library', '#books', 2, 'meeting,bookclub', 'order17', '8fae166d-33b9-4bf8-97e8-0eb6ddb0955b', FALSE),
(UUID(), 'Yoga Retreat', '2024-10-15', 3, 210, 'https://s2.qwant.com/thumbr/474x338/d/1/d8a55e65944805201cbd80c2de01dd5ea18899f76c85cc9b759ddac34ef6f1/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.9Q11j06j8BPIlYYSGPNdpgHaFS%26pid%3DApi&q=0&b=1&p=0&a=0', 'Relaxing yoga retreat in the mountains.', 'Retreat Center', '#yoga', 1, 'retreat,yoga', 'order18', '14e2d59e-32d6-40a8-b1f1-bfbd93931020', FALSE),
(UUID(), 'Charity Run', '2024-10-10', 2, 120, 'https://s2.qwant.com/thumbr/474x338/d/1/d8a55e65944805201cbd80c2de01dd5ea18899f76c85cc9b759ddac34ef6f1/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.9Q11j06j8BPIlYYSGPNdpgHaFS%26pid%3DApi&q=0&b=1&p=0&a=0', 'Participated in a charity run for a good cause.', 'City Park', '#charity', 2, 'run,charity', 'order19', 'ac5ccd32-a1da-4960-b2db-4996bf8d71b9', FALSE),
(UUID(), 'Wine Tasting', '2024-10-05', 4, 180, 'https://s2.qwant.com/thumbr/474x338/d/1/d8a55e65944805201cbd80c2de01dd5ea18899f76c85cc9b759ddac34ef6f1/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.9Q11j06j8BPIlYYSGPNdpgHaFS%26pid%3DApi&q=0&b=1&p=0&a=0', 'Enjoyed a wine tasting tour.', 'Vineyard', '#wine', 1, 'tasting,wine', 'order20', 'e8735c6d-19ba-4f3b-850b-cdab28e58c58', FALSE),
(UUID(), 'Photography Workshop', '2024-10-01', 3, 140, 'https://s2.qwant.com/thumbr/474x338/d/1/d8a55e65944805201cbd80c2de01dd5ea18899f76c85cc9b759ddac34ef6f1/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.9Q11j06j8BPIlYYSGPNdpgHaFS%26pid%3DApi&q=0&b=1&p=0&a=0', 'Improved my photography skills.', 'Studio', '#photography', 1, 'workshop,photography', 'order21', '4fb60321-b245-4199-a273-d864ed4e8780', FALSE),
(UUID(), 'Cultural Festival', '2024-09-25', 2, 200, 'https://s1.qwant.com/thumbr/474x296/3/3/4a375348c6d25b473ff6824bbf74f83d4459c9925786430ed34b3c0254b37e/th.jpg?u=https%3A%2F%2Ftse3.explicit.bing.net%2Fth%3Fid%3DOIP.y3b-ndE3BWeSl7xjAahD9wHaEo%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x316/c/8/d8012ae05688d210d9b1c5e2fd27b4ccb5baaea7edc85c6b93acf59bf9dd91/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.rhh9E8mtkIRktLihHUZ8pAHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Experienced diverse cultures at a festival.', 'Festival Grounds', '#culture', 2, 'festival,culture', 'order22', '7d3ccf83-edc1-4d77-870a-20d15b553e60', FALSE),
(UUID(), 'Fishing Trip', '2024-09-20', 3, 160, 'https://s1.qwant.com/thumbr/474x296/3/3/4a375348c6d25b473ff6824bbf74f83d4459c9925786430ed34b3c0254b37e/th.jpg?u=https%3A%2F%2Ftse3.explicit.bing.net%2Fth%3Fid%3DOIP.y3b-ndE3BWeSl7xjAahD9wHaEo%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x316/c/8/d8012ae05688d210d9b1c5e2fd27b4ccb5baaea7edc85c6b93acf59bf9dd91/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.rhh9E8mtkIRktLihHUZ8pAHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Spent a relaxing day fishing.', 'Lake', '#fishing', 1, 'trip,fishing', 'order23', 'f125a170-b480-415d-9c32-e9ffaa3cf043', FALSE),
(UUID(), 'Movie Night', '2024-09-15', 1, 110, 'https://s1.qwant.com/thumbr/474x296/3/3/4a375348c6d25b473ff6824bbf74f83d4459c9925786430ed34b3c0254b37e/th.jpg?u=https%3A%2F%2Ftse3.explicit.bing.net%2Fth%3Fid%3DOIP.y3b-ndE3BWeSl7xjAahD9wHaEo%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x316/c/8/d8012ae05688d210d9b1c5e2fd27b4ccb5baaea7edc85c6b93acf59bf9dd91/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.rhh9E8mtkIRktLihHUZ8pAHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Watched a classic movie with friends.', 'Home', '#movies', 2, 'night,movies', 'order24', '806bf56d-10f5-40ce-839c-1da507089623', FALSE),
(UUID(), 'Gardening Workshop', '2024-09-10', 4, 150, 'https://s1.qwant.com/thumbr/474x296/3/3/4a375348c6d25b473ff6824bbf74f83d4459c9925786430ed34b3c0254b37e/th.jpg?u=https%3A%2F%2Ftse3.explicit.bing.net%2Fth%3Fid%3DOIP.y3b-ndE3BWeSl7xjAahD9wHaEo%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x316/c/8/d8012ae05688d210d9b1c5e2fd27b4ccb5baaea7edc85c6b93acf59bf9dd91/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.rhh9E8mtkIRktLihHUZ8pAHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Learned new gardening techniques.', 'Community Garden', '#gardening', 1, 'workshop,gardening', 'order25', 'a2ae6969-8dba-464a-aff0-d1d037374c0f', FALSE),
(UUID(), 'Cycling Tour', '2024-09-05', 3, 190, 'https://s1.qwant.com/thumbr/474x296/3/3/4a375348c6d25b473ff6824bbf74f83d4459c9925786430ed34b3c0254b37e/th.jpg?u=https%3A%2F%2Ftse3.explicit.bing.net%2Fth%3Fid%3DOIP.y3b-ndE3BWeSl7xjAahD9wHaEo%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x316/c/8/d8012ae05688d210d9b1c5e2fd27b4ccb5baaea7edc85c6b93acf59bf9dd91/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.rhh9E8mtkIRktLihHUZ8pAHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Explored the countryside on a cycling tour.', 'Countryside', '#cycling', 1, 'tour,cycling', 'order26', '6e18a343-baa2-4400-a48a-bd695105ab7f', FALSE),
(UUID(), 'Pottery Class', '2024-09-01', 2, 130, 'https://s1.qwant.com/thumbr/474x296/3/3/4a375348c6d25b473ff6824bbf74f83d4459c9925786430ed34b3c0254b37e/th.jpg?u=https%3A%2F%2Ftse3.explicit.bing.net%2Fth%3Fid%3DOIP.y3b-ndE3BWeSl7xjAahD9wHaEo%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x316/c/8/d8012ae05688d210d9b1c5e2fd27b4ccb5baaea7edc85c6b93acf59bf9dd91/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.rhh9E8mtkIRktLihHUZ8pAHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Created beautiful pottery pieces.', 'Art Studio', '#pottery', 2, 'class,pottery', 'order27', '87694617-325d-4620-b40e-dc5581c399c5', FALSE),
(UUID(), 'Hiking Adventure', '2024-08-25', 3, 220, 'https://s2.qwant.com/thumbr/474x316/f/6/387bd095a2d0f1ccc6f49b7edf93b4930e5910003da49612309b72b64824c8/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.okaEG5SeQWsJBqKw0YdhjQHaE8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x266/d/4/ee17cb5f75dc787b836c251177be18e456abf8e9c599965626b4cd60abc726/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqCIUkZvpCiCDsheaCyCLAHaEK%26pid%3DApi&q=0&b=1&p=0&a=0', 'Explored new trails on a hiking adventure.', 'National Park', '#hiking', 1, 'adventure,hiking', 'order28', 'f7b26b88-9bae-4a6f-8021-64efb6d1d45b', FALSE),
(UUID(), 'Cooking Competition', '2024-08-20', 4, 240, 'https://s2.qwant.com/thumbr/474x316/f/6/387bd095a2d0f1ccc6f49b7edf93b4930e5910003da49612309b72b64824c8/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.okaEG5SeQWsJBqKw0YdhjQHaE8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x266/d/4/ee17cb5f75dc787b836c251177be18e456abf8e9c599965626b4cd60abc726/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqCIUkZvpCiCDsheaCyCLAHaEK%26pid%3DApi&q=0&b=1&p=0&a=0', 'Competed in a local cooking competition.', 'Community Center', '#cooking', 1, 'competition,cooking', 'order29', '037e545a-273e-4a65-9519-8dac591ca05e', FALSE),
(UUID(), 'Dance Performance', '2024-08-15', 2, 170, 'https://s2.qwant.com/thumbr/474x316/f/6/387bd095a2d0f1ccc6f49b7edf93b4930e5910003da49612309b72b64824c8/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.okaEG5SeQWsJBqKw0YdhjQHaE8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x266/d/4/ee17cb5f75dc787b836c251177be18e456abf8e9c599965626b4cd60abc726/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqCIUkZvpCiCDsheaCyCLAHaEK%26pid%3DApi&q=0&b=1&p=0&a=0', 'Performed in a dance show.', 'Theater', '#dance', 2, 'performance,dance', 'order30', '635626c0-2c94-4abf-b6fa-19fe7acf6a42', FALSE),
(UUID(), 'Art Workshop', '2024-08-10', 3, 180, 'https://s2.qwant.com/thumbr/474x316/f/6/387bd095a2d0f1ccc6f49b7edf93b4930e5910003da49612309b72b64824c8/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.okaEG5SeQWsJBqKw0YdhjQHaE8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x266/d/4/ee17cb5f75dc787b836c251177be18e456abf8e9c599965626b4cd60abc726/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqCIUkZvpCiCDsheaCyCLAHaEK%26pid%3DApi&q=0&b=1&p=0&a=0', 'Created art in a workshop.', 'Art Studio', '#art', 1, 'workshop,art', 'order31', 'c2c5f835-bede-4de2-a5ae-94f0ee6c3407', FALSE),
(UUID(), 'Fitness Challenge', '2024-08-05', 1, 100, 'https://s2.qwant.com/thumbr/474x316/f/6/387bd095a2d0f1ccc6f49b7edf93b4930e5910003da49612309b72b64824c8/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.okaEG5SeQWsJBqKw0YdhjQHaE8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x266/d/4/ee17cb5f75dc787b836c251177be18e456abf8e9c599965626b4cd60abc726/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqCIUkZvpCiCDsheaCyCLAHaEK%26pid%3DApi&q=0&b=1&p=0&a=0', 'Completed a fitness challenge.', 'Gym', '#fitness', 2, 'challenge,fitness', 'order32', '4f8682d5-f44a-468b-8b83-78b6416c4f2b', FALSE),
(UUID(), 'Nature Walk', '2024-08-01', 3, 120, 'https://s2.qwant.com/thumbr/474x316/f/6/387bd095a2d0f1ccc6f49b7edf93b4930e5910003da49612309b72b64824c8/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.okaEG5SeQWsJBqKw0YdhjQHaE8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x266/d/4/ee17cb5f75dc787b836c251177be18e456abf8e9c599965626b4cd60abc726/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqCIUkZvpCiCDsheaCyCLAHaEK%26pid%3DApi&q=0&b=1&p=0&a=0', 'Enjoyed a peaceful nature walk.', 'Forest', '#nature', 1, 'walk,nature', 'order33', 'cff54bd7-e83b-490e-aba8-7d6330c137b7', FALSE),
(UUID(), 'Painting Class', '2024-07-25', 2, 140, 'https://s2.qwant.com/thumbr/474x316/6/2/08ebd197e23970a9e412950d3197ce7c90d057d5e408b6a815af0af03f100d/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Dg_Ff0B02hawXT6DJGo6nAHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Learned new painting techniques.', 'Art Studio', '#painting', 1, 'class,painting', 'order34', 'da0f9809-71cf-4913-bce9-6d7f5b2d6d44', FALSE),
(UUID(), 'Volunteer Work', '2024-07-20', 4, 160, 'https://s2.qwant.com/thumbr/474x316/6/2/08ebd197e23970a9e412950d3197ce7c90d057d5e408b6a815af0af03f100d/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Dg_Ff0B02hawXT6DJGo6nAHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Volunteered at a local shelter.', 'Community Center', '#volunteer', 2, 'work,volunteer', 'order35', '446de252-5d4a-407e-8bb7-481a26c11e21', FALSE),
(UUID(), 'Road Trip', '2024-07-15', 3, 180, 'https://s2.qwant.com/thumbr/474x316/6/2/08ebd197e23970a9e412950d3197ce7c90d057d5e408b6a815af0af03f100d/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Dg_Ff0B02hawXT6DJGo6nAHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Went on a fun road trip with friends.', 'Highway', '#roadtrip', 1, 'trip,road', 'order36', '526f6e2d-8d05-4f66-b149-17f109660cb6', FALSE),
(UUID(), 'Board Game Night', '2024-07-10', 1, 110, 'https://s2.qwant.com/thumbr/474x316/6/2/08ebd197e23970a9e412950d3197ce7c90d057d5e408b6a815af0af03f100d/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Dg_Ff0B02hawXT6DJGo6nAHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Had a fun night playing board games.', 'Home', '#games', 2, 'night,games', 'order37', 'b0da8980-cf8b-4a55-a692-4f4ae45e6e92', FALSE),
(UUID(), 'DIY Project', '2024-07-05', 3, 130, 'https://s2.qwant.com/thumbr/474x316/6/2/08ebd197e23970a9e412950d3197ce7c90d057d5e408b6a815af0af03f100d/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Dg_Ff0B02hawXT6DJGo6nAHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Completed a DIY home project.', 'Home', '#diy', 1, 'project,diy', 'order38', '022d22a1-ad43-4684-8272-d558100f6d5f', FALSE),
(UUID(), 'Kayaking Adventure', '2024-07-01', 4, 150, 'https://s2.qwant.com/thumbr/474x316/6/2/08ebd197e23970a9e412950d3197ce7c90d057d5e408b6a815af0af03f100d/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Dg_Ff0B02hawXT6DJGo6nAHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Went kayaking on a beautiful lake.', 'Lake', '#kayaking', 1, 'adventure,kayaking', 'order39', 'ce216c39-0275-4d0c-9203-d3a09e7ade51', FALSE),
(UUID(), 'Baking Class', '2024-06-25', 2, 170, 'https://s2.qwant.com/thumbr/474x315/7/4/06190a5aaf58a106602431c8a78eed6c0aba7ed8089ac99f8bb97f91876557/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.10YryFNgL0dkNu3nBjcnkwHaE7%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x302/0/9/f0c5199baeb87badadfb7d9c6d8c7f02be819ee373c5ca7f5e232fc90aafef/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.e7ShWWBxRBiX57Clc5gHeAHaEu%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x366/d/d/2273121c90aaddb4a6af6c39f44decf7f6578000b73aeb8cb5245bef20bd33/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.4iRn7jTLuL8po20plexDkAHaFu%26pid%3DApi&q=0&b=1&p=0&a=0', 'Learned to bake delicious pastries.', 'Culinary School', '#baking', 1, 'class,baking', 'order40', '7fa9b68b-80ce-4f5e-8a90-d4e4db57cbb8', FALSE),
(UUID(), 'Horseback Riding', '2024-06-20', 3, 190, 'https://s2.qwant.com/thumbr/474x315/7/4/06190a5aaf58a106602431c8a78eed6c0aba7ed8089ac99f8bb97f91876557/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.10YryFNgL0dkNu3nBjcnkwHaE7%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x302/0/9/f0c5199baeb87badadfb7d9c6d8c7f02be819ee373c5ca7f5e232fc90aafef/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.e7ShWWBxRBiX57Clc5gHeAHaEu%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x366/d/d/2273121c90aaddb4a6af6c39f44decf7f6578000b73aeb8cb5245bef20bd33/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.4iRn7jTLuL8po20plexDkAHaFu%26pid%3DApi&q=0&b=1&p=0&a=0', 'Enjoyed a horseback riding session.', 'Ranch', '#horsebackriding', 1, 'riding,horseback', 'order41', 'fd8c1b82-9fd1-47fb-ae98-f3f0e8762a27', FALSE),
(UUID(), 'Language Class', '2024-06-15', 1, 100, 'https://s2.qwant.com/thumbr/474x315/7/4/06190a5aaf58a106602431c8a78eed6c0aba7ed8089ac99f8bb97f91876557/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.10YryFNgL0dkNu3nBjcnkwHaE7%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x302/0/9/f0c5199baeb87badadfb7d9c6d8c7f02be819ee373c5ca7f5e232fc90aafef/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.e7ShWWBxRBiX57Clc5gHeAHaEu%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x366/d/d/2273121c90aaddb4a6af6c39f44decf7f6578000b73aeb8cb5245bef20bd33/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.4iRn7jTLuL8po20plexDkAHaFu%26pid%3DApi&q=0&b=1&p=0&a=0', 'Started learning a new language.', 'Language School', '#language', 2, 'class,language', 'order42', '9c548d22-7a2d-4c9c-b25a-aa9f6c77d549', FALSE),
(UUID(), 'Scuba Diving', '2024-06-10', 4, 210, 'https://s2.qwant.com/thumbr/474x315/7/4/06190a5aaf58a106602431c8a78eed6c0aba7ed8089ac99f8bb97f91876557/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.10YryFNgL0dkNu3nBjcnkwHaE7%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x302/0/9/f0c5199baeb87badadfb7d9c6d8c7f02be819ee373c5ca7f5e232fc90aafef/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.e7ShWWBxRBiX57Clc5gHeAHaEu%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x366/d/d/2273121c90aaddb4a6af6c39f44decf7f6578000b73aeb8cb5245bef20bd33/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.4iRn7jTLuL8po20plexDkAHaFu%26pid%3DApi&q=0&b=1&p=0&a=0', 'Explored the underwater world.', 'Ocean', '#scuba', 1, 'diving,scuba', 'order43', '81e426fe-aca1-4941-9936-e3a31ec567f8', FALSE),
(UUID(), 'Potluck Dinner', '2024-06-05', 2, 120, 'https://s2.qwant.com/thumbr/474x315/7/4/06190a5aaf58a106602431c8a78eed6c0aba7ed8089ac99f8bb97f91876557/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.10YryFNgL0dkNu3nBjcnkwHaE7%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x302/0/9/f0c5199baeb87badadfb7d9c6d8c7f02be819ee373c5ca7f5e232fc90aafef/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.e7ShWWBxRBiX57Clc5gHeAHaEu%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x366/d/d/2273121c90aaddb4a6af6c39f44decf7f6578000b73aeb8cb5245bef20bd33/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.4iRn7jTLuL8po20plexDkAHaFu%26pid%3DApi&q=0&b=1&p=0&a=0', 'Hosted a potluck dinner with friends.', 'Home', '#food', 2, 'dinner,potluck', 'order44', 'd78fbf55-a771-4e8d-b8f9-7eb1af8d1c80', FALSE),
(UUID(), 'Bird Watching', '2024-06-01', 3, 140, 'https://s2.qwant.com/thumbr/474x315/7/4/06190a5aaf58a106602431c8a78eed6c0aba7ed8089ac99f8bb97f91876557/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.10YryFNgL0dkNu3nBjcnkwHaE7%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x302/0/9/f0c5199baeb87badadfb7d9c6d8c7f02be819ee373c5ca7f5e232fc90aafef/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.e7ShWWBxRBiX57Clc5gHeAHaEu%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x366/d/d/2273121c90aaddb4a6af6c39f44decf7f6578000b73aeb8cb5245bef20bd33/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.4iRn7jTLuL8po20plexDkAHaFu%26pid%3DApi&q=0&b=1&p=0&a=0', 'Spent a day bird watching.', 'Park', '#birdwatching', 1, 'watching,bird', 'order45', '61c24e4a-4486-4e7c-bae4-9ceae7aa668a', FALSE),
(UUID(), 'Craft Workshop', '2024-05-25', 1, 160, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Created handmade crafts.', 'Workshop', '#craft', 2, 'workshop,craft', 'order46', '27d4dce5-42db-4405-8025-5c23b9a67a2d', FALSE),
(UUID(), 'Sunset Hike', '2024-05-20', 3, 180, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Went on a beautiful sunset hike.', 'Mountain', '#hiking', 1, 'hike,sunset', 'order47', '4f468dba-2506-44f7-a27a-4d825349d738', FALSE),
(UUID(), 'Cooking Demo', '2024-05-15', 4, 200, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Attended a live cooking demo.', 'Culinary School', '#cooking', 1, 'demo,cooking', 'order48', '88a4e4f3-1622-4dda-a8c0-efc421ae9dfa', FALSE),
(UUID(), 'Beach Cleanup', '2024-05-10', 2, 110, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Participated in a beach cleanup event.', 'Beach', '#cleanup', 2, 'beach,cleanup', 'order49', '9f0c6aa9-5632-49a2-8c6d-bfe94f04224e', FALSE),
(UUID(), 'Flower Show', '2024-05-05', 3, 130, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Visited a beautiful flower show.', 'Garden', '#flowers', 1, 'show,flowers', 'order50', 'afa77a96-2166-4db4-b327-3fe9f9cf5d7c', FALSE),
(UUID(), 'Nature Walk', '2024-05-01', 3, 120, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Enjoyed a peaceful nature walk.', 'Forest', '#nature', 1, 'walk,nature', 'order51', 'b89df274-0451-4638-be76-cfd65a0a021e', FALSE),
(UUID(), 'Painting Class', '2024-04-25', 2, 140, 'https://s2.qwant.com/thumbr/474x338/d/1/d8a55e65944805201cbd80c2de01dd5ea18899f76c85cc9b759ddac34ef6f1/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.9Q11j06j8BPIlYYSGPNdpgHaFS%26pid%3DApi&q=0&b=1&p=0&a=0', 'Learned new painting techniques.', 'Art Studio', '#painting', 1, 'class,painting', 'order52', 'bc68f758-fc66-4b01-85b5-9da9e8953e44', FALSE),
(UUID(), 'Volunteer Work', '2024-04-20', 4, 160, 'https://s2.qwant.com/thumbr/474x338/d/1/d8a55e65944805201cbd80c2de01dd5ea18899f76c85cc9b759ddac34ef6f1/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.9Q11j06j8BPIlYYSGPNdpgHaFS%26pid%3DApi&q=0&b=1&p=0&a=0', 'Volunteered at a local shelter.', 'Community Center', '#volunteer', 2, 'work,volunteer', 'order53', 'aa0aceaa-57c5-4496-9c38-d404b13a40b1', FALSE),
(UUID(), 'Road Trip', '2024-04-15', 3, 180, 'https://s2.qwant.com/thumbr/474x338/d/1/d8a55e65944805201cbd80c2de01dd5ea18899f76c85cc9b759ddac34ef6f1/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.9Q11j06j8BPIlYYSGPNdpgHaFS%26pid%3DApi&q=0&b=1&p=0&a=0', 'Went on a fun road trip with friends.', 'Highway', '#roadtrip', 1, 'trip,road', 'order54', '55668095-f677-4e21-83b7-ce8784946247', FALSE),
(UUID(), 'Board Game Night', '2024-04-10', 1, 110, 'https://s2.qwant.com/thumbr/474x338/d/1/d8a55e65944805201cbd80c2de01dd5ea18899f76c85cc9b759ddac34ef6f1/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.9Q11j06j8BPIlYYSGPNdpgHaFS%26pid%3DApi&q=0&b=1&p=0&a=0', 'Had a fun night playing board games.', 'Home', '#games', 2, 'night,games', 'ef4f7b2e-cce3-11ef-b916-b48c9d6df3cd', '66ed8a89-c823-4821-9589-859c7ebe8ad2', FALSE),
(UUID(), 'DIY Project', '2024-04-05', 3, 130, 'https://s2.qwant.com/thumbr/474x338/d/1/d8a55e65944805201cbd80c2de01dd5ea18899f76c85cc9b759ddac34ef6f1/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.9Q11j06j8BPIlYYSGPNdpgHaFS%26pid%3DApi&q=0&b=1&p=0&a=0', 'Completed a DIY home project.', 'Home', '#diy', 1, 'project,diy', 'ef4f8184-cce3-11ef-b916-b48c9d6df3cd', 'f972326e-401c-44ce-bf20-346fbd96222f', FALSE),
(UUID(), 'Kayaking Adventure', '2024-04-01', 4, 150, 'https://s2.qwant.com/thumbr/474x338/d/1/d8a55e65944805201cbd80c2de01dd5ea18899f76c85cc9b759ddac34ef6f1/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.9Q11j06j8BPIlYYSGPNdpgHaFS%26pid%3DApi&q=0&b=1&p=0&a=0', 'Went kayaking on a beautiful lake.', 'Lake', '#kayaking', 1, 'adventure,kayaking', 'ef4f8326-cce3-11ef-b916-b48c9d6df3cd', 'ae512b71-e1a3-4b40-bf92-917801b3e902', FALSE),
(UUID(), 'Baking Class', '2024-03-25', 2, 170, 'https://s1.qwant.com/thumbr/474x296/3/3/4a375348c6d25b473ff6824bbf74f83d4459c9925786430ed34b3c0254b37e/th.jpg?u=https%3A%2F%2Ftse3.explicit.bing.net%2Fth%3Fid%3DOIP.y3b-ndE3BWeSl7xjAahD9wHaEo%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x316/c/8/d8012ae05688d210d9b1c5e2fd27b4ccb5baaea7edc85c6b93acf59bf9dd91/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.rhh9E8mtkIRktLihHUZ8pAHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Learned to bake delicious pastries.', 'Culinary School', '#baking', 1, 'class,baking', 'ef4f8568-cce3-11ef-b916-b48c9d6df3cd', 'adf11883-da54-4ddf-a548-4ba12604033b', FALSE),
(UUID(), 'Horseback Riding', '2024-03-20', 3, 190, 'https://s1.qwant.com/thumbr/474x296/3/3/4a375348c6d25b473ff6824bbf74f83d4459c9925786430ed34b3c0254b37e/th.jpg?u=https%3A%2F%2Ftse3.explicit.bing.net%2Fth%3Fid%3DOIP.y3b-ndE3BWeSl7xjAahD9wHaEo%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x316/c/8/d8012ae05688d210d9b1c5e2fd27b4ccb5baaea7edc85c6b93acf59bf9dd91/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.rhh9E8mtkIRktLihHUZ8pAHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Enjoyed a horseback riding session.', 'Ranch', '#horsebackriding', 1, 'riding,horseback', 'ef4f879e-cce3-11ef-b916-b48c9d6df3cd', '1f152489-da9b-4832-80b2-7c6329be6303', FALSE),
(UUID(), 'Language Class', '2024-03-15', 1, 100, 'https://s1.qwant.com/thumbr/474x296/3/3/4a375348c6d25b473ff6824bbf74f83d4459c9925786430ed34b3c0254b37e/th.jpg?u=https%3A%2F%2Ftse3.explicit.bing.net%2Fth%3Fid%3DOIP.y3b-ndE3BWeSl7xjAahD9wHaEo%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x316/c/8/d8012ae05688d210d9b1c5e2fd27b4ccb5baaea7edc85c6b93acf59bf9dd91/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.rhh9E8mtkIRktLihHUZ8pAHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Started learning a new language.', 'Language School', '#language', 2, 'class,language', 'ef4f8ae2-cce3-11ef-b916-b48c9d6df3cd', 'cd74daea-7c0e-4e41-bb8f-b49ade29bec3', FALSE),
(UUID(), 'Scuba Diving', '2024-03-10', 4, 210, 'https://s1.qwant.com/thumbr/474x296/3/3/4a375348c6d25b473ff6824bbf74f83d4459c9925786430ed34b3c0254b37e/th.jpg?u=https%3A%2F%2Ftse3.explicit.bing.net%2Fth%3Fid%3DOIP.y3b-ndE3BWeSl7xjAahD9wHaEo%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x316/c/8/d8012ae05688d210d9b1c5e2fd27b4ccb5baaea7edc85c6b93acf59bf9dd91/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.rhh9E8mtkIRktLihHUZ8pAHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Explored the underwater world.', 'Ocean', '#scuba', 1, 'diving,scuba', 'ef4f8d28-cce3-11ef-b916-b48c9d6df3cd', '2e93b113-45b7-48e9-b565-1609aa963305', FALSE),
(UUID(), 'Potluck Dinner', '2024-03-05', 2, 120, 'https://s1.qwant.com/thumbr/474x296/3/3/4a375348c6d25b473ff6824bbf74f83d4459c9925786430ed34b3c0254b37e/th.jpg?u=https%3A%2F%2Ftse3.explicit.bing.net%2Fth%3Fid%3DOIP.y3b-ndE3BWeSl7xjAahD9wHaEo%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x316/c/8/d8012ae05688d210d9b1c5e2fd27b4ccb5baaea7edc85c6b93acf59bf9dd91/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.rhh9E8mtkIRktLihHUZ8pAHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Hosted a potluck dinner with friends.', 'Home', '#food', 2, 'dinner,potluck', 'ef4f8f6a-cce3-11ef-b916-b48c9d6df3cd', 'd41b60e4-2bc0-4eeb-b132-3f958a9c2330', FALSE),
(UUID(), 'Bird Watching', '2024-03-01', 3, 140, 'https://s1.qwant.com/thumbr/474x296/3/3/4a375348c6d25b473ff6824bbf74f83d4459c9925786430ed34b3c0254b37e/th.jpg?u=https%3A%2F%2Ftse3.explicit.bing.net%2Fth%3Fid%3DOIP.y3b-ndE3BWeSl7xjAahD9wHaEo%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x316/c/8/d8012ae05688d210d9b1c5e2fd27b4ccb5baaea7edc85c6b93acf59bf9dd91/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.rhh9E8mtkIRktLihHUZ8pAHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Spent a day bird watching.', 'Park', '#birdwatching', 1, 'watching,bird', 'ef4f91c4-cce3-11ef-b916-b48c9d6df3cd', '9e27ba0d-6006-4489-b40a-16fb8ac36ae6', FALSE),
(UUID(), 'Craft Workshop', '2024-02-25', 1, 160, 'https://s2.qwant.com/thumbr/474x316/f/6/387bd095a2d0f1ccc6f49b7edf93b4930e5910003da49612309b72b64824c8/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.okaEG5SeQWsJBqKw0YdhjQHaE8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x266/d/4/ee17cb5f75dc787b836c251177be18e456abf8e9c599965626b4cd60abc726/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqCIUkZvpCiCDsheaCyCLAHaEK%26pid%3DApi&q=0&b=1&p=0&a=0', 'Created handmade crafts.', 'Workshop', '#craft', 2, 'workshop,craft', 'ef4f93fe-cce3-11ef-b916-b48c9d6df3cd', 'c8185919-219a-48ea-854e-8db9d4e92a88', FALSE),
(UUID(), 'Sunset Hike', '2024-02-20', 3, 180, 'https://s2.qwant.com/thumbr/474x316/f/6/387bd095a2d0f1ccc6f49b7edf93b4930e5910003da49612309b72b64824c8/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.okaEG5SeQWsJBqKw0YdhjQHaE8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x266/d/4/ee17cb5f75dc787b836c251177be18e456abf8e9c599965626b4cd60abc726/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqCIUkZvpCiCDsheaCyCLAHaEK%26pid%3DApi&q=0&b=1&p=0&a=0', 'Went on a beautiful sunset hike.', 'Mountain', '#hiking', 1, 'hike,sunset', 'dfc1fd09-0b7a-45bd-9f50-d353ea2e8652', '6f53dac5-e547-48d4-932c-2efb9770746e', FALSE),
(UUID(), 'Cooking Demo', '2024-02-15', 4, 200, 'https://s2.qwant.com/thumbr/474x316/f/6/387bd095a2d0f1ccc6f49b7edf93b4930e5910003da49612309b72b64824c8/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.okaEG5SeQWsJBqKw0YdhjQHaE8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x266/d/4/ee17cb5f75dc787b836c251177be18e456abf8e9c599965626b4cd60abc726/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqCIUkZvpCiCDsheaCyCLAHaEK%26pid%3DApi&q=0&b=1&p=0&a=0', 'Attended a live cooking demo.', 'Culinary School', '#cooking', 1, 'demo,cooking', 'a43443be-eccb-477c-81b4-a79b07c6a22b', 'a33ab7e9-961a-46c2-b832-26225c393335', FALSE),
(UUID(), 'Beach Cleanup', '2024-02-10', 2, 110, 'https://s2.qwant.com/thumbr/474x316/f/6/387bd095a2d0f1ccc6f49b7edf93b4930e5910003da49612309b72b64824c8/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.okaEG5SeQWsJBqKw0YdhjQHaE8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x266/d/4/ee17cb5f75dc787b836c251177be18e456abf8e9c599965626b4cd60abc726/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqCIUkZvpCiCDsheaCyCLAHaEK%26pid%3DApi&q=0&b=1&p=0&a=0', 'Participated in a beach cleanup event.', 'Beach', '#cleanup', 2, 'beach,cleanup', '915e4b91-f60d-4980-8f38-4e02d0e02d78', 'e4b4c683-c067-4fa7-82f1-60e448d59afe', FALSE),
(UUID(), 'Flower Show', '2024-02-05', 3, 130, 'https://s2.qwant.com/thumbr/474x316/f/6/387bd095a2d0f1ccc6f49b7edf93b4930e5910003da49612309b72b64824c8/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.okaEG5SeQWsJBqKw0YdhjQHaE8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x266/d/4/ee17cb5f75dc787b836c251177be18e456abf8e9c599965626b4cd60abc726/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqCIUkZvpCiCDsheaCyCLAHaEK%26pid%3DApi&q=0&b=1&p=0&a=0', 'Visited a beautiful flower show.', 'Garden', '#flowers', 1, 'show,flowers', 'dc725f1d-5242-4e11-9f85-bad4a6f2090f', '594a8d3f-53a4-4c1f-a514-71422b837b5b', FALSE),
(UUID(), 'Nature Walk', '2024-02-01', 3, 120, 'https://s2.qwant.com/thumbr/474x316/f/6/387bd095a2d0f1ccc6f49b7edf93b4930e5910003da49612309b72b64824c8/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.okaEG5SeQWsJBqKw0YdhjQHaE8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x266/d/4/ee17cb5f75dc787b836c251177be18e456abf8e9c599965626b4cd60abc726/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqCIUkZvpCiCDsheaCyCLAHaEK%26pid%3DApi&q=0&b=1&p=0&a=0', 'Enjoyed a peaceful nature walk.', 'Forest', '#nature', 1, 'walk,nature', '27117cb9-b482-43ac-9c9f-bc91feef4a63', '2b224bde-1d85-4f2b-9aea-6092ba676f77', FALSE),
(UUID(), 'Painting Class', '2024-01-25', 2, 140, 'https://s2.qwant.com/thumbr/474x315/7/4/06190a5aaf58a106602431c8a78eed6c0aba7ed8089ac99f8bb97f91876557/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.10YryFNgL0dkNu3nBjcnkwHaE7%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x302/0/9/f0c5199baeb87badadfb7d9c6d8c7f02be819ee373c5ca7f5e232fc90aafef/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.e7ShWWBxRBiX57Clc5gHeAHaEu%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x366/d/d/2273121c90aaddb4a6af6c39f44decf7f6578000b73aeb8cb5245bef20bd33/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.4iRn7jTLuL8po20plexDkAHaFu%26pid%3DApi&q=0&b=1&p=0&a=0', 'Learned new painting techniques.', 'Art Studio', '#painting', 1, 'class,painting', '361f8c50-2b99-4003-8c4b-c97abe830549', 'f06c7141-c628-406a-b9f2-ff022831e2a6', FALSE),
(UUID(), 'Volunteer Work', '2024-01-20', 4, 160, 'https://s2.qwant.com/thumbr/474x315/7/4/06190a5aaf58a106602431c8a78eed6c0aba7ed8089ac99f8bb97f91876557/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.10YryFNgL0dkNu3nBjcnkwHaE7%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x302/0/9/f0c5199baeb87badadfb7d9c6d8c7f02be819ee373c5ca7f5e232fc90aafef/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.e7ShWWBxRBiX57Clc5gHeAHaEu%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x366/d/d/2273121c90aaddb4a6af6c39f44decf7f6578000b73aeb8cb5245bef20bd33/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.4iRn7jTLuL8po20plexDkAHaFu%26pid%3DApi&q=0&b=1&p=0&a=0', 'Volunteered at a local shelter.', 'Community Center', '#volunteer', 2, 'work,volunteer', '2a12ab01-f358-4258-ab49-77487d1a8303', '2e7311b6-7d07-4073-bde0-9c40f0fe8557', FALSE),
(UUID(), 'Road Trip', '2024-01-15', 3, 180, 'https://s2.qwant.com/thumbr/474x315/7/4/06190a5aaf58a106602431c8a78eed6c0aba7ed8089ac99f8bb97f91876557/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.10YryFNgL0dkNu3nBjcnkwHaE7%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x302/0/9/f0c5199baeb87badadfb7d9c6d8c7f02be819ee373c5ca7f5e232fc90aafef/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.e7ShWWBxRBiX57Clc5gHeAHaEu%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x366/d/d/2273121c90aaddb4a6af6c39f44decf7f6578000b73aeb8cb5245bef20bd33/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.4iRn7jTLuL8po20plexDkAHaFu%26pid%3DApi&q=0&b=1&p=0&a=0', 'Went on a fun road trip with friends.', 'Highway', '#roadtrip', 1, 'trip,road', '489f8bcd-7a3f-4ef9-942f-2f8d7b573675', 'f619e28f-a0ed-4849-b389-6ded157ad901', FALSE),
(UUID(), 'Board Game Night', '2024-01-10', 1, 110, 'https://s2.qwant.com/thumbr/474x315/7/4/06190a5aaf58a106602431c8a78eed6c0aba7ed8089ac99f8bb97f91876557/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.10YryFNgL0dkNu3nBjcnkwHaE7%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x302/0/9/f0c5199baeb87badadfb7d9c6d8c7f02be819ee373c5ca7f5e232fc90aafef/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.e7ShWWBxRBiX57Clc5gHeAHaEu%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x366/d/d/2273121c90aaddb4a6af6c39f44decf7f6578000b73aeb8cb5245bef20bd33/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.4iRn7jTLuL8po20plexDkAHaFu%26pid%3DApi&q=0&b=1&p=0&a=0', 'Had a fun night playing board games.', 'Home', '#games', 2, 'night,games', 'b5c8cf0a-fd59-49cd-a060-1d0727226474', '979535d3-7cac-4827-891d-3357bf3aa6c7', FALSE),
(UUID(), 'DIY Project', '2024-01-05', 3, 130, 'https://s2.qwant.com/thumbr/474x315/7/4/06190a5aaf58a106602431c8a78eed6c0aba7ed8089ac99f8bb97f91876557/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.10YryFNgL0dkNu3nBjcnkwHaE7%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x302/0/9/f0c5199baeb87badadfb7d9c6d8c7f02be819ee373c5ca7f5e232fc90aafef/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.e7ShWWBxRBiX57Clc5gHeAHaEu%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x366/d/d/2273121c90aaddb4a6af6c39f44decf7f6578000b73aeb8cb5245bef20bd33/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.4iRn7jTLuL8po20plexDkAHaFu%26pid%3DApi&q=0&b=1&p=0&a=0', 'Completed a DIY home project.', 'Home', '#diy', 1, 'project,diy', '28262a7b-42b4-41c9-9610-fa6e5e3c5b1f', '875886d5-d4eb-4362-96fb-206beec6ddad', FALSE),
(UUID(), 'Kayaking Adventure', '2024-01-01', 4, 150, 'https://s2.qwant.com/thumbr/474x315/7/4/06190a5aaf58a106602431c8a78eed6c0aba7ed8089ac99f8bb97f91876557/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.10YryFNgL0dkNu3nBjcnkwHaE7%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x302/0/9/f0c5199baeb87badadfb7d9c6d8c7f02be819ee373c5ca7f5e232fc90aafef/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.e7ShWWBxRBiX57Clc5gHeAHaEu%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x366/d/d/2273121c90aaddb4a6af6c39f44decf7f6578000b73aeb8cb5245bef20bd33/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.4iRn7jTLuL8po20plexDkAHaFu%26pid%3DApi&q=0&b=1&p=0&a=0', 'Went kayaking on a beautiful lake.', 'Lake', '#kayaking', 1, 'adventure,kayaking', '2c6395c9-ad93-45c9-86a9-6f8a1637082a', '85efc017-adf3-44c8-b4fb-6a5a8e0e72ee', FALSE),
(UUID(), 'Baking Class', '2023-12-25', 2, 170, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Learned to bake delicious pastries.', 'Culinary School', '#baking', 1, 'class,baking', '4284cb6b-84a2-489a-942a-e2308540e4e4', '2d0bd405-bc58-4e07-a00e-2d15b8920ed6', FALSE),
(UUID(), 'Horseback Riding', '2023-12-20', 3, 190, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Enjoyed a horseback riding session.', 'Ranch', '#horsebackriding', 1, 'riding,horseback', 'a06a8145-63f5-4509-9156-f0afb30dd767', '75a204b0-f9cd-4e3d-a11c-072f5ef5abe5', FALSE),
(UUID(), 'Language Class', '2023-12-15', 1, 100, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Started learning a new language.', 'Language School', '#language', 2, 'class,language', 'b1a54c96-065b-44ba-b201-715a84c99d1f', '1fc55114-62f0-4b1d-8531-abab2ab1759f', FALSE),
(UUID(), 'Scuba Diving', '2023-12-10', 4, 210, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Explored the underwater world.', 'Ocean', '#scuba', 1, 'diving,scuba', '3cf09d2a-d82e-4827-9c96-988179c7c39d', '52f2a2d1-4d12-4f10-95c1-abda7d5200c6', FALSE),
(UUID(), 'Potluck Dinner', '2023-12-05', 2, 120, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Hosted a potluck dinner with friends.', 'Home', '#food', 2, 'dinner,potluck', '14ff5df9-4353-48e4-82fa-53a74dec71b7', '9866c4a1-64e1-45f8-869e-db3e1bee55de', FALSE),
(UUID(), 'Bird Watching', '2023-12-01', 3, 140, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Spent a day bird watching.', 'Park', '#birdwatching', 1, 'watching,bird', '8efceda2-4cd5-44c5-bcef-1ecc3f625e1e', '9fd3b785-4d45-4e2e-ac46-956c83f3be0e', FALSE),
(UUID(), 'Craft Workshop', '2023-11-25', 1, 160, 'https://s2.qwant.com/thumbr/474x338/d/1/d8a55e65944805201cbd80c2de01dd5ea18899f76c85cc9b759ddac34ef6f1/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.9Q11j06j8BPIlYYSGPNdpgHaFS%26pid%3DApi&q=0&b=1&p=0&a=0', 'Created handmade crafts.', 'Workshop', '#craft', 2, 'workshop,craft', '6e570750-6ad3-495e-9a07-7b6a35e1d2b0', 'a6315ff5-53a1-4118-b5f6-2d605e3624ae', FALSE),
(UUID(), 'Sunset Hike', '2023-11-20', 3, 180, 'https://s2.qwant.com/thumbr/474x338/d/1/d8a55e65944805201cbd80c2de01dd5ea18899f76c85cc9b759ddac34ef6f1/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.9Q11j06j8BPIlYYSGPNdpgHaFS%26pid%3DApi&q=0&b=1&p=0&a=0', 'Went on a beautiful sunset hike.', 'Mountain', '#hiking', 1, 'hike,sunset', '9293127c-834c-425e-a265-d147382ea8b8', '4ce9f3a9-6f22-48e2-8faa-2e88f17e9781', FALSE),
(UUID(), 'Cooking Demo', '2023-11-15', 4, 200, 'https://s2.qwant.com/thumbr/474x338/d/1/d8a55e65944805201cbd80c2de01dd5ea18899f76c85cc9b759ddac34ef6f1/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.9Q11j06j8BPIlYYSGPNdpgHaFS%26pid%3DApi&q=0&b=1&p=0&a=0', 'Attended a live cooking demo.', 'Culinary School', '#cooking', 1, 'demo,cooking', 'a1a09f7f-0000-4d02-ac4a-16da6065d923', '8c6a14b3-5b79-4287-ab85-98ca85876556', FALSE),
(UUID(), 'Beach Cleanup', '2023-11-10', 2, 110, 'https://s2.qwant.com/thumbr/474x338/d/1/d8a55e65944805201cbd80c2de01dd5ea18899f76c85cc9b759ddac34ef6f1/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.9Q11j06j8BPIlYYSGPNdpgHaFS%26pid%3DApi&q=0&b=1&p=0&a=0', 'Participated in a beach cleanup event.', 'Beach', '#cleanup', 2, 'beach,cleanup', '2aee7775-0591-46d3-833b-b8b3d857f79e', '5678832b-d534-4e1b-8370-a20516a5db08', FALSE),
(UUID(), 'Flower Show', '2023-11-05', 3, 130, 'https://s2.qwant.com/thumbr/474x338/d/1/d8a55e65944805201cbd80c2de01dd5ea18899f76c85cc9b759ddac34ef6f1/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.9Q11j06j8BPIlYYSGPNdpgHaFS%26pid%3DApi&q=0&b=1&p=0&a=0', 'Visited a beautiful flower show.', 'Garden', '#flowers', 1, 'show,flowers', 'b01f537c-236f-4dfa-bccf-d92b8c17b7ec', '14c160c9-6cb4-4d85-8a25-b0d92469e550', FALSE),
(UUID(), 'Nature Walk', '2023-11-01', 3, 120, 'https://s2.qwant.com/thumbr/474x338/d/1/d8a55e65944805201cbd80c2de01dd5ea18899f76c85cc9b759ddac34ef6f1/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.9Q11j06j8BPIlYYSGPNdpgHaFS%26pid%3DApi&q=0&b=1&p=0&a=0', 'Enjoyed a peaceful nature walk.', 'Forest', '#nature', 1, 'walk,nature', '4b4e336b-4413-4d05-911f-ecb7f1f69b0d', '36dfc032-f5e8-4ed4-a0e4-802f20a15cf9', FALSE),
(UUID(), 'Painting Class', '2023-10-25', 2, 140, 'https://s2.qwant.com/thumbr/474x316/f/6/387bd095a2d0f1ccc6f49b7edf93b4930e5910003da49612309b72b64824c8/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.okaEG5SeQWsJBqKw0YdhjQHaE8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x266/d/4/ee17cb5f75dc787b836c251177be18e456abf8e9c599965626b4cd60abc726/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqCIUkZvpCiCDsheaCyCLAHaEK%26pid%3DApi&q=0&b=1&p=0&a=0', 'Learned new painting techniques.', 'Art Studio', '#painting', 1, 'class,painting', 'ab271eb6-b55e-4274-bffc-29d1d5cf5159', '4f2d485c-bfeb-4d8f-adc1-c2ea2890b246', FALSE),
(UUID(), 'Volunteer Work', '2023-10-20', 4, 160, 'https://s2.qwant.com/thumbr/474x316/f/6/387bd095a2d0f1ccc6f49b7edf93b4930e5910003da49612309b72b64824c8/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.okaEG5SeQWsJBqKw0YdhjQHaE8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x266/d/4/ee17cb5f75dc787b836c251177be18e456abf8e9c599965626b4cd60abc726/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqCIUkZvpCiCDsheaCyCLAHaEK%26pid%3DApi&q=0&b=1&p=0&a=0', 'Volunteered at a local shelter.', 'Community Center', '#volunteer', 2, 'work,volunteer', 'e2cda31e-cfcd-4f85-88df-96663223eb7f', 'cd753433-a574-41bd-a0f1-c8c192f5f300', FALSE),
(UUID(), 'Road Trip', '2023-10-15', 3, 180, 'https://s2.qwant.com/thumbr/474x316/f/6/387bd095a2d0f1ccc6f49b7edf93b4930e5910003da49612309b72b64824c8/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.okaEG5SeQWsJBqKw0YdhjQHaE8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x266/d/4/ee17cb5f75dc787b836c251177be18e456abf8e9c599965626b4cd60abc726/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqCIUkZvpCiCDsheaCyCLAHaEK%26pid%3DApi&q=0&b=1&p=0&a=0', 'Went on a fun road trip with friends.', 'Highway', '#roadtrip', 1, 'trip,road', '1c985c41-8427-4253-b866-7018d994ce9c', 'aa637022-f2a0-48fe-8b8a-e73c36200391', FALSE),
(UUID(), 'Board Game Night', '2023-10-10', 1, 110, 'https://s2.qwant.com/thumbr/474x316/f/6/387bd095a2d0f1ccc6f49b7edf93b4930e5910003da49612309b72b64824c8/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.okaEG5SeQWsJBqKw0YdhjQHaE8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x266/d/4/ee17cb5f75dc787b836c251177be18e456abf8e9c599965626b4cd60abc726/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqCIUkZvpCiCDsheaCyCLAHaEK%26pid%3DApi&q=0&b=1&p=0&a=0', 'Had a fun night playing board games.', 'Home', '#games', 2, 'night,games', 'b539bfa5-4d15-4785-8a1a-dc31a59f66a3', '827c700d-1bee-4c78-9672-f5955c71176c', FALSE),
(UUID(), 'DIY Project', '2023-10-05', 3, 130, 'https://s2.qwant.com/thumbr/474x316/f/6/387bd095a2d0f1ccc6f49b7edf93b4930e5910003da49612309b72b64824c8/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.okaEG5SeQWsJBqKw0YdhjQHaE8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x266/d/4/ee17cb5f75dc787b836c251177be18e456abf8e9c599965626b4cd60abc726/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqCIUkZvpCiCDsheaCyCLAHaEK%26pid%3DApi&q=0&b=1&p=0&a=0', 'Completed a DIY home project.', 'Home', '#diy', 1, 'project,diy', '9dccceb9-3877-4ea4-bed7-5e8b2e1e7f8b', '1af2e795-006f-4065-a185-5aa3ab95e975', FALSE),
(UUID(), 'Kayaking Adventure', '2023-10-01', 4, 150, 'https://s2.qwant.com/thumbr/474x316/f/6/387bd095a2d0f1ccc6f49b7edf93b4930e5910003da49612309b72b64824c8/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.okaEG5SeQWsJBqKw0YdhjQHaE8%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x266/d/4/ee17cb5f75dc787b836c251177be18e456abf8e9c599965626b4cd60abc726/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.wqCIUkZvpCiCDsheaCyCLAHaEK%26pid%3DApi&q=0&b=1&p=0&a=0', 'Went kayaking on a beautiful lake.', 'Lake', '#kayaking', 1, 'adventure,kayaking', '014f5dea-c87c-455a-9a15-8442354be6b3', 'ce589280-f0da-4515-8578-2a945da0a1be', FALSE),
(UUID(), 'Baking Class', '2023-09-25', 2, 170, 'https://s2.qwant.com/thumbr/474x315/7/4/06190a5aaf58a106602431c8a78eed6c0aba7ed8089ac99f8bb97f91876557/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.10YryFNgL0dkNu3nBjcnkwHaE7%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x302/0/9/f0c5199baeb87badadfb7d9c6d8c7f02be819ee373c5ca7f5e232fc90aafef/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.e7ShWWBxRBiX57Clc5gHeAHaEu%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x366/d/d/2273121c90aaddb4a6af6c39f44decf7f6578000b73aeb8cb5245bef20bd33/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.4iRn7jTLuL8po20plexDkAHaFu%26pid%3DApi&q=0&b=1&p=0&a=0', 'Learned to bake delicious pastries.', 'Culinary School', '#baking', 1, 'class,baking', '6c25255d-2cb6-4b10-8ba9-7c39f77e2df9', '984edd9b-094d-4b3a-a6cd-56a1fe77617b', FALSE),
(UUID(), 'Horseback Riding', '2023-09-20', 3, 190, 'https://s2.qwant.com/thumbr/474x315/7/4/06190a5aaf58a106602431c8a78eed6c0aba7ed8089ac99f8bb97f91876557/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.10YryFNgL0dkNu3nBjcnkwHaE7%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x302/0/9/f0c5199baeb87badadfb7d9c6d8c7f02be819ee373c5ca7f5e232fc90aafef/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.e7ShWWBxRBiX57Clc5gHeAHaEu%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x366/d/d/2273121c90aaddb4a6af6c39f44decf7f6578000b73aeb8cb5245bef20bd33/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.4iRn7jTLuL8po20plexDkAHaFu%26pid%3DApi&q=0&b=1&p=0&a=0', 'Enjoyed a horseback riding session.', 'Ranch', '#horsebackriding', 1, 'riding,horseback', '83c11f46-15db-4c92-89bd-ab1e85b8ac7e', 'c3633edb-9ddc-417c-aebc-11096fb6a5a6', FALSE),
(UUID(), 'Language Class', '2023-09-15', 1, 100, 'https://s2.qwant.com/thumbr/474x315/7/4/06190a5aaf58a106602431c8a78eed6c0aba7ed8089ac99f8bb97f91876557/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.10YryFNgL0dkNu3nBjcnkwHaE7%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x302/0/9/f0c5199baeb87badadfb7d9c6d8c7f02be819ee373c5ca7f5e232fc90aafef/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.e7ShWWBxRBiX57Clc5gHeAHaEu%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x366/d/d/2273121c90aaddb4a6af6c39f44decf7f6578000b73aeb8cb5245bef20bd33/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.4iRn7jTLuL8po20plexDkAHaFu%26pid%3DApi&q=0&b=1&p=0&a=0', 'Started learning a new language.', 'Language School', '#language', 2, 'class,language', 'd8a9f88d-a555-4cdf-90ad-2f2c6d25cc11', 'b88964fc-887a-45e8-88cc-86a2e4b7f3b8', FALSE),
(UUID(), 'Scuba Diving', '2023-09-10', 4, 210, 'https://s2.qwant.com/thumbr/474x315/7/4/06190a5aaf58a106602431c8a78eed6c0aba7ed8089ac99f8bb97f91876557/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.10YryFNgL0dkNu3nBjcnkwHaE7%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x302/0/9/f0c5199baeb87badadfb7d9c6d8c7f02be819ee373c5ca7f5e232fc90aafef/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.e7ShWWBxRBiX57Clc5gHeAHaEu%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x366/d/d/2273121c90aaddb4a6af6c39f44decf7f6578000b73aeb8cb5245bef20bd33/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.4iRn7jTLuL8po20plexDkAHaFu%26pid%3DApi&q=0&b=1&p=0&a=0', 'Explored the underwater world.', 'Ocean', '#scuba', 1, 'diving,scuba', 'd31fc86e-be22-4907-af6e-ccc9f1a88806', '13836555-4836-4604-a2f6-35ed29a9ac09', FALSE),
(UUID(), 'Potluck Dinner', '2023-09-05', 2, 120, 'https://s2.qwant.com/thumbr/474x315/7/4/06190a5aaf58a106602431c8a78eed6c0aba7ed8089ac99f8bb97f91876557/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.10YryFNgL0dkNu3nBjcnkwHaE7%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x302/0/9/f0c5199baeb87badadfb7d9c6d8c7f02be819ee373c5ca7f5e232fc90aafef/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.e7ShWWBxRBiX57Clc5gHeAHaEu%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x366/d/d/2273121c90aaddb4a6af6c39f44decf7f6578000b73aeb8cb5245bef20bd33/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.4iRn7jTLuL8po20plexDkAHaFu%26pid%3DApi&q=0&b=1&p=0&a=0', 'Hosted a potluck dinner with friends.', 'Home', '#food', 2, 'dinner,potluck', '3d55695c-4f72-4cee-a075-ec6ba0579205', '87ebdf12-5e8d-4172-aba4-ee88c2251060', FALSE),
(UUID(), 'Bird Watching', '2023-09-01', 3, 140, 'https://s2.qwant.com/thumbr/474x315/7/4/06190a5aaf58a106602431c8a78eed6c0aba7ed8089ac99f8bb97f91876557/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.10YryFNgL0dkNu3nBjcnkwHaE7%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s1.qwant.com/thumbr/474x302/0/9/f0c5199baeb87badadfb7d9c6d8c7f02be819ee373c5ca7f5e232fc90aafef/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.e7ShWWBxRBiX57Clc5gHeAHaEu%26pid%3DApi&q=0&b=1&p=0&a=0<separationlienimage>https://s2.qwant.com/thumbr/474x366/d/d/2273121c90aaddb4a6af6c39f44decf7f6578000b73aeb8cb5245bef20bd33/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.4iRn7jTLuL8po20plexDkAHaFu%26pid%3DApi&q=0&b=1&p=0&a=0', 'Spent a day bird watching.', 'Park', '#birdwatching', 1, 'watching,bird', '9940866d-431f-4277-8372-572820deb6ce', '53e981f0-9e4d-44d9-837b-77ae0b091faa', FALSE),
(UUID(), 'Craft Workshop', '2023-08-25', 1, 160, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Created handmade crafts.', 'Workshop', '#craft', 2, 'workshop,craft', '3a8bf641-c5b1-40af-b605-be79a4050a51', '5f86ea7c-1e22-451b-ac36-4d671edda0c2', FALSE),
(UUID(), 'Sunset Hike', '2023-08-20', 3, 180, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Went on a beautiful sunset hike.', 'Mountain', '#hiking', 1, 'hike,sunset', '2621aeae-48bd-4dee-b98e-f078e71fd813', 'f70427c8-feef-4bf7-96bc-02c2aa56f127', FALSE),
(UUID(), 'Cooking Demo', '2023-08-15', 4, 200, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Attended a live cooking demo.', 'Culinary School', '#cooking', 1, 'demo,cooking', 'f5481f41-7e3b-41a1-9d94-9137d5653b09', 'b4c6d13a-0a40-421b-8a36-964b78bc9d0f', FALSE),
(UUID(), 'Beach Cleanup', '2023-08-10', 2, 110, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Participated in a beach cleanup event.', 'Beach', '#cleanup', 2, 'beach,cleanup', 'fcbdc2e9-8ca9-4fef-946b-f5b6318d7f61', 'f3a75103-ebff-4866-8361-eaf19a0f5b95', FALSE),
(UUID(), 'Flower Show', '2023-08-05', 3, 130, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Visited a beautiful flower show.', 'Garden', '#flowers', 1, 'show,flowers', '7755971b-e24f-4d0c-9370-1d85f41d52af', '69ac4bce-b419-4c87-bcfa-5c3c8562bf5f', FALSE),
(UUID(), 'Nature Walk', '2023-08-01', 3, 120, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Enjoyed a peaceful nature walk.', 'Forest', '#nature', 1, 'walk,nature', 'order105', '2fd1986f-f32a-4b1a-a095-9afc523d19a0', FALSE),
(UUID(), 'Painting Class', '2023-07-25', 2, 140, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Learned new painting techniques.', 'Art Studio', '#painting', 1, 'class,painting', 'order106', '91efddd0-4131-485a-ac14-a113aca48233', FALSE),
(UUID(), 'Volunteer Work', '2023-07-20', 4, 160, 'https://s1.qwant.com/thumbr/474x316/9/e/4f968fd7dd85c7c83eadddc80524fc9e1bb1cfd673c2a9eb21f0083cbb8570/th.jpg?u=https%3A%2F%2Ftse.mm.bing.net%2Fth%3Fid%3DOIP.Df0vZtLhyFa_O_bq4DPbQgHaE8%26pid%3DApi&q=0&b=1&p=0&a=0', 'Volunteered at a local shelter.', 'Community Center', '#volunteer', 2, 'work,volunteer', 'order107', 'f32059ac-5a63-4f17-b83a-059c3c88eff', FALSE);
-- Learning & Availability
CREATE TABLE location (
    locationId CHAR(36) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    addressId VARCHAR(255),
    availability INTEGER
);

-- Table for formationModel
CREATE TABLE formation (
    formationId CHAR(36) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    durationInHours INTEGER,
    startDate DATE,
    endDate DATE,
    locationId CHAR(36),
    state ENUM('Planned', 'InProgress', 'Cancelled', 'Completed') NOT NULL,
    FOREIGN KEY (locationId) REFERENCES location(locationId) ON DELETE CASCADE
);

-- Table for availabilityModel
CREATE TABLE formationavailability (
    availabilityId CHAR(36) PRIMARY KEY,
    formationId CHAR(36),
    year INTEGER NOT NULL,
    timeline VARCHAR(366) NOT NULL,
    FOREIGN KEY (formationId) REFERENCES formation(formationId) ON DELETE CASCADE,
    CONSTRAINT chk_timeline CHECK (timeline REGEXP '^[01]{365}$' OR timeline REGEXP '^[01]{366}$')

);

-- Enum for FORMATIONSTATE is embedded directly into the formation table as an ENUM type

-- Insert test data for locationModel
INSERT INTO location (locationId, name, addressId, availability) VALUES
('9f98e66a-0494-4c07-8cee-73c0122738a8', 'Location A', 'addr-001', 50),
('4bfcb9f9-9a93-4936-9862-67b400a66119', 'Location B', 'addr-002', 30);

-- Insert test data for formationModel
INSERT INTO formation (formationId, name, durationInHours, startDate, endDate, locationId, state) VALUES
('a09b751b-bd71-4d1a-ab36-9b1a62f79bcd', 'Formation 1', 40, '2025-01-01', '2025-01-05', '9f98e66a-0494-4c07-8cee-73c0122738a8', 'Planned'),
('88052d74-505a-4369-b696-1ff1acbe8da5', 'Formation 2', 20, '2025-02-01', '2025-02-03', '4bfcb9f9-9a93-4936-9862-67b400a66119', 'InProgress');

-- Insert test data for availabilityModel
INSERT INTO formationavailability (availabilityId, formationId, year, timeline) VALUES
('7611ece3-92d8-4f84-acd5-7cf479afd514', 'a09b751b-bd71-4d1a-ab36-9b1a62f79bcd', 2024, 
 '101100101011100101101111010100110010101001101001001001110100101011110101001001100001100001010011110001000001111110101111011110001010001011000111111101110110011101110010100111000110110010101000100001111011111001010000110001100010110111011111100111010001110101101011101100110101111001100010010110110010111111011110010001000001001011010010010100110111100011110010000110'),  -- 366 days for leap year
('20c92ebe-a7dc-4a2a-954a-e6712ad9f75b', '88052d74-505a-4369-b696-1ff1acbe8da5', 2025, 
 '00001110000011011110101100000000011011100110001000100001011000100100101011101010011011111101101010100100010001000110000010000010011110101100111001000011001101101000111110100001101010111001000111100010011100001011101100100100010101011101010010100011100000001001110101111111001110101000011011100100100011100111100111001000000100101011010101000110000100001111001110101');  -- 365 days for non-leap year


 -- Purchase & Provider
 CREATE TABLE IF NOT EXISTS `provider` (
  `id` varchar(16) NOT NULL,
  `name` varchar(255) NOT NULL,
  `service` varchar(255) NOT NULL,
  `siren` varchar(9) NOT NULL,
  `status` varchar(50) NOT NULL,
  `id_contact` varchar(16) NOT NULL,
  `registration_date` date NOT NULL,
  `region` varchar(100) NOT NULL,
  `legal_informations` text NOT NULL,
  `category` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `provider` VALUES ('1a7e9b4f3c2d5c8e','Gonzalez','embrace bleeding-edge mindshare','469212479','Inactive','343','2024-06-25','Bretagne','L\'assurance d\'avancer de mani�re efficace','Retail'),('2d4f9a8e7c1b3d6f','Roux','grow web-enabled mindshare','524027091','Active','111','2024-03-03','Bretagne','L\'avantage d\'�voluer sans soucis','Healthcare'),('3e5d9c7a4f1b2c6d','Dufour','deploy seamless users','665149097','Suspended','220','2023-04-05','Occitanie','La libert� d\'avancer plus rapidement','IT Services'),('4a5c9b8d3e2f1d4c','Grenier','cultivate end-to-end infrastructures','984179959','Inactive','129','2015-04-24','Occitanie','Le confort d\'�voluer plus rapidement','Agriculture'),('6d8c7e1b2f9a3d4f','Schneider SARL','benchmark turn-key infrastructures','522132365','Suspended','405','2019-07-12','Nouvelle-Aquitaine','Le pouvoir de rouler avant-tout','IT Services'),('7c1d5f3b4e2a9d8f','Duhamel','innovate front-end web services','779346520','Active','79','2018-06-05','Bourgogne-Franche-Comt�','Le droit de rouler autrement','Education'),('7d3f5e9b4c1d3a8f','Olivier Normand et Fils','reinvent holistic technologies','896059353','Pending','7','2017-01-22','Grand Est','L\'avantage d\'atteindre vos buts de mani�re efficace','Healthcare'),('9b4c3d5e6f7a8c1d','Lebon','strategize vertical e-business','981208650','Active','460','2024-07-05','Normandie','L\'assurance de changer � la pointe','IT Services'),('b2f4e7d3c1a8b9c5','Guilbert','matrix granular applications','476309348','Pending','322','2024-06-01','Bourgogne-Franche-Comt�','Le plaisir de changer sans soucis','Education'),('f91a3e4b2d7f9c7b','Courtois et Fils','scale revolutionary infrastructures','309218916','Suspended','337','2017-10-04','Bretagne','Le plaisir d\'�voluer de mani�re s�re','Construction');

CREATE TABLE `purchase` (
  `id` varchar(16) NOT NULL,
  `buyDate` date NOT NULL,
  `price` float NOT NULL,
  `quantity` int NOT NULL,
  `state` enum('pending','cancelled','delivered','in_delivery','confirmed') NOT NULL,
  `idProduct` varchar(36) NOT NULL,
  `product` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `purchase` VALUES ('0ee4800f-e69f-4','2024-05-29',92.6,17,'pending','77cf4a22-2de7-49d5-9f70-a539994ead33','Product_975'),('1947c848-8122-4','2024-02-17',427.25,41,'confirmed','8a3ffa99-f53a-4778-91e2-feedc1b40416','Product_446'),('1fd50eb8-b8c4-4','2024-10-14',78.21,30,'delivered','b147be12-c903-45f5-be5f-2406dfa670b6','Product_914'),('23838f15-1676-4e','2024-06-21',436.51,37,'in_delivery','dfae690f-1e50-4763-9225-a2634454b216','Product_181'),('38bf3233-9028-4','2024-02-20',433.44,4,'cancelled','0b188c3e-c9d2-464b-9efa-c00c59073faf','Product_154'),('3ab47ad6-044d-4','2024-10-26',57.46,14,'pending','53f83c9c-40df-4f71-97a4-563204a2ff01','Product_861'),('650599a6-8b5e-4','2024-01-19',32.68,48,'in_delivery','69d47814-9742-4bae-b3da-8515b4d2e5f4','Product_577'),('7a538497-81df-42','2024-06-02',147.78,11,'confirmed','58d6cd08-c674-45c3-a3b0-1f96398f43fa','Product_147'),('bd7a9f8c-9a4c-4','2024-06-11',246.57,30,'pending','36f88fb6-275e-45eb-a1b8-ef0f4adcf7c6','Product_934'),('ea2ad64f-8f2e-4','2024-06-20',365.07,48,'confirmed','abb64834-2cfd-4080-9b45-c22b8adb6ab8','Product_866');


