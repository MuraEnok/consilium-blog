# unpack qcew and map 2013 and 2007 with inflation adjustment
library(choroplethr)
library(dplyr)
library(stringr)

loc = paste0(getwd(), "/",  "data/")
# create a map of location of files
base = paste0(loc, "2013.q1-q3.by_area/")
# create list of the files to be used
dir <- dir(base)
# only get the files with county information
dirx = str_detect(dir, "County|Parish|Borough") # remove multiple county, msa data
dir = dir[dirx == TRUE]
# create the loop to grab the needed files from each csv
dfs <- lapply(dir, function(src) {
  nm = paste0(base, src )
  read.csv(nm, header=FALSE, skip=1, nrows=3, as.is=TRUE) # for this all we need is total employment
})
# combine each file into master file
qcew <- do.call(rbind, dfs)
# get column names from first file: and put into master file
colnm <- read.csv(paste0(base, dir[[1]]), header=TRUE,  nrows=1)
names(qcew) = names(colnm) 
rm(dfs)

df <-  filter(qcew, qtr == 2) %.%
  filter( ! (substr(area_fips, 1, 2) %in% c("CS", "C1")) )%.%
  select(area_fips, avg_wkly_wage, area_title) # %.%
# mutate( region = as.numeric(area_fips))

names(df) <- c( "region", "value", "nm")    
state.abb.48 = setdiff(state.abb, c("AK", "HI"))
choroplethr(df, "county", title = "Average Weekly Wage 2013 Qtr 3",  num_buckets = 5, states = state.abb.48)
map1 <- choroplethr(df, "county", title = "Average Weekly Wage 2013 Qtr 3",  num_buckets = 5, )
#########################################################################################
# get the inflation cpi from fred http://research.stlouisfed.org/fred2/data/CPIAUCNS.txt
url = "http://research.stlouisfed.org/fred2/data/CPIAUCNS.txt"
cpi <- read.table(url, skip = 13, header=TRUE, as.is=TRUE)
names(cpi) <- tolower(names(cpi))
cpi$date <- as.Date(cpi$date, "%Y-%m-%d")
top_dte = as.vector(cpi[cpi$date == "2007-09-01",2])
bot_dte = as.vector(cpi[cpi$date == "2013-09-01",2])
inflator =  bot_dte /top_dte
#########################################################################################

# create a map of location of files
base = paste0(loc, "2007.q1-q4.by_area/")
# create list of the files to be used
dir <- dir(base)
# only get the files with county information
dirx = str_detect(dir, "County|Parish|Borough") # remove multiple county, msa data
dir = dir[dirx == TRUE]
# create the loop to grab the needed files from each csv
dfs <- lapply(dir, function(src) {
  nm = paste0(base, src )
  read.csv(nm, header=FALSE, skip=1, nrows=3, as.is=TRUE) # for this all we need is total employment
})
# combine each file into master file
qcew <- do.call(rbind, dfs)
# get column names from first file: and put into master file
colnm <- read.csv(paste0(base, dir[[1]]), header=TRUE,  nrows=1)
names(qcew) = names(colnm) 
rm(dfs)

df.2 <-  filter(qcew, qtr == 2) %.%
  filter( ! (substr(area_fips, 1, 2) %in% c("CS", "C1")) )%.%
  select(area_fips, avg_wkly_wage, area_title) %.%
  mutate( wg_inflation_adj = avg_wkly_wage * inflator)
df.2 <- df.2[, c(1, 4)]

names(df.2) <- c( "region", "wg_inf_ad")    

# create a map that shows percent change of wages with inflation adjusted values form 2007 to 2013
df.pc <- left_join(df, df.2) %.%
        mutate(pct_ch = (value/wg_inf_ad)-1) %.%
        arrange(desc(pct_ch) )
names(df.pc) <- c("region", "2013_avg_week_wage", "Description", "2007_avg_week_wage_inflation_adj", "percent_change") 
df.pc <- df.pc[complete.cases(df.pc$percent_change),]
# save for web presentation using slick grid
write.csv(df.pc, "data/pctchg_wages.csv")


