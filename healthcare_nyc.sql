-- ============================================================
-- HEALTH CARE ORGANIZATION DATABASE
-- Location: New York City, NY
-- Author: Healthcare IT Department
-- Date: April 2026
-- Description: Complete Oracle SQL Script for NYC HealthCare DB
-- ============================================================

-- ============================================================
-- SECTION 1: DROP EXISTING TABLES (Clean Start)
-- ============================================================

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE APPOINTMENT CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE PRESCRIPTION CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE MEDICAL_RECORD CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE BILLING CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE STAFF CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE DEPARTMENT CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE DOCTOR CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE PATIENT CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

-- ============================================================
-- SECTION 2: CREATE TABLES
-- ============================================================

-- TABLE 1: PATIENT
CREATE TABLE PATIENT (
    PATIENT_ID      VARCHAR2(10)    PRIMARY KEY,
    FIRST_NAME      VARCHAR2(50)    NOT NULL,
    LAST_NAME       VARCHAR2(50)    NOT NULL,
    DATE_OF_BIRTH   DATE            NOT NULL,
    GENDER          VARCHAR2(10)    CHECK (GENDER IN ('Male','Female','Other')),
    PHONE           VARCHAR2(15),
    EMAIL           VARCHAR2(100),
    ADDRESS         VARCHAR2(200),
    BOROUGH         VARCHAR2(50),
    INSURANCE_ID    VARCHAR2(20),
    INSURANCE_TYPE  VARCHAR2(50),
    BLOOD_GROUP     VARCHAR2(5),
    REGISTRATION_DATE DATE          DEFAULT SYSDATE
);

-- TABLE 2: DOCTOR
CREATE TABLE DOCTOR (
    DOCTOR_ID       VARCHAR2(10)    PRIMARY KEY,
    FIRST_NAME      VARCHAR2(50)    NOT NULL,
    LAST_NAME       VARCHAR2(50)    NOT NULL,
    SPECIALIZATION  VARCHAR2(100)   NOT NULL,
    PHONE           VARCHAR2(15),
    EMAIL           VARCHAR2(100),
    LICENSE_NO      VARCHAR2(30)    UNIQUE,
    YEARS_EXPERIENCE NUMBER(3),
    HOSPITAL_AFFIL  VARCHAR2(100),
    CONSULT_FEE     NUMBER(8,2)
);

-- TABLE 3: DEPARTMENT
CREATE TABLE DEPARTMENT (
    DEPT_ID         VARCHAR2(10)    PRIMARY KEY,
    DEPT_NAME       VARCHAR2(100)   NOT NULL,
    DEPT_HEAD       VARCHAR2(10),
    LOCATION        VARCHAR2(100),
    PHONE_EXT       VARCHAR2(10),
    FLOOR_NO        NUMBER(2),
    TOTAL_BEDS      NUMBER(4),
    DEPT_STATUS     VARCHAR2(10)    DEFAULT 'Active'
);

-- TABLE 4: APPOINTMENT
CREATE TABLE APPOINTMENT (
    APPT_ID         VARCHAR2(10)    PRIMARY KEY,
    PATIENT_ID      VARCHAR2(10)    REFERENCES PATIENT(PATIENT_ID),
    DOCTOR_ID       VARCHAR2(10)    REFERENCES DOCTOR(DOCTOR_ID),
    DEPT_ID         VARCHAR2(10)    REFERENCES DEPARTMENT(DEPT_ID),
    APPT_DATE       DATE            NOT NULL,
    APPT_TIME       VARCHAR2(10),
    APPT_TYPE       VARCHAR2(50),
    STATUS          VARCHAR2(20)    DEFAULT 'Scheduled',
    REASON          VARCHAR2(300),
    NOTES           VARCHAR2(500),
    CREATED_DATE    DATE            DEFAULT SYSDATE
);

-- TABLE 5: MEDICAL_RECORD
CREATE TABLE MEDICAL_RECORD (
    RECORD_ID       VARCHAR2(10)    PRIMARY KEY,
    PATIENT_ID      VARCHAR2(10)    REFERENCES PATIENT(PATIENT_ID),
    DOCTOR_ID       VARCHAR2(10)    REFERENCES DOCTOR(DOCTOR_ID),
    VISIT_DATE      DATE            NOT NULL,
    DIAGNOSIS       VARCHAR2(500),
    SYMPTOMS        VARCHAR2(500),
    TREATMENT       VARCHAR2(500),
    TEST_RESULTS    VARCHAR2(500),
    FOLLOW_UP_DATE  DATE,
    RECORD_STATUS   VARCHAR2(20)    DEFAULT 'Active'
);

