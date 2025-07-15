# Clear environment
rm(list = ls())

# Load libraries
library(TTR)       # For EMA
library(ggplot2)   # For plotting
library(Metrics)   # For MAE and RMSE

# Load your data
data <- read.csv("C:/Users/Dilshan/Desktop/Portfolio Projects/Time Series/GOOGL.csv")

# Convert Date and sort
data$Date <- as.Date(data$Date)
data <- data[order(data$Date), ]

# Calculate 10-day Exponential Moving Average
data$EMA_5 <- EMA(data$Close, n = 5)

# Drop NA values from the beginning of EMA
data_clean <- na.omit(data)

# Evaluate accuracy
actual <- data_clean$Close
predicted <- data_clean$EMA_5

mae_val <- mae(actual, predicted)
rmse_val <- rmse(actual, predicted)

cat("Mean Absolute Error (MAE):", round(mae_val, 4), "\n")
cat("Root Mean Square Error (RMSE):", round(rmse_val, 4), "\n")

# Plot actual vs EMA
ggplot(data_clean, aes(x = Date)) +
  geom_line(aes(y = Close), color = "blue", size = 1, alpha = 0.6) +
  geom_line(aes(y = EMA_5), color = "green", size = 1) +
  labs(title = "Google Stock Price with 10-Day EMA",
       subtitle = paste("MAE:", round(mae_val, 2), "| RMSE:", round(rmse_val, 2)),
       x = "Date", y = "Price",
       caption = "Blue = Actual Close | Green = 5-Day EMA") +
  theme_minimal()
