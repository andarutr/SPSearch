-- Create Health Database
CREATE DATABASE HealthDB;
GO
USE HealthDB;
GO

-- Patients Table
CREATE TABLE Patients (
    patient_id INT IDENTITY(1,1) PRIMARY KEY,
    patient_code VARCHAR(20) UNIQUE NOT NULL,
    full_name NVARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M', 'F', 'O')) NOT NULL,
    blood_type CHAR(2),
    phone_number VARCHAR(20),
    email VARCHAR(100),
    address NVARCHAR(200),
    city NVARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    country NVARCHAR(50),
    emergency_contact_name NVARCHAR(100),
    emergency_contact_phone VARCHAR(20),
    emergency_contact_relationship VARCHAR(50),
    marital_status VARCHAR(20),
    occupation NVARCHAR(50),
    insurance_provider NVARCHAR(100),
    insurance_number VARCHAR(50),
    insurance_expiration_date DATE,
    height DECIMAL(5,2),
    weight DECIMAL(5,2),
    body_mass_index DECIMAL(4,2),
    medical_history TEXT,
    allergies TEXT,
    current_medication TEXT,
    previous_surgeries TEXT,
    family_medical_history TEXT,
    smoking_status VARCHAR(20),
    alcohol_consumption VARCHAR(20),
    physical_activity VARCHAR(50),
    emergency_contact_verified BIT DEFAULT 0,
    is_active BIT DEFAULT 1,
    registration_date DATETIME DEFAULT GETDATE(),
    last_visit_date DATETIME,
    notes TEXT
);
GO

-- Doctors Table
CREATE TABLE Doctors (
    doctor_id INT IDENTITY(1,1) PRIMARY KEY,
    doctor_code VARCHAR(20) UNIQUE NOT NULL,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    specialty NVARCHAR(50) NOT NULL,
    medical_license_number VARCHAR(50) UNIQUE NOT NULL,
    date_of_employment DATETIME NOT NULL,
    education_level NVARCHAR(50),
    medical_school NVARCHAR(100),
    graduation_year INT,
    board_certifications TEXT,
    hospital_affiliation NVARCHAR(100),
    department_id INT,
    phone_number VARCHAR(20),
    email VARCHAR(100),
    office_address NVARCHAR(200),
    consultation_fee DECIMAL(10,2),
    rating DECIMAL(3,2) DEFAULT 0,
    total_reviews INT DEFAULT 0,
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE()
);
GO

-- Departments Table
CREATE TABLE Departments (
    department_id INT IDENTITY(1,1) PRIMARY KEY,
    department_code VARCHAR(20) UNIQUE NOT NULL,
    department_name NVARCHAR(50) NOT NULL,
    description NVARCHAR(200),
    hospital_name NVARCHAR(100),
    location NVARCHAR(100),
    phone_number VARCHAR(20),
    fax_number VARCHAR(20),
    email VARCHAR(100),
    operating_hours VARCHAR(100),
    number_of_doctors INT DEFAULT 0,
    number_of_nurses INT DEFAULT 0,
    number_of_beds INT DEFAULT 0,
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE()
);
GO

