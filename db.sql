-- Create the UserProfile table
CREATE TABLE UserProfile (
    UserId TEXT NOT NULL,
    FirstName TEXT NOT NULL,
    LastName TEXT NOT NULL,
    Contact TEXT NOT NULL,
    Email TEXT,
    CreatedAt TIMESTAMP NOT NULL,
    PRIMARY KEY (UserId)
);
 
-- Create the News table
CREATE TABLE News (
    NewsId INT NOT NULL,
    Title TEXT NOT NULL,
    Content TEXT NOT NULL,
    PublishedAt TIMESTAMP NOT NULL,
    CreatedBy TEXT NOT NULL,
    Url TEXT,
    UrlToImage TEXT,
    PRIMARY KEY (NewsId),
    CONSTRAINT fk_createdby FOREIGN KEY (CreatedBy) REFERENCES UserProfile(UserId)
);
 
-- Create the UserTable table
CREATE TABLE UserTable (
    UserId TEXT NOT NULL,  
    Password TEXT NOT NULL,
    CONSTRAINT fk_UserId FOREIGN KEY (UserId) REFERENCES UserProfile(UserId),
    PRIMARY KEY (UserId)
);
 
-- Create the Reminders table
CREATE TABLE Reminders (
    ReminderId INT NOT NULL,
    Schedule TIMESTAMP NOT NULL,
    NewsId INT NOT NULL,
    PRIMARY KEY (ReminderId),
    CONSTRAINT fk_NewsId FOREIGN KEY (NewsId) REFERENCES News(NewsId)
);
 
-- Insert dummy data into UserProfile
INSERT INTO UserProfile (UserId, FirstName, LastName, Contact, Email, CreatedAt) VALUES 
('Emily', 'Johnson', 'Maria', '9001122334', 'emily.johnson@example.com', '2024-08-15 12:30:45'),
('David', 'Smith', 'William', '9876543210', 'david.smith@example.com', '2024-10-20 09:05:30'),
('Jack', 'Taylor', 'Anderson', '9443322110', 'jack.anderson@example.com', '2022-05-10 14:25:50'),
('John', 'Doe', 'Brown', '9198765432', 'john.doe@example.com', '2023-03-15 10:45:00');
 
-- Insert dummy data into News
INSERT INTO News (NewsId, Title, Content, PublishedAt, CreatedBy, Url, UrlToImage) VALUES 
(101, 'Tech Innovation in 2024', 'Details about tech innovation...', '2024-01-10 09:00:00', 'Emily', NULL, NULL),
(102, 'Healthcare Advancements', 'Details about healthcare...', '2023-12-20 15:30:00', 'David', NULL, NULL),
(103, 'Economic Growth in 2023', 'Details about economic growth...', '2023-05-15 11:00:00', 'Jack', NULL, NULL),
(104, 'Climate Change Effects', 'Details about climate change...', '2024-03-01 08:45:00', 'Emily', NULL, NULL);
 
-- Insert dummy data into UserTable
INSERT INTO UserTable (UserId, Password) VALUES 
('Emily', 'password123'),
('David', 'securepass456'),
('Jack', 'mypassword789'),
('John', 'johnpassword123');
 
-- Insert dummy data into Reminders
INSERT INTO Reminders (ReminderId, Schedule, NewsId) VALUES 
(1, '2024-01-15 10:00:00', 101),
(2, '2023-12-25 14:00:00', 103);
 
 
SELECT * 
FROM UserProfile
WHERE CreatedAt >= '2019-12-10';
 
SELECT u.*, n.*
FROM UserProfile u
INNER JOIN News n ON u.UserId = n.CreatedBy
WHERE u.FirstName = 'Jack';
 
SELECT u.*
FROM UserProfile u
INNER JOIN News n ON u.UserId = n.CreatedBy
WHERE n.NewsId = 103;
 
SELECT u.*
FROM UserProfile u
LEFT JOIN News n ON u.UserId = n.CreatedBy
WHERE n.CreatedBy IS NULL;
 
SELECT n.NewsId, n.Title
FROM News n
INNER JOIN Reminders r ON n.NewsId = r.NewsId;
 
SELECT n.CreatedBy, COUNT(*) AS TotalNews
FROM News n
GROUP BY n.CreatedBy;
 
UPDATE UserProfile
SET Contact = '9192939495'
WHERE UserId = 'John';
 
UPDATE News
SET Title = 'IT industry growth can be seen in 2020'
WHERE NewsId = 101;
 
DELETE FROM Reminders
WHERE NewsId IN (
    SELECT NewsId
    FROM News
    WHERE CreatedBy = 'Jack'
);
 
INSERT INTO Reminders (ReminderId, Schedule, NewsId)
VALUES (3, '2024-02-10 10:30:00', 104);
 