-- TABLE 6: PRESCRIPTION
CREATE TABLE PRESCRIPTION (
    PRESC_ID        VARCHAR2(10)    PRIMARY KEY,
    RECORD_ID       VARCHAR2(10)    REFERENCES MEDICAL_RECORD(RECORD_ID),
    PATIENT_ID      VARCHAR2(10)    REFERENCES PATIENT(PATIENT_ID),
    DOCTOR_ID       VARCHAR2(10)    REFERENCES DOCTOR(DOCTOR_ID),
    DRUG_NAME       VARCHAR2(100)   NOT NULL,
    DOSAGE          VARCHAR2(50),
    FREQUENCY       VARCHAR2(50),
    DURATION_DAYS   NUMBER(5),
    PRESC_DATE      DATE            DEFAULT SYSDATE,
    REFILLS_ALLOWED NUMBER(2)       DEFAULT 0,
    PHARMACY_NOTE   VARCHAR2(300)
);

-- TABLE 7: BILLING
CREATE TABLE BILLING (
    BILL_ID         VARCHAR2(10)    PRIMARY KEY,
    PATIENT_ID      VARCHAR2(10)    REFERENCES PATIENT(PATIENT_ID),
    APPT_ID         VARCHAR2(10)    REFERENCES APPOINTMENT(APPT_ID),
    BILL_DATE       DATE            DEFAULT SYSDATE,
    SERVICE_DESC    VARCHAR2(200),
    CONSULT_CHARGE  NUMBER(10,2),
    LAB_CHARGE      NUMBER(10,2),
    MEDICINE_CHARGE NUMBER(10,2),
    ROOM_CHARGE     NUMBER(10,2),
    TOTAL_AMOUNT    NUMBER(10,2),
    INSURANCE_PAID  NUMBER(10,2)    DEFAULT 0,
    PATIENT_DUE     NUMBER(10,2),
    PAYMENT_STATUS  VARCHAR2(20)    DEFAULT 'Pending',
    PAYMENT_METHOD  VARCHAR2(30)
);

-- TABLE 8: STAFF
CREATE TABLE STAFF (
    STAFF_ID        VARCHAR2(10)    PRIMARY KEY,
    FIRST_NAME      VARCHAR2(50)    NOT NULL,
    LAST_NAME       VARCHAR2(50)    NOT NULL,
    ROLE            VARCHAR2(50),
    DEPT_ID         VARCHAR2(10)    REFERENCES DEPARTMENT(DEPT_ID),
    PHONE           VARCHAR2(15),
    EMAIL           VARCHAR2(100),
    HIRE_DATE       DATE,
    SALARY          NUMBER(10,2),
    SHIFT           VARCHAR2(20)
);

-- ============================================================
-- SECTION 3: INSERT RECORDS
-- ============================================================

