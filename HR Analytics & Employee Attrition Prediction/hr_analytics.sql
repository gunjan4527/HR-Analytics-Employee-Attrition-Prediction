-- 1.attrition rate
SELECT
    COUNT(*) AS total_employees,
    SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    SUM(CASE WHEN "Attrition" = 'No' THEN 1 ELSE 0 END) AS retained,
    ROUND(
        100.0 * SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS attrition_rate_pct
FROM hr_analytics;


-- 1.2 Average monthly income overall vs attrited employees
SELECT
    "Attrition",
    COUNT(*) AS headcount,
    ROUND(AVG("MonthlyIncome"), 2) AS avg_monthly_income,
    ROUND(AVG("Age"), 1) AS avg_age,
    ROUND(AVG("YearsAtCompany"), 1) AS avg_tenure_years,
    ROUND(AVG("JobSatisfaction"), 2) AS avg_job_satisfaction
FROM hr_analytics
GROUP BY "Attrition";


-- 2.1 Attrition rate by department

SELECT
    "Department",
    COUNT(*) AS total,
    SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(
        100.0 * SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        1
    ) AS attrition_rate_pct
FROM hr_analytics
GROUP BY "Department"
ORDER BY attrition_rate_pct DESC;


-- 2.2 Department + Job Role drilldown
SELECT
    "Department",
    "JobRole",
    COUNT(*) AS total,
    SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(
        100.0 * SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        1
    ) AS attrition_rate_pct,
    ROUND(AVG("MonthlyIncome"), 0) AS avg_income
FROM hr_analytics
GROUP BY "Department", "JobRole"
ORDER BY "Department", attrition_rate_pct DESC;

-- 2.3 Sales Department — Overtime Attrition

SELECT
    "OverTime",
    COUNT(*) AS total,
    SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(100.0 * SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS attrition_rate_pct
FROM hr_analytics
WHERE "Department" = 'Sales'
GROUP BY "OverTime";


-- 3.1 Tenure Band Analysis
SELECT
    CASE
        WHEN "YearsAtCompany" BETWEEN 0 AND 2 THEN '0–2 years'
        WHEN "YearsAtCompany" BETWEEN 3 AND 5 THEN '3–5 years'
        WHEN "YearsAtCompany" BETWEEN 6 AND 10 THEN '6–10 years'
        WHEN "YearsAtCompany" BETWEEN 11 AND 20 THEN '11–20 years'
        ELSE '20+ years'
    END AS tenure_band,
    COUNT(*) AS total,
    SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(100.0 * SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS attrition_rate_pct
FROM hr_analytics
GROUP BY tenure_band
ORDER BY MIN("YearsAtCompany");


-- 3.2 Year-wise Attrition
SELECT
    "YearsAtCompany",
    COUNT(*) AS total,
    SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(100.0 * SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS attrition_rate_pct
FROM hr_analytics
GROUP BY "YearsAtCompany"
ORDER BY "YearsAtCompany";


-- 4.1 Overtime vs Attrition
SELECT
    "OverTime",
    COUNT(*) AS total,
    SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(100.0 * SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS attrition_rate_pct
FROM hr_analytics
GROUP BY "OverTime";


-- 4.2 Job Satisfaction vs Attrition
SELECT
    "JobSatisfaction",
    COUNT(*) AS total,
    SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(100.0 * SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS attrition_rate_pct
FROM hr_analytics
GROUP BY "JobSatisfaction"
ORDER BY "JobSatisfaction";


-- 4.3 Overtime + Satisfaction
SELECT
    "OverTime",
    "JobSatisfaction",
    COUNT(*) AS total,
    SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(100.0 * SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS attrition_rate_pct
FROM hr_analytics
GROUP BY "OverTime", "JobSatisfaction"
ORDER BY attrition_rate_pct DESC;


-- 5.1 Income Band Analysis
SELECT
    CASE
        WHEN "MonthlyIncome" < 3000 THEN 'Low (<3K)'
        WHEN "MonthlyIncome" < 6000 THEN 'Mid (3K–6K)'
        WHEN "MonthlyIncome" < 10000 THEN 'Upper-mid (6K–10K)'
        ELSE 'High (>10K)'
    END AS income_band,
    COUNT(*) AS total,
    SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(100.0 * SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS attrition_rate_pct,
    ROUND(AVG("MonthlyIncome"), 0) AS avg_income
FROM hr_analytics
GROUP BY income_band
ORDER BY AVG("MonthlyIncome");


-- 5.2 Salary Hike Analysis
SELECT
    "PercentSalaryHike",
    COUNT(*) AS total,
    ROUND(100.0 * SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS attrition_rate_pct
FROM hr_analytics
GROUP BY "PercentSalaryHike"
ORDER BY "PercentSalaryHike";


-- 6.1 Attrition Cost by Department
SELECT
    "Department",
    COUNT(*) AS total_employees,
    SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) AS attrited_count,
    ROUND(AVG(CASE WHEN "Attrition"='Yes' THEN "MonthlyIncome" END)*12, 0) AS avg_annual_salary_lost,
    ROUND(
        SUM(CASE WHEN "Attrition"='Yes' THEN "MonthlyIncome" ELSE 0 END) * 12 * 1.5,
        0
    ) AS estimated_annual_cost
FROM hr_analytics
GROUP BY "Department"
ORDER BY estimated_annual_cost DESC;


-- 6.2 Total Attrition Cost
SELECT
    ROUND(SUM(CASE WHEN "Attrition"='Yes' THEN "MonthlyIncome" ELSE 0 END) * 12 * 1.5, 0) AS total_cost,
    ROUND(SUM(CASE WHEN "Attrition"='Yes' THEN "MonthlyIncome" ELSE 0 END) * 12 * 1.5 * 0.18, 0) AS savings
FROM hr_analytics;


-- 7.1 High Risk Employees
SELECT
    "Department",
    "JobRole",
    "Age",
    "YearsAtCompany",
    "MonthlyIncome",
    "JobSatisfaction",
    "OverTime",
    "PercentSalaryHike",
    "Attrition",
    (
        CASE WHEN "OverTime" = 'Yes' THEN 1 ELSE 0 END +
        CASE WHEN "JobSatisfaction" <= 2 THEN 1 ELSE 0 END +
        CASE WHEN "YearsAtCompany" <= 2 THEN 1 ELSE 0 END +
        CASE WHEN "MonthlyIncome" < 3000 THEN 1 ELSE 0 END +
        CASE WHEN "PercentSalaryHike" < 12 THEN 1 ELSE 0 END +
        CASE WHEN "WorkLifeBalance" <= 2 THEN 1 ELSE 0 END
    ) AS risk_score
FROM hr_analytics
WHERE "Attrition" = 'No'
ORDER BY risk_score DESC
LIMIT 50;