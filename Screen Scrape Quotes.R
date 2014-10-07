# New and improved screen scraper using rvest instead of XML
library(rvest)
library(magrittr)
library(reshape2)
# get the topics here that are available for downloading
url_topics = "www.brainyquote.com/quotes/topics.html"
page_topics <- html_session(url_topics)
topics <- page_topics %>% html_nodes(xpath='//div[@class="bqLn"]/a') %>% html_text %>% .[1:60]

# set the topics to an number as the pages are index topic1, topic2, topic3, etc..
topics = lapply(topics, function(src) { 
  paste0(src, seq(1:10))
})
topics <- as.vector(unlist(topics))

# build loop to download 25 quotes for each topic in topics
base = 'http://www.brainyquote.com/quotes/topics/topic_'
dfs2 <- lapply(topics, function(src) {
  top = rep(paste0(src), times=25)
  result <- try({
  page <- html_session(paste0(base, src, '.html' ))
  list(quote = page %>% html_nodes(xpath='//span[@class="bqQuoteLink"]/a') %>% html_text() %>% .[1:25] ,
       author = page %>% html_nodes(xpath='//div[@class="bq-aut"]') %>% html_text() %>% .[1:25],
       topic = top[1:25]
  )
  }, silent =TRUE)
  if (!inherits(result, "try-error")) result
})

# combine each file into master file
quotes <- do.call(rbind, dfs2)

quote <- melt(quotes[,1], value.name="quote")
# make the single quotes in the quotes to be escaped
for ( i in seq(quote)) {
  quote[[i]] <- gsub("'" , "\\'", fixed=TRUE, quote[[i]])
}
author <- melt(quotes[,2] , value.name="author")
topic <- melt(quotes[, 3], value.name="topic")

# make master file
quotes2 <- cbind(quote, author, topic) [, c('quote', 'author', 'topic')]
# remove number
quotes2$topic = gsub("[0-9]", "", quotes2$topic)
# clean up the use of single quotes so it will fit in php array
