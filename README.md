# 🍔 Group Ordering Feature Adoption Analysis

A Product Analytics case study investigating the adoption, retention, and conversion performance of a newly launched Group Ordering feature in a food delivery application.

Dataset Size:
- 100,000 Users
- 3.3 Million Events
- Multiple User Segments
- Cross-Platform User Activity (iOS, Android, Web)

Tools Used:
- SQL
- Snowflake
- Tableau
- Product Analytics Frameworks

## Business Problem

A food delivery company launched a Group Ordering feature that allows multiple users to place orders together.

While the feature appeared promising, the product team lacked visibility into:

- Feature adoption
- User engagement
- Funnel conversion
- Retention impact
- Key drop-off points

The goal of this analysis was to understand how users interact with the feature, identify adoption bottlenecks, and provide actionable product recommendations.

## Project Objectives

- Measure feature adoption across the user base
- Identify the largest conversion bottlenecks
- Analyze adoption by user segment
- Evaluate platform-level adoption patterns
- Measure retention and engagement impact
- Generate product recommendations based on behavioral data

## Dataset Overview

### Users Table

Contains user-level attributes:

- User ID
- Signup Date
- Platform
- City
- User Segment

### Events Table

Contains event-level product telemetry:

- User ID
- Session ID
- Event Timestamp
- Event Name
- Platform

Key Events:

- restaurant_view
- group_order_click
- invite_sent_to_friend
- checkout
- order_complete

## Analysis Workflow

1. Data Validation & Exploration
2. Funnel Analysis
3. Adoption Analysis
4. Platform Analysis
5. User Segment Analysis
6. Retention Analysis
7. Cohort Analysis
8. Product Impact Analysis
9. Product Recommendations

## Feature Adoption Funnel

<img width="2884" height="1440" alt="01_feature_adoption_funnel" src="https://github.com/user-attachments/assets/fe4011a7-b5d8-435f-b93a-d23fd78862ff" />

The majority of users successfully discovered the feature, but conversion dropped significantly in later stages of the journey.

The funnel analysis revealed that the largest user loss occurred after users interacted with the feature but before reaching checkout.

## Funnel Bottlenecks

<img width="1342" height="668" alt="02_Largest Funnel Drop-Offs" src="https://github.com/user-attachments/assets/2f5c8cb4-7afa-464d-9aaf-dd9fc158ef05" />

### Key Insight

The largest conversion loss occurred between Group Order Click and Checkout, where 47.7% of users abandoned the journey.

### Key Finding

The largest conversion loss occurred between:

Group Order Click → Checkout

This stage experienced a 47.7% user drop-off rate, making it the primary bottleneck in the feature adoption journey.

Potential causes:

- Invitation friction
- Group coordination challenges
- Checkout complexity

## Adoption by User Segment

<img width="1344" height="685" alt="04_Feature Adoption Penetration Rate by User Segment" src="https://github.com/user-attachments/assets/70630e01-4dca-4ae8-a502-19bd00afc247" />

### Key Insight

Power Users demonstrated near-universal adoption while Casual Users adopted the feature at significantly lower rates.

Feature adoption varied significantly across user segments.

### Findings

- Power Users showed near-universal adoption.
- Regular Users also demonstrated strong engagement.
- Casual Users adopted the feature at substantially lower rates.

This suggests the feature naturally appeals to highly engaged users while creating less perceived value for infrequent users.

## Cohort Retention Analysis

Retention patterns remained relatively stable across cohorts.

Users who interacted with the Group Ordering feature demonstrated stronger long-term engagement compared to the overall user population.

This suggests the feature may contribute positively to user stickiness and repeat engagement.

## Platform Analysis

Feature adoption remained consistent across Android, iOS, and Web platforms.

No meaningful platform-specific adoption gaps were observed.

This indicates that platform type was not a major driver of feature usage behavior.

## Key Findings

- 82.6% of users adopted the Group Ordering feature.
- Power Users recorded the highest adoption rates.
- Casual Users were significantly less likely to adopt.
- The largest drop-off occurred between Group Order Click and Checkout.
- Platform had minimal impact on adoption behavior.
- Feature adopters demonstrated stronger engagement patterns than non-adopters.

## Product Recommendations

### 1. Reduce Checkout Friction

The largest drop-off occurred before checkout.

Potential improvements:

- Simplify group checkout flows
- Reduce required user actions
- Improve checkout visibility

### 2. Increase Casual User Adoption

Introduce:

- Feature onboarding
- Contextual prompts
- First-time incentives

### 3. Improve Group Coordination

Reduce invitation friction through:

- Shareable links
- Faster invite acceptance
- Improved group visibility

### 4. Track Feature Success

Monitor:

- Adoption Rate
- Checkout Conversion
- Retention
- Repeat Group Orders

## SQL Analysis Files

- 01_data_validation.sql
- 02_exploratory_analysis.sql
- 03_feature_adoption.sql
- 04_funnel_analysis.sql
- 05_segment_analysis.sql
- 06_platform_analysis.sql
- 07_session_analysis.sql
- 08_abandonment_analysis.sql
- 09_user_journey_analysis.sql
- 10_retention_analysis.sql
- 11_cohort_analysis.sql
- 12_feature_impact_analysis.sql
- 13_product_health_scoring.sql

## Conclusion

This project analyzed over 3.3 million product events to evaluate the performance of a newly launched Group Ordering feature.

The analysis identified a major conversion bottleneck between feature engagement and checkout, highlighted significant adoption differences across user segments, and provided data-driven recommendations to improve feature performance.

The project demonstrates the application of Product Analytics principles, SQL-based behavioral analysis, funnel optimization, retention analysis, and product decision-making.


