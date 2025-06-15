# load_data.R

if (basename(getwd()) == "testthat") {
  setwd("../..")
}
source("R/connect_db.R")

load_data <- function(df, overwrite = TRUE) {
  message("📤 Writing cleaned data to `offres_cleaned`...")
  
  con <- connect_db()
  
  DBI::dbWriteTable(
    con,
    name = "offres_cleaned",
    value = df,
    overwrite = overwrite
  )
  
  DBI::dbDisconnect(con)
}
