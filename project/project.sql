CREATE DATABASE student_system;
USE student_system;

CREATE TABLE departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    dob DATE,
    email VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

CREATE TABLE logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sample departments
INSERT INTO departments (name) VALUES ('CS'), ('IT'), ('SE');

DELIMITER //
CREATE PROCEDURE GetStudentById(IN sid INT)
BEGIN
    SELECT * FROM students WHERE id = sid;
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION GetStudentEmail(sid INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE email VARCHAR(100);
    SELECT s.email INTO email FROM students s WHERE s.id = sid;
    RETURN email;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER before_student_insert
BEFORE INSERT ON students
FOR EACH ROW
BEGIN
    IF NEW.email NOT LIKE '%@%' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid email format';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER after_student_insert
AFTER INSERT ON students
FOR EACH ROW
BEGIN
    INSERT INTO logs (message) VALUES (CONCAT('Student ', NEW.name, ' added.'));
END //
DELIMITER ;