-- Patients Table Sample Data
INSERT INTO Patients (patient_code, full_name, date_of_birth, gender, blood_type, phone_number, email, address, city, state, postal_code, country, emergency_contact_name, emergency_contact_phone, emergency_contact_relationship, marital_status, occupation, insurance_provider, insurance_number, height, weight, body_mass_index, smoking_status, alcohol_consumption, physical_activity) VALUES
('PAT001', 'Budi Santoso', '1985-03-15', 'M', 'A+', '081234567890', 'budi.santoso@email.com', 'Jl. Merdeka No. 45', 'Jakarta', 'DKI Jakarta', '10110', 'Indonesia', 'Siti Santoso', '081298765432', 'Wife', 'Married', 'Software Engineer', 'BPJS', 'BPJS123456', 175.0, 75.0, 24.49, 'Non-smoker', 'Occasional', 'Moderate exercise'),
('PAT002', 'Siti Aminah', '1990-07-22', 'F', 'O+', '081357986421', 'siti.aminah@email.com', 'Jl. Sudirman No. 123', 'Surabaya', 'East Java', '60111', 'Indonesia', 'Ahmad Aminah', '081387654321', 'Husband', 'Married', 'Teacher', 'Allianz', 'ALL123456', 165.0, 58.0, 21.33, 'Non-smoker', 'Rarely', 'Light exercise'),
('PAT003', 'Rahmat Hidayat', '1978-11-08', 'M', 'B-', '081456789123', 'rahmat.hidayat@email.com', 'Jl. Gatot Subroto No. 78', 'Bandung', 'West Java', '40111', 'Indonesia', 'Dewi Hidayat', '081478956321', 'Daughter', 'Divorced', 'Business Owner', 'Prudential', 'PRU123456', 180.0, 85.0, 26.23, 'Former smoker', 'Moderate', 'Intense exercise'),
('PAT004', 'Dewi Lestari', '1995-02-14', 'F', 'A-', '081567890456', 'dewi.lestari@email.com', 'Jl. Diponegoro No. 321', 'Medan', 'North Sumatra', '20111', 'Indonesia', 'Budi Lestari', '081598765432', 'Husband', 'Single', 'Student', 'Jasa Raharja', 'JRA123456', 162.0, 52.0, 19.84, 'Non-smoker', 'Never', 'No exercise'),
('PAT005', 'Agus Prasetyo', '1982-05-30', 'M', 'AB+', '081678901234', 'agus.prasetyo@email.com', 'Jl. Thamrin No. 654', 'Jakarta', 'DKI Jakarta', '10220', 'Indonesia', 'Sri Prasetyo', '081687654321', 'Wife', 'Married', 'Accountant', 'AXA', 'AXA123456', 178.0, 72.0, 22.71, 'Occasional', 'Moderate', 'Regular exercise');
GO

-- Doctors Table Sample Data
INSERT INTO Doctors (doctor_code, first_name, last_name, specialty, medical_license_number, date_of_employment, education_level, medical_school, graduation_year, board_certifications, hospital_affiliation, department_id, phone_number, email, consultation_fee, rating, total_reviews) VALUES
('DOC001', 'Dr. Andi Wijaya', 'Sp.PD', 'Internal Medicine', 'DIY123456', '2010-01-15', 'Master', 'Universitas Gadjah Mada', '2005', 'Spesialis Penyakit Dalam', 'RSUD Dr. Soetomo', 150000, 4.8, 245),
('DOC002', 'Dr. Siti Rahayu', 'Sp.A', 'Pediatrics', 'DIY234567', '2012-03-20', 'Master', 'Universitas Indonesia', '2007', 'Spesialis Anak', 'RSUD Dr. Cipto Mangunkusumo', 120000, 4.9, 312),
('DOC003', 'Dr. Budi Santoso', 'Sp.JP', 'Cardiology', 'DIY345678', '2008-06-10', 'Master', 'Universitas Airlangga', '2003', 'Spesialis Jantung', 'RSU Harapan Kita', 200000, 4.7, 189),
('DOC004', 'Dr. Dewi Lestari', 'Sp.M', 'Obstetrics & Gynecology', 'DIY456789', '2015-09-05', 'Master', 'Universitas Padjadjaran', '2010', 'Spesialis Kandungan', 'RS Pertiwi', 180000, 4.9, 276),
('DOC005', 'Dr. Ahmad Hidayat', 'Sp.FK', 'Family Medicine', 'DIY567890', '2013-11-18', 'Master', 'Universitas Diponegoro', '2008', 'Spesialis Kesehatan Keluarga', 'RSUD Dr. Soetomo', 100000, 4.6, 156);
GO

