
#=============================================================================================
# READING DATA
#=============================================================================================

library(dplyr)
library(lubridate)

# Data: 
        #read data
        data <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)

        #clean the data by adjusting date/time formats
        #filter the data to be used for the exercice
        df <- data %>%
                mutate(Date = dmy(Date)) %>%
                mutate(Time = hms(Time)) %>%
                filter(Date >= as.Date("2007-02-01"), Date <= as.Date("2007-02-02"))
        rm(data)


        
#=============================================================================================
# PLOT 1
#=============================================================================================
        
        
        png(filename = "plot1.png", width = 480, height = 480, units = "px")
        hist(df$Global_active_power,
             col = "red", 
             xlab = "Global Active Power (kilowatts)",
             main = "Global Active Power",
             yaxp = c(0, 1200, 6),
             cex.axis=0.9, 
             cex.lab= 0.9
             )
        dev.off()
       
        
    