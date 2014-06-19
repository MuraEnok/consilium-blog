# load qcew data download and unzip the qcew files for 2013 and 2007


library(stringr)

url = "http://www.bls.gov/cew/data/files/2013/csv/2013_qtrly_by_area.zip"
loc = paste0(getwd(), "/",  "data/")
dest = paste0(loc, "2013_qtrly_by_area.zip") 
download.file(url, dest) # get the file to data folder
unzip(dest, exdir= loc) # unzip the files into data folder
unlink(dest) 

url = "http://www.bls.gov/cew/data/files/2007/csv/2007_qtrly_by_area.zip"
dest = paste0(loc, "2007_qtrly_by_area.zip") 
download.file(url, dest) # get the file to data folder
unzip(dest, exdir= loc) # unzip the files into data folder
unlink(dest) 
