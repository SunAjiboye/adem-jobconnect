# connect_db.R
library(DBI)
library(RPostgres)

connect_db <- function() {
  con <- dbConnect(
    RPostgres::Postgres(),
    dbname   = Sys.getenv("PGDATABASE"),
    host     = Sys.getenv("PGHOST"),
    port     = Sys.getenv("PGPORT"),
    user     = Sys.getenv("PGUSER"),
    password = Sys.getenv("PGPASSWORD")
  )
  return(con)
}
