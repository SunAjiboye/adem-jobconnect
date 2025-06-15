# log_etl_run.R
source("R/connect_db.R")
library(glue)
library(digest)

`%||%` <- function(a, b) if (!is.null(a)) a else b

log_etl_run <- function(file_name = "R/etl_pipeline_transform.R", status = "Success") {
  con <- connect_db()
  
  run_id <- dbGetQuery(con, "SELECT COALESCE(MAX(run_id), 0) AS max_run FROM etl_run_log")$max_run + 1
  
  # Compute hash only if file exists
  if (!file.exists(file_name)) {
    warning(glue("⚠️ Cannot compute hash: file not found at `{file_name}`"))
    file_hash <- NA
  } else {
    file_hash <- digest::digest(file = file_name, algo = "sha256")
  }
  
  dbExecute(con, glue("
    INSERT INTO etl_run_log (run_id, file_name, file_hash, status)
    VALUES ({run_id}, '{file_name}', '{file_hash}', '{status}')
  "))
  
  DBI::dbDisconnect(con)
  message(glue("📝 Logged ETL run #{run_id} for `{file_name}`"))
}
