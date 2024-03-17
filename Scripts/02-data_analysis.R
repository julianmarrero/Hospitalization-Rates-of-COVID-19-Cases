# Load necessary libraries
library(dplyr)
library(ggplot2)
library(readr)

# Read the dataset
# Adjust the file path to where your CSV file is located
covid_cases <- read_csv("../Data/COVID19 cases.csv")

# Preprocess data
# Convert 'Ever_Hospitalized' into a binary variable (1 for Yes, 0 for No)
covid_cases$Ever_Hospitalized_Binary <- ifelse(covid_cases$'Ever Hospitalized' == "Yes", 1, 0)

# Convert 'Episode_Date' to Date type
covid_cases$Episode_Date <- as.Date(covid_cases$'Episode Date', format = "%Y-%m-%d")

# Aggregate data to calculate the daily hospitalization rate
daily_hospitalization_rate <- covid_cases %>%
  group_by(Episode_Date) %>%
  summarise(Hospitalized_Rate = mean(Ever_Hospitalized_Binary, na.rm = TRUE),
            .groups = 'drop')

# Convert 'Episode_Date' to a numeric variable (days since start)
daily_hospitalization_rate$Days_Since_Start <- as.numeric(daily_hospitalization_rate$Episode_Date - min(daily_hospitalization_rate$Episode_Date))

# Linear regression model
hospitalization_model <- lm(Hospitalized_Rate ~ Days_Since_Start, data=daily_hospitalization_rate)

# Summary of the model
summary(hospitalization_model)

# Plotting the data and the regression line
ggplot(daily_hospitalization_rate, aes(x = Days_Since_Start, y = Hospitalized_Rate)) +
  geom_point() +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "Daily COVID-19 Hospitalization Rate Over Time",
       x = "Days Since Start of Dataset",
       y = "Hospitalization Rate") +
  theme_minimal()
