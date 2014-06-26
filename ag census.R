# get usda ag census data 

url = "ftp://ftp.nass.usda.gov/quickstats/qs.census2012.txt.gz"

ag <- read.table("O/qs.census2012.txt", sep="\t", as.is=T)

