# Library necessary for testing
library(testthat)

# Test data frame structure
test_that("Data frames are correctly structured", {
  expect_true("Ever_Hospitalized_Binary" %in% colnames(covid_cases))
  expect_true("Episode_Date" %in% colnames(covid_cases))
  expect_true("Hospitalized_Rate" %in% colnames(daily_hospitalization_rate))
  expect_true("Days_Since_Start" %in% colnames(daily_hospitalization_rate))
})

# Test data type conversion
test_that("Data types are correctly converted", {
  expect_is(covid_cases$Ever_Hospitalized_Binary, "numeric")
  expect_is(covid_cases$Episode_Date, "Date")
  expect_is(daily_hospitalization_rate$Days_Since_Start, "numeric")
})

# Test Aggregation and Rate Calculation
test_that("Hospitalization rate is calculated correctly", {
  # Assuming we know the expected rate for a specific day in the test data
  expected_rate <- 0.5 # Placeholder for the correct expected rate
  actual_rate <- daily_hospitalization_rate %>%
    filter(Episode_Date == as.Date("2020-01-01")) %>%
    pull(Hospitalized_Rate)
  
  expect_equal(actual_rate, expected_rate)
})

# Test Model Output
test_that("Linear model is correctly fitted", {
  expect_is(hospitalization_model, "lm")
  expect_true(length(coef(hospitalization_model)) > 0)
})
