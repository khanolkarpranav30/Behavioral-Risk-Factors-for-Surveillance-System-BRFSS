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

## Cluster Analysis
From the results depicted in Figure 2, it is observed that the mean BMI values of all four clusters are nearly the same. The major factor in grouping observed is the population, where New York had the highest number of respondents forming its own cluster. The minor observations made in these four clusters are tabulated in Table.

<img width="571" alt="Screenshot 2025-02-18 at 5 38 20 PM" src="https://github.com/user-attachments/assets/6e4da1eb-8352-4f06-b7a7-d12d4ce92299" />


## ANOVA Analysis
As expected, all variables of interest violated the assumption of homogeneity (Appendix 2). Our ANOVA results showed:

- **Main Effects:**
  - Age was significant: F(12, 12246662) = 34.231, p< .001, ηA² = .001.
  - Gender was less significant: F(1, 12246662) = 4.660, p < .05, ηA² < .001.
  - Urban was significant: F(1, 12246662) = 7.559, p < .01, ηA² < .001.
  - Income was not significant: F(4, 12246662) = 2.237, p = 0.062, ηA² < .001.

- **Most Significant Interactions:**
  - Age and Gender: F(12, 12246662) = 4.17, p< .001, ηA² = .0002.
  - Gender and Income: F(4, 12246662) = 7.69, p < .001, ηA² = .0002.
  - Age, Gender, and Income: F(4, 12246662) = 1.532, p < .001, ηA² = .0002.

- **Less Significant Interactions:**
  - Age and Urban: F(12, 12246662) = 2.100, p < .05, ηA² = .0002.
  - Age and Income: F(48, 12246662) = 1.550, p < .01, ηA² = .0002.
  - Age, Gender, and Income: F(48, 12246662) = 4.769, p< .001, ηA² = .0002.

For younger age groups (18-39), BMI score differences between men and women were not significant. However, for older age groups, significant differences emerged. For instance, in the 45-49 age group:
- Men (M = 29.69, SD = 6.13, N=10968) had significantly higher BMI scores than women (M=29.25, SD=6.79, N=11653), p <.001, d = .06.

The interaction between Gender and Income was significant:
- For women, higher income groups had significantly lower BMI scores. The BMI score differences were observed between:
  - < $15K (M = 30.057, SD = 8.29, N=17159) and $15K-$25K (M = 29.189, SD = 7.49 , N=28662), p<.001, d=.11.
  - $15K-$25K and $25K-$35K (M = 28.757, SD = 7.00 , N=18271), p<.001, d =.06.
  - $35K-$50K (M= 28.613, SD = 6.74, N=22852) p<.01 and >$50K (M = 27.435, SD= 6.19, N=77203), p<.01, d=.19.
- For men, the only significant difference was between:
  - $25K-35K (M = 28.409, SD = 5.937, N = 14526) and $35K-$50K (M = 28.619, SD = 5.808, SD = 21083)，p <.05, d = .04.

## Logistic Regression Analysis
The results of the logistic regression models are summarized in Table 4.

- **Residual Deviance:** High for all predictors.
- **Predictivity:** Adding BMI improved predictivity as reflected with lower AIC scores.
- **Heart Attack Diagnosis:** Adding BMI improved the regression model, X²(1, N=317,557) = 497.51, p < .001.
- **Diabetes Diagnosis:** X²(1, N=317,557) = 3814.63, p < .001.
- **Cancer Diagnosis:** p = 0.334 (not improved by adding BMI).
- 
<img width="585" alt="Screenshot 2025-02-18 at 5 41 02 PM" src="https://github.com/user-attachments/assets/49ce2a15-7b18-4be1-9dd0-dacc8e068936" />


## Summary and Key Findings
The BRFSS dataset was utilized to analyze respondents' BMI data. The dataset was preprocessed to obtain 12 variables and included only complete responses for consistency across analyses.

- **Clustering Analysis:** Grouped US states based on mean BMI values to assist in health initiatives. All clusters had mean BMI values in the overweight category (~28). However, due to data skewness and limited state representation (e.g., only 12,000 of California's 40 million population responded), findings cannot be generalized.
- **ANOVA Analysis:** Demographic factors (Age, Gender, Income, Urban) significantly affect BMI scores. The interaction between Gender and Income suggests a societal issue—women’s BMI is associated with income, but men’s is not. Further research is needed to understand the causal mechanisms.
- **Regression Analysis:** Adding BMI as a predictor improved logistic regression models for predicting Heart Attack and Diabetes but not Cancer. Chi-squared statistics and pseudo-R² values supported this. However, low pseudo-R² values and high AIC scores indicate variability in the dataset. Additional factors (e.g., family medical history, diet, exercise) were not included but may contribute to BMI predictions.

---

### References
- BRFSS Dataset: [CDC BRFSS](https://www.cdc.gov/brfss/index.html)
- BMI Classification: [WHO BMI Guidelines](https://www.who.int/news-room/fact-sheets/detail/obesity-and-overweight)
- ANOVA Interpretation: [Understanding ANOVA](https://statisticsbyjim.com/anova/one-way-anova/)
- Logistic Regression: [Regression Analysis](https://towardsdatascience.com/logistic-regression-detailed-overview-46c4da4303bc)

---

## Implications
The insights derived from this analysis are crucial for government agencies such as the CDC, NIH, and FDA. They help inform public health policies, awareness programs, and resource allocation for medical interventions. By identifying trends and risk factors, appropriate measures can be taken at state and federal levels to promote healthier lifestyles and prevent obesity-related diseases.

## Research Focus
This study aims to identify patterns and trends in BMI data while assessing the significance of demographic and behavioral risk factors. The research questions and hypotheses explored in this project will contribute to a better understanding of obesity and its related health implications.

## Contribution
- **Data Analysis:** Identifying trends in BMI and their correlation with behavioral risk factors.
- **Public Health Insights:** Informing policymakers and healthcare organizations for better decision-making.
- **Predictive Modeling:** Exploring potential methods to predict health risks based on collected data.

## Conclusion
This study highlights the influence of behavioral and demographic factors on BMI. The findings provide insights into public health policies and potential risk factors associated with obesity-related diseases. However, due to dataset limitations, further research incorporating additional variables is recommended.


## License
This project is open-source and available under the [MIT License](LICENSE). Contributions are welcome!
