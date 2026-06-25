# Group Ordering Feature Analytics

## Overview
Group Ordering is a collaborative ordering feature that allows multiple users to participate in a shared order.
This project analyzes user behavior across the complete feature lifecycle, from initial discovery to final order completion. The objective is to understand feature adoption, identify conversion bottlenecks, evaluate user retention, and generate actionable product recommendations using SQL and Tableau.

**Tools:** SQL, PostgreSQL, Tableau

## Business Objectives
* Measure overall feature adoption.
* Track user progression across the ordering journey.
* Identify stages with the highest user drop-off.
* Compare adoption behavior across user segments.
* Analyze platform-wise performance.
* Evaluate retention trends through cohort analysis.

## Dataset
The dataset contains user interaction events generated throughout the Group Ordering experience.

### Key Events
* Restaurant View
* Group Order Click
* Invite Sent To Friend
* Checkout
* Order Complete

### Additional Attributes
* User ID
* Event Date
* Platform
* User Segment
* Event Name

---

## Overall Feature Adoption
This analysis measures how many users adopted the Group Ordering feature compared to those who never interacted with it.

<img width="1335" height="675" alt="07_feature_impact (eliminated)" src="https://github.com/user-attachments/assets/c210cf0a-8927-4960-a2df-bc831c2445be" />


### Key Findings
* Feature adoption reached 82.6%, indicating strong feature awareness and discovery.
* Only 17.4% of users never interacted with the feature.
* Adoption is already strong; improving conversion through later stages presents the biggest opportunity.

### Business Interpretation
The feature successfully reaches a large portion of the user base. Rather than increasing awareness, future product efforts should focus on helping users progress further through the ordering journey.

---

## Feature Adoption Funnel
To understand how users progress through the experience, a funnel was created covering every major stage of the ordering journey.

<img width="2884" height="1440" alt="01_feature_adoption_funnel" src="https://github.com/user-attachments/assets/3846fa6c-37c9-42e0-a202-1da1bb6c5a34" />

### Funnel Journey
Restaurant View → Group Order Click → Invite Sent To Friend → Checkout → Order Complete

### Key Findings
* Strong adoption occurs immediately after restaurant discovery.
* User participation remains stable through the invitation stage.
* The largest reduction in user volume occurs before checkout.
* Most users who reach checkout successfully complete their order.

### Business Interpretation
The funnel shows strong top-of-funnel engagement, with most users discovering and initiating group orders.
A significant reduction occurs before checkout, suggesting friction during group coordination, decision-making, or purchase commitment.
Users who successfully reach checkout demonstrate a very high completion rate, indicating that checkout itself is not the primary issue.

---

## Leakage Analysis
Drop-off analysis highlights where users abandon the ordering journey.

<img width="1342" height="668" alt="02_Largest Funnel Drop-Offs" src="https://github.com/user-attachments/assets/1463d531-5ccb-40b8-a78f-e186ea6c60cc" />

### Key Findings
* The largest leakage occurs between Group Order Click and Checkout.
* Nearly half of users fail to progress to checkout after initiating a group order.
* Checkout to Order Completion shows relatively low abandonment.

### Product Opportunity
* The largest growth opportunity exists between Group Order Click and Checkout.
* Reducing friction at this stage could significantly increase completed orders without requiring additional user acquisition.

---

## User Segment Analysis
Users were segmented based on engagement levels to understand which groups adopt the feature most frequently.

<img width="1344" height="685" alt="04_Feature Adoption Penetration Rate by User Segment" src="https://github.com/user-attachments/assets/9594b58f-0ae3-453b-be22-1ed13203c582" />

### Key Findings
* Power users exhibit the highest adoption rate.
* Regular users also demonstrate strong engagement.
* Casual users lag behind both groups.
* Casual users represent the largest opportunity for future growth.

### Business Interpretation
Power and Regular users have already integrated the feature into their ordering behavior.
Increasing feature visibility and encouraging first-time usage among Casual users is likely to generate the highest improvement in adoption.

---

## Platform Analysis
Feature adoption was compared across platforms to determine whether device experience impacts engagement.

<img width="1107" height="661" alt="05_Feature Adoption Penetration Rate by Platform" src="https://github.com/user-attachments/assets/c675232f-9ec0-47e8-8041-da312057401e" />

### Key Findings
* Adoption rates remain highly consistent across Android, iOS, and Web.
* No platform demonstrates a significant advantage or disadvantage.
* User behavior appears driven more by product experience than platform differences.

### Business Interpretation
Since adoption remains consistent across all platforms, platform-specific issues appear minimal.
Future optimization efforts should focus on improving the product experience rather than implementing platform-specific changes.

---

## Cohort Retention Analysis
A cohort retention analysis was performed to evaluate how user engagement changes over time after adoption.

<img width="1387" height="667" alt="03_cohort_retention_heatmap" src="https://github.com/user-attachments/assets/d5fd3dfc-11c0-4b56-b7bb-80a775cf7359" />

### Key Findings
* Retention patterns remain relatively stable across cohorts.
* No major cohort shows unusual churn behavior.
* User engagement gradually declines over time, following a typical retention pattern.
* Retention consistency suggests the feature continues to provide value after initial adoption.

### Business Interpretation
Retention remains relatively stable over time, suggesting that users continue finding value after adopting the feature.
The absence of major retention spikes or sudden declines indicates consistent long-term engagement across user cohorts.

---

## Executive Summary
* Overall feature adoption reached 82.6%, indicating strong user awareness and successful feature discovery.
* The primary conversion bottleneck occurs between Group Order Click and Checkout, where nearly half of users abandon the journey.
* Power users demonstrate the highest adoption rates, while Casual users represent the largest opportunity for future growth.
* Adoption remains highly consistent across Android, iOS, and Web, suggesting minimal platform-specific differences.
* Cohort retention remains stable, indicating sustained engagement after feature adoption.
* Improving progression from group order creation to checkout offers the highest potential impact on increasing completed orders.

---

## Recommendations
* Simplify the checkout experience to reduce funnel leakage.
* Re-engage users who initiate but do not complete group orders.
* Increase feature visibility among Casual users through targeted onboarding and in-app prompts.
* Experiment with incentives that encourage users to complete the checkout process.
* Continue monitoring cohort retention to measure the long-term impact of future product improvements.
