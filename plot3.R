library(dplyr)
library(lubridate)

x <- 0 ## read switch

if (x == 1) { 
        
        pow <- read.csv2("household_power_consumption.txt",
                         sep = ";", header = TRUE, na.strings = "?")
        pow <- tbl_df(pow)
        
        pow$Global_reactive_power <- as.numeric(as.character(pow$Global_reactive_power))
        pow$Global_active_power <- as.numeric(as.character(pow$Global_active_power))
        pow$Voltage <- as.numeric(as.character(pow$Voltage))
        pow$Date <- as.Date(pow$Date, format = "%d/%m/%Y") 
        
        pow$Sub_metering_1 <- as.numeric(as.character(pow$Sub_metering_1)) 
        pow$Sub_metering_2 <- as.numeric(as.character(pow$Sub_metering_2)) 
        pow$Sub_metering_3 <- as.numeric(as.character(pow$Sub_metering_3)) 
        
        pow <- transform(pow, datetime = as.POSIXct(paste(Date, Time), "%d/%m/%Y %H:%M:%S")) 
        pow <- filter(pow, Date >= "2007-02-01" & Date <= "2007-02-02")
        
} 


## plot3
png("plot3.png", height = 480, width = 480)
attach(pow)
plot(datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(datetime, Sub_metering_2, col = "red")
lines(datetime, Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))  
detach(pow)  
dev.off()
