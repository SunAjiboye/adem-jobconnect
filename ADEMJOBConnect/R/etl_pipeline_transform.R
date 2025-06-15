#' Run the ETL Pipeline
#'
#' This function runs all four stages of the ETL process:
#' extract, transform, load, and log.
#'
#' @export
run_etl_pipeline <- function() {
  message("🚀 Starting ETL Pipeline...")

  df_raw <- extract_data()                      # 📌 Step 1: Extract
  df_clean <- transform_data(df_raw)            # 📌 Step 2: Transform
  load_data(df_clean)                           # 📌 Step 3: Load
  log_etl_run("R/etl_pipeline_transform.R", "Success")  # 📌 Step 4: Log

  message("✅ ETL pipeline completed successfully!")
}