-- ---- PATIENT Records (10 patients) ----
INSERT INTO PATIENT VALUES ('P001','James','Harrison',TO_DATE('1985-03-14','YYYY-MM-DD'),'Male','212-555-1001','james.h@email.com','45 W 34th St, Manhattan, NY 10001','Manhattan','INS-78451','BlueCross BlueShield','O+',TO_DATE('2022-01-10','YYYY-MM-DD'));
INSERT INTO PATIENT VALUES ('P002','Maria','Rodriguez',TO_DATE('1990-07-22','YYYY-MM-DD'),'Female','718-555-2002','maria.r@email.com','123 Grand Concourse, Bronx, NY 10451','Bronx','INS-66312','Medicaid','A+',TO_DATE('2022-03-05','YYYY-MM-DD'));
INSERT INTO PATIENT VALUES ('P003','David','Kim',TO_DATE('1978-11-30','YYYY-MM-DD'),'Male','646-555-3003','david.k@email.com','88 Flatbush Ave, Brooklyn, NY 11217','Brooklyn','INS-55298','Aetna','B-',TO_DATE('2021-11-20','YYYY-MM-DD'));
INSERT INTO PATIENT VALUES ('P004','Sophia','Chen',TO_DATE('2001-04-09','YYYY-MM-DD'),'Female','917-555-4004','sophia.c@email.com','200 Queens Blvd, Queens, NY 11375','Queens','INS-44187','UnitedHealth','AB+',TO_DATE('2023-02-14','YYYY-MM-DD'));
INSERT INTO PATIENT VALUES ('P005','Michael','Johnson',TO_DATE('1965-09-18','YYYY-MM-DD'),'Male','212-555-5005','michael.j@email.com','78 Bay St, Staten Island, NY 10301','Staten Island','INS-33076','Medicare','O-',TO_DATE('2020-06-01','YYYY-MM-DD'));
INSERT INTO PATIENT VALUES ('P006','Aisha','Williams',TO_DATE('1995-12-05','YYYY-MM-DD'),'Female','718-555-6006','aisha.w@email.com','340 E 149th St, Bronx, NY 10455','Bronx','INS-22965','Cigna','A-',TO_DATE('2023-07-22','YYYY-MM-DD'));
INSERT INTO PATIENT VALUES ('P007','Robert','Thompson',TO_DATE('1972-06-28','YYYY-MM-DD'),'Male','646-555-7007','robert.t@email.com','510 Atlantic Ave, Brooklyn, NY 11217','Brooklyn','INS-11854','BlueCross BlueShield','B+',TO_DATE('2021-05-11','YYYY-MM-DD'));
INSERT INTO PATIENT VALUES ('P008','Emily','Martinez',TO_DATE('1988-02-17','YYYY-MM-DD'),'Female','917-555-8008','emily.m@email.com','93 Nagle Ave, Manhattan, NY 10040','Manhattan','INS-99743','Aetna','O+',TO_DATE('2022-09-30','YYYY-MM-DD'));
INSERT INTO PATIENT VALUES ('P009','Kevin','Patel',TO_DATE('2005-08-25','YYYY-MM-DD'),'Male','212-555-9009','kevin.p@email.com','1452 Jamaica Ave, Queens, NY 11432','Queens','INS-88632','Medicaid','AB-',TO_DATE('2024-01-15','YYYY-MM-DD'));
INSERT INTO PATIENT VALUES ('P010','Natalie','Brown',TO_DATE('1950-01-12','YYYY-MM-DD'),'Female','718-555-0010','natalie.b@email.com','22 Hylan Blvd, Staten Island, NY 10305','Staten Island','INS-77521','Medicare','A+',TO_DATE('2019-12-03','YYYY-MM-DD'));

-- ---- DOCTOR Records (8 doctors) ----
INSERT INTO DOCTOR VALUES ('D001','Richard','Nguyen','Cardiology','212-700-1001','r.nguyen@nychealthcare.org','LIC-NY-10021',22,'NYU Langone Medical Center',450.00);
INSERT INTO DOCTOR VALUES ('D002','Linda','Kapoor','Internal Medicine','212-700-1002','l.kapoor@nychealthcare.org','LIC-NY-10022',15,'Mount Sinai Hospital',300.00);
INSERT INTO DOCTOR VALUES ('D003','Carlos','Reyes','Orthopedics','212-700-1003','c.reyes@nychealthcare.org','LIC-NY-10023',18,'NYC Health + Hospitals',380.00);
INSERT INTO DOCTOR VALUES ('D004','Jennifer','Walsh','Pediatrics','212-700-1004','j.walsh@nychealthcare.org','LIC-NY-10024',10,'Weill Cornell Medicine',280.00);
INSERT INTO DOCTOR VALUES ('D005','Andrew','Lee','Neurology','212-700-1005','a.lee@nychealthcare.org','LIC-NY-10025',25,'Columbia University Irving',520.00);
INSERT INTO DOCTOR VALUES ('D006','Patricia','Okonkwo','Oncology','212-700-1006','p.okonkwo@nychealthcare.org','LIC-NY-10026',20,'Memorial Sloan Kettering',600.00);
INSERT INTO DOCTOR VALUES ('D007','Samuel','Fisher','Emergency Medicine','212-700-1007','s.fisher@nychealthcare.org','LIC-NY-10027',8,'Bellevue Hospital Center',350.00);
INSERT INTO DOCTOR VALUES ('D008','Grace','Hernandez','Psychiatry','212-700-1008','g.hernandez@nychealthcare.org','LIC-NY-10028',12,'NYC Health + Hospitals',320.00);

