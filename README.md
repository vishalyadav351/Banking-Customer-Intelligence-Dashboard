# 🏦 Enterprise Bank Financial Performance & Customer Analytics Platform

![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![SQL](https://img.shields.io/badge/SQL-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)
![ETL Pipeline](https://img.shields.io/badge/ETL-Power_Query-2BABA7?style=for-the-badge)
![Data Architecture](https://img.shields.io/badge/Schema-Star_Schema-blue?style=for-the-badge)

An end-to-end, enterprise-grade Data Analytics and Business Intelligence solution designed for the Banking and Financial Services (BFSI) sector. This platform processes raw, disparate transactional data into high-fidelity, interactive operational dashboards.

## 🏗️ System Architecture & Data Pipeline

Below is the structured data engineering workflow and operational roadmap implemented in this project:

┌────────────────────────────────────────────────────────────────────────┐
│                      💾 RAW TRANSACTIONAL DATABASES                    │
│      (Source tables containing unstructured customer & log logs)       │
└──────────────────────────────────┬─────────────────────────────────────┘
                                   │
                                   ▼  [Extraction via Complex Queries]
┌────────────────────────────────────────────────────────────────────────┐
│                      🔍 SQL ENGINEERING LAYER                           │
│     (Relational Joins, Window Functions, CTEs, & Aggregations)         │
└──────────────────────────────────┬─────────────────────────────────────┘
                                   │
                                   ▼  [Data Cleaning & Standardization]
┌────────────────────────────────────────────────────────────────────────┐
│                      🧹 POWER QUERY ETL ENGINE                         │
│   (Null imputation, string trimming, custom Calendar dimension table)  │
└──────────────────────────────────┬─────────────────────────────────────┘
                                   │
                                   ▼  [Relational Optimization]
┌────────────────────────────────────────────────────────────────────────┐
│                      📐 STAR SCHEMA DATA MODEL                         │
│  (1:N Direct Unidirectional Relationships | Fact & Dimension Split)   │
└──────────────────────────────────┬─────────────────────────────────────┘
                                   │
                                   ▼  [Analytical Engineering]
┌────────────────────────────────────────────────────────────────────────┐
│                      🧮 DAX CALCULATIONS LAYER                         │
│    (Time-Series intelligence, Credit Utilization, Approval Ratios)     │
└──────────────────────────────────┬─────────────────────────────────────┘
                                   │
                                   ▼  [Presentation Tier]
┌────────────────────────────────────────────────────────────────────────┐
│             📊 HIGH-FIDELITY INTERACTIVE POWER BI UI                   │
│         (Cross-filtering, global slicers, operational console)        │
└────────────────────────────────────────────────────────────────────────┘


## 🛠️ Data Engineering & ETL Deep Dive

### 1. Extraction Layer (SQL Engineering)
To optimize data load and ensure the dashboard operates at low latency, aggregation was pushed back to the database tier using advanced SQL:
* **Relational Merging:** Utilized optimized `INNER JOIN` and `LEFT JOIN` operations across `Customer Profiles`, `Transaction Logs`, and `Loan Ledger` tables.
* **Modular Logic:** Structured complex multi-step processing using **CTEs (Common Table Expressions)** to pre-calculate volatile financial metrics (e.g., historical rolling balances).
* **Categorical Binning:** Implemented robust `CASE WHEN` logic to segment continuous numerical data into discrete analytical classes (e.g., Age Groups, Credit Risk tiers).

### 2. Transformation Layer (Power Query Engine)
The raw dataset contained structural inconsistencies and integrity anomalies. The following preprocessing rules were applied:

| Data Field / Domain | Discovered Anomaly | Resolution / Transformation Applied |
| :--- | :--- | :--- |
| **Transaction & Credit Limits** | Null / Blank Values | Implemented logical constraints and mean-imputation where applicable. |
| **Demographics (City / Gender)**| Case mismatches, trailing spaces, duplicate names | String trimming, structural standardization, and uniform case mapping. |
| **Temporal Data (Dates)** | Non-contiguous date records | Generated a dynamic, centralized Calendar Table to establish time-series integrity. |

### 3. Data Modeling (Analytical Layer)
The database layout inside Power BI was re-architected into a highly performant **Star Schema**:
* **Fact Tables:** Centered around `Fact_Transactions` and `Fact_Loans` containing high-volume metric data.
* **Dimension Tables:** Surrounded by decoupled lookup tables including `Dim_Customers`, `Dim_Branch`, and `Dim_CreditCards`.
* **Cardinality:** Enforced strict `1-to-Many (1:N)` unidirectional relationships to mitigate performance overhead and prevent circular dependency traps.

---

## 📊 Dashboard Architecture & Core Business Intelligence

The final deliverable is an interactive, multi-page business console comprised of four dedicated analytical modules:

### 🔹 1. Executive Summary
* **Business Objective:** Provides C-suite executives with a holistic overview of institutional financial health.
* **Core KPIs Captured:** Total unique customer volume, aggregate balance velocity, and an impressive **$127.51M Total Transaction Volume**.
* **Visual Mechanics:** Dynamic time-series area charts tracking transaction density over a multi-month horizon.

### 🔹 2. Customer Analytics
* **Business Objective:** Unlocks granular visibility into demographic behaviors and high-value customer acquisition.
* **Core KPIs Captured:** Average account equity distributed across target demographics (Age Groups: 18-25 through 60+, Gender, and Regional distribution).
* **Visual Mechanics:** Interactive geographic breakdowns mapping account performance by city.

### 🔹 3. Loan Portfolio Analytics
* **Business Objective:** Monitors credit exposure, risk allocation, and structural operational performance.
* **Core KPIs Captured:** Ratio analysis of Loan Approval vs. Rejection metrics and average interest yield variations.
* **Visual Mechanics:** Multi-dimensional matrix breakdowns cross-referencing sectors (**Auto, Mortgage, Personal Loans**).

### 🔹 4. Credit Card Analytics
* **Business Objective:** Assesses market penetration and capital risk profile across institutional card lines.
* **Core KPIs Captured:** Segmented volume logs for major networks (**AMEX, Visa, MasterCard**) alongside total credit limits and real-time Credit Utilization Ratios.

---

## 🚀 Deployment & Local Execution

1. **Clone the Repository:**
   ```bash
   git clone [https://github.com/yourusername/bank-analytics-platform.git](https://github.com/vishalyadav351/bank-analytics-platform.git)
 ### 🔹 1. File Name
Review Database Logic: Navigated to the /banking_queries.sql file to inspect production-ready schema modification queries.
###  2. project overview pbix
 Initialize the Console: Open the compiled .pbix solution within Power BI Desktop to leverage interactive cross-filtering and synchronized global slicers.
