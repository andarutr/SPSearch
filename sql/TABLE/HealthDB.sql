-- Health Database - 50 Tables with 3 Records Each
-- ROWID as PK, dex_row_id as unique identifier, full FK relationships

CREATE DATABASE HealthDB;
GO
USE HealthDB;
GO

-- ============================================================
-- TIER 0: No FK dependencies
-- ============================================================

-- TBL001 - Patients
CREATE TABLE Patients (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    patient_code VARCHAR(20) UNIQUE NOT NULL,
    full_name NVARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M', 'F', 'O')) NOT NULL,
    blood_type VARCHAR(5),
    phone_number VARCHAR(20),
    email VARCHAR(100),
    address NVARCHAR(200),
    city NVARCHAR(50),
    state VARCHAR(50),
    country NVARCHAR(50),
    emergency_contact_name NVARCHAR(100),
    emergency_contact_phone VARCHAR(20),
    marital_status VARCHAR(20),
    occupation NVARCHAR(50),
    insurance_provider NVARCHAR(100),
    is_active BIT DEFAULT 1,
    registration_date DATETIME DEFAULT GETDATE(),
    notes TEXT
);
GO

INSERT INTO Patients (dex_row_id, patient_code, full_name, date_of_birth, gender, blood_type, phone_number, email, address, city, state, country, emergency_contact_name, emergency_contact_phone, marital_status, occupation, insurance_provider) VALUES
('DEX001', 'PAT001', N'Budi Santoso', '1985-03-15', 'M', 'A+', '081234567890', 'budi@email.com', N'Jl. Merdeka No. 45', N'Jakarta', 'DKI Jakarta', 'Indonesia', N'Siti Santoso', '081298765432', 'Married', 'Software Engineer', 'BPJS'),
('DEX002', 'PAT002', N'Siti Aminah', '1990-07-22', 'F', 'O+', '081357986421', 'siti@email.com', N'Jl. Sudirman No. 123', N'Surabaya', 'East Java', 'Indonesia', N'Ahmad Aminah', '081387654321', 'Married', 'Teacher', 'Allianz'),
('DEX003', 'PAT003', N'Rahmat Hidayat', '1978-11-08', 'M', 'B-', '081456789123', 'rahmat@email.com', N'Jl. Gatot Subroto No. 78', N'Bandung', 'West Java', 'Indonesia', N'Dewi Hidayat', '081478956321', 'Divorced', 'Business Owner', 'Prudential');
GO

