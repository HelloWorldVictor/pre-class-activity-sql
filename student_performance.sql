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

-- 2. Queries to Implement
-- Insert sample data into each table (at least 15 students)

-- Insert students
INSERT INTO students (student_name, intake_year) VALUES
('Victor Hamzat', 2023),
('Ayobamidele Aiyedogbon', 2023),
('Liata Ornella', 2022),
('Jean Luc Mucyo Ndahimana', 2023),
('Victor Idowu', 2022),
('Fatima Al-Fihri', 2024),
('Nelson Mandela', 2023),
('Wangari Maathai', 2022),
('Chinua Achebe', 2024),
('Ngozi Okonjo-Iweala', 2023),
('Elon Musk', 2022),
('Jeff Bezos', 2024),
('Bill Gates', 2023),
('Mark Zuckerberg', 2022),
('Ada Lovelace', 2024);

-- Insert Linux grades (some students took this course)
INSERT INTO linux_grades (student_id, grade_obtained) VALUES
(1, 85),
(2, 45),
(3, 70),
(4, 90),
(5, 48),
(7, 60),
(8, 75),
(10, 88),
(11, 40),
(13, 95),
(15, 80);

-- Insert Python grades (some students took this course)
INSERT INTO python_grades (student_id, grade_obtained) VALUES
(1, 92),
(3, 78),
(4, 85),
(6, 95),
(7, 68),
(9, 88),
(10, 91),
(12, 72),
(13, 89),
(14, 65),
(15, 82);

-- Find students who scored less than 50% in the Linux course.
-- This query selects students from the linux_grades table with a grade less than 50.
SELECT s.student_name, lg.grade_obtained
FROM students s
JOIN linux_grades lg ON s.student_id = lg.student_id
WHERE lg.grade_obtained < 50;

-- Find students who took only one course (either Linux or Python, not both).
-- This query unions all course records, groups by student, and counts their courses.
-- A count of 1 means the student took only one course.
SELECT s.student_name
FROM students s
JOIN (
    SELECT student_id FROM linux_grades
    UNION ALL
    SELECT student_id FROM python_grades
) AS all_courses ON s.student_id = all_courses.student_id
GROUP BY s.student_id, s.student_name
HAVING COUNT(s.student_id) = 1;

-- Find students who took both courses.
-- This query finds students who have an entry in both the linux_grades and python_grades tables.
SELECT s.student_name
FROM students s
JOIN linux_grades lg ON s.student_id = lg.student_id
JOIN python_grades pg ON s.student_id = pg.student_id;


-- Calculate the average grade per course (Linux and Python separately).
-- This query calculates the average grade for the Linux course.
SELECT 'Linux' AS course, AVG(grade_obtained) AS average_grade
FROM linux_grades;

-- This query calculates the average grade for the Python course.
SELECT 'Python' AS course, AVG(grade_obtained) AS average_grade
FROM python_grades;

-- Identify the top-performing student across both courses (based on the average of their grades).
-- This query calculates the average grade for each student across all courses they took,
-- then orders the results to find the student with the highest average.
SELECT s.student_name, AVG(all_grades.grade) as average_score
FROM students s
JOIN (
    SELECT student_id, grade_obtained as grade FROM linux_grades
    UNION ALL
    SELECT student_id, grade_obtained as grade FROM python_grades
) AS all_grades ON s.student_id = all_grades.student_id
GROUP BY s.student_id, s.student_name
ORDER BY average_score DESC
LIMIT 1;
