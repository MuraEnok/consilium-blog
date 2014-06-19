# mortgate amortization tool
# http://www.r-chart.com/2010/11/mortgage-calculator-and-amortization.html

library(fgui)
gui(mortgage)

mortgage(P=100000, I=10, L=7, amort=T, plotData=T)