-- ---- DEPARTMENT Records (6 departments) ----
INSERT INTO DEPARTMENT VALUES ('DEP01','Cardiology','D001','Building A - Wing 3','Ext-301',3,40,'Active');
INSERT INTO DEPARTMENT VALUES ('DEP02','Internal Medicine','D002','Building B - Wing 1','Ext-201',2,60,'Active');
INSERT INTO DEPARTMENT VALUES ('DEP03','Orthopedics','D003','Building C - Wing 2','Ext-401',4,30,'Active');
INSERT INTO DEPARTMENT VALUES ('DEP04','Pediatrics','D004','Building A - Wing 1','Ext-101',1,50,'Active');
INSERT INTO DEPARTMENT VALUES ('DEP05','Neurology','D005','Building B - Wing 3','Ext-501',5,25,'Active');
INSERT INTO DEPARTMENT VALUES ('DEP06','Emergency Medicine','D007','Ground Floor - ER','Ext-911',1,80,'Active');

-- ---- APPOINTMENT Records (12 appointments) ----
INSERT INTO APPOINTMENT VALUES ('A001','P001','D001','DEP01',TO_DATE('2026-01-15','YYYY-MM-DD'),'10:00 AM','Follow-up','Completed','Chest pain follow-up','Patient on beta-blockers',TO_DATE('2025-12-20','YYYY-MM-DD'));
INSERT INTO APPOINTMENT VALUES ('A002','P002','D002','DEP02',TO_DATE('2026-01-18','YYYY-MM-DD'),'11:30 AM','New Visit','Completed','General checkup','Hypertension noted',TO_DATE('2025-12-22','YYYY-MM-DD'));
INSERT INTO APPOINTMENT VALUES ('A003','P003','D003','DEP03',TO_DATE('2026-02-05','YYYY-MM-DD'),'09:00 AM','Consultation','Completed','Knee pain evaluation','MRI recommended',TO_DATE('2026-01-10','YYYY-MM-DD'));
INSERT INTO APPOINTMENT VALUES ('A004','P004','D004','DEP04',TO_DATE('2026-02-12','YYYY-MM-DD'),'02:00 PM','Routine','Completed','Annual physical','All vitals normal',TO_DATE('2026-01-15','YYYY-MM-DD'));
INSERT INTO APPOINTMENT VALUES ('A005','P005','D005','DEP05',TO_DATE('2026-02-20','YYYY-MM-DD'),'03:30 PM','Follow-up','Completed','Migraine review','Medication adjusted',TO_DATE('2026-01-25','YYYY-MM-DD'));
INSERT INTO APPOINTMENT VALUES ('A006','P006','D001','DEP01',TO_DATE('2026-03-01','YYYY-MM-DD'),'08:30 AM','New Visit','Completed','Palpitations evaluation','ECG and echo scheduled',TO_DATE('2026-02-05','YYYY-MM-DD'));
INSERT INTO APPOINTMENT VALUES ('A007','P007','D002','DEP02',TO_DATE('2026-03-10','YYYY-MM-DD'),'01:00 PM','Follow-up','Completed','Diabetes management','HbA1c improved',TO_DATE('2026-02-12','YYYY-MM-DD'));
INSERT INTO APPOINTMENT VALUES ('A008','P008','D008','DEP05',TO_DATE('2026-03-18','YYYY-MM-DD'),'04:00 PM','New Visit','Completed','Anxiety assessment','CBT recommended',TO_DATE('2026-02-20','YYYY-MM-DD'));
INSERT INTO APPOINTMENT VALUES ('A009','P009','D004','DEP04',TO_DATE('2026-04-02','YYYY-MM-DD'),'10:30 AM','Routine','Completed','Growth check','On track',TO_DATE('2026-03-01','YYYY-MM-DD'));
INSERT INTO APPOINTMENT VALUES ('A010','P010','D006','DEP02',TO_DATE('2026-04-08','YYYY-MM-DD'),'09:30 AM','Follow-up','Completed','Chemotherapy review','Response positive',TO_DATE('2026-03-08','YYYY-MM-DD'));
INSERT INTO APPOINTMENT VALUES ('A011','P001','D005','DEP05',TO_DATE('2026-04-20','YYYY-MM-DD'),'11:00 AM','New Visit','Scheduled','Headaches','Awaiting visit',TO_DATE('2026-03-25','YYYY-MM-DD'));
INSERT INTO APPOINTMENT VALUES ('A012','P003','D007','DEP06',TO_DATE('2026-04-25','YYYY-MM-DD'),'08:00 AM','Emergency','Completed','Acute knee injury','X-ray done',TO_DATE('2026-04-25','YYYY-MM-DD'));

