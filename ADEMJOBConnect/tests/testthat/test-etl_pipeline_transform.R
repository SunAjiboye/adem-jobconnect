test_that("ETL pipeline writes non-empty data to the cleaned table", {
  run_etl_pipeline()  # 👈 calls your exported function from the package

  con <- connect_db()
  result <- DBI::dbGetQuery(con, "SELECT COUNT(*) AS n FROM offres_cleaned")
  expect_gt(result$n, 0)
  DBI::dbDisconnect(con)
})