-- Departments Table Sample Data
INSERT INTO Departments (department_code, department_name, description, hospital_name, location, phone_number, fax_number, email, operating_hours, number_of_doctors, number_of_nurses, number_of_beds, is_active) VALUES
('DEP001', 'Internal Medicine', 'Pelayanan medis untuk penyakit dalam', 'RSUD Dr. Soetomo', 'Lantai 2', '021-3456789', '021-3456790', 'internal@rssoetomo.co.id', 'Senin-Jumat: 08:00-17:00', 15, 45, 80, 1),
('DEP002', 'Pediatrics', 'Pelayanan kesehatan anak', 'RSUD Dr. Soetomo', 'Lantai 3', '021-3456791', '021-3456792', 'pediatrics@rssoetomo.co.id', 'Senin-Jumat: 08:00-17:00', 12, 38, 60, 1),
('DEP003', 'Cardiology', 'Pelayanan kesehatan jantung', 'RSU Harapan Kita', 'Lantai 4', '021-7890123', '021-7890124', 'cardiology@harapankita.co.id', 'Senin-Jumat: 08:00-17:00', 8, 25, 40, 1),
('DEP004', 'Obstetrics & Gynecology', 'Pelayanan kesehatan wanita', 'RS Pertiwi', 'Lantai 2', '021-8765432', '021-8765433', 'obgyn@pertiwirs.co.id', 'Senin-Jumat: 08:00-17:00', 10, 32, 50, 1),
('DEP005', 'Family Medicine', 'Pelayanan kesehatan keluarga', 'RSUD Dr. Soetomo', 'Lantai 1', '021-3456793', '021-3456794', 'family@rssoetomo.co.id', 'Senin-Jumat: 08:00-17:00', 10, 30, 45, 1);
GO

-- Patients Table Additional Sample Data (for more columns demonstration)
INSERT INTO Patients (patient_code, full_name, date_of_birth, gender, blood_type, phone_number, email, address, city, state, postal_code, country, emergency_contact_name, emergency_contact_phone, emergency_contact_relationship, marital_status, occupation, insurance_provider, insurance_number, insurance_expiration_date, height, weight, body_mass_index, medical_history, allergies, current_medication, previous_surgeries, family_medical_history, smoking_status, alcohol_consumption, physical_activity, emergency_contact_verified, is_active, registration_date, last_visit_date, notes) VALUES
('PAT006', 'Wahyu Saputra', '1988-09-12', 'M', 'B+', '081789012345', 'wahyu.saputra@email.com', 'Jl. Gatot Subroto No. 987', 'Jakarta', 'DKI Jakarta', '10230', 'Indonesia', 'Maya Saputra', '081790123456', 'Wife', 'Married', 'Architect', 'Jasa Raharja', 'JRA789012', '2026-12-31', 172.0, 68.0, 23.01, 'Hypertension', 'Penicillin', 'Amlodipine 5mg daily', 'Appendectomy 2005', 'Diabetes in father', 'Former smoker', 'Moderate', 'Regular exercise', 1, 1, '2024-01-10 09:30:00', '2024-06-15 14:20:00', 'Follow-up for hypertension'),
('PAT007', 'Maya Sari', '1993-01-25', 'F', 'O-', '081890123456', 'maya.sari@email.com', 'Jl. Sudirman No. 543', 'Bandung', 'West Java', '40220', 'Indonesia', 'Doni Sari', '081891234567', 'Husband', 'Married', 'Graphic Designer', 'Allianz', 'ALL789012', '2026-12-31', 160.0, 55.0, 21.48, 'None', 'Latex', '', '', 'None', 'Non-smoker', 'Occasional', 'Light exercise', 1, 1, '2024-02-15 11:00:00', '2024-05-20 10:00:00', 'Routine check-up'),
('PAT008', 'Eko Prasetyo', '1980-04-18', 'M', 'AB-', '081901234567', 'eko.prasetyo@email.com', 'Jl. Thamrin No. 6543', 'Surabaya', 'East Java', '60230', 'Indonesia', 'Rina Prasetyo', '081902345678', 'Wife', 'Married', 'Businessman', 'Prudential', 'PRU789012', '2026-12-31', 175.0, 78.0, 25.51, 'Asthma', 'None', 'Salbutamol PRN', 'Cholecystectomy 2010', 'None', 'Former smoker', 'Moderate', 'No exercise', 1, 1, '2024-03-08 08:45:00', '2024-06-18 16:30:00', 'Asthma evaluation'),
('PAT009', 'Rina Wulandari', '1997-07-07', 'F', 'A+', '082012345678', 'rina.wulandari@email.com', 'Jl. Diponegoro No. 876', 'Medan', 'North Sumatra', '20122', 'Indonesia', 'Dimas Wulandari', '082013456789', 'Husband', 'Single', 'Nurse', 'Jasa Raharja', 'JRA789012', '2026-12-31', 163.0, 54.0, 20.37, 'None', 'None', '', '', 'Hypertension in mother', 'Non-smoker', 'Rarely', 'Moderate exercise', 0, 1, '2024-04-12 13:15:00', NULL, 'New patient registration'),
('PAT010', 'Dimas Anggara', '1992-10-31', 'M', 'B-', '082123456789', 'dimas.anggara@email.com', 'Jl. Gatot Subroto No. 210', 'Jakarta', 'DKI Jakarta', '10240', 'Indonesia', 'Susi Anggara', '082124567890', 'Wife', 'Married', 'Software Developer', 'AXA', 'AXA789012', '2026-12-31', 170.0, 64.0, 22.15, 'None', 'None', '', '', 'None', 'Non-smoker', 'Moderate', 'Intense exercise', 1, 1, '2024-05-20 10:00:00', '2024-06-20 11:30:00', 'Preventive check-up');
GO

