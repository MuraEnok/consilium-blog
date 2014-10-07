# devtools::install_github("hrbrmstr/statebins")
library(statebins)
dat <- data.frame(state=state.abb, value=0, stringsAsFactors = F)
dat[dat$state %in% c("MN", "IA", "MO", "KS", "OK", "KY", 
                     "IN", "WI", "OH", "PA", "NJ", "DE", "CT", "MA",
                     "VT", "NH", "ND", "ME", "MI", "IL", "TN", "RI", "WV")
    ,]$value <- 1

statebins(dat, breaks=2, 
          labels=c("Yes", "No"), 
          brewer_pal="PuOr", 
          text_color="black",
          font_size=3, 
          legend_title="States I have visited", 
          legend_position="bottom")

