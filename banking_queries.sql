-- ====================================================================
-- ENTERPRISE BANKING ANALYTICS - DATA EXTRACTION & ETL SCRIPTS
-- Purpose: Data Aggregation, Cleaning, and Star Schema Decoupling
-- ====================================================================

-- 1. DATA EXTRACTION & COMPACT RELATION JOINING (Summary Dashboard Support)
-- Combines Customer Data, Transactions, and Loans into a Master Fact Sheet
WITH MonthlyBalances AS (
    SELECT 
        c.customer_id,
        c.customer_name,
        c.age,
        c.gender,
        c.city,
        t.transaction_id,
        t.transaction_amount,
        t.transaction_date,
        t.account_type,
        l.loan_type,
        l.loan_amount,
        l.loan_status,
        l.interest_rate
    FROM Fact_Transactions t
    INNER JOIN Dim_Customers c ON t.customer_id = c.customer_id
    LEFT JOIN Fact_Loans l ON c.customer_id = l.customer_id
)
SELECT * FROM MonthlyBalances;


-- 2. DATA CLEANING & CATEGORICAL BINNING (Customer Analytics Support)
-- Standardizes messy text values and groups continuous Age variables
SELECT 
    customer_id,
    customer_name,
    -- Handling case mismatches and removing leading/trailing spaces in City
    TRIM(UPPER(city)) AS cleaned_city,
    -- Standardizing Gender records
    CASE 
        WHEN TRIM(LOWER(gender)) IN ('m', 'male') THEN 'Male'
        WHEN TRIM(LOWER(gender)) IN ('f', 'female') THEN 'Female'
        ELSE 'Other'
    END AS standardized_gender,
    -- Dynamic Age Bracket Segmentation for Age Slicers
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS age_group
FROM Dim_Customers;


-- 3. RISK PROFILE & METRIC AGGREGATION (Credit Card Analytics Support)
-- Implements imputation for missing values and calculates Credit Utilization
SELECT 
    card_type,
    COUNT(customer_id) AS total_cards,
    -- Resolving blank limits by setting a default floor average limit
    SUM(COALESCE(credit_limit, 5000)) AS total_credit_limit,
    -- Aggregating total balances to calculate real-time Credit Utilization Ratio
    ROUND((SUM(outstanding_balance) / SUM(COALESCE(credit_limit, 5000))) * 100, 2) AS credit_utilization_percentage,
    AVG(reward_points) AS avg_reward_points
FROM Fact_CreditCards
GROUP BY card_type
ORDER BY credit_utilization_percentage DESC;


-- 4. PERFORMANCE AGGREGATION KPI (Loan Analytics Support)
-- Calculates Loan Portfolio performance metrics, Approval Rates, and Interest yields
SELECT 
    loan_type,
    COUNT(loan_id) AS total_loan_applications,
    SUM(CASE WHEN loan_status = 'Approved' THEN 1 ELSE 0 END) AS approved_loans_count,
    SUM(CASE WHEN loan_status = 'Rejected' THEN 1 ELSE 0 END) AS rejected_loans_count,
    -- Loan Approval Rate Percentage Calculation
    ROUND((SUM(CASE WHEN loan_status = 'Approved' THEN 1 ELSE 0 END) * 1.0 / COUNT(loan_id)) * 100, 2) AS loan_approval_rate,
    ROUND(AVG(interest_rate), 2) AS average_interest_rate,
    SUM(loan_amount) AS total_loan_disbursed
FROM Fact_Loans
GROUP BY loan_type;