-- ---- MEDICAL_RECORD Records (10 records) ----
INSERT INTO MEDICAL_RECORD VALUES ('MR001','P001','D001',TO_DATE('2026-01-15','YYYY-MM-DD'),'Coronary Artery Disease (CAD)','Chest tightness, shortness of breath','Beta-blocker therapy continued; low-sodium diet advised','Troponin normal; ECG stable',TO_DATE('2026-04-15','YYYY-MM-DD'),'Active');
INSERT INTO MEDICAL_RECORD VALUES ('MR002','P002','D002',TO_DATE('2026-01-18','YYYY-MM-DD'),'Hypertension Stage 2','Headache, dizziness, fatigue','Amlodipine 5mg prescribed; BP monitoring daily','BP: 158/98; Cholesterol slightly elevated',TO_DATE('2026-03-18','YYYY-MM-DD'),'Active');
INSERT INTO MEDICAL_RECORD VALUES ('MR003','P003','D003',TO_DATE('2026-02-05','YYYY-MM-DD'),'Osteoarthritis - Right Knee','Swelling, stiffness, pain on movement','Physical therapy 3x/week; NSAIDs as needed','MRI: Grade II cartilage wear',TO_DATE('2026-05-05','YYYY-MM-DD'),'Active');
INSERT INTO MEDICAL_RECORD VALUES ('MR004','P004','D004',TO_DATE('2026-02-12','YYYY-MM-DD'),'Healthy - Annual Physical','None','Maintain current health habits; vitamins recommended','All bloodwork normal; BMI 22',TO_DATE('2027-02-12','YYYY-MM-DD'),'Active');
INSERT INTO MEDICAL_RECORD VALUES ('MR005','P005','D005',TO_DATE('2026-02-20','YYYY-MM-DD'),'Chronic Migraine','Severe headaches, nausea, light sensitivity','Sumatriptan 50mg for acute attacks; Topiramate preventive','MRI brain: no abnormalities',TO_DATE('2026-05-20','YYYY-MM-DD'),'Active');
INSERT INTO MEDICAL_RECORD VALUES ('MR006','P006','D001',TO_DATE('2026-03-01','YYYY-MM-DD'),'Atrial Fibrillation','Irregular heartbeat, fatigue, palpitations','Anticoagulant therapy; rate control with Metoprolol','ECG: AFib confirmed; Echo: mild LV dilation',TO_DATE('2026-06-01','YYYY-MM-DD'),'Active');
INSERT INTO MEDICAL_RECORD VALUES ('MR007','P007','D002',TO_DATE('2026-03-10','YYYY-MM-DD'),'Type 2 Diabetes Mellitus','Increased thirst, frequent urination, fatigue','Metformin 1000mg BID; Lifestyle modification plan','HbA1c: 7.1% (improved from 8.5%)',TO_DATE('2026-06-10','YYYY-MM-DD'),'Active');
INSERT INTO MEDICAL_RECORD VALUES ('MR008','P008','D008',TO_DATE('2026-03-18','YYYY-MM-DD'),'Generalized Anxiety Disorder','Excessive worry, insomnia, panic episodes','CBT sessions weekly; Sertraline 50mg prescribed','GAD-7 Score: 14 (Moderate-Severe)',TO_DATE('2026-06-18','YYYY-MM-DD'),'Active');
INSERT INTO MEDICAL_RECORD VALUES ('MR009','P009','D004',TO_DATE('2026-04-02','YYYY-MM-DD'),'Normal Growth & Development','None','Recommended Vitamin D supplement; dental checkup','Height/Weight: 50th percentile; all milestones met',TO_DATE('2027-04-02','YYYY-MM-DD'),'Active');
INSERT INTO MEDICAL_RECORD VALUES ('MR010','P010','D006',TO_DATE('2026-04-08','YYYY-MM-DD'),'Breast Cancer - Stage II','Lump in left breast; mild fatigue','Chemotherapy cycle 4 of 6; Anti-nausea meds prescribed','Tumor shrinkage 35%; PET scan scheduled',TO_DATE('2026-07-08','YYYY-MM-DD'),'Active');