-- Doctors Table Additional Sample Data
INSERT INTO Doctors (doctor_code, first_name, last_name, specialty, medical_license_number, date_of_employment, education_level, medical_school, graduation_year, board_certifications, hospital_affiliation, department_id, phone_number, email, consultation_fee, rating, total_reviews) VALUES
('DOC006', 'Dr. Heri Kusuma', 'Sp.B', 'Cardiovascular Surgery', 'DIY678901', '2015-04-22', 'Master', 'Universitas Indonesia', '2010', 'Spesialis Bedah Jantung', 'RSU Harapan Kita', 3, 4.9, 198),
('DOC007', 'Dr. Ani Putri', 'Sp.A', 'Pediatrics', 'DIY789012', '2014-07-15', 'Master', 'Universitas Gadjah Mada', '2009', 'Spesialis Anak', 'RSUD Dr. Cipto Mangunkusumo', 2, 4.8, 245),
('DOC008', 'Dr. Hendra Wijaya', 'Sp.M', 'Obstetrics & Gynecology', 'DIY890123', '2016-10-08', 'Master', 'Universitas Airlangga', '2011', 'Spesialis Kandungan', 'RS Pertiwi', 3, 4.7, 167),
('DOC009', 'Dr. Maya Sari', 'Sp.B', 'Cardiovascular Surgery', 'DIY901234', '2017-02-20', 'Master', 'Universitas Diponegoro', '2012', 'Spesialis Bedah Jantung', 'RSU Harapan Kita', 3, 4.9, 212),
('DOC010', 'Dr. Budi Santoso', 'Sp.PD', 'Internal Medicine', 'DIY012345', '2011-08-12', 'Master', 'Universitas Padjadjaran', '2006', 'Spesialis Penyakit Dalam', 'RSUD Dr. Soetomo', 2, 4.6, 134);
GO

-- Departments Table Additional Sample Data
INSERT INTO Departments (department_code, department_name, description, hospital_name, location, phone_number, fax_number, email, operating_hours, number_of_doctors, number_of_nurses, number_of_beds, is_active) VALUES
('DEP006', 'Cardiovascular Surgery', 'Pelayanan bedah jantung', 'RSU Harapan Kita', 'Lantai 5', '021-7890125', '021-7890126', 'cardio.surgery@harapankita.co.id', 'Senin-Jumat: 08:00-17:00', 6, 18, 30, 1),
('DEP007', 'Emergency Medicine', 'Pelayanan medis darurat', 'RSUD Dr. Soetomo', 'Lantai 1', '021-3456795', '021-3456796', 'emergency@rssoetomo.co.id', '24/7', 20, 60, 100, 1),
('DEP008', 'Radiology', 'Pelayanan radiologi', 'RSUD Dr. Soetomo', 'Lantai 2', '021-3456797', '021-3456798', 'radiology@rssoetomo.co.id', 'Senin-Jumat: 08:00-17:00', 8, 25, 15, 1),
('DEP009', 'Laboratory', 'Pelayanan laboratorium', 'RSUD Dr. Soetomo', 'Lantai 2', '021-3456799', '021-3456800', 'laboratory@rssoetomo.co.id', 'Senin-Jumat: 07:00-19:00', 12, 35, 20, 1),
('DEP010', 'Pharmacy', 'Pelayanan farmasi', 'RSUD Dr. Soetomo', 'Lantai 1', '021-3456801', '021-3456802', 'pharmacy@rssoetomo.co.id', 'Senin-Jumat: 08:00-17:00', 8, 20, 10, 1);
GO