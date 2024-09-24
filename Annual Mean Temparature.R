#Importing Libraries
library(forecast)
library(tseries)

# Load the data-set
cet_temp <- read.csv("cet_temp.csv")
str(cet_temp)
# Convert structure from data frame to time series
ts_data = ts(cet_temp$avg_annual_temp_C, start = c(1900), frequency = 1)
str(ts_data)
#Plotting the Time Series
plot(ts_data, main = "Annual Mean Temperature in Midlands", 
     ylab = "Temperature (°C)", xlab = "Year",type='l',lwd=2)
points(ts_data, cex=0.8, col='navy')


# Plot Sample ACF & PACF 
acf(ts_data, main = "Sample ACF")
pacf(ts_data, main = "Sample PACF")

# Statistical test for stationarity
PP.test(ts_data)
adf.test(ts_data)

# model fitting
fit = auto.arima(ts_data, trace = T,max.d = 0,ic = 'bic')
fit

# checking model fit

# 1. average error = 0
mean(fit$residuals, na.rm = T) 

# 2. autocorrelation of errors
tsdiag(fit)

# 3. sample distribution
hist(fit$residuals, freq = F, main='Error Distribution')
lines(density(fit$residuals), col = 'navy', lwd=2)

seq = seq(-3,3,0.1)
pdf = dnorm(seq, mean = mean(fit$residuals,na.rm = T), sd = sd(fit$residuals,na.rm = T))
lines(seq, pdf, type='l',lwd=2, col='red')

legend('topright', c('Sample Density','Fitted Normal'),lty=1, lwd=2, col=c('navy','red'),bty='n')

# 4. qq plot
qqnorm(fit$fitted)
qqline(fit$fitted)

# 5. actual vs fitted
plot(as.numeric(ts_data), fit$fitted, main='Actual vs. Fitted', xlab='Actual',ylab='Fitted')
abline(0,1, col='red')

# 6. accuracy metrics
library("Metrics")
mape(as.numeric(ts_data), fit$fitted)
rmse(as.numeric(ts_data), fit$fitted)

# baseline model
baseline = naive(ts_data)
summary(baseline)