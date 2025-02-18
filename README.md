# Behavioral-Risk-Factors-for-Surveillance-System-BRFSS
Statistical analyses of the Behavioral Risk Factors for Surveillance System (BRFSS) for effective monitoring of weight related concerns

The Behavioral Risk Factor Surveillance System (BRFSS) dataset provides a comprehensive list of information of US residents regarding their behavioral traits, demographics, and medical information obtained through interviews conducted by Centers for Disease Control and Prevention (CDC).

## Overview
Behavioural risk factors are traits and habits that can negatively impact a person's health when excessively indulged in. Examples include tobacco use, alcohol consumption, and smoking. These factors can significantly affect body weight, which remains a major health concern in the U.S. and globally. Healthcare professionals widely recommend proper weight maintenance through regular exercise and a suitable diet to promote overall health and maintain a Body Mass Index (BMI) within the normal range of 18.5-24.9.

## BMI Categories
| BMI Range   | Weight Category   |
|------------|-----------------|
| < 18.5    | Underweight      |
| 18.5 – 24.9 | Normal          |
| 25 – 29.9  | Overweight      |
| 30 – 40    | Obesity         |
| > 40      | Extreme Obesity  |

Maintaining a healthy BMI can reduce the risk of various diseases, including diabetes, kidney problems, high blood pressure, heart disease, and certain cancers such as breast, colorectal, and prostate cancer.

## Hypotheses covered
1. Do certain states have similar BMI profile, based on their respective populations and mean BMI of
respondents?
2. Do demographic data such as gender, age, income, urban/rural residence have a significant effect on the BMI
of the population?
3. Can BMI categories and substance use help predict probability of cancer, diabetes, and heart attack
diagnoses? 

## Data Collection & Analysis
The Behavioral Risk Factor Surveillance System (BRFSS) collects health-related data from U.S. residents, including demographics and behavioral risk factors. This data allows researchers to analyze trends in BMI across different states, age groups, income levels, and lifestyle habits (e.g., smoking and alcohol consumption). The BRFSS dataset contains 276 variables that include interview information, location, and demographics, health, and medical information of 437436 respondents. For this study, only 12 variables are selected; Age, US state location,
Gender, Income, Urban/Rural residence, Smoking uses, Alcohol consumption, Heart Attack diagnoses, Diabetes, Cancer diagnoses, BMI, and BMI category. Further, the participants with incomplete information are excluded from this study that brings the number of respondents to 317557. Every variable used in this study, is categorical, except BMI which is continuous.

## Descriptive Statistics

Firstly, descriptive statistics -- mean, standard deviation, maximum, minimum values, and category-wise frequency – for the BMI variable are displayed in **Table 2** (Please refer to Appendix 1 for more details).

The primary dependent variable considered for this study is the **BMI value**, comprising continuous values. The distribution of the BMI variable across the data is depicted in **Figure 1**. It is observed that the data has a high **positive skewness (1.374)**. The number of respondents in each BMI category is depicted in **Table 2**. 

Further, it is observed that the number of respondents with BMI above 40 (extreme obesity) is only **16,295**, which accounts for only **5%** of the total respondents in this study. The skewness of the BMI distribution decreases significantly (**0.32**) if these **5% respondents** are excluded. In this manner, the presence of skewness in the BMI data can be attributed to only a few values (**≤5%**) in comparison to the overall size of the dataset.

## Table 2: Descriptive Statistics of BMI (Variable of Interest)

| Variable | Mean | Standard Deviation | Maximum | Minimum |
|----------|------|-------------------|---------|---------|
| BMI      | 28.428 | 6.3605 | 98.73 | 12.11 |

### BMI Category Frequencies

| BMI Category        | Frequency |
|---------------------|-----------|
| Underweight        | 4,760     |
| Normal            | 94,222    |
| Overweight        | 114,400   |
| Obese             | 87,880    |
| Extremely Obese   | 16,295    |

For this study, according to **BRFSS data**, the number of BMI categories considered are **four** (*Underweight, Normal, Overweight, and Obese*).

<img width="372" alt="Screenshot 2025-02-18 at 5 28 14 PM" src="https://github.com/user-attachments/assets/10402397-7cd1-4bbf-a1d0-d1adeffee1a5" />


## Implications
The insights derived from this analysis are crucial for government agencies such as the CDC, NIH, and FDA. They help inform public health policies, awareness programs, and resource allocation for medical interventions. By identifying trends and risk factors, appropriate measures can be taken at state and federal levels to promote healthier lifestyles and prevent obesity-related diseases.

## Research Focus
This study aims to identify patterns and trends in BMI data while assessing the significance of demographic and behavioral risk factors. The research questions and hypotheses explored in this project will contribute to a better understanding of obesity and its related health implications.

## Contribution
- **Data Analysis:** Identifying trends in BMI and their correlation with behavioral risk factors.
- **Public Health Insights:** Informing policymakers and healthcare organizations for better decision-making.
- **Predictive Modeling:** Exploring potential methods to predict health risks based on collected data.

## License
This project is open-source and available under the [MIT License](LICENSE). Contributions are welcome!