-- ---- PRESCRIPTION Records (10 prescriptions) ----
INSERT INTO PRESCRIPTION VALUES ('RX001','MR001','P001','D001','Metoprolol Succinate','50mg','Once daily','365',TO_DATE('2026-01-15','YYYY-MM-DD'),3,'Take with food; avoid grapefruit');
INSERT INTO PRESCRIPTION VALUES ('RX002','MR002','P002','D002','Amlodipine','5mg','Once daily','180',TO_DATE('2026-01-18','YYYY-MM-DD'),5,'Monitor blood pressure weekly');
INSERT INTO PRESCRIPTION VALUES ('RX003','MR003','P003','D003','Ibuprofen','400mg','Twice daily as needed','90',TO_DATE('2026-02-05','YYYY-MM-DD'),2,'Take with food; not more than 7 days continuously');
INSERT INTO PRESCRIPTION VALUES ('RX004','MR005','P005','D005','Sumatriptan','50mg','At onset of migraine; max 2/day','90',TO_DATE('2026-02-20','YYYY-MM-DD'),2,'Do not take with MAOIs');
INSERT INTO PRESCRIPTION VALUES ('RX005','MR005','P005','D005','Topiramate','25mg','Once daily at bedtime','180',TO_DATE('2026-02-20','YYYY-MM-DD'),3,'Preventive; do not stop abruptly');
INSERT INTO PRESCRIPTION VALUES ('RX006','MR006','P006','D001','Rivaroxaban','20mg','Once daily with evening meal','365',TO_DATE('2026-03-01','YYYY-MM-DD'),4,'Watch for bleeding signs; avoid aspirin');
INSERT INTO PRESCRIPTION VALUES ('RX007','MR007','P007','D002','Metformin','1000mg','Twice daily with meals','365',TO_DATE('2026-03-10','YYYY-MM-DD'),5,'Monitor kidney function quarterly');
INSERT INTO PRESCRIPTION VALUES ('RX008','MR008','P008','D008','Sertraline','50mg','Once daily in morning','180',TO_DATE('2026-03-18','YYYY-MM-DD'),3,'May take 4-6 weeks for full effect');
INSERT INTO PRESCRIPTION VALUES ('RX009','MR009','P009','D004','Vitamin D3','1000 IU','Once daily','180',TO_DATE('2026-04-02','YYYY-MM-DD'),2,'Take with calcium-rich meal');
INSERT INTO PRESCRIPTION VALUES ('RX010','MR010','P010','D006','Ondansetron','8mg','Every 8 hours as needed','30',TO_DATE('2026-04-08','YYYY-MM-DD'),1,'Anti-nausea during chemotherapy');

-- ---- BILLING Records (10 bills) ----
INSERT INTO BILLING VALUES ('B001','P001','A001',TO_DATE('2026-01-15','YYYY-MM-DD'),'Cardiology Consultation + ECG',450.00,120.00,45.00,0,615.00,490.00,125.00,'Paid','Insurance + Credit Card');
INSERT INTO BILLING VALUES ('B002','P002','A002',TO_DATE('2026-01-18','YYYY-MM-DD'),'Internal Medicine - New Visit',300.00,85.00,35.00,0,420.00,0,420.00,'Paid','Medicaid');
INSERT INTO BILLING VALUES ('B003','P003','A003',TO_DATE('2026-02-05','YYYY-MM-DD'),'Orthopedics Consultation + MRI',380.00,1200.00,50.00,0,1630.00,1300.00,330.00,'Paid','Insurance + Debit');
INSERT INTO BILLING VALUES ('B004','P004','A004',TO_DATE('2026-02-12','YYYY-MM-DD'),'Annual Physical + Lab Tests',280.00,150.00,0,0,430.00,430.00,0,'Paid','Insurance');
INSERT INTO BILLING VALUES ('B005','P005','A005',TO_DATE('2026-02-20','YYYY-MM-DD'),'Neurology Consultation + MRI Brain',520.00,1500.00,75.00,0,2095.00,1676.00,419.00,'Paid','Insurance + Cash');
INSERT INTO BILLING VALUES ('B006','P006','A006',TO_DATE('2026-03-01','YYYY-MM-DD'),'Cardiology - ECG + Echocardiogram',450.00,850.00,60.00,0,1360.00,1088.00,272.00,'Paid','Insurance');
INSERT INTO BILLING VALUES ('B007','P007','A007',TO_DATE('2026-03-10','YYYY-MM-DD'),'Internal Medicine - Diabetes Follow-up',300.00,95.00,40.00,0,435.00,348.00,87.00,'Paid','Insurance');
INSERT INTO BILLING VALUES ('B008','P008','A008',TO_DATE('2026-03-18','YYYY-MM-DD'),'Psychiatry - Initial Assessment',320.00,0,55.00,0,375.00,300.00,75.00,'Paid','Insurance + Card');
INSERT INTO BILLING VALUES ('B009','P009','A009',TO_DATE('2026-04-02','YYYY-MM-DD'),'Pediatrics - Growth & Development',280.00,60.00,15.00,0,355.00,0,355.00,'Pending','Medicaid');
INSERT INTO BILLING VALUES ('B010','P010','A010',TO_DATE('2026-04-08','YYYY-MM-DD'),'Oncology - Chemotherapy Cycle 4',600.00,800.00,200.00,1200.00,2800.00,2240.00,560.00,'Partial','Insurance + Payment Plan');

