
library(choroplethr)

  url = "http://www.ers.usda.gov/datafiles/County_Typology_Codes/PersistentPovertyCounties.xls"
  download.file(url, "download/poverty.xls", method="wget")
# use the system call to use in2csv. It does a better job of converting to csv than other items.
  system(  "in2csv -f xls download/poverty.xls   > download/poverty.csv" )
  df <- read.csv("download/poverty.csv", sep=",", header=TRUE, as.is=TRUE)
  names(df) <- c("region", "state", "county.name", "persistent.poverty", "metro")
  df$value <- df$persistent.poverty + 1
# create map of US counties with persistent poverty
  choroplethr(df, "county", num_buckets=2, title = "Counties with persistent poverty 2014: Darker Blue = Yes")