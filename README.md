<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:1B3A6B,50:1A7A6E,100:0D5EA0&height=200&section=header&text=NYC%20Healthcare%20Database&fontSize=40&fontColor=ffffff&fontAlignY=38&desc=Oracle%20SQL%20%7C%20Relational%20Database%20Management%20System&descAlignY=58&descSize=15&animation=fadeIn" width="100%"/>

<br/>

[![Oracle](https://img.shields.io/badge/Oracle_SQL-F80000?style=for-the-badge&logo=oracle&logoColor=white)](.)
[![Platform](https://img.shields.io/badge/FreeSQL-Platform-1A7A6E?style=for-the-badge&logo=databricks&logoColor=white)](https://freesql.com)
[![Tables](https://img.shields.io/badge/8_Tables-1B3A6B?style=for-the-badge&logo=microsoftazure&logoColor=white)](.)
[![Records](https://img.shields.io/badge/80%2B_Records-0D5EA0?style=for-the-badge&logo=databricks&logoColor=white)](.)
[![Reports](https://img.shields.io/badge/4_SQL_Reports-2E8B57?style=for-the-badge&logo=googleanalytics&logoColor=white)](.)
[![Status](https://img.shields.io/badge/Status-Complete_✓-brightgreen?style=for-the-badge)](.)

<br/>

### 🏥 A fully normalized Oracle relational database for a multi-specialty hospital network<br/>serving all **5 boroughs of New York City**

<br/>

</div>

---

## 👨‍💻 Project Info

| | |
|--|--|
| **Student** | Mahmudul Hasan |
| **Institution** | New York City College of Technology |
| **Course** | CST1204 — Database Management (W29) |
| **Professor** | Edward Banduk |
| **Platform** | Oracle Database — FreeSQL.com |
| **Date** | April 2026 |

---

## 🗄️ Database at a Glance

```
  PATIENT ──────► APPOINTMENT ◄────── DOCTOR
     │                 │                 │
     │                 ▼                 │
     │             BILLING          DEPARTMENT
     │                                   │
     ├──► MEDICAL_RECORD ──► PRESCRIPTION│
     │                                   │
     └───────────────────────────── STAFF┘

  8 Tables  •  80+ Records  •  4 Multi-Table SQL Reports
```

| # | Table | Description | Records |
|---|-------|-------------|---------|
| 1 | 🧑‍🤝‍🧑 PATIENT | Demographics, insurance, NYC borough data | 10 |
| 2 | 👨‍⚕️ DOCTOR | Credentials, specialization, hospital affiliation | 8 |
| 3 | 🏢 DEPARTMENT | Structure, beds, floor, department head | 6 |
| 4 | 📅 APPOINTMENT | Patient visit scheduling and status tracking | 12 |
| 5 | 🩺 MEDICAL_RECORD | Diagnosis, treatment, test results | 10 |
| 6 | 💊 PRESCRIPTION | Drug orders linked to medical records | 10 |
| 7 | 💰 BILLING | Charges, insurance coverage, payment status | 10 |
| 8 | 👩‍⚕️ STAFF | Nurses, technicians, roles, salaries | 8 |

---

## 📊 SQL Reports

| # | Report | Join Type | Tables Used |
|---|--------|-----------|-------------|
| 1 | 📋 Patient Appointment History | 4-Table INNER JOIN | APPOINTMENT + PATIENT + DOCTOR + DEPARTMENT |
| 2 | 💵 Patient Billing Summary | 4-Table INNER JOIN | BILLING + PATIENT + APPOINTMENT + DOCTOR |
| 3 | 🩺 Doctor Performance & Workload | 5-Table LEFT JOIN + GROUP BY + AVG + SUM | DOCTOR + APPOINTMENT + DEPARTMENT + PRESCRIPTION + BILLING |
| 4 | 🔬 Clinical Records + Prescription | 4-Table + LEFT JOIN | MEDICAL_RECORD + PRESCRIPTION + PATIENT + DOCTOR |

---

## ▶️ How to Run

```bash
# Step 1 — Go to FreeSQL or Oracle Live SQL
https://freesql.com   OR   https://livesql.oracle.com

# Step 2 — Open SQL Worksheet and paste the full script
healthcare_nyc.sql

# Step 3 — Click ▶ Run  (all tables + records insert automatically)

# Step 4 — Run each Report query individually to view results
```

---

## 📁 Repository Files

```
📦 nyc-healthcare-oracle-sql-database/
 ┣ 📜 README.md                  ← Project overview (you are here)
 ┣ 🗃️ healthcare_nyc.sql         ← Full Oracle SQL: DDL + DML + 4 Reports
 ┣ 📄 Project_Report.pdf          ← Complete documentation with ERD + screenshots
 ┗ 📁 screenshots/
    ┣ 🖼️ Table 1 - Patient.png
    ┣ 🖼️ Table 2 - Doctor.png
    ┣ 🖼️ Table 3 - Department.png
    ┣ 🖼️ Table 4 - Appointment.png
    ┣ 🖼️ Table 5 - Medical Record.png
    ┣ 🖼️ Table 6 - Prescription.png
    ┣ 🖼️ Table 7 - Billing.png
    ┣ 🖼️ Table 8 - Staff.png
    ┣ 🖼️ Report 1.png
    ┣ 🖼️ Report 2.png
    ┣ 🖼️ Report 3.png
    ┗ 🖼️ Report 4.png
```

---

## 🛠️ Tech Stack

`Oracle Database` &nbsp;•&nbsp; `SQL (DDL / DML / SELECT)` &nbsp;•&nbsp; `FreeSQL` &nbsp;•&nbsp; `3NF Normalization` &nbsp;•&nbsp; `ER Modeling` &nbsp;•&nbsp; `Microsoft Word`

---

<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:1A7A6E,100:1B3A6B&height=100&section=footer&animation=fadeIn" width="100%"/>

*Mahmudul Hasan &nbsp;•&nbsp; CST1204 &nbsp;•&nbsp; New York City College of Technology &nbsp;•&nbsp; 2026*

</div>