-- ---- STAFF Records (8 staff) ----
INSERT INTO STAFF VALUES ('ST001','Angela','Davis','Head Nurse','DEP01','212-600-1001','a.davis@nychealthcare.org',TO_DATE('2015-03-01','YYYY-MM-DD'),82000.00,'Day');
INSERT INTO STAFF VALUES ('ST002','Marcus','White','Medical Technician','DEP02','212-600-1002','m.white@nychealthcare.org',TO_DATE('2018-07-15','YYYY-MM-DD'),62000.00,'Day');
INSERT INTO STAFF VALUES ('ST003','Helen','Torres','Registered Nurse','DEP03','212-600-1003','h.torres@nychealthcare.org',TO_DATE('2020-01-10','YYYY-MM-DD'),74000.00,'Night');
INSERT INTO STAFF VALUES ('ST004','Brian','Jackson','Ward Coordinator','DEP04','212-600-1004','b.jackson@nychealthcare.org',TO_DATE('2017-05-20','YYYY-MM-DD'),68000.00,'Day');
INSERT INTO STAFF VALUES ('ST005','Fatima','Ali','Clinical Pharmacist','DEP02','212-600-1005','f.ali@nychealthcare.org',TO_DATE('2016-09-08','YYYY-MM-DD'),95000.00,'Day');
INSERT INTO STAFF VALUES ('ST006','Jason','Park','X-Ray Technician','DEP03','212-600-1006','j.park@nychealthcare.org',TO_DATE('2019-11-30','YYYY-MM-DD'),70000.00,'Rotating');
INSERT INTO STAFF VALUES ('ST007','Sandra','Moore','Emergency Nurse','DEP06','212-600-1007','s.moore@nychealthcare.org',TO_DATE('2014-06-01','YYYY-MM-DD'),88000.00,'Night');
INSERT INTO STAFF VALUES ('ST008','Daniel','Wright','Billing Coordinator','DEP02','212-600-1008','d.wright@nychealthcare.org',TO_DATE('2021-03-22','YYYY-MM-DD'),58000.00,'Day');

COMMIT;

-- ============================================================
-- SECTION 4: SQL REPORTS / QUERIES
-- ============================================================

-- ============================================================
-- REPORT 1: PATIENT APPOINTMENT HISTORY REPORT
-- Description: Full list of all appointments with patient name,
--              doctor name, department, date, and status.
-- Tables Used: APPOINTMENT, PATIENT, DOCTOR, DEPARTMENT
-- ============================================================
SELECT
    A.APPT_ID,
    P.PATIENT_ID,
    P.FIRST_NAME || ' ' || P.LAST_NAME      AS PATIENT_NAME,
    P.BOROUGH,
    P.INSURANCE_TYPE,
    D.FIRST_NAME || ' ' || D.LAST_NAME      AS DOCTOR_NAME,
    D.SPECIALIZATION,
    DEP.DEPT_NAME                           AS DEPARTMENT,
    A.APPT_DATE,
    A.APPT_TIME,
    A.APPT_TYPE,
    A.STATUS,
    A.REASON
FROM APPOINTMENT A
JOIN PATIENT    P   ON A.PATIENT_ID = P.PATIENT_ID
JOIN DOCTOR     D   ON A.DOCTOR_ID  = D.DOCTOR_ID
JOIN DEPARTMENT DEP ON A.DEPT_ID    = DEP.DEPT_ID
ORDER BY A.APPT_DATE ASC;


-- ============================================================
-- REPORT 2: PATIENT BILLING SUMMARY REPORT
-- Description: Financial summary of each patient's billing
--              including insurance coverage vs patient due amount.
-- Tables Used: BILLING, PATIENT, APPOINTMENT, DOCTOR
-- ============================================================
SELECT
    B.BILL_ID,
    P.FIRST_NAME || ' ' || P.LAST_NAME      AS PATIENT_NAME,
    P.BOROUGH,
    P.INSURANCE_TYPE,
    D.FIRST_NAME || ' ' || D.LAST_NAME      AS TREATING_DOCTOR,
    D.SPECIALIZATION,
    B.BILL_DATE,
    B.SERVICE_DESC,
    B.CONSULT_CHARGE,
    B.LAB_CHARGE,
    B.MEDICINE_CHARGE,
    B.ROOM_CHARGE,
    B.TOTAL_AMOUNT,
    B.INSURANCE_PAID,
    B.PATIENT_DUE,
    B.PAYMENT_STATUS,
    B.PAYMENT_METHOD
