## Read data and subset 2007-02-01 and 2007-02-02 

consumption <- read.csv("household_power_consumption.txt", sep=";")
consumption[,1] <- as.Date(consumption[,1], "%d/%m/%Y")
consumption <- consumption[which(as.numeric(format(consumption$Date,"%Y")) == 2007),]
consumption <- consumption[which(as.numeric(format(consumption$Date,"%m")) == 2),]
consumption <- consumption[which(as.numeric(format(consumption$Date,"%d")) < 3),]
consumption[,3] <- as.numeric(as.character(consumption[,3]))

## Plot 2
library(dplyr)
consumption <- mutate(consumption, dtime = paste(Date, Time))
consumption[,10] <- as.POSIXct(consumption[,10])
png(filename = "plot2.png")
with(consumption, plot(dtime, Global_active_power, pch = 20, 
                       type = "n", xlab = "", ylab = "Global Active Power (kilowatts)"))
for(i in 1:(nrow(consumption)-1)){
  segments(consumption[i,10], consumption[i,3], 
           consumption[i+1,10], consumption[i+1,3])
}
dev.off()