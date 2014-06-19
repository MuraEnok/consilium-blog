# print out top and bottom of percent change of wages from 2007 to 2013 with adjustment for inflation.
df.pc = read.csv("data/pctchg_wages.csv")[3:6]


names(df.pc) = c("avg_wg_13", "Desc", "avg_wg_07", "pc")
df.pc <- select(df.pc, Desc, avg_wg_07, avg_wg_13, pc)

head(df.pc, n = 20)
tail(df.pc, n = 20)
