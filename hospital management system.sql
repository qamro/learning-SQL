-- Setup
CREATE DATABASE IF NOT EXISTS hospital;
USE hospital;

-- Tables
CREATE TABLE doctors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    specialization VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    salary DECIMAL(10,2)
);

CREATE TABLE patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    city VARCHAR(100),
    email VARCHAR(100),
    blood_type VARCHAR(5)
);

CREATE TABLE appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    status VARCHAR(20),
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients(id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(id)
);

CREATE TABLE prescriptions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT,
    medicine VARCHAR(100),
    dosage VARCHAR(100),
    duration VARCHAR(50),
    FOREIGN KEY (appointment_id) REFERENCES appointments(id)
);

CREATE TABLE rooms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10),
    type VARCHAR(50),
    price_per_night DECIMAL(10,2),
    available BOOLEAN DEFAULT TRUE
);

CREATE TABLE admissions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    room_id INT,
    admit_date DATE,
    discharge_date DATE,
    FOREIGN KEY (patient_id) REFERENCES patients(id),
    FOREIGN KEY (room_id) REFERENCES rooms(id)
);

-- Insert Data
INSERT INTO doctors (name, specialization, email, phone, salary) VALUES
('Dr. Smith', 'Cardiology', 'smith@hospital.com', '123456789', 8000.00),
('Dr. Johnson', 'Neurology', 'johnson@hospital.com', '987654321', 9000.00),
('Dr. Brown', 'Pediatrics', 'brown@hospital.com', '456789123', 7500.00),
('Dr. Davis', 'Orthopedics', 'davis@hospital.com', '321654987', 8500.00),
('Dr. Wilson', 'Dermatology', 'wilson@hospital.com', '654321789', 7000.00);

INSERT INTO patients (name, age, gender, city, email, blood_type) VALUES
('Alice', 30, 'Female', 'Paris', 'alice@email.com', 'A+'),
('Bob', 45, 'Male', 'London', 'bob@email.com', 'B+'),
('Charlie', 25, 'Male', 'Berlin', 'charlie@email.com', 'O+'),
('Diana', 35, 'Female', 'Paris', 'diana@email.com', 'AB+'),
('Eve', 50, 'Female', 'London', 'eve@email.com', 'A-'),
('Frank', 28, 'Male', 'Berlin', 'frank@email.com', 'B-'),
('Grace', 40, 'Female', 'Paris', 'grace@email.com', 'O-');

INSERT INTO appointments (patient_id, doctor_id, appointment_date, status, notes) VALUES
(1, 1, '2024-01-10', 'completed', 'Regular checkup'),
(2, 2, '2024-01-15', 'completed', 'Headache issues'),
(3, 3, '2024-01-20', 'completed', 'Fever and cold'),
(4, 1, '2024-02-01', 'completed', 'Heart checkup'),
(5, 4, '2024-02-10', 'completed', 'Knee pain'),
(6, 5, '2024-02-15', 'completed', 'Skin rash'),
(7, 2, '2024-03-01', 'completed', 'Migraine'),
(1, 3, '2024-03-10', 'upcoming', 'Follow up'),
(2, 1, '2024-03-15', 'upcoming', 'Heart checkup');

INSERT INTO prescriptions (appointment_id, medicine, dosage, duration) VALUES
(1, 'Aspirin', '500mg', '7 days'),
(1, 'Vitamin C', '1000mg', '30 days'),
(2, 'Ibuprofen', '400mg', '5 days'),
(3, 'Paracetamol', '500mg', '3 days'),
(4, 'Atorvastatin', '20mg', '90 days'),
(5, 'Diclofenac', '50mg', '10 days'),
(6, 'Hydrocortisone', '1%', '14 days'),
(7, 'Sumatriptan', '50mg', '5 days');

INSERT INTO rooms (room_number, type, price_per_night, available) VALUES
('101', 'Single', 100.00, TRUE),
('102', 'Single', 100.00, FALSE),
('201', 'Double', 150.00, TRUE),
('202', 'Double', 150.00, FALSE),
('301', 'Suite', 300.00, TRUE),
('302', 'ICU', 500.00, FALSE);

INSERT INTO admissions (patient_id, room_id, admit_date, discharge_date) VALUES
(2, 2, '2024-01-15', '2024-01-20'),
(4, 4, '2024-02-01', '2024-02-05'),
(5, 6, '2024-02-10', NULL),
(7, 2, '2024-03-01', NULL);



-- QUERIES






-- 1. Show all doctors and their specialization
SELECT name, specialization FROM doctors;

-- 2. Show all patients with blood type A+
SELECT * FROM patients WHERE blood_type = 'A+';

-- 3. Show all upcoming appointments
SELECT patients.name, doctors.name AS doctor, 
appointments.appointment_date, appointments.notes
FROM appointments
INNER JOIN patients ON appointments.patient_id = patients.id
INNER JOIN doctors ON appointments.doctor_id = doctors.id
WHERE appointments.status = 'upcoming';

-- 4. Show all prescriptions for each patient
SELECT patients.name, prescriptions.medicine, 
prescriptions.dosage, prescriptions.duration
FROM prescriptions
INNER JOIN appointments ON prescriptions.appointment_id = appointments.id
INNER JOIN patients ON appointments.patient_id = patients.id;

-- 5. Show how many appointments each doctor has
SELECT doctors.name, COUNT(*) AS total_appointments
FROM appointments
INNER JOIN doctors ON appointments.doctor_id = doctors.id
GROUP BY doctors.name
ORDER BY total_appointments DESC;

-- 6. Show patients currently admitted (no discharge date)
SELECT patients.name, rooms.room_number, 
rooms.type, admissions.admit_date
FROM admissions
INNER JOIN patients ON admissions.patient_id = patients.id
INNER JOIN rooms ON admissions.room_id = rooms.id
WHERE admissions.discharge_date IS NULL;

-- 7. Show available rooms
SELECT * FROM rooms WHERE available = TRUE;

-- 8. Show highest paid doctors
SELECT name, specialization, salary FROM doctors
ORDER BY salary DESC;

-- 9. Show patients from Paris
SELECT * FROM patients WHERE city = 'Paris';

-- 10. Count patients by blood type
SELECT blood_type, COUNT(*) AS total
FROM patients
GROUP BY blood_type
ORDER BY total DESC;