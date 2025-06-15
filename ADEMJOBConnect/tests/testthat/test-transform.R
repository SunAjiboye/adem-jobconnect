test_that("transform_data filters out rows with postes_declares <= 0", {
  source("../../R/transform_data.R")
  
  df <- data.frame(
    id = 1:3,
    date = as.character(Sys.Date()),
    postes_declares = c(10, 0, -5),
    stock_postes_vacants = c(5, 0, 1)
  )
  
  clean <- transform_data(df)
  expect_equal(nrow(clean), 1)
  expect_true(all(clean$postes_declares > 0))
})
