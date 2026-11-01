# SaaS Customer and Subscription Analysis (2023–2026)

**SQL | Excel | Data Analysis | Business Reporting**

## Executive Summary

This project analyses SaaS business performance, focusing on customer acquisition, subscription retention, revenue, payment activity, product usage and customer support.

The analysis identified strong revenue growth alongside a high proportion of cancelled subscriptions and recurring payment and billing issues.

A further investigation found that net payment value increased by **14.7% in January–August 2026 compared with the same period in 2025**, despite a 13.5% decline in paying customers. Increased payment frequency was a notable contributor to this growth, while average payment values and subscription plan distribution remained relatively stable.

The findings highlight an important business challenge: generating revenue growth while retaining customers and improving the payment experience.

## Business Problem

### Why did I do this project?

A SaaS business can acquire customers and generate strong revenue without necessarily achieving sustainable growth.

Subscription cancellations can weaken recurring revenue, failed payments can interrupt collections, and customer support issues can affect the overall customer experience. Similarly, high customer acquisition numbers do not automatically translate into long-term customer value.

I wanted to use a realistic relational dataset to investigate how these areas connect and identify where the business could improve its performance.

### What problem am I trying to solve?

The main objective is to understand whether customer acquisition and revenue growth are translating into sustainable customer value.

The analysis focuses on four areas:

- **Customer growth:** Which customer segments and acquisition channels contribute most?
- **Subscription performance:** How many subscriptions remain active, and how many have been cancelled?
- **Revenue and payment health:** What drives payment performance, and where could payment issues affect collections?
- **Customer experience:** Which support issues may be affecting customer satisfaction and retention?

## Business Questions

- How is the customer base growing?
- Which plans, industries and acquisition channels contribute most to revenue?
- How significant are subscription cancellations?
- Are payment failures and refunds creating potential revenue risks?
- Where are customer support issues concentrated?
- What factors may explain changes in payment performance?
- How can the business improve retention and sustainable growth?

## Methodology

### SQL Analysis

SQL Server and SSMS were used to explore and analyse the related customer, subscription, payment, product usage, support and marketing tables.

Technical skills demonstrated:

- Data exploration and quality checks.
- Multi-table JOINs.
- Aggregations using COUNT, SUM and AVG.
- GROUP BY, ORDER BY and WHERE.
- CASE statements and conditional aggregation.
- Date-based analysis using YEAR, MONTH, DATENAME and DATEDIFF.
- Subqueries and CTEs.
- KPI calculations and year-on-year comparisons.

The analysis was driven by business questions, with follow-up queries used to investigate unexpected results and understand contributing factors.

### Excel Visualisation

Excel and XLOOKUP were used to combine relevant data for analysis.

Pivot tables and charts were created to compare performance, identify trends and communicate key findings through a business dashboard.

## Key Findings and Business Actions

### 1. Payment value increased despite fewer paying customers

Comparing January–August 2025 with the same period in 2026:

Net payment value increased from R2.99 million to R3.42 million (+14.7%).

Paying customers declined from 973 to 842 (-13.5%).

Net payment value per paying customer increased from R3,069.57 to R4,067.63.

Insight: The company generated more payment value from a smaller paying customer base, making customer retention an important area to monitor.

### 2. Subscription cancellations are a major retention concern

Of 3,300 recorded subscriptions, 2,528 were cancelled and 772 were active. Approximately 77% of recorded subscriptions were cancelled.

This is a historical status distribution, not a formal churn rate, because subscriptions began at different times.

**Business insight:** The high number of cancelled subscriptions highlights customer retention as an important area for further investigation.

**Recommendation:** Investigate cancellation timing, customer segments, acquisition channels, and product usage to understand why customers leave.

### 3. Payment activity increased despite fewer paying customers

Comparing January–August 2025 with January–August 2026:

| Metric | 2025 | 2026 |
|---|---:|---:|
| Net payment value | R2.99m | R3.42m |
| Paying customers | 973 | 842 |
| Subscriptions with payments | 1,500 | 1,280 |
| Average payments per subscription | 2.60 | 3.45 |
| Average net payment per transaction | R766.41 | R774.52 |

Net payment value increased by **14.7%**, while paying customers declined by **13.5%**.

Average payments per subscription increased by approximately **33%**, while average payment value remained relatively stable.

The subscription plan distribution also remained broadly similar, with no major shift towards higher-priced plans.

**Business insight:** Increased payment frequency was a notable contributor to higher payment value, rather than substantially larger individual transactions or a major change in plan mix.

