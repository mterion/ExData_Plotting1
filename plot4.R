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
        mutate(DTimeC = paste(Date, Time)) %>%                  # Aggregate Date + Time as working char var
        mutate(DTime = dmy_hms(DTimeC)) %>%                     # Create Date - time var -> POSIXct
        select(-DTimeC) %>%                                     # Remove working var because no use of it anymore
        mutate(Date = dmy(Date)) %>%
        mutate(Time = hms(Time)) %>%
        filter(Date >= as.Date("2007-02-01"), Date <= as.Date("2007-02-02")) %>%
        mutate(WDay = wday(Date, label = TRUE)) %>%
        select(DTime, Date, WDay, Time, everything())           # Reorder columns

rm(data)


#=============================================================================================
# PLOT 4 
#=============================================================================================


png(filename = "plot4.png", width = 480, height = 480, units = "px")

par(mfcol = c(2,2))

# 1st plot
        plot(df$DTime, 
             df$Global_active_power, 
             type = "l", 
             lty = 1,
             xlab = "",
             ylab = "Global Active Power"
        )

# 2nd plot
        # Create 1st line
        plot(df$DTime, 
             df$Sub_metering_1, 
             type = "l", 
             lty = 1,
             xlab = "",
             ylab = "Energy sub metering"
        )
        
        # Create 2nd line
        lines(df$DTime, 
              df$Sub_metering_2, 
              type = "l", 
              col = "red"
        )
        
        # Create 3rd line
        lines(df$DTime, 
              df$Sub_metering_3, 
              type = "l", 
              col = "blue"
        )        
        
        # Legend
        legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               col = c("black", "red", "blue"),
               lty = 1, 
               bty = "n"
        )


#3rd plot
        plot(df$DTime, 
             df$Voltage, 
             type = "l", 
             lty = 1,
             xlab = "datetime",
             ylab = "Voltage"
        )

#4th plot
        plot(df$DTime, 
             df$Global_reactive_power, 
             type = "l", 
             lty = 1,
             xlab = "datetime",
             ylab = "Global_reactive_power"
        )           

dev.off()



