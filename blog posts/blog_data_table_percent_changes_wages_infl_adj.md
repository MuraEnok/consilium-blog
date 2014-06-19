Here is the head and tail of the data table showing the top 15 gainers
and declining counties in US from 2007 to 2013. All wages were inflation
adjusted to show real gains. Clearly oil, gas and mining is driving the
numbers for gaining communities. I am unsure what is causing the
declines, but will post more when I dig into things a bit more.

    library(dplyr)

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

    # print out top and bottom of percent change of wages from 2007 to 2013 with adjustment for inflation.
    df.pc = read.csv("../data/pctchg_wages.csv")[3:6]


    names(df.pc) = c("avg_wg_13", "Desc", "avg_wg_07", "pc")
    df.pc <- select(df.pc, Desc, avg_wg_07, avg_wg_13, pc)

    head(df.pc, n = 20)

    ##                              Desc avg_wg_07 avg_wg_13     pc
    ## 1       Dunn County, North Dakota     591.9      1355 1.2894
    ## 2     Divide County, North Dakota     564.9      1123 0.9879
    ## 3  Mountrail County, North Dakota     604.2      1197 0.9811
    ## 4   McKenzie County, North Dakota     752.5      1397 0.8566
    ## 5   Williams County, North Dakota     823.2      1469 0.7845
    ## 6      Stark County, North Dakota     641.3      1140 0.7777
    ## 7      Kemper County, Mississippi     536.8       924 0.7212
    ## 8          La Salle County, Texas     737.9      1220 0.6534
    ## 9             Lee County, Georgia     580.6       945 0.6275
    ## 10      Shackelford County, Texas     627.8      1013 0.6136
    ## 11           Donley County, Texas     486.3       781 0.6060
    ## 12         Dewey County, Oklahoma     614.3       973 0.5839
    ## 13    Musselshell County, Montana     533.5       821 0.5390
    ## 14             King County, Texas     718.8      1086 0.5109
    ## 15      Alpine County, California     700.8      1027 0.4655
    ## 16     Kewaunee County, Wisconsin     712.0      1037 0.4564
    ## 17          Coffey County, Kansas     797.4      1161 0.4560
    ## 18         Woods County, Oklahoma     494.2       718 0.4530
    ## 19     Burke County, North Dakota     714.3      1015 0.4210
    ## 20   Powder River County, Montana     470.6       665 0.4132

    tail(df.pc, n = 20)

    ##                             Desc avg_wg_07 avg_wg_13      pc
    ## 3067      Boone County, Illinois    1022.0       802 -0.2153
    ## 3068      Clinch County, Georgia     639.0       500 -0.2176
    ## 3069      Howard County, Indiana    1108.5       853 -0.2305
    ## 3070        Sabine County, Texas     790.6       607 -0.2323
    ## 3071      Twiggs County, Georgia     797.4       608 -0.2375
    ## 3072      Ionia County, Michigan     737.9       557 -0.2451
    ## 3073   Gallatin County, Illinois     872.6       644 -0.2620
    ## 3074        Loving County, Texas    1473.5      1078 -0.2684
    ## 3075   Buffalo County, Wisconsin     835.6       611 -0.2688
    ## 3076      Taylor County, Georgia     643.5       467 -0.2743
    ## 3077     Armstrong County, Texas     786.1       564 -0.2826
    ## 3078 Bolivar County, Mississippi     842.3       598 -0.2900
    ## 3079        Ohio County, Indiana     606.5       430 -0.2910
    ## 3080     Mercer County, Missouri     841.2       592 -0.2962
    ## 3081      Box Elder County, Utah     909.7       638 -0.2987
    ## 3082 Rio Blanco County, Colorado    1209.5       848 -0.2989
    ## 3083     Somervell County, Texas    1436.4      1004 -0.3010
    ## 3084        Morris County, Texas    1245.5       866 -0.3047
    ## 3085         Delta County, Texas     557.0       363 -0.3483
    ## 3086     Clayton County, Georgia    1524.0       876 -0.4252
