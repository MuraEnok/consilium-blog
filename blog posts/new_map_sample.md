---
title: "New Map"
author: "fr. Athanasius"
date: "June 17, 2014"

---

	loc = paste0(getwd(), "/",  "data/")
	# unpack qcew and map 2013 and 2007 with inflation adjustment
	library(choroplethr)
	library(dplyr)
	library(stringr)

#### create a map of location of files
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

Clean the dataframe using dplyr packaage.

####Create the map


Map of the 2013 Quarter 3 weekly wages for all US counties and take out
Alaska and Hawai.

    names(df) <- c( "region", "value", "nm")    
    state.abb.48 = setdiff(state.abb, c("AK", "HI"))
    choroplethr(df, "county", title = "Average Weekly Wage 2013 Qtr 3",  num_buckets = 5, states = state.abb.48)

    

![plot of chunk
unnamed-chunk-4](./new_map_sample_files/figure-markdown_strict/unnamed-chunk-4.png)
