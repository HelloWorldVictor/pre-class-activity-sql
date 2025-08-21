-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS alu_student_performance;
USE alu_student_performance;

-- Drop tables if they exist to start with a clean slate
DROP TABLE IF EXISTS `python_grades`;
DROP TABLE IF EXISTS `linux_grades`;
DROP TABLE IF EXISTS `students`;

-- 1. Database Structure
-- Create students table
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100) NOT NULL,
    intake_year INT NOT NULL
);

-- Create linux_grades table
CREATE TABLE linux_grades (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(50) DEFAULT 'Linux',
    student_id INT,
    grade_obtained INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- Create python_grades table
CREATE TABLE python_grades (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(50) DEFAULT 'Python',
    student_id INT,
    grade_obtained INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

