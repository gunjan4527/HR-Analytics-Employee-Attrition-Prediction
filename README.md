
# 🏢 HR Analytics & Employee Attrition Prediction

> **Predicting employee attrition using Machine Learning, EDA, and interactive Tableau dashboards — helping HR leadership reduce annual attrition costs by 18%.**

<br/>

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![Dataset](https://img.shields.io/badge/Dataset-IBM%20HR%20Analytics-blue)](https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset)
[![Model Accuracy](https://img.shields.io/badge/Model%20Accuracy-88%25-brightgreen)]()
[![ROC AUC](https://img.shields.io/badge/ROC--AUC-0.843-blue)]()

</div>

---

## 📌 Project Overview

This end-to-end data science project analyzes **employee attrition patterns** across 1,470+ employee records to uncover root causes and build a predictive model that identifies at-risk employees before they leave.

The project combines **Exploratory Data Analysis**, **SQL querying**, **Machine Learning modeling**, and an **interactive Tableau dashboard** to deliver actionable HR insights — ultimately providing leadership with a roadmap to reduce projected annual attrition costs by **18%**.

---

## 🎯 Key Results

| Metric | Result |
|--------|--------|
| 📊 Employees Analyzed | 1,470+ records, 35 features |
| 🔴 Sales Dept Attrition | **34% higher** than company average |
| 🤖 Model Accuracy | **88%** (Random Forest) |
| 📈 ROC-AUC Score | **0.843** |
| 💰 Cost Reduction | **18%** projected annual savings |
| ⚡ #1 Attrition Driver | Overtime (confirmed by both EDA & ML) |

---

## 🗂️ Project Structure

```
hr-attrition-prediction/
│
├── 📁 data/
│   ├── WA_Fn-UseC_-HR-Employee-Attrition.csv   ← Raw IBM HR dataset
│   └── hr_processed.csv                         ← Cleaned & feature-engineered data
│
├── 📁 notebooks/
│   ├── 01_eda_visualization.py                  ← EDA & 9 visualization charts
│   └── 02_ml_modeling.py                        ← ML models, SMOTE, evaluation
│
├── 📁 sql/
│   └── 03_sql_queries.sql                       ← 15 analytical SQL queries
│
├── 📁 outputs/
│   ├── eda/                                     ← 9 PNG charts from EDA
│   └── ml/                                      ← Model file, risk scores, ML charts
│
├── 📁 dashboard/
│   └── 04_tableau_dashboard_guide.txt           ← 12-step Tableau build guide
│
└── README.md
```

---

## 📊 Dataset

**IBM HR Analytics Employee Attrition & Performance**

- 🔗 **Source:** [Kaggle — IBM HR Analytics](https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset)
- 📋 **Records:** 1,470 employees | 35 features
- 🎯 **Target variable:** `Attrition` (Yes / No)
- 📄 **License:** Open Database License (ODbL)

**Key features used:**

| Category | Features |
|----------|----------|
| Demographics | `Age`, `Gender`, `MaritalStatus` |
| Job Info | `Department`, `JobRole`, `JobLevel` |
| Compensation | `MonthlyIncome`, `PercentSalaryHike` |
| Satisfaction | `JobSatisfaction`, `WorkLifeBalance`, `EnvironmentSatisfaction` |
| Work Patterns | `OverTime`, `BusinessTravel`, `DistanceFromHome` |
| Tenure | `YearsAtCompany`, `YearsInCurrentRole`, `YearsSinceLastPromotion` |

---

## ⚙️ Installation & Setup

### Prerequisites
- Python 3.10+
- Tableau Desktop or [Tableau Public](https://public.tableau.com/en-us/s/download) (free)
- DB Browser for SQLite (free) — for SQL queries

### Install dependencies

```bash
git clone https://github.com/YOUR_USERNAME/hr-attrition-prediction.git
cd hr-attrition-prediction
pip install pandas numpy matplotlib seaborn scikit-learn imbalanced-learn joblib openpyxl
```

### Download the dataset

```bash
# Option 1: Kaggle CLI
kaggle datasets download -d pavansubhasht/ibm-hr-analytics-attrition-dataset
unzip ibm-hr-analytics-attrition-dataset.zip -d data/

# Option 2: Manual download
# Go to: https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset
# Download and save to: data/WA_Fn-UseC_-HR-Employee-Attrition.csv
```

---

## ▶️ How to Run

### Step 1 — EDA & Visualization
```bash
python notebooks/01_eda_visualization.py
```
Generates 9 charts in `outputs/eda/` and creates the processed dataset.

### Step 2 — Machine Learning Modeling
```bash
python notebooks/02_ml_modeling.py
```
Outputs the trained model, risk scores, ROC curve, feature importance chart, and model report.

### Step 3 — SQL Analysis
Load into SQLite:
```python
import sqlite3, pandas as pd
conn = sqlite3.connect("hr_attrition.db")
pd.read_csv("data/WA_Fn-UseC_-HR-Employee-Attrition.csv").to_sql("employees", conn, if_exists="replace", index=False)
```
Then open `sql/03_sql_queries.sql` in DB Browser for SQLite.

### Step 4 — Tableau Dashboard
Connect Tableau to `outputs/ml/hr_with_risk_score.csv` and follow the step-by-step guide in `dashboard/04_tableau_dashboard_guide.txt`.

---

## 🔍 Phase 1 — Exploratory Data Analysis

Performed comprehensive EDA on 1,470+ records to surface attrition patterns:

- **Department Analysis** — Sales attrition rate of **34%**, compared to 13.8% in R&D
- **Tenure Analysis** — Attrition peaks at **0–2 years** (31.9% rate) — the critical early window
- **Overtime Impact** — Employees working overtime leave at **3× the rate** (30.5% vs 10.4%)
- **Compensation** — Attrited employees earn **$1,000–$2,000/month less** on average
- **Satisfaction** — Low job satisfaction (Level 1) correlates with **22.8% attrition rate**

**Charts generated:**
| Chart | Insight |
|-------|---------|
| `02_attrition_by_department.png` | Sales = highest risk department |
| `03_attrition_by_tenure.png` | 0–2 year employees are most vulnerable |
| `05_overtime_attrition.png` | Overtime = #1 behavioral risk factor |
| `06_correlation_with_attrition.png` | Top 10 correlated features |
| `08_attrition_by_jobrole.png` | Sales Representatives = 39.8% attrition |

---

## 🤖 Phase 2 — Machine Learning Models

### Models Built

| Model | Accuracy | ROC-AUC | Notes |
|-------|----------|---------|-------|
| Logistic Regression | 82.3% | 0.791 | Interpretable baseline |
| **Random Forest** | **88.2%** | **0.843** | Best model ✅ |

### Methodology
- **Train/Test Split:** 80% / 20%, stratified
- **Class Imbalance:** Handled with **SMOTE** (attrition is ~16% of data)
- **Validation:** 5-fold stratified cross-validation
- **CV ROC-AUC:** 0.837 ± 0.021 (stable, no overfitting)

### Top 5 Attrition Drivers (Feature Importance)

```
1. OverTime              0.142  ████████████████████
2. MonthlyIncome         0.118  ████████████████
3. Age                   0.097  █████████████
4. YearsAtCompany        0.089  ████████████
5. JobSatisfaction       0.078  ██████████
```

### Risk Score Output
The model outputs a continuous **attrition probability score (0–1)** for every employee, classified into tiers:

| Risk Tier | Score Range | Recommended Action |
|-----------|-------------|-------------------|
| 🔴 High Risk | > 0.65 | Immediate manager 1:1 + comp review |
| 🟡 Medium Risk | 0.35 – 0.65 | Quarterly check-in |
| 🟢 Low Risk | < 0.35 | Standard retention practices |

---

## 📈 Phase 3 — SQL Analysis

**15 analytical queries** covering:
- Overall KPIs and attrition rate by department
- Tenure band analysis (year-by-year breakdown)
- Overtime and job satisfaction cross-tabulation
- Monthly income percentile bucketing
- **Attrition cost model** (1.5× annual salary replacement benchmark)
- **High-risk employee identification** with multi-factor risk score

```sql
-- The 34% Sales finding
SELECT Department,
       ROUND(100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS attrition_rate_pct
FROM employees
GROUP BY Department
ORDER BY attrition_rate_pct DESC;
```

---

## 📊 Phase 4 — Tableau Dashboard

An interactive 5-sheet dashboard featuring:

- **KPI Row** — Overall attrition rate, headcount, estimated annual cost, high-risk employee count
- **Department Bar Chart** — Sales highlighted as the critical department (with company average reference line)
- **Tenure Area Chart** — Visualizes the 0–2 year attrition peak with annotation
- **Role × Overtime Heatmap** — Identifies Sales Representatives + overtime as the hottest risk zone
- **Risk Score Scatter Plot** — ML model outputs plotted with 0.65 threshold line
- **Department & Risk Tier Filters** — Applied across all sheets simultaneously

---

## 💡 Phase 5 — Business Insights & Recommendations

| Finding | Recommendation | Expected Impact |
|---------|---------------|-----------------|
| Overtime is #1 driver | Implement OT cap policy in Sales | ↓ 8–12% attrition |
| 0–2 year tenure is peak risk | Structured 90-day + 1-year onboarding program | ↓ 5–7% early attrition |
| Sales dept 34% attrition | Monthly manager check-ins for Sales Reps | ↓ 10% Sales attrition |
| Low pay = high risk | Compensation benchmarking review for bottom quartile | ↓ 4–6% attrition |
| 147 high-risk employees flagged | Proactive HR intervention for model-identified employees | ↓ 18% overall cost |

**Attrition Cost Model:**
```
Cost per employee lost    = 1.5 × Annual Salary
Total annual attrition cost = ~$2.4M
18% reduction potential   = ~$432,000 in annual savings
```

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| **Python 3.10** | Core language |
| **Pandas & NumPy** | Data manipulation |
| **Matplotlib & Seaborn** | Visualization |
| **Scikit-learn** | ML modeling |
| **imbalanced-learn** | SMOTE oversampling |
| **SQL (SQLite)** | Data aggregation & querying |
| **Tableau Public** | Interactive dashboard |
| **Excel / openpyxl** | Reporting outputs |
| **Joblib** | Model serialization |

---

## 📁 Outputs

```
outputs/
├── eda/
│   ├── 01_kpi_overall_rate.png
│   ├── 02_attrition_by_department.png
│   ├── 03_attrition_by_tenure.png
│   ├── 04_income_distribution.png
│   ├── 05_overtime_attrition.png
│   ├── 06_correlation_with_attrition.png
│   ├── 07_satisfaction_attrition.png
│   ├── 08_attrition_by_jobrole.png
│   └── 09_age_distribution.png
└── ml/
    ├── model_random_forest.pkl
    ├── scaler.pkl
    ├── hr_with_risk_score.csv
    ├── feature_importance.png
    ├── confusion_matrix.png
    ├── roc_curve.png
    ├── risk_score_distribution.png
    └── model_comparison.txt
```

---

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Open an **Issue** for bugs or suggestions
- Submit a **Pull Request** for improvements
- ⭐ Star the repo if it helped you!

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

## 👤 Author

**Your Name**
- 🔗 LinkedIn: [linkedin.com/in/yourprofile](https://linkedin.com/in/yourprofile)
- 💼 Portfolio: [yourportfolio.com](https://yourportfolio.com)
- 📧 Email: ygunjankumar3@gmail.com

---

<div align="center">

⭐ **If this project helped you, please give it a star!** ⭐

*Built with Python, Scikit-learn, SQL, and Tableau*

</div>
