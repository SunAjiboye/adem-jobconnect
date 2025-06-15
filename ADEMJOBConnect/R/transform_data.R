# transform_data.R
library(dplyr)

transform_data <- function(df) {
  message("🔧 Transforming data...")
  df$date <- as.Date(df$date)
  df_clean <- df %>% filter(postes_declares > 0)
  return(df_clean)
}