**Recommended action:** Monitor payment frequency and investigate the decline in paying customers to understand whether the increase in payment value can be sustained.

### 4. Payment and billing issues may be affecting customer value

The analysis identified:

- 1,074 failed payments.
- 499 refunded payments.
- Approximately R813,604 associated with failed payments.
- Approximately R385,799 associated with refunds.

Billing was also the most common support issue, with 856 tickets. Its average satisfaction score was approximately 2.9 out of 5.

Payment success rates changed very little, increasing from 91.38% in 2025 to 91.47% in 2026.

**Business insight:** Payment and billing problems appear in both financial and customer-support data, making them important areas to investigate. Failed and refunded transaction values should not automatically be treated as actual revenue losses.

**Recommended action:** Improve payment notifications and recovery processes, investigate refund reasons, and determine whether repeated payment issues are followed by subscription cancellations.

### 5. Acquisition should be measured by customer value, not just volume

Referral and Organic Search were among the largest acquisition channels, with 526 and 525 customers respectively.

Referral generated approximately R2.97 million in net revenue, while Organic Search generated approximately R2.82 million.

**Business insight:** Acquisition volume alone does not show whether a channel brings in customers who remain subscribed or generate long-term value.

**Recommended action:** Evaluate acquisition channels using a broader performance measure:

**Acquisition Cost → Customer Retention → Revenue → Customer Lifetime Value**

## Overall Business Priorities

Based on the findings, four areas deserve attention:

1. **Improve customer retention:** Understand why customers cancel and identify those most at risk.
2. **Protect payment performance:** Monitor failed payments, refunds and payment frequency.
3. **Improve the customer experience:** Investigate billing complaints and support satisfaction.
4. **Measure acquisition quality:** Focus on customer value and retention rather than acquisition volume alone.

## Technical and Analytical Skills Demonstrated

This project demonstrates my ability to:

- Work with related business tables using SQL joins.
- Calculate and compare business KPIs.
- Investigate unexpected changes in business performance.
- Use follow-up queries to explore possible explanations.
- Identify potential revenue and retention risks.
- Translate numerical findings into business implications and recommendations.
- Communicate findings through Excel dashboards and business reporting.

## Limitations

- The dataset is historical rather than live.
- The 2026 payment comparison covers January–August, not the full year.
- The 77% cancelled-subscription figure is not a formal churn rate.
- Failed and refunded payment values represent recorded transaction amounts, not necessarily confirmed revenue losses.
- The analysis identifies patterns but does not establish causation.
- More detailed cancellation reasons and customer lifetime value data would support deeper investigation.
- The Excel dashboard is static and does not currently offer interactive filtering or drill-down.

## Next Steps

The next stage of analysis will focus on understanding why the identified patterns are occurring.

Potential investigations include:

- Customer tenure before cancellation.
- Payment failures compared with subscription cancellations.
- Product usage compared with customer retention.
- Customer lifetime value by acquisition channel.
- Acquisition cost compared with long-term customer value.
- Cancellation reasons and customer segments.

The analysis can also be developed into an interactive Power BI dashboard with dynamic KPIs, filters and drill-down capabilities.

## Conclusion

This project demonstrates how SQL and Excel can be used to move beyond reporting business metrics and investigate what they mean for company performance.

The analysis identified strong payment growth alongside increased payment frequency, but also highlighted customer cancellations, payment issues and billing support as areas requiring attention.

The main business challenge is to sustain revenue growth while improving customer retention and the overall subscription experience.

*Dataset period: January 2023 – August 2026. Payment comparisons use January–August across each year.*

## Project Deliverables

```text
SaaS-Analytics/
│
├── README.md
├── SaaS_Analysis.sql
├── SaaS_Dashboard.xlsx
├── Business_Report.pdf
├── quarterly-revenue.png
├── subscription-status.png
├── payment-issues.png
└── acquisition-channels.png
```

### Dashboard Preview

<img src="SaaS%20Business%20Analytics%20Dashboard.png" width="600">

## Final Takeaway

The analysis shows a SaaS business generating meaningful revenue across multiple plans and acquisition channels, but sustainable growth depends on more than acquiring customers.

The biggest opportunities are to **retain customers, reduce payment and billing problems, protect recurring revenue and understand which acquisition channels create the most valuable customers**.

The next step is to move beyond describing what happened and investigate why it happened, creating stronger insights that can support better retention, revenue and customer experience decisions.

**Tools:** SQL Server | Excel | XLOOKUP | Pivot Tables | Data Visualisation | Business Analysis
