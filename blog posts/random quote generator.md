One of my favorite economist for quotes is John Kenneth Galbraith.  Here is R code that will go out to a site and grab his quotes and create a PHP array that will randomly place a quote in your website.  Don't like economist, that is alright you can change the author and create a quote of anyone.  Why did I choose to do it as PHP, well it just runs on every single website out there with out much fuss.  I could have done this using javascript, but that meant I needed to open another book and just figuring out how to best scrape web sites took me awhile.  

```r
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
```

To place a quote in your website place the php code like this:
```{php}
<div class="row">
        <div class="col-lg-4" style="text-align:center">
          <img src="/graphics/jkg_200.jpg">
          <h2>John Kenneth Galbraith Quote's</h2>
          <p>
         <?php 
         $include_Quote = file_get_contents("http://intermountainimpact.org/includes/quote json.php"); 
         echo $include_Quote;
         ?></p>
```
Have fun create a random quote section for you website or blog.




