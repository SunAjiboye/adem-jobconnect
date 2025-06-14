print("🚀 Starting ETL Pipeline...")

# Load necessary libraries
library(DBI)
library(RPostgres)
library(dplyr)
library(readr)
library(glue)
library(digest)

# Database connection
con <- dbConnect(RPostgres::Postgres(), dbname = Sys.getenv("PGDATABASE"))

# 📌 Step 1: Extract data
print("📥 Extracting data from `offres`...")
offres_raw <- dbGetQuery(con, "SELECT * FROM offres")

# 📌 Step 2: Transform data
print("🔄 Transforming data...")
offres_cleaned <- offres_raw %>%
  mutate(date = as.Date(date)) %>%
  filter(postes_declares > 0)

# 📌 Step 3: Overwrite `offres` with cleaned data
print("📤 Writing cleaned data back to `offres`...")
dbWriteTable(con, "offres", offres_cleaned, overwrite = TRUE)

# 📌 Step 4: Log ETL run with file hash
print("📝 Logging ETL run...")
run_id <- dbGetQuery(con, "SELECT COALESCE(MAX(run_id), 0) AS max_run FROM etl_run_log")$max_run + 1
file_hash <- digest(file = "etl/etl_pipeline.R", algo = "sha256")

dbExecute(con, glue(
  "INSERT INTO etl_run_log (run_id, file_name, file_hash, status)
   VALUES ({run_id}, 'etl_pipeline.R', '{file_hash}', 'Success')"
))

print("✅ ETL pipeline completed successfully!")

# Disconnect from DB
dbDisconnect(con)