-- TBL002 - Doctors (FK to Departments added below)
CREATE TABLE Doctors (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    doctor_code VARCHAR(20) UNIQUE NOT NULL,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    specialty NVARCHAR(50) NOT NULL,
    medical_license_number VARCHAR(50) UNIQUE NOT NULL,
    department_rowid INT,
    phone_number VARCHAR(20),
    email VARCHAR(100),
    consultation_fee DECIMAL(10,2),
    rating DECIMAL(3,2) DEFAULT 0,
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO Doctors (dex_row_id, doctor_code, first_name, last_name, specialty, medical_license_number, department_rowid, phone_number, email, consultation_fee, rating) VALUES
('DEX004', 'DOC001', N'Dr. Andi', N'Wijaya', 'Internal Medicine', 'LIC123456', 1, '081111111111', 'andi.w@hospital.com', 150000, 4.8),
('DEX005', 'DOC002', N'Dr. Siti', N'Rahayu', 'Pediatrics', 'LIC234567', 2, '081111111112', 'siti.r@hospital.com', 120000, 4.9),
('DEX006', 'DOC003', N'Dr. Budi', N'Santoso', 'Cardiology', 'LIC345678', 3, '081111111113', 'budi.s@hospital.com', 200000, 4.7);
GO

-- TBL003 - Departments
CREATE TABLE Departments (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    department_code VARCHAR(20) UNIQUE NOT NULL,
    department_name NVARCHAR(50) NOT NULL,
    description NVARCHAR(200),
    location NVARCHAR(100),
    phone_number VARCHAR(20),
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO Departments (dex_row_id, department_code, department_name, description, location, phone_number) VALUES
('DEX007', 'DEP001', N'Internal Medicine', N'Pelayanan penyakit dalam', 'Floor 2', '021-3456789'),
('DEX008', 'DEP002', N'Pediatrics', N'Pelayanan kesehatan anak', 'Floor 3', '021-3456791'),
('DEX009', 'DEP003', N'Cardiology', N'Pelayanan kesehatan jantung', 'Floor 4', '021-7890123');
GO

-- FK: Doctors.department_rowid -> Departments.ROWID
ALTER TABLE Doctors ADD CONSTRAINT FK_Doctors_Departments FOREIGN KEY (department_rowid) REFERENCES Departments(ROWID);
GO

-- TBL004 - DrugCategories
CREATE TABLE DrugCategories (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    category_code VARCHAR(20) UNIQUE NOT NULL,
    category_name NVARCHAR(50) NOT NULL,
    description NVARCHAR(200)
);
GO

INSERT INTO DrugCategories (dex_row_id, category_code, category_name, description) VALUES
('DEX010', 'DRGCAT01', N'Antibiotics', N'Obat anti-infeksi bakteri'),
('DEX011', 'DRGCAT02', N'Antihypertensives', N'Obat penurun tekanan darah'),
('DEX012', 'DRGCAT03', N'Analgesics', N'Obat pereda nyeri');
GO

-- TBL005 - Suppliers
CREATE TABLE Suppliers (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    supplier_code VARCHAR(20) UNIQUE NOT NULL,
    supplier_name NVARCHAR(100) NOT NULL,
    contact_person NVARCHAR(100),
    phone_number VARCHAR(20),
    email VARCHAR(100),
    address NVARCHAR(200),
    is_active BIT DEFAULT 1
);
GO

INSERT INTO Suppliers (dex_row_id, supplier_code, supplier_name, contact_person, phone_number, email, address) VALUES
('DEX013', 'SUP001', N'PT Medika Farma', N'Bambang Susilo', '021-5550001', 'bambang@medikafarma.co.id', N'Jl. Industri No. 10, Jakarta'),
('DEX014', 'SUP002', N'CV Sehat Sentosa', N'Ratna Dewi', '021-5550002', 'ratna@sehatsentosa.co.id', N'Jl. Raya No. 25, Bandung'),
('DEX015', 'SUP003', N'PT Farmasi Nusantara', N'Hendra Gunawan', '021-5550003', 'hendra@farmasinusantara.co.id', N'Jl. Gatot Subroto No. 88, Jakarta');
GO

-- TBL006 - LabTestTypes
CREATE TABLE LabTestTypes (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    test_code VARCHAR(20) UNIQUE NOT NULL,
    test_name NVARCHAR(100) NOT NULL,
    unit VARCHAR(20),
    normal_range_min DECIMAL(18,4),
    normal_range_max DECIMAL(18,4)
);
GO

INSERT INTO LabTestTypes (dex_row_id, test_code, test_name, unit, normal_range_min, normal_range_max) VALUES
('DEX016', 'LABT01', 'Hemoglobin', 'g/dL', 13.5, 17.5),
('DEX017', 'LABT02', 'White Blood Cell Count', 'x10^3/uL', 4.5, 11.0),
('DEX018', 'LABT03', 'Blood Glucose', 'mg/dL', 70, 110);
GO

-- TBL007 - ImagingTypes
CREATE TABLE ImagingTypes (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    imaging_code VARCHAR(20) UNIQUE NOT NULL,
    type_name NVARCHAR(50) NOT NULL,
    description NVARCHAR(200)
);
GO

INSERT INTO ImagingTypes (dex_row_id, imaging_code, type_name, description) VALUES
('DEX019', 'IMG01', 'X-Ray', N'Pemeriksaan radiologi sinar-X'),
('DEX020', 'IMG02', 'MRI', 'Magnetic Resonance Imaging'),
('DEX021', 'IMG03', 'CT Scan', 'Computed Tomography Scan');
GO

-- TBL008 - SurgeryTypes
CREATE TABLE SurgeryTypes (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    surgery_code VARCHAR(20) UNIQUE NOT NULL,
    type_name NVARCHAR(100) NOT NULL,
    description NVARCHAR(200),
    duration_minutes INT
);
GO

INSERT INTO SurgeryTypes (dex_row_id, surgery_code, type_name, description, duration_minutes) VALUES
('DEX022', 'SRG01', N'Appendectomy', N'Pengangkatan usus buntu', 60),
('DEX023', 'SRG02', N'Cholecystectomy', N'Pengangkatan kantung empedu', 90),
('DEX024', 'SRG03', N'Cataract Surgery', N'Operasi katarak mata', 45);
GO

-- TBL009 - OperatingRooms
CREATE TABLE OperatingRooms (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    room_code VARCHAR(20) UNIQUE NOT NULL,
    room_name NVARCHAR(50) NOT NULL,
    floor_number INT,
    equipment_level VARCHAR(50),
    is_active BIT DEFAULT 1
);
GO

INSERT INTO OperatingRooms (dex_row_id, room_code, room_name, floor_number, equipment_level) VALUES
('DEX025', 'OR001', 'Operating Room 1', 5, 'Standard'),
('DEX026', 'OR002', 'Operating Room 2', 5, 'Advanced'),
('DEX027', 'OR003', 'Operating Room 3', 6, 'Sterile');
GO

-- TBL010 - Wards
CREATE TABLE Wards (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    ward_code VARCHAR(20) UNIQUE NOT NULL,
    ward_name NVARCHAR(50) NOT NULL,
    floor_number INT,
    ward_type VARCHAR(50),
    total_beds INT,
    is_active BIT DEFAULT 1
);
GO

INSERT INTO Wards (dex_row_id, ward_code, ward_name, floor_number, ward_type, total_beds) VALUES
('DEX028', 'WRD01', N'General Ward A', 3, 'General', 40),
('DEX029', 'WRD02', N'Pediatric Ward', 4, 'Pediatric', 30),
('DEX030', 'WRD03', N'Intensive Care Unit', 2, 'ICU', 15);
GO

-- TBL011 - RoomTypes
CREATE TABLE RoomTypes (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    room_type_code VARCHAR(20) UNIQUE NOT NULL,
    type_name NVARCHAR(50) NOT NULL,
    rate_per_day DECIMAL(10,2),
    description NVARCHAR(200)
);
GO

INSERT INTO RoomTypes (dex_row_id, room_type_code, type_name, rate_per_day, description) VALUES
('DEX031', 'RT01', 'VIP', 1500000, N'Kelas VIP with AC, TV, private bathroom'),
('DEX032', 'RT02', 'Class 1', 750000, N'Kelas 1 with AC, shared bathroom'),
('DEX033', 'RT03', 'Class 2', 350000, N'Kelas 2 standard');
GO

-- TBL012 - AppointmentTypes
CREATE TABLE AppointmentTypes (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    appt_type_code VARCHAR(20) UNIQUE NOT NULL,
    type_name NVARCHAR(50) NOT NULL,
    duration_minutes INT
);
GO

INSERT INTO AppointmentTypes (dex_row_id, appt_type_code, type_name, duration_minutes) VALUES
('DEX034', 'AT01', N'General Checkup', 30),
('DEX035', 'AT02', N'Specialist Consultation', 45),
('DEX036', 'AT03', N'Follow-up Visit', 15);
GO

-- TBL013 - AppointmentStatuses
CREATE TABLE AppointmentStatuses (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    status_code VARCHAR(20) UNIQUE NOT NULL,
    status_name NVARCHAR(50) NOT NULL
);
GO

INSERT INTO AppointmentStatuses (dex_row_id, status_code, status_name) VALUES
('DEX037', 'STAT01', 'Scheduled'),
('DEX038', 'STAT02', 'Completed'),
('DEX039', 'STAT03', 'Cancelled');
GO

-- TBL014 - StaffRoles
CREATE TABLE StaffRoles (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    role_code VARCHAR(20) UNIQUE NOT NULL,
    role_name NVARCHAR(50) NOT NULL,
    description NVARCHAR(200)
);
GO

INSERT INTO StaffRoles (dex_row_id, role_code, role_name, description) VALUES
('DEX040', 'ROLE01', N'Nurse', N'Perawat pelaksana'),
('DEX041', 'ROLE02', N'Lab Technician', N'Teknisi laboratorium'),
('DEX042', 'ROLE03', N'Administrator', N'Staf administrasi');
GO

-- TBL015 - PaymentMethods
CREATE TABLE PaymentMethods (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    method_code VARCHAR(20) UNIQUE NOT NULL,
    method_name NVARCHAR(50) NOT NULL
);
GO

INSERT INTO PaymentMethods (dex_row_id, method_code, method_name) VALUES
('DEX043', 'PAY01', 'Cash'),
('DEX044', 'PAY02', 'Credit Card'),
('DEX045', 'PAY03', 'Bank Transfer');
GO

-- TBL016 - BillingItemCategories
CREATE TABLE BillingItemCategories (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    category_code VARCHAR(20) UNIQUE NOT NULL,
    category_name NVARCHAR(50) NOT NULL
);
GO

INSERT INTO BillingItemCategories (dex_row_id, category_code, category_name) VALUES
('DEX046', 'BIC01', 'Consultation Fee'),
('DEX047', 'BIC02', 'Lab Test'),
('DEX048', 'BIC03', 'Medication');
GO

-- TBL017 - ShiftTypes
CREATE TABLE ShiftTypes (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    shift_code VARCHAR(20) UNIQUE NOT NULL,
    shift_name NVARCHAR(50) NOT NULL,
    start_time TIME,
    end_time TIME
);
GO

INSERT INTO ShiftTypes (dex_row_id, shift_code, shift_name, start_time, end_time) VALUES
('DEX049', 'SHFT01', 'Morning Shift', '07:00', '15:00'),
('DEX050', 'SHFT02', 'Afternoon Shift', '15:00', '23:00'),
('DEX051', 'SHFT03', 'Night Shift', '23:00', '07:00');
GO

-- TBL018 - BloodTypes
CREATE TABLE BloodTypes (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    blood_type_code VARCHAR(10) UNIQUE NOT NULL,
    blood_type_name NVARCHAR(50),
    rh_factor VARCHAR(10)
);
GO

INSERT INTO BloodTypes (dex_row_id, blood_type_code, blood_type_name, rh_factor) VALUES
('DEX052', 'BT01', 'A Positive', 'Positive'),
('DEX053', 'BT02', 'O Positive', 'Positive'),
('DEX054', 'BT03', 'B Negative', 'Negative');
GO

-- ============================================================
-- TIER 1: Depends on Tier 0
-- ============================================================

-- TBL019 - Rooms (FK: Wards, RoomTypes)
CREATE TABLE Rooms (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    room_code VARCHAR(20) UNIQUE NOT NULL,
    room_name NVARCHAR(50) NOT NULL,
    ward_rowid INT NOT NULL,
    room_type_rowid INT NOT NULL,
    capacity INT DEFAULT 1,
    is_occupied BIT DEFAULT 0,
    is_active BIT DEFAULT 1
);
GO

INSERT INTO Rooms (dex_row_id, room_code, room_name, ward_rowid, room_type_rowid, capacity) VALUES
('DEX055', 'RM001', 'VIP-A1', 1, 1, 1),
('DEX056', 'RM002', 'Class1-B2', 1, 2, 2),
('DEX057', 'RM003', 'ICU-C1', 3, 2, 1);
GO

ALTER TABLE Rooms ADD CONSTRAINT FK_Rooms_Wards FOREIGN KEY (ward_rowid) REFERENCES Wards(ROWID);
ALTER TABLE Rooms ADD CONSTRAINT FK_Rooms_RoomTypes FOREIGN KEY (room_type_rowid) REFERENCES RoomTypes(ROWID);
GO

-- TBL020 - Beds (FK: Rooms)
CREATE TABLE Beds (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    bed_code VARCHAR(20) UNIQUE NOT NULL,
    bed_number VARCHAR(10) NOT NULL,
    room_rowid INT NOT NULL,
    is_occupied BIT DEFAULT 0,
    is_active BIT DEFAULT 1
);
GO

INSERT INTO Beds (dex_row_id, bed_code, bed_number, room_rowid) VALUES
('DEX058', 'BED001', 'A1-1', 1),
('DEX059', 'BED002', 'B2-1', 2),
('DEX060', 'BED003', 'C1-1', 3);
GO

ALTER TABLE Beds ADD CONSTRAINT FK_Beds_Rooms FOREIGN KEY (room_rowid) REFERENCES Rooms(ROWID);
GO

-- TBL021 - Staff (FK: Departments, StaffRoles)
CREATE TABLE Staff (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    staff_code VARCHAR(20) UNIQUE NOT NULL,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    department_rowid INT NOT NULL,
    role_rowid INT NOT NULL,
    phone_number VARCHAR(20),
    email VARCHAR(100),
    hire_date DATE,
    is_active BIT DEFAULT 1
);
GO

INSERT INTO Staff (dex_row_id, staff_code, first_name, last_name, department_rowid, role_rowid, phone_number, email, hire_date) VALUES
('DEX061', 'STF001', N'Susi', N'Rahmawati', 1, 1, '082111111111', 'susi.r@hospital.com', '2020-01-15'),
('DEX062', 'STF002', N'Agus', N'Prasetyo', 2, 2, '082111111112', 'agus.p@hospital.com', '2019-06-01'),
('DEX063', 'STF003', N'Dewi', N'Kusuma', 1, 3, '082111111113', 'dewi.k@hospital.com', '2021-03-20');
GO

ALTER TABLE Staff ADD CONSTRAINT FK_Staff_Departments FOREIGN KEY (department_rowid) REFERENCES Departments(ROWID);
ALTER TABLE Staff ADD CONSTRAINT FK_Staff_Roles FOREIGN KEY (role_rowid) REFERENCES StaffRoles(ROWID);
GO

-- TBL022 - Medications (FK: DrugCategories, Suppliers)
CREATE TABLE Medications (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    medication_code VARCHAR(20) UNIQUE NOT NULL,
    medication_name NVARCHAR(100) NOT NULL,
    category_rowid INT NOT NULL,
    supplier_rowid INT NOT NULL,
    unit_price DECIMAL(10,2),
    stock_quantity INT DEFAULT 0,
    requires_prescription BIT DEFAULT 1,
    is_active BIT DEFAULT 1
);
GO

INSERT INTO Medications (dex_row_id, medication_code, medication_name, category_rowid, supplier_rowid, unit_price, stock_quantity) VALUES
('DEX064', 'MED001', 'Amoxicillin 500mg', 1, 1, 15000, 500),
('DEX065', 'MED002', 'Amlodipine 5mg', 2, 2, 12000, 300),
('DEX066', 'MED003', 'Paracetamol 500mg', 3, 3, 5000, 1000);
GO

ALTER TABLE Medications ADD CONSTRAINT FK_Medications_Categories FOREIGN KEY (category_rowid) REFERENCES DrugCategories(ROWID);
ALTER TABLE Medications ADD CONSTRAINT FK_Medications_Suppliers FOREIGN KEY (supplier_rowid) REFERENCES Suppliers(ROWID);
GO

-- TBL023 - LabTests (FK: Patients, Doctors, LabTestTypes)
CREATE TABLE LabTests (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    lab_test_code VARCHAR(20) UNIQUE NOT NULL,
    patient_rowid INT NOT NULL,
    doctor_rowid INT NOT NULL,
    test_type_rowid INT NOT NULL,
    test_date DATETIME DEFAULT GETDATE(),
    result_value DECIMAL(18,4),
    result_unit VARCHAR(20),
    notes NVARCHAR(500)
);
GO

INSERT INTO LabTests (dex_row_id, lab_test_code, patient_rowid, doctor_rowid, test_type_rowid, test_date, result_value) VALUES
('DEX067', 'LAB001', 1, 1, 1, '2024-06-15', 14.5),
('DEX068', 'LAB002', 2, 2, 2, '2024-06-16', 7.2),
('DEX069', 'LAB003', 3, 3, 3, '2024-06-17', 95.0);
GO

ALTER TABLE LabTests ADD CONSTRAINT FK_LabTests_Patients FOREIGN KEY (patient_rowid) REFERENCES Patients(ROWID);
ALTER TABLE LabTests ADD CONSTRAINT FK_LabTests_Doctors FOREIGN KEY (doctor_rowid) REFERENCES Doctors(ROWID);
ALTER TABLE LabTests ADD CONSTRAINT FK_LabTests_TestTypes FOREIGN KEY (test_type_rowid) REFERENCES LabTestTypes(ROWID);
GO

-- ============================================================
-- TIER 2: Depends on Tier 0-1
-- ============================================================

-- TBL024 - PatientAllergies (FK: Patients, DrugCategories)
CREATE TABLE PatientAllergies (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    patient_rowid INT NOT NULL,
    category_rowid INT,
    allergy_name NVARCHAR(100) NOT NULL,
    severity VARCHAR(20) CHECK (severity IN ('Mild', 'Moderate', 'Severe')),
    notes NVARCHAR(500)
);
GO

INSERT INTO PatientAllergies (dex_row_id, patient_rowid, category_rowid, allergy_name, severity, notes) VALUES
('DEX070', 1, 1, 'Penicillin', 'Moderate', N'Ruam dan demam ringan'),
('DEX071', 2, 3, 'Aspirin', 'Mild', N'Sakit perut ringan'),
('DEX072', 3, 1, 'Sulfa', 'Severe', N'Sesak napas, harus dihindari');
GO

ALTER TABLE PatientAllergies ADD CONSTRAINT FK_Allergies_Patients FOREIGN KEY (patient_rowid) REFERENCES Patients(ROWID);
ALTER TABLE PatientAllergies ADD CONSTRAINT FK_Allergies_Categories FOREIGN KEY (category_rowid) REFERENCES DrugCategories(ROWID);
GO

-- TBL025 - VitalSigns (FK: Patients)
CREATE TABLE VitalSigns (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    patient_rowid INT NOT NULL,
    blood_pressure_systolic INT,
    blood_pressure_diastolic INT,
    heart_rate INT,
    temperature DECIMAL(4,1),
    respiratory_rate INT,
    oxygen_saturation INT,
    recorded_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO VitalSigns (dex_row_id, patient_rowid, blood_pressure_systolic, blood_pressure_diastolic, heart_rate, temperature, respiratory_rate, oxygen_saturation) VALUES
('DEX073', 1, 120, 80, 72, 36.5, 16, 98),
('DEX074', 2, 110, 70, 80, 36.8, 18, 99),
('DEX075', 3, 140, 90, 88, 37.0, 20, 97);
GO

ALTER TABLE VitalSigns ADD CONSTRAINT FK_VitalSigns_Patients FOREIGN KEY (patient_rowid) REFERENCES Patients(ROWID);
GO

-- TBL026 - InsurancePolicies (FK: Patients)
CREATE TABLE InsurancePolicies (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    policy_number VARCHAR(50) UNIQUE NOT NULL,
    patient_rowid INT NOT NULL,
    provider_name NVARCHAR(100) NOT NULL,
    coverage_type VARCHAR(50),
    start_date DATE,
    end_date DATE,
    is_active BIT DEFAULT 1
);
GO

INSERT INTO InsurancePolicies (dex_row_id, policy_number, patient_rowid, provider_name, coverage_type, start_date, end_date) VALUES
('DEX076', 'POL001', 1, 'BPJS', 'Full Coverage', '2024-01-01', '2024-12-31'),
('DEX077', 'POL002', 2, 'Allianz', 'Inpatient Only', '2024-03-01', '2025-02-28'),
('DEX078', 'POL003', 3, 'Prudential', 'Outpatient Only', '2024-06-01', '2025-05-31');
GO

ALTER TABLE InsurancePolicies ADD CONSTRAINT FK_Policies_Patients FOREIGN KEY (patient_rowid) REFERENCES Patients(ROWID);
GO

-- TBL027 - LabResults (FK: LabTests)
CREATE TABLE LabResults (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    lab_test_rowid INT NOT NULL,
    result_text NVARCHAR(500),
    is_abnormal BIT DEFAULT 0,
    verified_by_doctor_rowid INT,
    result_date DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO LabResults (dex_row_id, lab_test_rowid, result_text, is_abnormal, result_date) VALUES
('DEX079', 1, 'Hemoglobin 14.5 g/dL - Normal', 0, '2024-06-15'),
('DEX080', 2, 'WBC 7.2 x10^3/uL - Normal', 0, '2024-06-16'),
('DEX081', 3, 'Blood Glucose 95 mg/dL - Normal', 0, '2024-06-17');
GO

ALTER TABLE LabResults ADD CONSTRAINT FK_LabResults_LabTests FOREIGN KEY (lab_test_rowid) REFERENCES LabTests(ROWID);
GO

-- TBL028 - LabNormalRanges (FK: LabTestTypes)
CREATE TABLE LabNormalRanges (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    test_type_rowid INT NOT NULL,
    gender VARCHAR(10),
    age_min_years INT,
    age_max_years INT,
    range_min DECIMAL(18,4),
    range_max DECIMAL(18,4)
);
GO

INSERT INTO LabNormalRanges (dex_row_id, test_type_rowid, gender, age_min_years, age_max_years, range_min, range_max) VALUES
('DEX082', 1, 'Male', 18, 60, 13.5, 17.5),
('DEX083', 1, 'Female', 18, 60, 12.0, 16.0),
('DEX084', 2, NULL, 0, 99, 4.5, 11.0);
GO

ALTER TABLE LabNormalRanges ADD CONSTRAINT FK_Ranges_TestTypes FOREIGN KEY (test_type_rowid) REFERENCES LabTestTypes(ROWID);
GO

-- TBL029 - StaffCertifications (FK: Staff)
CREATE TABLE StaffCertifications (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    staff_rowid INT NOT NULL,
    certification_name NVARCHAR(100) NOT NULL,
    issuing_authority NVARCHAR(100),
    issue_date DATE,
    expiry_date DATE
);
GO

INSERT INTO StaffCertifications (dex_row_id, staff_rowid, certification_name, issuing_authority, issue_date, expiry_date) VALUES
('DEX085', 1, 'Basic Life Support', 'American Heart Association', '2023-01-15', '2025-01-15'),
('DEX086', 1, 'Advanced Cardiac Life Support', 'American Heart Association', '2023-06-20', '2025-06-20'),
('DEX087', 2, 'Clinical Lab Scientist License', 'Ministry of Health', '2022-03-10', '2027-03-10');
GO

ALTER TABLE StaffCertifications ADD CONSTRAINT FK_Certifications_Staff FOREIGN KEY (staff_rowid) REFERENCES Staff(ROWID);
GO

-- TBL030 - StaffSchedules (FK: Staff, ShiftTypes)
CREATE TABLE StaffSchedules (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    staff_rowid INT NOT NULL,
    shift_date DATE NOT NULL,
    shift_type_rowid INT NOT NULL,
    notes NVARCHAR(200)
);
GO

INSERT INTO StaffSchedules (dex_row_id, staff_rowid, shift_date, shift_type_rowid, notes) VALUES
('DEX088', 1, '2024-07-01', 1, 'Floor 2 - Internal Medicine'),
('DEX089', 2, '2024-07-01', 2, 'Lab duty'),
('DEX090', 3, '2024-07-01', 1, 'Administration desk');
GO

ALTER TABLE StaffSchedules ADD CONSTRAINT FK_Schedules_Staff FOREIGN KEY (staff_rowid) REFERENCES Staff(ROWID);
ALTER TABLE StaffSchedules ADD CONSTRAINT FK_Schedules_ShiftTypes FOREIGN KEY (shift_type_rowid) REFERENCES ShiftTypes(ROWID);
GO

-- TBL031 - Appointments (FK: Patients, Doctors, AppointmentTypes, AppointmentStatuses)
CREATE TABLE Appointments (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    appointment_code VARCHAR(20) UNIQUE NOT NULL,
    patient_rowid INT NOT NULL,
    doctor_rowid INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    appointment_type_rowid INT NOT NULL,
    status_rowid INT NOT NULL,
    notes NVARCHAR(500)
);
GO

INSERT INTO Appointments (dex_row_id, appointment_code, patient_rowid, doctor_rowid, appointment_date, appointment_type_rowid, status_rowid) VALUES
('DEX091', 'APT001', 1, 1, '2024-07-05 09:00', 1, 1),
('DEX092', 'APT002', 2, 2, '2024-07-05 10:00', 2, 1),
('DEX093', 'APT003', 3, 3, '2024-07-06 11:00', 3, 2);
GO

ALTER TABLE Appointments ADD CONSTRAINT FK_Appointments_Patients FOREIGN KEY (patient_rowid) REFERENCES Patients(ROWID);
ALTER TABLE Appointments ADD CONSTRAINT FK_Appointments_Doctors FOREIGN KEY (doctor_rowid) REFERENCES Doctors(ROWID);
ALTER TABLE Appointments ADD CONSTRAINT FK_Appointments_Types FOREIGN KEY (appointment_type_rowid) REFERENCES AppointmentTypes(ROWID);
ALTER TABLE Appointments ADD CONSTRAINT FK_Appointments_Statuses FOREIGN KEY (status_rowid) REFERENCES AppointmentStatuses(ROWID);
GO

-- ============================================================
-- TIER 3: Depends on Tier 2
-- ============================================================

-- TBL032 - Admissions (FK: Patients, Doctors, Wards, Beds)
CREATE TABLE Admissions (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    admission_code VARCHAR(20) UNIQUE NOT NULL,
    patient_rowid INT NOT NULL,
    doctor_rowid INT NOT NULL,
    ward_rowid INT NOT NULL,
    bed_rowid INT,
    admission_date DATETIME NOT NULL,
    diagnosis NVARCHAR(500),
    is_emergency BIT DEFAULT 0
);
GO

INSERT INTO Admissions (dex_row_id, admission_code, patient_rowid, doctor_rowid, ward_rowid, bed_rowid, admission_date, diagnosis, is_emergency) VALUES
('DEX094', 'ADM001', 1, 1, 1, 1, '2024-06-14 14:30', N'Hipertensi stage 2', 0),
('DEX095', 'ADM002', 2, 2, 2, 2, '2024-06-15 09:00', N'Demam tinggi', 0),
('DEX096', 'ADM003', 3, 3, 3, 3, '2024-06-16 22:15', N'Sesak napas akut', 1);
GO

ALTER TABLE Admissions ADD CONSTRAINT FK_Admissions_Patients FOREIGN KEY (patient_rowid) REFERENCES Patients(ROWID);
ALTER TABLE Admissions ADD CONSTRAINT FK_Admissions_Doctors FOREIGN KEY (doctor_rowid) REFERENCES Doctors(ROWID);
ALTER TABLE Admissions ADD CONSTRAINT FK_Admissions_Wards FOREIGN KEY (ward_rowid) REFERENCES Wards(ROWID);
ALTER TABLE Admissions ADD CONSTRAINT FK_Admissions_Beds FOREIGN KEY (bed_rowid) REFERENCES Beds(ROWID);
GO

-- TBL033 - Prescriptions (FK: Patients, Doctors, Medications)
CREATE TABLE Prescriptions (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    prescription_code VARCHAR(20) UNIQUE NOT NULL,
    patient_rowid INT NOT NULL,
    doctor_rowid INT NOT NULL,
    medication_rowid INT NOT NULL,
    dosage NVARCHAR(100) NOT NULL,
    frequency NVARCHAR(100),
    duration_days INT,
    prescribed_date DATETIME DEFAULT GETDATE(),
    notes NVARCHAR(500)
);
GO

INSERT INTO Prescriptions (dex_row_id, prescription_code, patient_rowid, doctor_rowid, medication_rowid, dosage, frequency, duration_days, prescribed_date) VALUES
('DEX097', 'PRS001', 1, 1, 2, '5 mg', 'Once daily', 30, '2024-06-15'),
('DEX098', 'PRS002', 2, 2, 1, '500 mg', 'Three times daily', 7, '2024-06-16'),
('DEX099', 'PRS003', 3, 3, 3, '500 mg', 'As needed', 5, '2024-06-17');
GO

ALTER TABLE Prescriptions ADD CONSTRAINT FK_Prescriptions_Patients FOREIGN KEY (patient_rowid) REFERENCES Patients(ROWID);
ALTER TABLE Prescriptions ADD CONSTRAINT FK_Prescriptions_Doctors FOREIGN KEY (doctor_rowid) REFERENCES Doctors(ROWID);
ALTER TABLE Prescriptions ADD CONSTRAINT FK_Prescriptions_Medications FOREIGN KEY (medication_rowid) REFERENCES Medications(ROWID);
GO

-- TBL034 - SurgeryRecords (FK: Patients, Doctors, SurgeryTypes, OperatingRooms)
CREATE TABLE SurgeryRecords (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    surgery_code VARCHAR(20) UNIQUE NOT NULL,
    patient_rowid INT NOT NULL,
    doctor_rowid INT NOT NULL,
    surgery_type_rowid INT NOT NULL,
    operating_room_rowid INT NOT NULL,
    scheduled_date DATETIME,
    actual_start_time DATETIME,
    actual_end_time DATETIME,
    status VARCHAR(20) DEFAULT 'Scheduled',
    notes NVARCHAR(500)
);
GO

INSERT INTO SurgeryRecords (dex_row_id, surgery_code, patient_rowid, doctor_rowid, surgery_type_rowid, operating_room_rowid, scheduled_date, status) VALUES
('DEX100', 'SREC001', 1, 1, 1, 1, '2024-07-10 08:00', 'Scheduled'),
('DEX101', 'SREC002', 2, 2, 2, 2, '2024-07-11 09:00', 'Scheduled'),
('DEX102', 'SREC003', 3, 3, 3, 3, '2024-07-12 10:00', 'Completed');
GO

ALTER TABLE SurgeryRecords ADD CONSTRAINT FK_Surgery_Patients FOREIGN KEY (patient_rowid) REFERENCES Patients(ROWID);
ALTER TABLE SurgeryRecords ADD CONSTRAINT FK_Surgery_Doctors FOREIGN KEY (doctor_rowid) REFERENCES Doctors(ROWID);
ALTER TABLE SurgeryRecords ADD CONSTRAINT FK_Surgery_Types FOREIGN KEY (surgery_type_rowid) REFERENCES SurgeryTypes(ROWID);
ALTER TABLE SurgeryRecords ADD CONSTRAINT FK_Surgery_Rooms FOREIGN KEY (operating_room_rowid) REFERENCES OperatingRooms(ROWID);
GO

-- TBL035 - ImagingStudies (FK: Patients, Doctors, ImagingTypes)
CREATE TABLE ImagingStudies (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    study_code VARCHAR(20) UNIQUE NOT NULL,
    patient_rowid INT NOT NULL,
    doctor_rowid INT NOT NULL,
    imaging_type_rowid INT NOT NULL,
    study_date DATETIME DEFAULT GETDATE(),
    body_part NVARCHAR(100),
    status VARCHAR(20) DEFAULT 'Pending'
);
GO

INSERT INTO ImagingStudies (dex_row_id, study_code, patient_rowid, doctor_rowid, imaging_type_rowid, body_part, status) VALUES
('DEX103', 'IMGST01', 1, 1, 1, 'Chest', 'Completed'),
('DEX104', 'IMGST02', 2, 2, 2, 'Brain', 'Completed'),
('DEX105', 'IMGST03', 3, 3, 3, 'Abdomen', 'Pending');
GO

ALTER TABLE ImagingStudies ADD CONSTRAINT FK_Studies_Patients FOREIGN KEY (patient_rowid) REFERENCES Patients(ROWID);
ALTER TABLE ImagingStudies ADD CONSTRAINT FK_Studies_Doctors FOREIGN KEY (doctor_rowid) REFERENCES Doctors(ROWID);
ALTER TABLE ImagingStudies ADD CONSTRAINT FK_Studies_Types FOREIGN KEY (imaging_type_rowid) REFERENCES ImagingTypes(ROWID);
GO

-- TBL036 - ImagingResults (FK: ImagingStudies)
CREATE TABLE ImagingResults (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    imaging_study_rowid INT NOT NULL,
    result_text NVARCHAR(MAX),
    impression NVARCHAR(MAX),
    radiologist_notes NVARCHAR(MAX),
    result_date DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO ImagingResults (dex_row_id, imaging_study_rowid, result_text, impression, result_date) VALUES
('DEX106', 1, N'Chest X-ray shows clear lung fields', N'Normal chest X-ray', '2024-06-15'),
('DEX107', 2, N'Brain MRI shows no acute abnormality', N'Normal MRI brain', '2024-06-16'),
('DEX108', 3, N'CT abdomen pending review', N'Awaiting final interpretation', '2024-06-17');
GO

ALTER TABLE ImagingResults ADD CONSTRAINT FK_Results_Studies FOREIGN KEY (imaging_study_rowid) REFERENCES ImagingStudies(ROWID);
GO

-- TBL037 - Invoices (FK: Patients, Appointments)
CREATE TABLE Invoices (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    invoice_number VARCHAR(50) UNIQUE NOT NULL,
    patient_rowid INT NOT NULL,
    appointment_rowid INT,
    total_amount DECIMAL(12,2) NOT NULL,
    tax_amount DECIMAL(12,2) DEFAULT 0,
    discount_amount DECIMAL(12,2) DEFAULT 0,
    status VARCHAR(20) DEFAULT 'Unpaid',
    invoice_date DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO Invoices (dex_row_id, invoice_number, patient_rowid, appointment_rowid, total_amount, tax_amount, status) VALUES
('DEX109', 'INV001', 1, 1, 350000, 35000, 'Paid'),
('DEX110', 'INV002', 2, 2, 500000, 50000, 'Unpaid'),
('DEX111', 'INV003', 3, 3, 150000, 15000, 'Unpaid');
GO

ALTER TABLE Invoices ADD CONSTRAINT FK_Invoices_Patients FOREIGN KEY (patient_rowid) REFERENCES Patients(ROWID);
ALTER TABLE Invoices ADD CONSTRAINT FK_Invoices_Appointments FOREIGN KEY (appointment_rowid) REFERENCES Appointments(ROWID);
GO

-- TBL038 - InsuranceClaims (FK: Invoices, InsurancePolicies)
CREATE TABLE InsuranceClaims (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    claim_number VARCHAR(50) UNIQUE NOT NULL,
    invoice_rowid INT NOT NULL,
    policy_rowid INT NOT NULL,
    claim_amount DECIMAL(12,2) NOT NULL,
    approved_amount DECIMAL(12,2),
    status VARCHAR(20) DEFAULT 'Submitted',
    claim_date DATETIME DEFAULT GETDATE(),
    approved_date DATETIME
);
GO

INSERT INTO InsuranceClaims (dex_row_id, claim_number, invoice_rowid, policy_rowid, claim_amount, status) VALUES
('DEX112', 'CLM001', 1, 1, 350000, 'Approved'),
('DEX113', 'CLM002', 2, 2, 500000, 'Submitted'),
('DEX114', 'CLM003', 3, 3, 150000, 'Pending');
GO

ALTER TABLE InsuranceClaims ADD CONSTRAINT FK_Claims_Invoices FOREIGN KEY (invoice_rowid) REFERENCES Invoices(ROWID);
ALTER TABLE InsuranceClaims ADD CONSTRAINT FK_Claims_Policies FOREIGN KEY (policy_rowid) REFERENCES InsurancePolicies(ROWID);
GO

-- TBL039 - Payments (FK: Invoices, PaymentMethods)
CREATE TABLE Payments (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    payment_code VARCHAR(20) UNIQUE NOT NULL,
    invoice_rowid INT NOT NULL,
    payment_method_rowid INT NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    payment_date DATETIME DEFAULT GETDATE(),
    reference_number VARCHAR(100)
);
GO

INSERT INTO Payments (dex_row_id, payment_code, invoice_rowid, payment_method_rowid, amount, reference_number) VALUES
('DEX115', 'PAY001', 1, 2, 385000, 'CC-20240615-001'),
('DEX116', 'PAY002', 2, 1, 550000, 'Cash-001'),
('DEX117', 'PAY003', 3, 3, 165000, 'TRF-20240617-001');
GO

ALTER TABLE Payments ADD CONSTRAINT FK_Payments_Invoices FOREIGN KEY (invoice_rowid) REFERENCES Invoices(ROWID);
ALTER TABLE Payments ADD CONSTRAINT FK_Payments_Methods FOREIGN KEY (payment_method_rowid) REFERENCES PaymentMethods(ROWID);
GO

-- ============================================================
-- TIER 4: Depends on Tier 3
-- ============================================================

-- TBL040 - Discharges (FK: Admissions, Doctors)
CREATE TABLE Discharges (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    discharge_code VARCHAR(20) UNIQUE NOT NULL,
    admission_rowid INT NOT NULL,
    doctor_rowid INT NOT NULL,
    discharge_date DATETIME DEFAULT GETDATE(),
    discharge_type VARCHAR(50),
    summary NVARCHAR(MAX)
);
GO

INSERT INTO Discharges (dex_row_id, discharge_code, admission_rowid, doctor_rowid, discharge_type, summary) VALUES
('DEX118', 'DCH001', 1, 1, 'Home', N'Pasien membaik, dipulangkan'),
('DEX119', 'DCH002', 2, 2, 'Home', N'Demam turun, dipulangkan'),
('DEX120', 'DCH003', 3, 3, 'Transfer', N'Dirujuk ke ICU');
GO

ALTER TABLE Discharges ADD CONSTRAINT FK_Discharges_Admissions FOREIGN KEY (admission_rowid) REFERENCES Admissions(ROWID);
ALTER TABLE Discharges ADD CONSTRAINT FK_Discharges_Doctors FOREIGN KEY (doctor_rowid) REFERENCES Doctors(ROWID);
GO

-- TBL041 - Transfers (FK: Admissions, Rooms)
CREATE TABLE Transfers (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    transfer_code VARCHAR(20) UNIQUE NOT NULL,
    admission_rowid INT NOT NULL,
    from_room_rowid INT NOT NULL,
    to_room_rowid INT NOT NULL,
    transfer_datetime DATETIME DEFAULT GETDATE(),
    reason NVARCHAR(500),
    transferred_by_rowid INT
);
GO

INSERT INTO Transfers (dex_row_id, transfer_code, admission_rowid, from_room_rowid, to_room_rowid, reason) VALUES
('DEX121', 'TRF001', 3, 1, 3, N'Membutuhkan perawatan intensif'),
('DEX122', 'TRF002', 1, 2, 1, N'Peningkatan kelas perawatan'),
('DEX123', 'TRF003', 2, 3, 2, N'Kondisi stabil, pindah ke rawat inap');
GO

ALTER TABLE Transfers ADD CONSTRAINT FK_Transfers_Admissions FOREIGN KEY (admission_rowid) REFERENCES Admissions(ROWID);
ALTER TABLE Transfers ADD CONSTRAINT FK_Transfers_FromRoom FOREIGN KEY (from_room_rowid) REFERENCES Rooms(ROWID);
ALTER TABLE Transfers ADD CONSTRAINT FK_Transfers_ToRoom FOREIGN KEY (to_room_rowid) REFERENCES Rooms(ROWID);
GO

-- TBL042 - FollowUps (FK: Appointments, Doctors)
CREATE TABLE FollowUps (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    followup_code VARCHAR(20) UNIQUE NOT NULL,
    appointment_rowid INT NOT NULL,
    doctor_rowid INT NOT NULL,
    followup_date DATE NOT NULL,
    instructions NVARCHAR(MAX),
    is_completed BIT DEFAULT 0
);
GO

INSERT INTO FollowUps (dex_row_id, followup_code, appointment_rowid, doctor_rowid, followup_date, instructions) VALUES
('DEX124', 'FLW001', 1, 1, '2024-07-19', N'Periksa tekanan darah kembali'),
('DEX125', 'FLW002', 2, 2, '2024-07-20', N'Evaluasi hasil lab lanjutan'),
('DEX126', 'FLW003', 3, 3, '2024-07-21', N'Pantau gula darah puasa');
GO

ALTER TABLE FollowUps ADD CONSTRAINT FK_FollowUps_Appointments FOREIGN KEY (appointment_rowid) REFERENCES Appointments(ROWID);
ALTER TABLE FollowUps ADD CONSTRAINT FK_FollowUps_Doctors FOREIGN KEY (doctor_rowid) REFERENCES Doctors(ROWID);
GO

-- TBL043 - Referrals (FK: Patients, Doctors, Departments)
CREATE TABLE Referrals (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    referral_code VARCHAR(20) UNIQUE NOT NULL,
    patient_rowid INT NOT NULL,
    referring_doctor_rowid INT NOT NULL,
    target_department_rowid INT NOT NULL,
    referral_date DATETIME DEFAULT GETDATE(),
    reason NVARCHAR(MAX),
    is_urgent BIT DEFAULT 0
);
GO

INSERT INTO Referrals (dex_row_id, referral_code, patient_rowid, referring_doctor_rowid, target_department_rowid, reason, is_urgent) VALUES
('DEX127', 'REF001', 1, 1, 3, N'Keluhan nyeri dada, perlu evaluasi kardiologi', 1),
('DEX128', 'REF002', 2, 2, 2, N'Batuk kronis, perlu evaluasi lebih lanjut', 0),
('DEX129', 'REF003', 3, 3, 1, N'Tekanan darah tidak terkontrol', 0);
GO

ALTER TABLE Referrals ADD CONSTRAINT FK_Referrals_Patients FOREIGN KEY (patient_rowid) REFERENCES Patients(ROWID);
ALTER TABLE Referrals ADD CONSTRAINT FK_Referrals_Doctors FOREIGN KEY (referring_doctor_rowid) REFERENCES Doctors(ROWID);
ALTER TABLE Referrals ADD CONSTRAINT FK_Referrals_Departments FOREIGN KEY (target_department_rowid) REFERENCES Departments(ROWID);
GO

-- TBL044 - Consultations (FK: Appointments, Doctors)
CREATE TABLE Consultations (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    consultation_code VARCHAR(20) UNIQUE NOT NULL,
    appointment_rowid INT NOT NULL,
    consulting_doctor_rowid INT NOT NULL,
    consultation_date DATETIME DEFAULT GETDATE(),
    findings NVARCHAR(MAX),
    recommendations NVARCHAR(MAX)
);
GO

INSERT INTO Consultations (dex_row_id, consultation_code, appointment_rowid, consulting_doctor_rowid, findings, recommendations) VALUES
('DEX130', 'CONS001', 1, 1, N'Tekanan darah 140/90, EKG normal', N'Lanjutkan amlodipine, kontrol 2 minggu'),
('DEX131', 'CONS002', 2, 2, N'Suhu 38.5C, faring hiperemis', N'Rawat jalan, antibiotik 5 hari'),
('DEX132', 'CONS003', 3, 3, N'GDS 95 mg/dL, dalam batas normal', N'Pola makan dijaga, kontrol 3 bulan');
GO

ALTER TABLE Consultations ADD CONSTRAINT FK_Consultations_Appointments FOREIGN KEY (appointment_rowid) REFERENCES Appointments(ROWID);
ALTER TABLE Consultations ADD CONSTRAINT FK_Consultations_Doctors FOREIGN KEY (consulting_doctor_rowid) REFERENCES Doctors(ROWID);
GO

-- TBL045 - WaitingList (FK: Patients, Doctors, AppointmentTypes)
CREATE TABLE WaitingList (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    patient_rowid INT NOT NULL,
    doctor_rowid INT NOT NULL,
    appointment_type_rowid INT NOT NULL,
    requested_date DATETIME NOT NULL,
    priority VARCHAR(20) DEFAULT 'Normal',
    status VARCHAR(20) DEFAULT 'Waiting',
    notes NVARCHAR(500)
);
GO

INSERT INTO WaitingList (dex_row_id, patient_rowid, doctor_rowid, appointment_type_rowid, requested_date, priority) VALUES
('DEX133', 1, 2, 2, '2024-07-01 08:00', 'High'),
('DEX134', 2, 3, 1, '2024-07-01 08:00', 'Normal'),
('DEX135', 3, 1, 3, '2024-07-02 08:00', 'Low');
GO

ALTER TABLE WaitingList ADD CONSTRAINT FK_Waiting_Patients FOREIGN KEY (patient_rowid) REFERENCES Patients(ROWID);
ALTER TABLE WaitingList ADD CONSTRAINT FK_Waiting_Doctors FOREIGN KEY (doctor_rowid) REFERENCES Doctors(ROWID);
ALTER TABLE WaitingList ADD CONSTRAINT FK_Waiting_Types FOREIGN KEY (appointment_type_rowid) REFERENCES AppointmentTypes(ROWID);
GO

-- TBL046 - Dispensations (FK: Prescriptions, Medications)
CREATE TABLE Dispensations (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    dispensation_code VARCHAR(20) UNIQUE NOT NULL,
    prescription_rowid INT NOT NULL,
    medication_rowid INT NOT NULL,
    quantity_dispensed INT NOT NULL,
    dispensed_by_rowid INT,
    dispensation_date DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO Dispensations (dex_row_id, dispensation_code, prescription_rowid, medication_rowid, quantity_dispensed, dispensed_by_rowid) VALUES
('DEX136', 'DISP001', 1, 2, 30, 3),
('DEX137', 'DISP002', 2, 1, 21, 3),
('DEX138', 'DISP003', 3, 3, 10, 3);
GO

ALTER TABLE Dispensations ADD CONSTRAINT FK_Dispensations_Prescriptions FOREIGN KEY (prescription_rowid) REFERENCES Prescriptions(ROWID);
ALTER TABLE Dispensations ADD CONSTRAINT FK_Dispensations_Medications FOREIGN KEY (medication_rowid) REFERENCES Medications(ROWID);
GO

-- TBL047 - DrugInventory (FK: Medications, Suppliers)
CREATE TABLE DrugInventory (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    medication_rowid INT NOT NULL,
    supplier_rowid INT NOT NULL,
    batch_number VARCHAR(50) NOT NULL,
    quantity INT NOT NULL,
    expiry_date DATE,
    received_date DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO DrugInventory (dex_row_id, medication_rowid, supplier_rowid, batch_number, quantity, expiry_date) VALUES
('DEX139', 1, 1, 'BATCH-AMX-001', 200, '2025-12-31'),
('DEX140', 2, 2, 'BATCH-AML-001', 150, '2025-06-30'),
('DEX141', 3, 3, 'BATCH-PAR-001', 500, '2026-03-15');
GO

ALTER TABLE DrugInventory ADD CONSTRAINT FK_Inventory_Medications FOREIGN KEY (medication_rowid) REFERENCES Medications(ROWID);
ALTER TABLE DrugInventory ADD CONSTRAINT FK_Inventory_Suppliers FOREIGN KEY (supplier_rowid) REFERENCES Suppliers(ROWID);
GO

-- TBL048 - MedicalEquipment (FK: Departments, Suppliers)
CREATE TABLE MedicalEquipment (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    equipment_code VARCHAR(20) UNIQUE NOT NULL,
    equipment_name NVARCHAR(100) NOT NULL,
    department_rowid INT NOT NULL,
    supplier_rowid INT NOT NULL,
    purchase_date DATE,
    warranty_expiry DATE,
    last_maintenance_date DATE,
    status VARCHAR(20) DEFAULT 'Operational'
);
GO

INSERT INTO MedicalEquipment (dex_row_id, equipment_code, equipment_name, department_rowid, supplier_rowid, purchase_date, status) VALUES
('DEX142', 'EQP001', N'X-Ray Machine', 2, 1, '2022-01-15', 'Operational'),
('DEX143', 'EQP002', N'MRI Scanner', 2, 2, '2023-06-20', 'Operational'),
('DEX144', 'EQP003', N'ECG Monitor', 3, 3, '2024-01-10', 'Maintenance');
GO

ALTER TABLE MedicalEquipment ADD CONSTRAINT FK_Equipment_Departments FOREIGN KEY (department_rowid) REFERENCES Departments(ROWID);
ALTER TABLE MedicalEquipment ADD CONSTRAINT FK_Equipment_Suppliers FOREIGN KEY (supplier_rowid) REFERENCES Suppliers(ROWID);
GO

-- TBL049 - AnesthesiaRecords (FK: SurgeryRecords, Doctors)
CREATE TABLE AnesthesiaRecords (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    record_code VARCHAR(20) UNIQUE NOT NULL,
    surgery_rowid INT NOT NULL,
    anesthesiologist_rowid INT NOT NULL,
    anesthesia_type VARCHAR(50),
    start_time DATETIME,
    end_time DATETIME,
    complications NVARCHAR(MAX),
    notes NVARCHAR(MAX)
);
GO

INSERT INTO AnesthesiaRecords (dex_row_id, record_code, surgery_rowid, anesthesiologist_rowid, anesthesia_type, start_time) VALUES
('DEX145', 'ANR001', 1, 1, 'General', '2024-07-10 08:00'),
('DEX146', 'ANR002', 2, 2, 'Epidural', '2024-07-11 09:00'),
('DEX147', 'ANR003', 3, 3, 'Local', '2024-07-12 10:00');
GO

ALTER TABLE AnesthesiaRecords ADD CONSTRAINT FK_Anesthesia_Surgery FOREIGN KEY (surgery_rowid) REFERENCES SurgeryRecords(ROWID);
ALTER TABLE AnesthesiaRecords ADD CONSTRAINT FK_Anesthesia_Doctors FOREIGN KEY (anesthesiologist_rowid) REFERENCES Doctors(ROWID);
GO

-- TBL050 - AuditLogs (FK: Patients, Staff)
CREATE TABLE AuditLogs (
    ROWID INT IDENTITY(1,1) PRIMARY KEY,
    dex_row_id VARCHAR(50),
    log_code VARCHAR(20) UNIQUE NOT NULL,
    patient_rowid INT,
    staff_rowid INT,
    action_type VARCHAR(50) NOT NULL,
    table_name VARCHAR(50),
    record_rowid INT,
    old_value NVARCHAR(MAX),
    new_value NVARCHAR(MAX),
    ip_address VARCHAR(50),
    log_timestamp DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO AuditLogs (dex_row_id, log_code, patient_rowid, staff_rowid, action_type, table_name, record_rowid) VALUES
('DEX148', 'AUD001', 1, 3, 'INSERT', 'Patients', 1),
('DEX149', 'AUD002', 2, 3, 'UPDATE', 'Appointments', 2),
('DEX150', 'AUD003', 3, 3, 'DELETE', 'WaitingList', 1);
GO

ALTER TABLE AuditLogs ADD CONSTRAINT FK_Audit_Patients FOREIGN KEY (patient_rowid) REFERENCES Patients(ROWID);
ALTER TABLE AuditLogs ADD CONSTRAINT FK_Audit_Staff FOREIGN KEY (staff_rowid) REFERENCES Staff(ROWID);
GO

PRINT 'HealthDB created successfully with 50 tables and 3 records each.';
GO
