CREATE DATABASE college_db;
USE college_db;

CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    hod_name VARCHAR(100),
    department_email VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    
    date_of_birth DATE NOT NULL,
    age INT CHECK (age >= 16),
    
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) UNIQUE,
    
    address TEXT,
    city VARCHAR(50) DEFAULT 'Delhi',
    state VARCHAR(50) DEFAULT 'Delhi',
    pincode VARCHAR(10),
    
    course VARCHAR(100) NOT NULL,
    year_of_study INT CHECK (year_of_study BETWEEN 1 AND 5),
    
    department_id INT,
    
    admission_date DATE DEFAULT (CURRENT_DATE),
    
    fees_paid DECIMAL(10,2) DEFAULT 0.00,
    attendance_percentage DECIMAL(5,2) CHECK (attendance_percentage BETWEEN 0 AND 100),
    
    is_active BOOLEAN DEFAULT TRUE,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE INDEX idx_student_name ON students(first_name, last_name);
CREATE INDEX idx_course ON students(course);
CREATE INDEX idx_department ON students(department_id);

INSERT INTO departments (department_name, hod_name, department_email)
VALUES
('Computer Science', 'Dr. Sharma', 'cse@college.com'),
('Management', 'Dr. Mehta', 'mba@college.com'),
('Commerce', 'Dr. Verma', 'bcom@college.com');

INSERT INTO students
(first_name, last_name, gender, date_of_birth, age, email, phone, address, city, state, pincode,
 course, year_of_study, department_id, fees_paid, attendance_percentage)
VALUES
('Niharika', 'Kanujia', 'Female', '2004-06-03', 21, 'niharika@gmail.com', '9876543210',
 'Shiamgir', 'Delhi', 'Delhi', '110001',
 'BCA', 3, 1, 45000.00, 92.50),

('Rahul', 'Sharma', 'Male', '2003-09-15', 22, 'rahul@gmail.com', '9123456780',
 'Noida', 'Noida', 'UP', '201301',
 'MBA', 2, 2, 60000.00, 85.00);
 
 SELECT * FROM students;
 
 SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    s.course,
    d.department_name,
    s.attendance_percentage
FROM students s
LEFT JOIN departments d
ON s.department_id = d.department_id;