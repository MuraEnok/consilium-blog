# this file downloads all the area files for qcew from the bls and unzips them into a file called data in the pwd
# get the qcew files, download and clean : http://www.bls.gov/cew/datatoc.htm
# http://www.bls.gov/cew/data/files/2013/csv/2013_qtrly_by_area.zip

group = seq(2007,2013)
for (i in seq(group)){
  url_base = "http://www.bls.gov/cew/data/files/"
  year = paste(group[[i]])
  url_mid = "/csv/"
  url_end = "_qtrly_by_area.zip"
  url = paste0(url_base, year, url_mid, year, url_end)
  
  loc = paste0(getwd(), "/",  "data/")
  dest = paste0(loc, year, url_end) 
  download.file(url, dest) # get the file to data folder
  unzip(dest, exdir= loc) # unzip the files into data folder
  unlink(dest) 
  
}
