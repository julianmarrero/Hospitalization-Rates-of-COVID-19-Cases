# Load necessary libraries
library(tidyverse) # For data manipulation and ggplot2
library(lubridate) # For easy date manipulation

# Simulate data
set.seed(42) 
dates <- seq(as.Date("2020-01-01"), by="day", length.out=365)
cases <- round(10 + (1:365) * 0.5 + rnorm(365, mean=0, sd=5))

# Creating a data frame
simulated_data <- tibble(Reported_Date = dates, Number_of_Cases = pmax(cases, 0))

# Writing simulated data to a csv file
write.csv(simulated_data, "simulated_covid_cases.csv", row.names = FALSE)

# Print head of the simulated data
head(simulated_data)
