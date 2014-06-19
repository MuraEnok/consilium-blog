One of the best sources of local economic data is the quarterly census
of wages and employment. In terms of usefulness this data is golden. In
fact it is used to validate most other series of data that gets more of
the monthly headlines, like the current employment statistics. The data
is found [qcew] (<http://www.bls.gov/cew/datatoc.htm>) from the bls. The
granularity of this data is very deep, as it goes down to a 6 digit
NAICS code and to counties. It shows average employment, the number of
firms and the total wages earned by quarter. The main downfall of this
data is that it does not get published until five and a half months
after the close of the quarter, so it is slow. But I will take accuracy
over speed here.

To see the script for downloading and unzipping the qcew data go [here]
(<https://github.com/MuraEnok/consilium-blog>). I did not place it in
the code as it due to the size of the files it takes a while to run and
unzip.

    ## 
    ## Attaching package: 'dplyr'
    ## 
    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag
    ## 
    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

This assumes you have run the script above and have the files in a
folder called data on your pwd. Then creates a list of all the unzipped
files to build the QCEW data file for all counties.

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
    qcew <- do.call(rbind, dfs)
