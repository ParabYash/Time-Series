library('forecast')
library('tseries')

# Load the data-set
set.seed(2023)
df = read.csv('em_house_prices.csv')
str(df)
# Convert structure from data frame to time series
df = ts(df$average_price_gbp, start = c(2010, 1), frequency = 12)
str(df)

#Plotting the Time Series
plot(df, type='l',main='Monthly Mean House Sale Prices,East Midlands(Jan 2010-Dec 2019)',ylab='Price in £GBP')
points(df, cex=0.5, col='navy')

# Plot Sample ACF & PACF 
acf(as.numeric(df), main='Sample ACF') 
pacf(as.numeric(df), main='Sample PACF') 

#Statistical Test for Stationary 
PP.test(df)
adf.test(df)

#Differencing of Time Series
var(df)
for(i in 1:5){
  dxt = diff(df, differences = i)
  print(paste('Order of difference =',i,'and variance =',round(var(dxt), 4) ))
}

dxt = diff(df, differences = 1,lag = 1) 

#Plotting the differenced Time Series
plot(dxt, type='l',main='Diff Mean House Price',ylab='Price in £GBP')
points(dxt, cex=0.5, col='navy')

# Plot Sample ACF & PACF 
acf(as.numeric(dxt), lag.max = 60,main='Sample ACF')
abline(v=c(12,24,36,48),lty=2) 
pacf(as.numeric(dxt), lag.max = 48, main='Sample PACF') # cuts off indicating AR process

#Stationary Test 
PP.test(dxt)
adf.test(dxt)

#Model Fitting
fit1 = arima(x = dxt, order = c(1,0,0)) # aic = 2043
fit2 = arima(x = dxt, order = c(2,0,0)) # aic = 2040
fit3 = arima(x = dxt, order = c(6,0,0)) # aic = 2031
fit = arima(x = dxt, order = c(12,0,0)) # aic = 2013 (lowest)
fit5 = arima(x = dxt, order = c(20,0,0)) # aic = 2022

fit1
fit2
fit3
fit
fit5

# checking model fit
# 1.ACF of Errors
tsdiag(fit)


# 2. sample distribution
hist(fit$residuals, freq = F, main='Error Distribution')
lines(density(fit$residuals), col = 'navy', lwd=2)

seq = seq(-3500,3500,0.1)
pdf = dnorm(seq, mean = mean(fit$residuals,na.rm = T), sd = sd(fit$residuals,na.rm = T))
lines(seq, pdf, type='l',lwd=2, col='red')

legend('topright', c('Sample Density','Fitted Normal'),lty=1, lwd=2, col=c('navy','red'),bty='n')

# 3. qq plot
qqnorm(fitted(fit))
qqline(fitted(fit))

# 4. actual vs fitted
plot(as.numeric(dxt), fitted(fit), main='Actual vs. Fitted')
abline(0,1, col='red')

# 5. accuracy metrics
library("Metrics")
mape(as.numeric(dxt), fitted(fit))
rmse(as.numeric(dxt), fitted(fit))

# 6. baseline model
baseline = naive(dxt)
summary(baseline)

# Forecasting

pred = forecast(fit,h=6)
plot(pred)

#Back to Original Units
preds = as.numeric(tail(df, 1)) + cumsum(pred$mean)
low80  = as.numeric(tail(df, 1)) + cumsum(pred$lower[,1])
high80 = as.numeric(tail(df, 1)) + cumsum(pred$upper[,1])
low95  = as.numeric(tail(df, 1)) + cumsum(pred$lower[,2])
high95 = as.numeric(tail(df, 1)) + cumsum(pred$upper[,2])

plot(df, xlim=c(2010, 2020.5), main='Forecasts from ARIMA(12,0,0)', ylim=c(min(df), max(high95)))
lines(seq(2020, 2020+5/12, 1/12), preds, col='red',lwd=2)
lines(seq(2020, 2020+5/12, 1/12), low80, col='lightblue',lwd=2)
lines(seq(2020, 2020+5/12, 1/12), high80, col='lightblue',lwd=2)
lines(seq(2020, 2020+5/12, 1/12), low95, col='navy',lwd=2)
lines(seq(2020, 2020+5/12, 1/12), high95, col='navy',lwd=2)

preds = ts(preds, start=c(2020, 1), frequency=12)

ts.plot(preds, col='red', ylim=c(min(low95), max(high95)), main='Forecasts')
points(preds, cex=0.5,col='red')
lines(seq(2020, 2020.5, 0.1), low80, col='lightblue',lwd=2)
lines(seq(2020, 2020.5, 0.1), high80, col='lightblue',lwd=2)
lines(seq(2020, 2020.5, 0.1), low95, col='navy',lwd=2)
lines(seq(2020, 2020.5, 0.1), high95, col='navy',lwd=2)
