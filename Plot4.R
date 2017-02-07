## Read data and subset 2007-02-01 and 2007-02-02 

consumption <- read.csv("household_power_consumption.txt", sep=";")
consumption[,1] <- as.Date(consumption[,1], "%d/%m/%Y")
consumption <- consumption[which(as.numeric(format(consumption$Date,"%Y")) == 2007),]
consumption <- consumption[which(as.numeric(format(consumption$Date,"%m")) == 2),]
consumption <- consumption[which(as.numeric(format(consumption$Date,"%d")) < 3),]
consumption[,3] <- as.numeric(as.character(consumption[,3]))
library(dplyr)
consumption <- mutate(consumption, dtime = paste(Date, Time))
consumption[,10] <- as.POSIXct(consumption[,10])
consumption[,7] <- as.numeric(as.character(consumption[,7]))
consumption[,8] <- as.numeric(as.character(consumption[,8]))
consumption[,9] <- as.numeric(as.character(consumption[,9]))

## Plot 4 
consumption[,5] <- as.numeric(as.character(consumption[,5]))
consumption[,4] <- as.numeric(as.character(consumption[,4]))
png(filename = "plot4.png")
par(mfrow = c(2,2))

## 1
with(consumption, plot(dtime, Global_active_power, pch = 20, 
                       type = "n", xlab = "", ylab = "Global Active Power (kilowatts)"))
for(i in 1:(nrow(consumption)-1)){
  segments(consumption[i,10], consumption[i,3], 
           consumption[i+1,10], consumption[i+1,3])
}
## 2 
with(consumption, plot(dtime, Voltage, type = "n", 
                       ylab = "Voltage", xlab = "datetime"))
for(i in 1:(nrow(consumption)-1)){
  segments(consumption[i,10], consumption[i,5], 
           consumption[i+1,10], consumption[i+1,5])
}
##3
with(consumption, plot(dtime, Sub_metering_1, type = "n", 
                       ylab = "Energy sub metering", xlab = ""))
for(i in 1:(nrow(consumption)-1)){
  segments(consumption[i,10], consumption[i,7], 
           consumption[i+1,10], consumption[i+1,7], col = "black")
  segments(consumption[i,10], consumption[i,8], 
           consumption[i+1,10], consumption[i+1,8], col = "red")
  segments(consumption[i,10], consumption[i,9], 
           consumption[i+1,10], consumption[i+1,9], col = "blue")
}
legend("topright", col = c("black", "red", "blue"), 
       pch = "-", legend = c("Sub_metering_1", "Sub_metering_2", 
                             "Sub_metering_3"), cex = 0.75)
## 4 
with(consumption, plot(dtime, Global_reactive_power, type = "n", 
                       ylab = "Global_reactive_power", xlab = "datetime"))
for(i in 1:(nrow(consumption)-1)){
  segments(consumption[i,10], consumption[i,4], 
           consumption[i+1,10], consumption[i+1,4])
}
dev.off()