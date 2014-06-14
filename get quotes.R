# create a random quote table for website using screen scrape techniques and R
library(XML)
url ='http://www.brainyquote.com/quotes/authors/j/john_kenneth_galbraith.html'
page <- htmlParse(url)
out <- sapply(page['//span[@class="bqQuoteLink"]/a'], xmlValue)

for ( i in seq(out)) {
  out[[i]] <- gsub("'" , "\\'", fixed=T, out[[i]])
}
# this fomats the last string to not have a trailing comma
last = out[[(length(out) -3)]]
# this format the other quotes to have trailing comma
out <- out[1:(length(out) -2)]

write(paste0("'", out, "', "), "quote.txt")
write(paste0("'", last, "'"), "last.txt")

top = "<?php 
$quotes = array("

bottom = ");
$rand = rand( 0, count($quotes)-1 );
echo $quotes[$rand];
?>"
write(paste0(top), "top.txt")
write(bottom, "bottom.txt")

# use the system command to have unix or linux cat files.  Just works.
system(paste("cat top.txt quote.txt last.txt bottom.txt > quote.php"))