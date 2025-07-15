# Clear environment
rm(list = ls())

# Load libraries
library(TTR)       # For SMA
library(ggplot2)   # For plotting
library(Metrics)   # For MAE and RMSE

# Load your data
data <- read.csv("C:/Users/Dilshan/Desktop/Portfolio Projects/Time Series/GOOGL.csv")

# Convert Date and sort
data$Date <- as.Date(data$Date)
data <- data[order(data$Date), ]

# Calculate 10-day Simple Moving Average
data$SMA_10 <- SMA(data$Close, n = 10)

# Drop initial NA values caused by SMA
data_clean <- na.omit(data)

# Evaluate accuracy: compare SMA vs actual Close
actual <- data_clean$Close
predicted <- data_clean$SMA_10

mae_val <- mae(actual, predicted)
rmse_val <- rmse(actual, predicted)

cat("Mean Absolute Error (MAE):", round(mae_val, 4), "\n")
cat("Root Mean Square Error (RMSE):", round(rmse_val, 4), "\n")

# Plot actual vs SMA
ggplot(data_clean, aes(x = Date)) +
  geom_line(aes(y = Close), color = "blue", size = 1, alpha = 0.6) +
  geom_line(aes(y = SMA_10), color = "red", size = 1) +
  labs(title = "Google Stock Price with 10-Day SMA",
       subtitle = paste("MAE:", round(mae_val, 2), "| RMSE:", round(rmse_val, 2)),
       x = "Date", y = "Price",
       caption = "Blue = Actual Close | Red = 10-Day SMA") +
  theme_minimal()

