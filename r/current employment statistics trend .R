# get total employment employment cew data and create time series
library(dplyr)
library(tframe)
#  Average Weekly Hours of All Employees: Total Private
# U.S. Department of Labor: Bureau of Labor Statistics

url = "http://research.stlouisfed.org/fred2/data/AWHAETP.txt"
url = "http://research.stlouisfed.org/fred2/data/PAYNSA.txt"
hr.wk <- read.table(url, skip = 44, as.is=TRUE, header=TRUE)
names(hr.wk) = tolower(names(hr.wk))


hr.wk$date <- as.Date(hr.wk$date, "%Y-%m-%d")
hr.wk <- filter(hr.wk, date >= "1990-01-01")

hr.wk.ts <- ts(hr.wk$value, start = c(1990, 1), frequency = 12)

#Take the stl decomposition and then linear and cubic models
upl_stl <- stl(log(hr.wk.ts),
               s.window=15,
               robust=TRUE)
plot(upl_stl)

upl_trend <- round(exp(upl_stl$time.series[,'trend']),2)
upl_trend <- tfwindow(upl_trend,start=c(2005,1))
upl_season <- round(exp(upl_stl$time.series[,'seasonal']),2)
upl_season <- tfwindow(upl_season,start=c(2005,1))
upl_ts <- tfwindow(hr.wk.ts,start=c(2005,1))

x <- 11:0
trend.y <- upl_trend[length(upl_trend)-x]
x <- 0:11
trend.lm <- lm(trend.y~x)

m <- trend.lm$coef[2]

