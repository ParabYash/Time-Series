# Time Series Analysis Project: Midlands Temperature and East Midlands House Prices

## Project Overview

This repository contains time series analyses of two datasets: 
1. **Annual Mean Temperature in Midlands, England (1900-2021)** 
2. **Monthly Average House Prices in East Midlands (Jan 2010 - Dec 2020)** 

The project highlights exploratory data analysis, stationarity testing, model fitting, and forecasting techniques.

## Datasets

### 1. **Midlands Annual Mean Temperature (1900-2021)**

- **Dataset**: Annual mean temperature in degrees Celsius recorded by the UK Meteorological Office for the Midlands region.
- **Objective**: Analyze and model temperature variations over time and forecast future temperatures using an ARIMA model.
- **File**: `cet_temp.csv`

### 2. **East Midlands Monthly Average House Prices (2010-2020)**

- **Dataset**: Monthly average house prices (in GBP) in the East Midlands from January 2010 to December 2020.
- **Objective**: Analyze and forecast house prices for the first half of 2021 using an ARIMA model.
- **File**: `em_house_prices.csv`


## Objectives

### Midlands Temperature Analysis:
- **Exploratory Data Analysis (EDA)**: Explore trends in the temperature data and assess whether the data is stationary.
- **Model Fitting**: Fit an ARIMA model to the time series data to model temperature trends.
- **Forecasting**: Predict future temperature values using the fitted ARIMA model.

### East Midlands House Price Analysis:
- **Exploratory Data Analysis (EDA)**: Examine house price trends and identify patterns.
- **Differencing**: Transform the data to achieve stationarity.
- **Model Fitting**: Fit an ARIMA model to forecast house prices.
- **Forecasting**: Predict house prices for the first six months of 2021 with associated uncertainty bounds.

## Methodology

### 1. **Exploratory Data Analysis (EDA)**:
- **Visualization**: Time series plots were used to observe trends and fluctuations over time.
- **ACF and PACF**: Analyzed autocorrelation and partial autocorrelation plots to determine patterns in the data.
- **Stationarity Tests**: 
  - *Phillips-Perron (PP) test*: Used to assess stationarity.
  - *Augmented Dickey-Fuller (ADF) test*: Another test to confirm stationarity.
  
### 2. **Model Fitting**:
- **ARIMA Model**: The `auto.arima()` function was used to identify the best-fitting ARIMA model for both datasets based on information criteria (AIC, BIC).
- **Parameter Tuning**: Various ARIMA models were evaluated to choose the best-performing model.

### 3. **Forecasting**:
- **Midlands Temperature Forecast**: The ARIMA(1,0,1) model was selected and used to forecast temperature trends.
- **East Midlands House Price Forecast**: The ARIMA(12,0,0) model was identified and used to forecast house prices, including 80% and 95% prediction intervals for the first six months of 2021.

## Key Findings

### Midlands Temperature:
- A slight upward trend in temperature was observed.
- ARIMA(1,0,1) was the best fit for the temperature data, and it produced reliable forecasts for the future.

### East Midlands House Prices:
- A clear upward trend in house prices from 2010 to 2020, especially after 2015.
- ARIMA(12,0,0) was the best model, capturing the yearly autocorrelation in house prices and providing accurate forecasts for early 2021.

## Visualizations

- **Time Series Plots**: Visualized trends over time for both datasets.
- **ACF and PACF Plots**: Provided insights into autocorrelation patterns in the data.
- **Residual Analysis**: Diagnostic plots to check the fit of the ARIMA models.
- **Forecast Plots**: Displayed predicted values along with prediction intervals.

## How to Use

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/ParabYash/Time-Series-Analysis.git
   ```

2. **Install Required Packages**:
   Ensure you have the necessary R packages installed:
   ```R
   install.packages(c("forecast", "tseries", "Metrics"))
   ```

3. **Run the R Script**:
   Open `Coursework_RFile.R` in RStudio or any R environment, and run the code to replicate the analyses and forecasts.

4. **Read the Report**:
   Refer to `MTH4005_Coursework_Report.pdf` for detailed explanations and results.

## Contact Information

For any questions or suggestions, feel free to contact me:

- **Email**: yashparab05@gmail.com
- **LinkedIn**: [Yash Parab](https://linkedin.com/in/yash-parab-9a5a6a209)
