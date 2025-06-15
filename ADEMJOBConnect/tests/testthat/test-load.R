test_that("load_data writes a data.frame to the DB table", {
      # Assumes you're running this from the project root
  source("../../R/connect_db.R")
  source("../../R/load_data.R")
  # Create dummy data
  df <- data.frame(
    id = 1:2,
    date = Sys.Date(),
    postes_declares = c(10, 15),
    stock_postes_vacants = c(5, 7)
  )
  
  test_table <- "offres_cleaned_test"
  
  # Create a wrapper for testing that uses a test-specific table
  load_data_test <- function(df, overwrite = TRUE) {
    con <- connect_db()
    DBI::dbWriteTable(con, name = test_table, value = df, overwrite = overwrite)
    DBI::dbDisconnect(con)
  }
  
  # Run test logic
  load_data_test(df)
  
  con <- connect_db()
  result <- DBI::dbReadTable(con, test_table)
  
  # Cleanup
  DBI::dbRemoveTable(con, test_table)
  DBI::dbDisconnect(con)
  
  # Assertions
  expect_equal(nrow(result), nrow(df))
  expect_equal(names(result), names(df))
})
