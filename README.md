# ROC Curve Analysis in R

This repository contains an R script demonstrating how to perform **ROC (Receiver Operating Characteristic) curve analysis** using built-in datasets. The code covers **single-variable and multivariable models**, including calculation of **AUC (Area Under the Curve)**, **confidence intervals**, and **optimal thresholds**.

## 1. Datasets Used

### 1.1 PimaIndiansDiabetes (`mlbench` package)
- Contains diagnostic data for diabetes in Pima Indian women.  
- Used to illustrate ROC curves with a single predictor (`glucose`) and compare multiple predictors.

### 1.2 BreastCancer (`mlbench` package)
- Contains diagnostic data for breast cancer.  
- Used to illustrate ROC curves with a single predictor (`Cell.size`) and multivariable logistic regression models.

## 2. Features

The script demonstrates:

- **Basic ROC curve creation** for a single variable.  
- **Smoothed ROC curves** for visual clarity.  
- **Calculation of AUC** to quantify the predictive power of variables.  
- **Coordinates extraction** for sensitivity, specificity, and thresholds.  
- **Confidence intervals for sensitivity** to assess uncertainty.  
- **Optimal threshold selection** to determine the best cutoff value.  
- **Comparison of ROC curves** between two predictors.  
- **Multivariable ROC curves** using logistic regression models for improved discrimination.

## 3. How to Use

1. Install required packages:

```r
install.packages(c("pROC", "mlbench"))
```

2. Load the script in RStudio and run it step by step.

Explore the outputs:
- Plots of ROC curves with AUC and confidence intervals.
- Tables of sensitivity, specificity, and optimal thresholds.
- Comparison of single-variable versus multivariable models.

## 4. Example Outputs

- ROC curve for glucose predicting diabetes
- ROC curve for Cell.size predicting breast cancer
- ROC curve for a multivariable logistic regression model
- Comparison of AUC between predictors

## 5. Educational Purpose
This script is designed for teaching and learning purposes, demonstrating how to evaluate the diagnostic performance of variables in both binary classification problems and multivariable models.