FROM BILLING B
JOIN PATIENT     P  ON B.PATIENT_ID = P.PATIENT_ID
JOIN APPOINTMENT A  ON B.APPT_ID    = A.APPT_ID
JOIN DOCTOR      D  ON A.DOCTOR_ID  = D.DOCTOR_ID
ORDER BY B.TOTAL_AMOUNT DESC;


-- ============================================================
-- REPORT 3: DOCTOR PERFORMANCE & WORKLOAD REPORT
-- Description: Each doctor's total appointments, patients seen,
--              prescriptions written, average billing, and
--              department information.
-- Tables Used: DOCTOR, APPOINTMENT, PRESCRIPTION, BILLING,
--              DEPARTMENT
-- ============================================================
SELECT
    D.DOCTOR_ID,
    D.FIRST_NAME || ' ' || D.LAST_NAME      AS DOCTOR_NAME,
    D.SPECIALIZATION,
    D.YEARS_EXPERIENCE,
    D.HOSPITAL_AFFIL,
    D.CONSULT_FEE,
    DEP.DEPT_NAME                           AS DEPARTMENT,
    COUNT(DISTINCT A.APPT_ID)               AS TOTAL_APPOINTMENTS,
    COUNT(DISTINCT A.PATIENT_ID)            AS UNIQUE_PATIENTS,
    COUNT(DISTINCT RX.PRESC_ID)             AS PRESCRIPTIONS_WRITTEN,
    ROUND(AVG(B.TOTAL_AMOUNT), 2)           AS AVG_BILL_PER_VISIT,
    SUM(B.TOTAL_AMOUNT)                     AS TOTAL_REVENUE_GENERATED
FROM DOCTOR D
LEFT JOIN APPOINTMENT    A   ON D.DOCTOR_ID = A.DOCTOR_ID
LEFT JOIN DEPARTMENT     DEP ON A.DEPT_ID   = DEP.DEPT_ID
LEFT JOIN PRESCRIPTION   RX  ON D.DOCTOR_ID = RX.DOCTOR_ID
LEFT JOIN BILLING        B   ON A.APPT_ID   = B.BILL_ID
GROUP BY
    D.DOCTOR_ID, D.FIRST_NAME, D.LAST_NAME, D.SPECIALIZATION,
    D.YEARS_EXPERIENCE, D.HOSPITAL_AFFIL, D.CONSULT_FEE, DEP.DEPT_NAME
ORDER BY TOTAL_APPOINTMENTS DESC;


-- ============================================================
-- BONUS REPORT 4: MEDICAL RECORDS + PRESCRIPTION DETAIL REPORT
-- Description: Full clinical view of each patient's diagnosis
--              paired with prescriptions issued.
-- Tables Used: MEDICAL_RECORD, PRESCRIPTION, PATIENT, DOCTOR
-- ============================================================
SELECT
    MR.RECORD_ID,
    P.FIRST_NAME || ' ' || P.LAST_NAME          AS PATIENT_NAME,
    P.DATE_OF_BIRTH,
    P.BLOOD_GROUP,
    D.FIRST_NAME || ' ' || D.LAST_NAME          AS DOCTOR_NAME,
    D.SPECIALIZATION,
    MR.VISIT_DATE,
    MR.DIAGNOSIS,
    MR.SYMPTOMS,
    MR.TREATMENT,
    MR.TEST_RESULTS,
    MR.FOLLOW_UP_DATE,
    RX.DRUG_NAME,
    RX.DOSAGE,
    RX.FREQUENCY,
    RX.DURATION_DAYS                            AS DAYS_SUPPLY
FROM MEDICAL_RECORD MR
JOIN PATIENT        P   ON MR.PATIENT_ID = P.PATIENT_ID
JOIN DOCTOR         D   ON MR.DOCTOR_ID  = D.DOCTOR_ID
LEFT JOIN PRESCRIPTION RX ON MR.RECORD_ID = RX.RECORD_ID
ORDER BY MR.VISIT_DATE DESC;


-- ============================================================
-- END OF SCRIPT
-- ============================================================
