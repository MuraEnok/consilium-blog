library(googleVis)
library(weatherData)


w2012 <- getWeatherForYear("EWR",2012)
w2013 <- getWeatherForYear("EWR",2013)
w2014 <- getWeatherForYear("EWR",2014)
weather <- rbind(w2012, w2013, w2014)
# use weatherData to get the weather for Newark, NJ airportcode EWR
weather <- getSummarizedWeather("EWR", "2012-01-01", "2015-01-01", opt_temperature_columns = TRUE)

cal <- gvisCalendar(weather, 
                    datevar = "Date",
                    numvar="Mean_TemperatureF", 
                    options=list(
                      title ="Daily temperature Newark, NJ",
                      height=320,
                      calendar="{yearLabel: {fontName: 'Times-Roman', 
                      fontsize: 32, color: '#1a8763', bold: true},
                      cellSize: 10, 
                      cellColor: { stroke: 'red', strokeOpacity: 0.2 },
                      focusedCellColor: {stroke:'red'}}")
)

plot(cal)

Cal <- gvisCalendar(Cairo, 
                    datevar="Date", 
                    numvar="Temp",
                    options=list(
                      title="Daily temperature in Cairo",
                      height=320,
                      calendar="{yearLabel: { fontName: 'Times-Roman',
                               fontSize: 32, color: '#1A8763', bold: true},
                               cellSize: 10,
                               cellColor: { stroke: 'red', strokeOpacity: 0.2 },
                               focusedCellColor: {stroke:'red'}}")
)
plot(Cal)




library(ggplot2)
library(scales)
library(plyr)

w2013 <- getWeatherForYear("sfo",2013)

w2013$shortdate <- strftime(w2013$Time, format="%m-%d")

meanTemp <- ddply(w2013, .(shortdate), summarize, mean_T=mean(TemperatureF))
meanTemp$shortdate <- as.Date(meanTemp$shortdate,format="%m-%d")

ggplot(meanTemp, aes(shortdate, mean_T)) + geom_line() +
  scale_x_date(labels=date_format("%m/%d")) + xlab("") + ylab("Mean Temp deg F") +
  ggtitle("2013 Average Daily Temperature at SFO")
