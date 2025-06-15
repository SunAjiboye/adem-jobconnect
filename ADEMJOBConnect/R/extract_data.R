# Fallback-safe operator
`%||%` <- function(a, b) if (!is.null(a)) a else b

# Resolve absolute path to this script
etl_path <- tryCatch(
  normalizePath(sys.frame(1)$ofile, mustWork = TRUE),
  error = function(e) {
    fallback <- file.path(getwd(), "..", "..", "R", "extract_data.R")
    if (!file.exists(fallback)) {
      stop("❌ Could not resolve path to extract_data.R. Please check your test setup.")
    }
    normalizePath(fallback, mustWork = TRUE)
  }
)
etl_dir <- dirname(etl_path)

# Load DB connector
source(file.path(etl_dir, "connect_db.R"))

extract_data <- function() {
  con <- connect_db()
  message("📥 Extracting data from `offres` table...")
  df <- DBI::dbGetQuery(con, "SELECT * FROM offres")
  DBI::dbDisconnect(con)
  return(df)
}
